//
//  ServiceDetailController.m
//  jingGang
//
//  Created by 张康健 on 15/9/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "ServiceDetailController.h"
#import "GlobeObject.h"
#import "Util.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "VApiManager.h"
#import "mapObject.h"
#import "ServiceDetailModel.h"
#import "NSDate+Addition.h"
#import "GotoStoreExperienceTableView.h"
#import "SDCycleScrollView.h"
#import "ServiceModel.h"
#import "SubmitOrderController.h"
#import "KJShoppingAlertView.h"
#import "ZkgLoadingHub.h"
#import "XKJHMapViewController.h"
#import "AppDelegate.h"
#import "JGShareView.h"
#import "NodataShowView.h"
#import "WSJMerchantDetailViewController.h"
@interface ServiceDetailController ()<UIWebViewDelegate,SDCycleScrollViewDelegate> {
    VApiManager *_vapManager;
    JGShareView *_shareView;
}

@property (strong, nonatomic) JGShareView *shareView;
@property (weak, nonatomic) IBOutlet SDCycleScrollView *headerScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;

@property (nonatomic, strong)ServiceDetailModel *serviceDetailModel;
@property (weak, nonatomic) IBOutlet UILabel *serviceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *hasSaledCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *nowPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *originalPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *beginEndTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIWebView *buyNeetoKnowWebView;
@property (weak, nonatomic) IBOutlet UIWebView *serviceDescriptionWebView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buyNeettoKnowWebViewHeightContraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailDescriptionWebViewHeightConstraint;
@property (weak, nonatomic) IBOutlet GotoStoreExperienceTableView *guessYouLikeTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *guessYouLikeTableHeightConstraint;

@end

@implementation ServiceDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    
    //请求猜您喜欢以外的数据
    [self _requestData];
    
    //请求猜您喜欢
    [self _requestGuessYoulikeData];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    //打开侧滑
    AppDelegate *app = kAppDelegate;
    [app.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [app.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
}



#pragma mark ----------------------- private Method -------------------
- (void)_init {

    NSLog(@"service id %@",self.serviceID);
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(back) target:self];
    [Util setNavTitleWithTitle:@"服务详情" ofVC:self];
    self.navigationController.navigationBar.barTintColor = NavBarColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _vapManager = [[VApiManager alloc] init];
    self.headerHeightConstraint.constant = kScreenWidth;
    self.buyNeetoKnowWebView.delegate = self;
    self.serviceDescriptionWebView.delegate = self;
    self.buyNeetoKnowWebView.tag = 1;
    self.serviceDescriptionWebView.tag = 2;
    //猜您喜欢共用之前tableView
    self.guessYouLikeTableView.gotoStoreTableType = PromoteRecommendTableType;
    self.serviceDescriptionWebView.scrollView.scrollEnabled = NO;
    self.buyNeetoKnowWebView.scrollView.scrollEnabled = NO;
    WEAK_SELF
    self.guessYouLikeTableView.clickItemBlock = ^(NSNumber *itemID){
    
        ServiceDetailController *serviceDetailVC = [[ServiceDetailController alloc] init];
        serviceDetailVC.serviceID = itemID;
        [weak_self.navigationController pushViewController:serviceDetailVC animated:YES];
    };
    [self _initHeaderScrollView];
    
}

-(void)_initHeaderScrollView {
    _headerScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _headerScrollView.delegate = self;
    _headerScrollView.backgroundColor = [UIColor whiteColor];
    _headerScrollView.autoScrollTimeInterval = 5.0f;
    // 自定义分页控件小圆标颜色
    _headerScrollView.dotColor = [UIColor whiteColor];

}


