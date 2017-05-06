//
//  WSJMerchantDetailsViewController.m
//  jingGang
//
//  Created by thinker on 15/9/9.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJMerchantDetailViewController.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "PublicInfo.h"
#import "JGShareView.h"
#import "shareView.h"
#import "WSJStarView.h"
#import "Masonry.h"
#import "AppDelegate.h"
#import "WSJMerchantDetailsTableViewCell.h"
#import "WSJEvaluateModel.h"
#import "WSJEvaluateView.h"
#import "VApiManager.h"
#import "MJExtension.h"
#import "GlobeObject.h"
#import "Util.h"
#import "EnvironmentPhotoController.h"
#import "UIImageView+WebCache.h"
#import "mapObject.h"
#import "KJShoppingAlertView.h"
#import "ServiceDetailController.h"
#import "WSJMerchantEvaluateViewController.h"
#import "XKJHMapViewController.h"
#import "AppDelegate.h"

@interface WSJMerchantDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>
{
    VApiManager *_vapiManager;
    NSString *_merchantLogoURL;

    __weak IBOutlet UIView *_loadingView;
    __weak IBOutlet NSLayoutConstraint *_xianHeight;
    __weak IBOutlet NSLayoutConstraint *evalueteXianHeight1;
    __weak IBOutlet NSLayoutConstraint *evaluateXianHeight2;
    __weak IBOutlet NSLayoutConstraint *introduceXianHeight;
    __weak IBOutlet UIButton *collectionBtn;//收藏按钮
    UIWebView *phoneCallWebView;//手机一键拨号
    NSString *_tel;//手机号码
    NSNumber *_storeLat;//纬度
    NSNumber *_storeLon;//经度
}

@property (nonatomic, strong) JGShareView *shareV;//分享事件

//整体框架
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

//图片
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
//图片数据
@property (weak, nonatomic) IBOutlet UILabel *photoCountLabel;

//商户标题
@property (weak, nonatomic) IBOutlet UILabel *merchantTitleLabel;

//星星   starView星星等级     starLabel星星分数
@property (weak, nonatomic) IBOutlet WSJStarView *starView;
@property (weak, nonatomic) IBOutlet UILabel *starLabel;


//地址信息   mapInfoLabel地理位置信息     distanceLabel当前地理距离
@property (weak, nonatomic) IBOutlet UILabel *mapInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *merchantTitleLabel1;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;

//套餐选择
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (nonatomic, strong) NSMutableArray *dataSource;


//评论
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *evaluateHeight;
@property (weak, nonatomic) IBOutlet UILabel *evaluateCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *evaluteRightImageView;
@property (weak, nonatomic) IBOutlet WSJEvaluateView *evaluateContent;


//商户介绍View
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;
@property (weak, nonatomic) IBOutlet UIWebView *infoWebView;


@end

static NSString *merchantDetailsTabelViewCell = @"merchantDetailsTabelViewCell";

@implementation WSJMerchantDetailViewController

