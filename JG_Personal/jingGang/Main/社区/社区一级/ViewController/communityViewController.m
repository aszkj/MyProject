//
//  communityViewController.m
//  jingGang
//
//  Created by yi jiehuang on 15/5/21.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "communityViewController.h"
#import "PublicInfo.h"
#import "communitTableViewCell.h"
#import "WWSideslipViewController.h"
#import "communitBtn.h"
#import "shareView.h"
#import "JGShareView.h"
#import "SearchVC.h" ///-------wy
#import "userDefaultManager.h"
#import "UIImageView+WebCache.h"
#import "loginViewController.h"
#import "FollwerContent.h"
#import "UIImageView+AFNetworking.h"
#import "WebDayVC.h"
#import "advertManager.h"
#import "AppDelegate.h"
#import "MJRefresh.h"
#import "GlobeObject.h"
#import "UIView+BlockGesture.h"
#import "UIViewExt.h"
#import "RecommentCodeDefine.h"
#import "Util.h"
#import "H5page_URL.h"
#import "LeftSlideViewController.h"
#import "H5Base_url.h"
#import "TMCache.h"
#import "MJExtension.h"
#import "AppDelegate.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"

#import "mainPublicTableViewCell.h"
#import "mainPublicTableViewHeader.h"
#import "communitCardTableViewCell.h"
#import "comunitchildViewController.h"


#define codeCommunity @"SNS_INDEX_SLIDE"
#define codeCommunityDaty @"SNS_INDEX_ARTICLE"

@interface communityViewController ()<SDCycleScrollViewDelegate>
{
    JGShareView *_shareView;
    BOOL _isShare;//判断是否点击过分享按钮
    VApiManager       *_VApManager;
    
    /**
     *  每日精华数据
     */
    NSMutableArray *codeComDa;
    /**
     *  广告数据
     */
    NSArray     *headImgArr;

    int pageNum;
    
    TMCache             *_cache;
    BOOL                _hasCache;
    
}
@property (nonatomic,strong) UITableView *myTableView;


@end

NSString *const communityTableViewCell = @"mainPublicTableViewCell";
NSString *const communityUserTableViewCell = @"communitCardTableViewCell";

@implementation communityViewController

-(UITableView *)myTableView
{
    if (_myTableView == nil) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, __MainScreen_Height - 49 - 64) style:UITableViewStyleGrouped];
        [self.view addSubview:_myTableView];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        [_myTableView registerNib:[UINib nibWithNibName:@"mainPublicTableViewCell" bundle:nil] forCellReuseIdentifier:communityTableViewCell];
        [_myTableView registerNib:[UINib nibWithNibName:@"communitCardTableViewCell" bundle:nil] forCellReuseIdentifier:communityUserTableViewCell];
        _myTableView.backgroundColor = background_Color;
        [self.view bringSubviewToFront:_myTableView];
    }
    return _myTableView;
}
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.barTintColor = COMMONTOPICCOLOR;
    [super viewWillAppear:animated];
    // 友盟统计
    [MobClick beginLogPageView:kCommunityViewController];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 友盟统计
    [MobClick endLogPageView:kCommunityViewController];
}
#pragma mark - 实例化UI
- (void)initUI
{
    [_myScrollView removeAllSubviews];
    _VApManager = [[VApiManager alloc] init];
    //TODO:段头View
    float tableView_height = _midleView.frame.origin.y+_midleView.frame.size.height+10;
    UIView *tableViewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, tableView_height)];
    tableViewHeader.backgroundColor = background_Color;
    [tableViewHeader addSubview:_topScrollView];
    [tableViewHeader addSubview:_midleView];
    self.myTableView.tableHeaderView = tableViewHeader;
    
    _news_array = [[NSMutableArray alloc]init];
    pageNum = 1;
    codeComDa = [[NSMutableArray alloc]init];
    [self doSomeRequest];
    
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1];
    self.jtitle = @"健康圈";
    UIButton *rightSearch = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightSearch setImage:[UIImage imageNamed:@"search for1"] forState:UIControlStateNormal];
    rightSearch.frame = CGRectMake(__MainScreen_Width- 40, 30, 30, 31);
    rightSearch.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 8, 8);
    [rightSearch addTarget:self action:@selector(searchClickss) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightSearch];
    
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem barButtonItemSpace:-12],[[UIBarButtonItem alloc] initWithCustomView:rightSearch]];
    
    _lit_midel_view.hidden = YES;
    
}
- (void)viewDidLoad {

    [super viewDidLoad];
    [self _initBaseVCInfo];
    [self initUI];
    [self addHeaderFresh];
    [self addFooter];
    [self requestCommuntity:codeCommunityDaty];
    [self _requestAdDataWithCode:Community_shouye_ad_code];

    [self _initCacheData];
    
    
}