#pragma mark ----------------------- Request Data  -----------------------
- (void)_requestData {
    
    ZkgLoadingHub *hub = [[ZkgLoadingHub alloc] initHubInView:self.view withLoadingType:LoadingSystemtype];
    PersonalGroupGoodsLikeRequest *request = [[PersonalGroupGoodsLikeRequest alloc] init:GetToken];
    request.api_gId = self.serviceID;
    request.api_storeLat = [[mapObject sharedMap] baiduLatitude];
    request.api_storeLon = [[mapObject sharedMap] baiduLongitude];

    [_vapManager personalGroupGoodsLike:request success:^(AFHTTPRequestOperation *operation, PersonalGroupGoodsLikeResponse *response) {
        [hub endLoading];
        NSLog(@"服务详情 response %@",response);
        NSDictionary *dic = (NSDictionary *)response.youLikeGoods;
        self.serviceDetailModel = [[ServiceDetailModel alloc] initWithJSONDic:dic];
        //给ui赋值
        [self assignData];
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [hub endLoading];
        [Util ShowAlertWithOnlyMessage:error.localizedDescription];
        
        [NodataShowView showInContentView:self.view withReloadBlock:nil requestResultType:NetworkRequestFaildType];
        
    }];
    
}
#pragma mark 跳转去商铺
- (IBAction)pushToStoreDetail:(id)sender {
    if(!self.serviceDetailModel.storeId){
        return;
    }
    WSJMerchantDetailViewController *controller = [[WSJMerchantDetailViewController alloc] init];
    controller.api_classId = self.serviceDetailModel.storeId;
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)_requestGuessYoulikeData {
    
    PersonalYoulikeStoreListRequest *request = [[PersonalYoulikeStoreListRequest alloc] init:GetToken];
    request.api_storeLat = [[mapObject sharedMap] baiduLatitude];
    request.api_storeLon = [[mapObject sharedMap] baiduLongitude];
    request.api_areaId = [[mapObject sharedMap] baiduCityID];
    
    
    [_vapManager personalYoulikeStoreList:request success:^(AFHTTPRequestOperation *operation, PersonalYoulikeStoreListResponse *response) {
        NSInteger itemCount = response.youLike.count;
        self.guessYouLikeTableHeightConstraint.constant = itemCount * 98;
        
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:itemCount];
        for (NSDictionary *dic in response.youLike) {
            ServiceModel *model = [[ServiceModel alloc] initWithJSONDic:dic];
            [arr addObject:model];
        }
        self.guessYouLikeTableView.dataArr = (NSArray *)arr;
        [self.guessYouLikeTableView reloadData];
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
}

#pragma mark - 赋值UI
-(void)assignData {
    
    self.serviceNameLabel.text = self.serviceDetailModel.ggName;
    self.hasSaledCountLabel.text = [NSString stringWithFormat:@"已售%@",self.serviceDetailModel.selledCount];
    NSLog(@"原价 %@ 团购价 %@",self.serviceDetailModel.costPrice,self.serviceDetailModel.groupPrice);
    
//    self.nowPriceLabel.text = [NSString stringWithFormat:@"%@",self.serviceDetailModel.groupPrice];
     self.nowPriceLabel.text = kNumberToStrRemain2Point(self.serviceDetailModel.groupPrice);
    self.originalPriceLabel.text =[NSString stringWithFormat:@"￥%@",kNumberToStrRemain2Point(self.serviceDetailModel.costPrice)];
    ;
    NSString *beginTimeStr = [NSString stringWithFormat:@"%@",self.serviceDetailModel.beginTime];
    if (beginTimeStr.length > 9 ) {
        beginTimeStr = [beginTimeStr substringToIndex:beginTimeStr.length-9];
    }
    
    NSString *endTimeStr = [NSString stringWithFormat:@"%@",self.serviceDetailModel.endTime];
    if (endTimeStr.length > 9) {
        endTimeStr = [endTimeStr substringToIndex:endTimeStr.length-9];
    }
    
    self.beginEndTimeLabel.text = [NSString stringWithFormat:@"%@至%@",beginTimeStr,endTimeStr];
    self.storeNameLabel.text = self.serviceDetailModel.storeName;
    self.addressLabel.text = self.serviceDetailModel.storeAddress;
    
    NSLog(@"距离---%.2f",self.serviceDetailModel.distance.floatValue);
    self.distanceLabel.text = [Util transferDistanceStrWithDistance:self.serviceDetailModel.distance];
    [self.buyNeetoKnowWebView loadHTMLString:self.serviceDetailModel.groupNotice baseURL:nil];
    [self.serviceDescriptionWebView loadHTMLString:self.serviceDetailModel.groupDesc baseURL:nil];
    
    NSArray *imgArr = [self.serviceDetailModel.groupAccPath componentsSeparatedByString:@";"];
    if (imgArr.count > 0) {
        NSMutableArray *twiceImgUrlArr = [NSMutableArray arrayWithCapacity:imgArr.count];
        for (NSString *urlStr in imgArr) {
//            NSString *twiceImgUrlStr = TwiceImgUrlStr(urlStr, kScreenWidth, kScreenWidth);
            [twiceImgUrlArr addObject:urlStr];
        }
        _headerScrollView.imageURLStringsGroup = (NSArray *)twiceImgUrlArr;
    }
}


#pragma mark ----------------------- Action Method -----------------------
- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 收藏，取消收藏入口
- (IBAction)serviceFavoriteAction:(id)sender {
    UNLOGIN_HANDLE
    if (!self.favoriteButton.selected) {
        //收藏
        [self _doFavorite];
        
    }else {
        //取消收藏
        [self _cancelFavorite];
    }
}


-(void)_doFavorite {

    UsersFavoritesRequest *request = [[UsersFavoritesRequest alloc] init:GetToken];
    request.api_fid = kNumberToStr(self.serviceDetailModel.ServiceDetailModelID);
    request.api_type = @5;
    [_vapManager usersFavorites:request success:^(AFHTTPRequestOperation *operation, UsersFavoritesResponse *response) {
        if (!response.errorCode) {
            [KJShoppingAlertView showAlertTitle:@"收藏成功" inContentView:self.view];
            self.favoriteButton.selected = YES;
        }else {
            [KJShoppingAlertView showAlertTitle:@"收藏失败" inContentView:self.view];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [KJShoppingAlertView showAlertTitle:@"收藏失败" inContentView:self.view];
        
    }];
}

- (void)_cancelFavorite {
    
    PersonalCancelRequest *request = [[PersonalCancelRequest alloc] init:GetToken];
    request.api_fid = self.serviceDetailModel.ServiceDetailModelID;
    request.api_type = @5;
    [_vapManager personalCancel:request success:^(AFHTTPRequestOperation *operation, PersonalCancelResponse *response) {
        NSLog(@"取消收藏 response %@",response.errorCode);
        if (!response.errorCode) {
            [KJShoppingAlertView showAlertTitle:@"取消收藏成功" inContentView:self.view];
            self.favoriteButton.selected = NO;
        }else {
            [KJShoppingAlertView showAlertTitle:@"取消收藏失败" inContentView:self.view];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
            [KJShoppingAlertView showAlertTitle:@"取消收藏失败" inContentView:self.view];
    }];
}


- (IBAction)imidetelyBuyAction:(id)sender {
    UNLOGIN_HANDLE
    SubmitOrderController *submitOrderController = [[SubmitOrderController alloc] init];
    submitOrderController.serviceId = self.serviceDetailModel.ServiceDetailModelID.integerValue;
    submitOrderController.serviceName = self.serviceDetailModel.ggName;
    submitOrderController.price = kNumberToStr(self.serviceDetailModel.groupPrice);
    submitOrderController.maxNum = 1000;
    submitOrderController.serviceDetail = self.serviceDetailModel;
    [self.navigationController pushViewController:submitOrderController animated:YES];
}


#pragma mark - 打电话
- (IBAction)callPhoneAction:(id)sender {
    UNLOGIN_HANDLE
//    if (self.serviceDetailModel.licenseCTelephone) {
//        [Util dialWithPhoneNumber:self.serviceDetailModel.licenseCTelephone];
//    }
    if(self.serviceDetailModel.storeTelephone){
        [Util dialWithPhoneNumber:self.serviceDetailModel.storeTelephone];
    }
}


#pragma mark - 分享
- (IBAction)shareAction:(id)sender {
    UNLOGIN_HANDLE
    [self.shareView show];
}


-(JGShareView *)shareView {
    
    if (!_shareView) {
        if (!self.serviceDetailModel.licenseCTelephone) {
            self.serviceDetailModel.licenseCTelephone = @"";
        }
        NSString *shareContent = [NSString stringWithFormat:@"%@ %@ %@",self.serviceDetailModel.ggName,self.serviceDetailModel.storeAddress,self.serviceDetailModel.licenseCTelephone];
        _shareView = [JGShareView shareViewWithTitle:self.serviceDetailModel.storeName content:shareContent imgUrlStr:self.serviceDetailModel.groupAccPath ulrStr:kMerchantShareWithID(self.serviceDetailModel.ServiceDetailModelID) contentView:self.view shareImagePath:nil];
        NSString *wxShareContent = [NSString stringWithFormat:@"【%@】%@ %@ %@",self.serviceDetailModel.storeName,self.serviceDetailModel.ggName,self.serviceDetailModel.storeAddress,self.serviceDetailModel.licenseCTelephone];
//        _shareView.wxFriendShareModle.shareTitle = [NSString stringWithFormat:@"【%@】%@",self.serviceDetailModel.storeName,self.serviceDetailModel.ggName];
         _shareView.wxFriendShareModle.shareTitle = wxShareContent;
        _shareView.weiBoShareModel.shareContent = k_ShareDec;
        _shareView.qqShareModel.shareContent = k_ShareDec;
    }
    
    return _shareView;
}

#pragma mark - 进入地图页
- (IBAction)comtoMapPageAction:(id)sender {
    XKJHMapViewController *mapVc = [[XKJHMapViewController alloc] init];
    mapVc.shopAddress = self.serviceDetailModel.storeAddress;
    mapVc.latitude = self.serviceDetailModel.storeLat.doubleValue;
    mapVc.longitude = self.serviceDetailModel.storeLon.doubleValue;
    NSLog(@"经度 %.2f 纬度 %.2f",mapVc.latitude,mapVc.longitude);
    [self.navigationController pushViewController:mapVc animated:YES];
}

#pragma mark ----------------------- webView delegat Method ----------------------
-(void)webViewDidFinishLoad:(UIWebView *)webView {

    CGRect frame = webView.frame;
    frame.size.height = 1;
    webView.frame = frame;
    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    
    float height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] floatValue];
    height += 20;
    if (webView.tag == 1) {
        self.buyNeettoKnowWebViewHeightContraint.constant = height;
    }else {
        self.detailDescriptionWebViewHeightConstraint.constant = height;
    }
    [self.view layoutIfNeeded];
}

#pragma mark ----------------------- SDCycleScrollView delegate -----------------------
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{


}




@end