#pragma mark - 网络请求数据
- (void)requestData
{
    //TODO:商户信息
    PersonalStoreInfoRequest *storeInfoRequest = [[PersonalStoreInfoRequest alloc] init:GetToken];
    storeInfoRequest.api_storeId = self.api_classId;
    storeInfoRequest.api_storeLat = [[mapObject sharedMap] baiduLatitude];
    storeInfoRequest.api_storeLon = [[mapObject sharedMap] baiduLongitude];
    WEAK_SELF
    [_vapiManager personalStoreInfo:storeInfoRequest success:^(AFHTTPRequestOperation *operation, PersonalStoreInfoResponse *response) {
        //TODO:店铺信息
        PGroup *storeInfo = [PGroup objectWithKeyValues:response.storeInfo];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weak_self.photoImageView sd_setImageWithURL:[NSURL URLWithString:storeInfo.storeInfoBO.photoPath]];
            _merchantLogoURL = storeInfo.storeInfoBO.photoPath;
            weak_self.photoCountLabel.text = [NSString stringWithFormat:@"%@张",storeInfo.storeInfoBO.photoSize ? storeInfo.storeInfoBO.photoSize:@"0"];
            weak_self.merchantTitleLabel.text = storeInfo.storeInfoBO.storeName;
            weak_self.merchantTitleLabel1.text = storeInfo.storeInfoBO.storeName;
            [weak_self setStarCount:[storeInfo.storeInfoBO.storeEvaluationAverage integerValue]];
            weak_self.mapInfoLabel.text = storeInfo.storeInfoBO.storeAddress;
            weak_self.distanceLabel.text = [Util transferDistanceStrWithDistance:storeInfo.storeInfoBO.distance] ;
            //电话号码、纬度、经度
            _tel = storeInfo.storeInfoBO.storeTelephone;
            _storeLat = storeInfo.storeInfoBO.storeLat;
            _storeLon = storeInfo.storeInfoBO.storeLon;
            weak_self.phoneNumberLabel.text = _tel;
            //介绍
            [weak_self.infoWebView loadHTMLString:storeInfo.storeInfoBO.licenseCDesc baseURL:nil];
        });
        _loadingView.hidden = YES;
        NSMutableArray *mutableArray1 = [NSMutableArray array];
        NSDictionary *dict1 = @{@"title":@"代金券",
                               @"data":mutableArray1};
        for (NSDictionary *dict in storeInfo.cashList)
        {
            [mutableArray1 addObject:dict];
        }
        NSMutableArray *mutableArray2 = [NSMutableArray array];
        NSDictionary *dict2 = @{@"title":@"套餐券",
                                @"data":mutableArray2};
        for (NSDictionary *dict in storeInfo.packageList)
        {
            [mutableArray2 addObject:dict];
        }
        
        if (mutableArray1.count > 0)
        {
            [weak_self.dataSource addObject:dict1];
        }
        if (mutableArray2.count > 0)
        {
            [weak_self.dataSource addObject:dict2];
        }
        [weak_self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"商户详情页 ---- %@",error.localizedDescription);
        [Util ShowAlertWithOnlyMessage:[NSString stringWithFormat:@"请求该商户数据失败,请检查网络...%@",error.localizedDescription]];
        [_vapiManager.operationQueue cancelAllOperations];
        [weak_self.navigationController popViewControllerAnimated:YES];
    }];
    
    //TODO:查看评论
    GroupEvaluateListRequest *evaluateLiStRequest = [[GroupEvaluateListRequest  alloc] init:GetToken];
    evaluateLiStRequest.api_pageNum = @(1);
    evaluateLiStRequest.api_pageSize = @(100);
    evaluateLiStRequest.api_storeId = self.api_classId;
    [_vapiManager groupEvaluateList:evaluateLiStRequest success:^(AFHTTPRequestOperation *operation, GroupEvaluateListResponse *response) {
        if (response.evaluateList.count > 0)
        {
            NSDictionary *dict = response.evaluateList[0];
            WSJEvaluateModel *model = [[WSJEvaluateModel alloc]init];
            model.titleImageURL = dict[@"avatarUrl"];
            model.starCount = [dict[@"score"] intValue];
            model.titleName  = dict[@"nickName"];
            model.date = dict[@"evaluateTime"];
            model.evaluateContent = dict[@"content"];
            if ([dict[@"photoUrls"] length] > 0) {
                [model.dataImageArray addObjectsFromArray:[dict[@"photoUrls"] componentsSeparatedByString:@";"]];
            }
            model.shopkeeper = dict[@"replyContent"];
            [weak_self setEvaluateWithModel:model];
            weak_self.evaluateCountLabel.text = [NSString stringWithFormat:@"查看全部%ld条评论",response.evaluateList.count];
        }
        else
        {
            [weak_self setEvaluateWithModel:nil];
            weak_self.evaluateCountLabel.text = [NSString stringWithFormat:@"查看全部0条评论"];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"评价 ---- %@",error);
    }];
    
    if (IsEmpty(GetToken)) {  //判断是否登录
        return;
    }
    //TODO:判断是否收藏过
    PersonalFavoritesListRequest *favoritesListRequest = [[PersonalFavoritesListRequest alloc ]init:GetToken];
    favoritesListRequest.api_pageNum = @(1);
    favoritesListRequest.api_pageSize = @(100);
    favoritesListRequest.api_storeLat = [[mapObject sharedMap] baiduLatitude];
    favoritesListRequest.api_storeLon = [[mapObject sharedMap] baiduLongitude];
    [_vapiManager personalFavoritesList:favoritesListRequest success:^(AFHTTPRequestOperation *operation, PersonalFavoritesListResponse *response) {
        for (NSDictionary *dict in response.favaStoreList)
        {
            if ([dict[@"id"] intValue] == [weak_self.api_classId intValue])
            {
                collectionBtn.selected = YES;
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"店铺收藏数据请求错误 ---- %@",error);
    }];
}