#pragma mark - 搜索
-(void)searchClickss
{
    SearchVC *search = [[SearchVC alloc]init];
//    UINavigationController *nas = [[UINavigationController alloc]initWithRootViewController:search];
//    nas.navigationBar.barTintColor = [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1];
//    [self presentViewController:nas animated:YES completion:nil];
    [self.navigationController pushViewController:search animated:YES];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if (codeComDa.count>5) {
            return 5;
        }else{
            return codeComDa.count;
        }
    }else{
        return self.news_array.count;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float  height = 45;
    switch (indexPath.section) {
        case 0:
        {
            height = __table_cell1_h;
        }
            break;
        case 1:
        {
            height = communitCellRowHeight;
        }
            break;
        case 2:
        {
            height = 92;
        }
            break;
            
        default:
            break;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {    
        mainPublicTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:communityTableViewCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section == 0) {
            if (indexPath.row < codeComDa.count) {
                    NSDictionary *dictss = codeComDa[indexPath.row];
                    NSString *url = [NSString stringWithFormat:@"%@_%ix%i",[dictss objectForKey:@"adImgPath"],(int)cell.left_img.frame.size.width*2,(int)cell.left_img.frame.size.height*2];
                    [cell.left_img sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"blank_default200"]];
                    cell.name_lab.text = [dictss objectForKey:@"adTitle"];
                    cell.sub_lab.text = [dictss objectForKey:@"adText"];
            }else{
                cell.left_img.image = nil;
                cell.name_lab.text = nil;
                cell.sub_lab.text = nil;
                cell.bg_img.hidden = YES;
                cell.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
            }
        }
        return cell;
    }

    //重构新代码
    communitCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:communityUserTableViewCell];
    if (indexPath.row < self.news_array.count)
    {
        NSDictionary * dic = [self.news_array objectAtIndex:indexPath.row];
        [cell customCellWithDict:dic withCircle:YES withTimePast:@"发"];
        WEAK_SELF
        cell.numWithBlock = ^(NSDictionary *dict){
            [weak_self.news_array removeObjectAtIndex:indexPath.row];
            [weak_self.news_array insertObject:dict atIndex:indexPath.row];
            [_myTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        };
        cell.likeWithBlock = ^(NSDictionary *dict){
            [weak_self.news_array removeObjectAtIndex:indexPath.row];
            [weak_self.news_array insertObject:dict atIndex:indexPath.row];
            [_myTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        };
        cell.shareBlock = ^(){
            
            [weak_self shareWithIndexPath:indexPath];
        };
        cell.fallowBlock = ^(){
            [weak_self fallowBack:dic];
        };
        [[NSUserDefaults standardUserDefaults]setObject:[dic objectForKey:@"title"] forKey:@"circleTitle"];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSDictionary *ser = codeComDa[indexPath.row];
        NSString *str = [NSString stringWithFormat:@"%@%@",Base_URL,[ser objectForKey:@"adUrl"]];
        [[NSUserDefaults standardUserDefaults]setObject:[ser objectForKey:@"adTitle"] forKey:@"circleTitle"];
        WebDayVC *web = [[WebDayVC alloc] init];
        web.strUrl = str;
        web.ind = 0;
        int type = [[ser objectForKey:@"adType"] intValue];
        if (type == 1) {
            web.dic = ser;
        }
        UINavigationController *nas = [[UINavigationController alloc]initWithRootViewController:web];
        nas.navigationBar.barTintColor =COMMONTOPICCOLOR;
        [self presentViewController:nas animated:YES completion:nil];
    }
    
    if(indexPath.section == 1)
    {
        if (self.news_array.count>0) {
            [[NSUserDefaults standardUserDefaults]setObject:[self.news_array objectAtIndex:indexPath.row] forKey:@"circleTitle"];
            WebDayVC *weh = [[WebDayVC alloc]init];
            NSDictionary * dic = [self.news_array objectAtIndex:indexPath.row];
            [[NSUserDefaults standardUserDefaults]setObject:dic[@"title"]  forKey:@"circleTitle"];
            NSString *url = [NSString stringWithFormat:@"%@%@%@",Base_URL,user_tiezi,[dic objectForKey:@"id"]];
            weh.strUrl = url;
            weh.ind = 1;
            weh.dic = [self.news_array objectAtIndex:indexPath.row];
            weh.backBlock = ^(){
            };
            UINavigationController *nas = [[UINavigationController alloc]initWithRootViewController:weh];
            nas.navigationBar.barTintColor = COMMONTOPICCOLOR;
            [self presentViewController:nas animated:YES completion:nil];
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return __table_section_h;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    mainPublicTableViewHeader *headerView = [[NSBundle mainBundle]
                                             loadNibNamed:@"mainPublicTableViewHeader" owner:self options:nil][0];
    NSArray * name_array = [NSArray arrayWithObjects:@"每日精华",@"用户帖子", nil];
    headerView.titleNameLabel.textColor = COMMONTOPICCOLOR;
    headerView.titleNameLabel.text = name_array[section];
    if (section == 0) {
        headerView.statusLabel.text = @"新认识";
        headerView.titleImageView.image = [UIImage imageNamed:@"everyday"];
        headerView.titleNameLabel.textColor = COMMONTOPICCOLOR;
    }
    else
    {
        headerView.titleImageView.image = [UIImage imageNamed:@"com_post"];
        headerView.statusLabel.hidden = YES;
        headerView.statusImageView.hidden = YES;
    }
    return headerView;
}

#pragma mark - 控制表格线条从左边开始
-(void)viewDidLayoutSubviews
{
    if ([_myTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_myTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([_myTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_myTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - 尾部刷新
- (void)addFooter
{
    WEAK_SELF
    [_myTableView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        [weak_self doSomeRequest];
    }];
}

#pragma mark - 头部刷新
- (void)addHeaderFresh{
    WEAK_SELF
    [_myTableView addHeaderWithCallback:^{
        pageNum = 1;
        [weak_self doSomeRequest];
        [weak_self requestCommuntity:codeCommunityDaty];
        [weak_self _requestAdDataWithCode:Community_shouye_ad_code];
    }];
}

-(void)setAlter
{
    UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"没有更多了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
}
#pragma mark - 跟帖
-(void)fallowBack:(NSDictionary *)dic
{
    UNLOGIN_HANDLE
    [[NSUserDefaults standardUserDefaults]setObject:dic[@"title"]  forKey:@"circleTitle"];
    FollwerContent *follow = [[FollwerContent alloc]init];
    NSNumber *nubm = dic[@"id"];
    
    follow.num = nubm;
    WEAK_SELF
    follow.commentBlcock = ^(BOOL success){
        if (success) {
            // pageNum = 1;
            [weak_self.news_array removeAllObjects];
        }
    };
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:follow];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - ==========================网络请求数据================================

#pragma mark - 网络请求动画URl数据
-(void)_requestAdDataWithCode:(NSString *)addCode{
    
    NSString *token = [userDefaultManager GetLocalDataString:@"Token"];
    SnsRecommendListRequest *request = [[SnsRecommendListRequest alloc] init:token];
    request.api_posCode = addCode;
    WEAK_SELF
    [_VApManager snsRecommendList:request success:^(AFHTTPRequestOperation *operation, SnsRecommendListResponse *response) {
        [_myTableView headerEndRefreshing];
        //        NSLog(@"%@",response);
        headImgArr = response.advList;
        //重新计算头部
        [weak_self calCulateHeadScrollSizeWithArr];
        //广告缓存
        [_cache setObject:response.advList forKey:Tuijianwei_ad_cache_communityID];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error.localizedDescription);
    }];
    
}//请求头部



#pragma mark - 网络请求每日精华
-(void)requestCommuntity:(NSString *)code
{

    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
    SnsRecommendListRequest *snsRecommendListRequest = [[SnsRecommendListRequest alloc] init:accessToken];
    
    snsRecommendListRequest.api_posCode = code;
    
    
    [_VApManager snsRecommendList:snsRecommendListRequest success:^(AFHTTPRequestOperation *operation, SnsRecommendListResponse *response) {
        
        NSLog(@"snsRecommen----推荐成功");
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"--------SNSRecommen----%@",dict);
        
        NSArray *arr = [dict objectForKey:@"advList"];
        
        NSMutableArray *requestData = [NSMutableArray arrayWithCapacity:arr.count];
        for (NSDictionary *dic in arr) {
            [requestData addObject:dic];
        }
        codeComDa = requestData;
        [_myTableView reloadData];
        
        //缓存每日精华
        if ( arr > 0) {
            [_cache setObject:arr forKey:Tuijianwei_perdayessene_cache_communityID];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"========snsRecom---%@",error);
    }];
    
}

#pragma mark - 请求用户帖子数据
-(void)doSomeRequest
{
    UsersInvitationAllListRequest *userCirCleInvitationList = [[UsersInvitationAllListRequest alloc] init:GetToken];
    userCirCleInvitationList.api_invitationType = @1;
    userCirCleInvitationList.api_pageNum = @(pageNum);
    userCirCleInvitationList.api_pageSize = @5;
    WEAK_SELF
    [_VApManager usersInvitationAllList:userCirCleInvitationList success:^(AFHTTPRequestOperation *operation, UsersInvitationAllListResponse *response) {
        [_myTableView footerEndRefreshing];
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        NSString * codeStr = [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]];
        if ([codeStr intValue]) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"获取用户帖子失败，请检查网络。" delegate:weak_self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }else{
            NSArray * array = [dict objectForKey:@"invitation"];
            if ([array count] == 0) {//没有数据提示
                [weak_self setAlter];
                [_myTableView reloadData];
                return ;
            }
            if (pageNum == 1) {
                [weak_self.news_array removeAllObjects];
            }
            pageNum++;
            [weak_self.news_array addObjectsFromArray:array];
            [_myTableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_myTableView footerEndRefreshing];
    }];
}
#pragma mark - 分享
-(void)shareWithIndexPath:(NSIndexPath *)index{
    NSLog(@"ceshi ---- %@",NSStringFromCGRect(_shareView.frame));
    if (_isShare) {
        return;
    }
    _isShare = YES;
    
    NSDictionary *dict = self.news_array[index.row];
    
    NSString *share_title = dict[@"title"];
    NSString *imageUrl = [dict objectForKey:@"thumbnail"];
    if(imageUrl == nil){
        imageUrl = [dict objectForKey:@"headImgPath"];
    }
    NSString *share_imagerUrl = imageUrl;
    NSString *share_URL = [NSString stringWithFormat:@"%@%@%@",Base_URL,user_tiezi,[dict objectForKey:@"id"]];
    
    UsersInvitationDetailsRequest *usersInvitationDetailsRequest = [[UsersInvitationDetailsRequest alloc] init:GetToken];
    
    usersInvitationDetailsRequest.api_invnId = [dict objectForKey:@"id"];
    WEAK_SELF
    [_VApManager usersInvitationDetails:usersInvitationDetailsRequest success:^(AFHTTPRequestOperation *operation, UsersInvitationDetailsResponse *response) {
        _shareView = [JGShareView shareViewWithTitle:share_title content:response.content imgUrlStr:share_imagerUrl ulrStr:share_URL contentView:weak_self.view.window shareImagePath:nil];
        [_shareView show];
        _shareView.hiddenBlock = ^(){
            _isShare = NO;
        };
        communitCardTableViewCell *cell = [_myTableView cellForRowAtIndexPath:index];
        cell.isShare = YES;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _isShare = NO;
        [Util ShowAlertWithOutCancelWithTitle:@"提示" message:@"请求分享内容失败"];
    }];
    
}


#pragma mark  - ==========================初始化缓存信息==========================
-(void)_initCacheData{
    
    _cache = [TMCache sharedCache];
    
    
#pragma mark - 先去掉头部广告缓存
//    //广告
//    headImgArr = [_cache objectForKey:Tuijianwei_ad_cache_communityID];
//    if (headImgArr) {//如果不为空，赋给headImgArr
//        [self calCulateHeadScrollSizeWithArr];
//    }
    
//    NSLog(@"head add %@",headImgArr);

    
    //相关资讯
    NSArray *arr = nil;
    arr = [_cache objectForKey:Tuijianwei_perdayessene_cache_communityID];
    codeComDa = [NSMutableArray arrayWithArray:arr];
    if (arr.count > 0 ) {
        _hasCache = YES;
    }
    
}


#pragma mark - 处理头部scroll view
-(void)calCulateHeadScrollSizeWithArr {
    
    //获取图片url数组
    NSMutableArray *clearImgUrlArr = [NSMutableArray arrayWithCapacity:headImgArr.count];
    for (NSDictionary *dic in headImgArr) {
        NSString *originalImgStr = dic[@"adImgPath"];
        NSString *clearImgUrl = [NSString stringWithFormat:@"%@_%ix%i",originalImgStr,(int)_topScrollView.frame.size.width*2,(int)_topScrollView.frame.size.height*2];
        [clearImgUrlArr addObject:clearImgUrl];
        
    }
    _topScrollView.delegate = self;
    _topScrollView.imageURLStringsGroup = (NSArray *)clearImgUrlArr;
    
}

#pragma mark - SDCycleScrollViewDelegate  动画代理协议
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSDictionary *dic = headImgArr[index];
    WebDayVC *web = [[WebDayVC alloc]init];
    web.strUrl = [NSString stringWithFormat:@"%@%@",Base_URL,[dic objectForKey:@"adUrl"]];
    int type = [[dic objectForKey:@"adType"] intValue];
    if (type == 1) {
        web.dic = dic;
    }
    [[NSUserDefaults standardUserDefaults]setObject:[dic objectForKey:@"adTitle"] forKey:@"circleTitle"];
    UINavigationController *nas = [[UINavigationController alloc]initWithRootViewController:web];
    nas.navigationBar.barTintColor = COMMONTOPICCOLOR;
    [self presentViewController:nas animated:YES completion:nil];
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

}

#pragma mark --------------------- 初始化基类视图，数据信息  ---------------------
-(void)_initBaseVCInfo {
    
    [self initBaseVCInfo];
    [self _setCirlcleData];
}


#pragma mark ----------------------- 八大分类 -----------------------
#pragma mark - 配置八大分类数据源
-(void)_setCirlcleData {
//    NSArray *mainCircleItems = @[@{@"gcName":@"亚健康",@"mobileIcon":@"com_1",@"headImg":@"com_subh02"},
//                                 @{@"gcName":@"饮食",@"mobileIcon":@"com_2",@"headImg":@"com_drink02"},
//                                 @{@"gcName":@"运动",@"mobileIcon":@"com_3",@"headImg":@"com_sport02"},
//                                 @{@"gcName":@"生活",@"mobileIcon":@"com_4",@"headImg":@"com_life02"},
//                                 @{@"gcName":@"丽人",@"mobileIcon":@"com_5",@"headImg":@"com_women02"},
//                                 @{@"gcName":@"两性",@"mobileIcon":@"com_6",@"headImg":@"com_bisexual02"},
//                                 @{@"gcName":@"养生",@"mobileIcon":@"com_7",@"headImg":@"com_food02"},
//                                 @{@"gcName":@"育儿",@"mobileIcon":@"com_8",@"headImg":@"com_baby02"}];
    NSArray *mainCircleItems = @[@{@"gcName":@"亚健康",@"mobileIcon":@"healthOne",@"headImg":@"healthOne"},
                                 @{@"gcName":@"饮食",@"mobileIcon":@"healthTwo",@"headImg":@"healthTwo"},
                                 @{@"gcName":@"运动",@"mobileIcon":@"healthThree",@"headImg":@"healthThree"},
                                 @{@"gcName":@"生活",@"mobileIcon":@"healthFour",@"headImg":@"healthFour"},
                                 @{@"gcName":@"丽人",@"mobileIcon":@"healthFive",@"headImg":@"healthFive"},
                                 @{@"gcName":@"两性",@"mobileIcon":@"healthSix",@"headImg":@"healthSix"},
                                 @{@"gcName":@"养生",@"mobileIcon":@"healthSeven",@"headImg":@"healthSeven"},
                                 @{@"gcName":@"育儿",@"mobileIcon":@"healthEight",@"headImg":@"healthEight"}];
    self.middleDataArr = mainCircleItems;
    
}


#pragma mark - 点击八大分类点击事件
-(void)clickCircleAtIndex:(NSInteger)circleIndex {
     comunitchildViewController * comunitchildVc = [[comunitchildViewController alloc]init];
    comunitchildVc.cycleId = (int)(circleIndex + 1);
    comunitchildVc.head_img_str = self.middleDataArr[circleIndex][@"headImg"];
    comunitchildVc.JGTitle = [self.middleDataArr[circleIndex][@"gcName"] stringByAppendingFormat:@"圈"];
    [self.navigationController pushViewController:comunitchildVc animated:YES];
    
}


@end