#pragma mark - 收藏商户
- (IBAction)collectionMerchant:(UIButton *)sender
{
    UNLOGIN_HANDLE
    if (!sender.selected)
    {
        UsersFavoritesRequest *favoritesRequest = [[UsersFavoritesRequest alloc] init:GetToken];
        favoritesRequest.api_type = @"6";
        favoritesRequest.api_fid = [self.api_classId stringValue];
        [_vapiManager usersFavorites:favoritesRequest success:^(AFHTTPRequestOperation *operation, UsersFavoritesResponse *response) {
            if (!response.subCode)
            {
                sender.selected = YES;
                [KJShoppingAlertView showAlertTitle:@"收藏该商户成功" inContentView:self.view.window];
            }
            else
            {
                [KJShoppingAlertView showAlertTitle:@"收藏该商户失败" inContentView:self.view.window];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"收藏 ---- %@",error);
            [KJShoppingAlertView showAlertTitle:@"收藏该商户失败" inContentView:self.view.window];
        }];
        
    }
    else
    {
        PersonalCancelRequest *cancelRequest = [[PersonalCancelRequest alloc ]init:GetToken];
        cancelRequest.api_type = @(6);
        cancelRequest.api_fid = self.api_classId;
        [_vapiManager personalCancel:cancelRequest success:^(AFHTTPRequestOperation *operation, PersonalCancelResponse *response) {
            if (!response.subCode)
            {
                [KJShoppingAlertView showAlertTitle:@"取消该商户成功" inContentView:self.view.window];
                sender.selected = NO;
            }
            else
            {
                [KJShoppingAlertView showAlertTitle:@"取消该商户失败" inContentView:self.view.window];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"collection Cancle ---- %@",error);
            [KJShoppingAlertView showAlertTitle:@"取消该商户失败" inContentView:self.view.window];
        }];
    }
}
#pragma mark - 分享事件
- (IBAction)shareAction:(UIButton *)sender
{
    UNLOGIN_HANDLE
    [self.shareV show];
}
-(JGShareView *)shareV
{
    if (_shareV == nil)
    {
        NSString *content = [NSString stringWithFormat:@"%@ %@",self.mapInfoLabel.text,_tel];
        NSString *shareURL = [NSString stringWithFormat:@"http://shop.jgyes.com/group/store.htm?id=%@",self.api_classId];
        NSString *shareImageUrl = TwiceImgUrlStr(_merchantLogoURL, 50, 50);
        _shareV = [JGShareView shareViewWithTitle:self.merchantTitleLabel.text content:content imgUrlStr:_merchantLogoURL ulrStr:shareURL contentView:self.view shareImagePath:nil];
        //QQ空间分享内容
        _shareV.qqShareModel.shareTitle = self.merchantTitleLabel.text;
        _shareV.qqShareModel.shareContent = [NSString stringWithFormat:@"这家店不错哦，一起去吧！%@，%@ %@ 快来下载吧！%@",self.merchantTitleLabel.text,self.mapInfoLabel.text,_tel,k_ShareURL];
        _shareV.qqShareModel.shareImgUrl = _merchantLogoURL;
        _shareV.qqShareModel.shareUlrStr = shareURL;
        //微博分享内容
        _shareV.weiBoShareModel.shareTitle = self.merchantTitleLabel.text;
        _shareV.weiBoShareModel.shareContent = [NSString stringWithFormat:@"这家店不错哦，一起去吧！%@，%@ %@ 快来下载吧！%@",self.merchantTitleLabel.text,self.mapInfoLabel.text,_tel,k_ShareURL];
        _shareV.weiBoShareModel.shareImgUrl = _merchantLogoURL;
        _shareV.weiBoShareModel.shareUlrStr = shareURL;
        //微信好友
        _shareV.wxShareModel.shareTitle = self.merchantTitleLabel.text;
        _shareV.wxShareModel.shareContent = content;
        _shareV.wxShareModel.shareImgUrl = _merchantLogoURL;
        _shareV.wxShareModel.shareUlrStr = shareURL;
        //微信朋友圈
        _shareV.wxFriendShareModle.shareTitle = [NSString stringWithFormat:@"【%@】%@",self.merchantTitleLabel.text,self.mapInfoLabel.text];
        _shareV.wxFriendShareModle.shareContent = [NSString stringWithFormat:@"【%@】%@",self.merchantTitleLabel.text,self.mapInfoLabel.text];
        _shareV.wxFriendShareModle.shareImgUrl = _merchantLogoURL;
        _shareV.wxFriendShareModle.shareUlrStr = shareURL;
        
    }
    return _shareV;
}

#pragma mark - 商户相册列表
- (IBAction)merchantPhoto:(id)sender
{
    EnvironmentPhotoController *photoVC = [[EnvironmentPhotoController alloc] init];
    photoVC.storeId = self.api_classId;
    [self.navigationController pushViewController:photoVC animated:YES];
}

#pragma mark - 跳转到地图界面
- (IBAction)mapAction:(id)sender
{
    NSLog(@"跳转地图界面");
    XKJHMapViewController *mapVC = [[XKJHMapViewController alloc] initWithNibName:@"XKJHMapViewController" bundle:nil];
    mapVC.shopAddress = self.mapInfoLabel.text;
    mapVC.latitude = [_storeLat floatValue];
    mapVC.longitude = [_storeLon floatValue];
    [self.navigationController pushViewController:mapVC animated:YES];
}

#pragma mark - 拨打电话
- (IBAction)phoneTel:(UIButton *)sender
{
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",_tel]];
    if (!phoneCallWebView ) {
        phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
    }
    [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
}

#pragma mark - 设置评分等级
- (void) setStarCount:(NSInteger)count
{
    self.starLabel.text = [NSString stringWithFormat:@"%ld分",count];
    self.starView.count = count;
}

#pragma mark - 跳转查看更多评论界面
- (IBAction)evaluateAction:(UITapGestureRecognizer *)sender
{
    WSJMerchantEvaluateViewController *evaluateVC = [[WSJMerchantEvaluateViewController alloc] initWithNibName:@"WSJMerchantEvaluateViewController" bundle:nil];
    evaluateVC.api_classId = self.api_classId;
    [self.navigationController pushViewController:evaluateVC animated:YES];
}

#pragma mark - 设置评论内容
- (void) setEvaluateWithModel:(WSJEvaluateModel *)model
{
    CGFloat height = 88 - 130;
    if (model == nil)
    {
        self.evaluateHeight.constant = 88;
    }
    else
    {
        self.evaluateContent.model = model;
        self.evaluateContent.hidden = NO;
        self.evaluateHeight.constant = 88 + model.O2OHeight;
        height += model.O2OHeight;
    }
    self.scrollView.contentSize = CGSizeMake(1, CGRectGetMaxY(self.bottomView.frame) + height);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self requestData];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGSize finishSize = [webView sizeThatFits:CGSizeZero];
    self.bottomViewHeight.constant = self.bottomViewHeight.constant + finishSize.height - 40;
    self.scrollView.contentSize = CGSizeMake(1, CGRectGetMaxY(self.bottomView.frame) + finishSize.height - 40);
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    CGFloat height = 0;
    for (NSDictionary *dict in self.dataSource)
    {
        NSArray *array = dict[@"data"];
        height = height +  100 * array.count + 52;
    }
    self.scrollView.contentSize = CGSizeMake(1, CGRectGetMaxY(self.bottomView.frame) + height);
    self.tableViewHeight.constant = height;
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.dataSource[section][@"data"];
    return array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSJMerchantDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:merchantDetailsTabelViewCell];
    NSArray *array = self.dataSource[indexPath.section][@"data"];
    [cell willCustomCellWithData:array[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = self.dataSource[indexPath.section][@"data"];
    NSDictionary *dict = array[indexPath.row];
    ServiceDetailController *serviceDetailVC = [[ServiceDetailController alloc ]initWithNibName:@"ServiceDetailController" bundle:nil];
    serviceDetailVC.serviceID = dict[@"id"];
    [self.navigationController pushViewController:serviceDetailVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 52;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self createTableViewHeaderViewWithTitle:self.dataSource[section][@"title"]];
}
- (UIView *)createTableViewHeaderViewWithTitle:(NSString *)title
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 52)];
    v.backgroundColor = [UIColor whiteColor];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 8)];
    headerView.backgroundColor =[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    [v addSubview:headerView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 8, __MainScreen_Width - 30, 44)];
    label.text = title;
    label.textColor = UIColorFromRGB(0X999999);
    [v addSubview:label];
    return v;
}


#pragma mark - 实例化UI
- (void)initUI
{
    if (self.api_classId == nil)
    {
        self.api_classId = @(18);
    }
    self.infoWebView.scrollView.scrollEnabled = NO;
    _vapiManager = [[VApiManager alloc] init];
    self.dataSource = [NSMutableArray array];
    [self.tableView registerNib:[UINib nibWithNibName:@"WSJMerchantDetailsTableViewCell" bundle:nil] forCellReuseIdentifier:merchantDetailsTabelViewCell];
    self.tableView.rowHeight = 100;
    
    _xianHeight.constant = 0.25;
    evalueteXianHeight1.constant = 0.25;
    evaluateXianHeight2.constant = 0.5;
    introduceXianHeight.constant = 0.5;
    
    //返回上一级控制器按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(btnClick) target:self];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    //设置背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
}

//返回上一级界面
- (void) btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(__MainScreen_Width/2 - 30, __StatusScreen_Height, 60, 40)];
    l.text = @"商户详情";
    l.font = [UIFont systemFontOfSize:18];
    l.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = l;

    //关闭侧滑
    AppDelegate *app = kAppDelegate;
    [app.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [app.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_vapiManager.operationQueue cancelAllOperations];
}
@end
