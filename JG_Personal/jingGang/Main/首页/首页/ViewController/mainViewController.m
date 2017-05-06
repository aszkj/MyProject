//
//  mainViewController.m
//  jingGang
//
//  Created by yi jiehuang on 15/5/12.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "mainViewController.h"
#import "mainTableViewCell.h"
#import "userDefaultManager.h"
#import "WWSideslipViewController.h"
#import "VApiManager.h"
#import "userDefaultManager.h"
#import "UIImageView+AFNetworking.h"
#import "WebDayVC.h"
#import "H5Base_url.h"
#import "GlobeObject.h"
#import "PublicInfo.h"
#import "UserCustomer.h"
#import "UIImageView+WebCache.h"
#import "JGBlueToothManager.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "RecommentCodeDefine.h"
#import "UIViewExt.h"
#import "UIView+BlockGesture.h"
#import "TMCache.h"
#import "Util.h"
#import "projectViewController.h"
#import "sunViewController.h"
#import "AppDelegate.h"
#import "UserModel.h"
#import "APService.h"
#import "CareChoosenCollectionView.h"
#import "GoodStoreRecommendTableView.h"
#import "mapObject.h"
#import "UIViewExt.h"
#import "PStoreInfoModel.h"
#import "GoodsDetailModel.h"
#import "CustomTabBar.h"
#import "weatherManager.h"
#import "mainPublicTableViewCell.h"
#import "DefuController.h"
#import "devicesViewController.h"
#import "NewCenterVC.h"
#import "ShoppingHomeController.h"
#import "consultationViewController.h"
#import "mainPublicTableViewHeader.h"
#import "UIButton+Block.h"
#import "JGActivityDetailController.h"
#import "JGActivityColumnHelper.h"
#import "JGActivityTools.h"
#import "JGDropdownMenu.h"
#import "JGActivityCommonController.h"
#import "JGActivityWebController.h"
#import "JGActivityHelper.h"

#import "userTestTableViewCell.h"
#import "JGHealthTaskManager.h"
#import "JGMainClickView.h"
#import "ZongHeZhengVC.h"
#import "ZhengZhuangVC.h"
#import "ListVC.h"
#import "foodViewController.h"
#import "someTestViewController.h"
#import "testchildViewController.h"
#import "HeatTestVC.h"
#import "JGCustomTestFaceController.h"

#define mainDataReq @"INDEX_ELITE"

#import "individualSignView.h"
#define defaultRecommentCount 4
static BOOL locationMap;  //APP打开只进行一次定位
@interface mainViewController ()<SDCycleScrollViewDelegate,weatherManagerDelegate,JGMainClickViewDelegate>
{
    BOOL weatherIsOpen;
    float table_height;
    
    JGMainClickView *_mainClickView;
    
    weatherManager *_weatherManager;
    UITableView    *_myTableView;
    UILabel        * address_lab;//具体地址
    VApiManager    *_vapManager;
    NSMutableArray *arr_data;
    
    UIImageView * log_img;
    UILabel * weather_lab;
    UIImageView * weather_img;
    UIImageView *iamge_bg;
    UIView * topView;
//    天气图
    UIView * top_view;
    
    NSTimer        *_myTimer;
    NSMutableArray *headImgArr;
    
    JGBlueToothManager *_jgBlutoothManger;
    
    TMCache             *_cache;
    BOOL                _hasCache;
    UIImageView * img2;
    
    NSString    *_jingGangProjectImgUrlStr;
    
    CareChoosenCollectionView *careChoosenCollectionView;
    GoodStoreRecommendTableView *goodStoreRecommendTableView;
    UIView *goodsChooseenHeaderView;
    UIView *goodStoreHeaderView;
    
    NSNumber *_longtitude; //纬度
    NSNumber *_latitude;//经度
    NSNumber *_cityID;//城市ID
}
@property (nonatomic, strong) individualSignView *signPrompt;//签到提示

@property (assign, nonatomic) NSInteger comingCount;

@property (strong,nonatomic) UIButton *nyButton;

@property (strong,nonatomic) JGDropdownMenu *menu;

@end

NSString * const mainCell = @"mainPublicTableViewCell";

@implementation mainViewController

//版本标记 2016-2-23 10:26

static mainViewController *shopview = nil;

+ (mainViewController *) instance {
    if (shopview == nil){
        shopview = [[mainViewController alloc] init];
    }
    return shopview;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
//    self.navigationController.navigationBar.barTintColor = kGetColor(232, 36, 39);
    self.navigationController.navigationBar.barTintColor = COMMONTOPICCOLOR;
    // 友盟统计
    [MobClick beginLogPageView:kMainViewController];
    
    _longtitude = [[mapObject sharedMap] baiduLongitude];
    _latitude = [[mapObject sharedMap] baiduLatitude];
    _cityID = [[mapObject sharedMap] baiduCityID];

  
#pragma  mark ---- 每日精华网络数据请求 --------
    [self requestCommuntity:mainDataReq];
    // 判断定位操作是否被允许
    if([CLLocationManager locationServicesEnabled]) {
        if (nil == _myLocation)
        {
            _myLocation = [[CLLocationManager alloc] init];
        }
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        {
            [_myLocation requestWhenInUseAuthorization];
            
        }

        _myLocation.delegate = self;
//        [_myLocation requestWhenInUseAuthorization];
        [_myLocation startUpdatingLocation];
    }else {
        [SVProgressHUD dismissWithSuccess:@"定位不成功，请打开设备定位功能" afterDelay:1];
    }
    //显示导航栏上UI
    [self _displayOrHidden:NO];
    
   
}
- (void)showActivityView:(ActivityHotSaleApiBO *)apiBo {
    
    JGDropdownMenu *menu = [JGDropdownMenu menu];
    [menu configTouchViewDidDismissController:NO];
    [menu configBgShowMengban];
    JGShopActiveContentController *activityController = [[JGShopActiveContentController alloc] initWithControllerType:ControllerPopImageType imageUrlString:[JGActivityHelper downloadActivityImageWithUrlString]];
    __weak typeof(JGDropdownMenu *)weakMenu = menu;
    activityController.closeViewClickBlock = ^(){
        [weakMenu dismiss];
        [JGActivityHelper dismissImage];
    };
    
    WeakSelf;
    activityController.pushActivityPageBlock = ^(){
        [weakMenu dismiss];
        NSString *strNewUrl = [NSString stringWithFormat:@"%@/newyear/cash_coupon.htm",Shop_url];
        JGActivityWebController *webController = [[JGActivityWebController alloc] initWithAdvertBO:nil withHeaderRequest:strNewUrl ApiBO:apiBo isPushType:NO];
        [bself.navigationController pushViewController:webController animated:YES];
    };
    
    activityController.view.width = ScreenWidth;
    activityController.view.height = ScreenHeight - 3.5 * NavBarHeight;
    menu.contentController = activityController;
    [menu showWithFrameWithDuration:0.25];
    self.menu = menu;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    if(weatherIsOpen){
        [self ImageCLcikHide];
    }
    //隐藏导航栏上的UI
    [self _displayOrHidden:YES];
    self.navigationController.navigationBar.barTintColor = COMMONTOPICCOLOR;
    [self.menu dismiss];
    [JGActivityHelper notTargetControllerShowImage];
    // 友盟统计
    [MobClick endLogPageView:kMainViewController];
}



//每日精华推荐请求
-(void)requestCommuntity:(NSString *)code
{
    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
    SnsRecommendListRequest *snsRecommendListRequest = [[SnsRecommendListRequest alloc] init:accessToken];
    snsRecommendListRequest.api_posCode = code;
    [_vapManager snsRecommendList:snsRecommendListRequest success:^(AFHTTPRequestOperation *operation, SnsRecommendListResponse *response) {
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        NSArray *arr = [dict objectForKey:@"advList"];
        NSMutableArray *requestData = [NSMutableArray arrayWithCapacity:arr.count];
        for (int i=0; i<arr.count; i++) {
            [requestData addObject:arr[i]];
        }
        arr_data = requestData;
        if (!_hasCache) {//第一次没有缓存的话，在这里创建，在请求结果里创建
            [self creatUIFace];
        }
        [_myTableView reloadData];
        if (arr_data.count > 0) {
            //缓存每日精华
            [_cache setObject:arr_data forKey:Tuijianwei_perdayessene_cache_shouyeID];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

#pragma mark - Location
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currentLocation = [locations lastObject];
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    //根据经纬度反向地理编译出地址信
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *array, NSError *error)
    {
        if (array.count > 0)
        {
            CLPlacemark *placemark = [array objectAtIndex:0];
            //将获得的所有信息显示到label上
//            NSLog(@"placemark.name-------->%@",placemark.name);
            //获取城市
            NSString *city = placemark.locality;
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
            NSString * city_name = [[city componentsSeparatedByString:@"市"]objectAtIndex:0];
            [userDefaultManager SetLocalDataString:city_name key:@"city"];
            address_lab.text = city_name;
            if (!_weatherManager) {
                _weatherManager = [[weatherManager alloc]init];
            }
            [_weatherManager setLocationWithCity:city_name];
            [_weatherManager startRequestWithDelegate:self];
        }
        else if (error == nil && [array count] == 0)
        {
            JGLog(@"No results were returned.");
        }
        else if (error != nil)
        {
            JGLog(@"An error occurred = %@", error);
        }
        
    }];
    [_myLocation stopUpdatingLocation];
}

- (void)shouldShowActivityNoti:(NSNotification *)noti {
    NSString *notiObj = TNSString(noti.object);
    
    if (![notiObj integerValue]) {
        self.nyButton.hidden = NO;
    }else {
        self.nyButton.hidden = YES;
    }
    
    if ([JGActivityHelper downloadActivityImageWithUrlString]) {
        // 图片已经下载
        if ([JGActivityHelper showImage]) {
            [self showActivityView:[JGActivityHelper sharedManager].response.activityHotSaleApiBO];
        }
    }
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    if (self.nyButton.hidden) {
        [JGActivityHelper queryActivityWithActivityCode:@"APP_SPRING_FESTIVAL" progressing:^{
            
        } beyondTime:^{
            self.nyButton.hidden = YES;
        } error:^(NSError *error) {
        } notiBlock:^{
            self.nyButton.hidden = NO;
        }];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];

    weatherIsOpen = NO;
    [kNotification addObserver:self selector:@selector(shouldShowActivityNoti:) name:@"PostActivityKey" object:nil];
//    初始化视图

    [self _initBaseVCInfo];
    
    _vapManager = [[VApiManager alloc]init];
    _jgBlutoothManger = [JGBlueToothManager shareInstances];
    
    arr_data = [[NSMutableArray alloc]init];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1];
    
    topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __MainScreen_Width, __Other_Height)];
    topView.backgroundColor = [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1];
    
    self.navigationController.navigationBar.barTintColor = COMMONTOPICCOLOR;
    
    log_img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 54, 27)];
    log_img.image = [UIImage imageNamed:@"home_logo"];
    log_img.center = CGPointMake(__MainScreen_Width/2, __Other_Height/2-3);
    [self.navigationController.view addSubview:log_img];
    
    //  地址- 天气
    address_lab = [[UILabel alloc]init];
    address_lab.frame = CGRectMake(__MainScreen_Width-55, __StatusScreen_Height+7, 40, 15);
    address_lab.font = [UIFont systemFontOfSize:13];
    address_lab.textColor = [UIColor whiteColor];
    if ([userDefaultManager GetLocalDataString:@"city"]) {
        NSString * city_name = [[[userDefaultManager GetLocalDataString:@"city"] componentsSeparatedByString:@"市"]objectAtIndex:0];
        address_lab.text = city_name;
    }else
    {
        address_lab.text = @"暂无";
    }
    [self.navigationController.view addSubview:address_lab];
    
    weather_lab = [[UILabel alloc]init];
    weather_lab.frame = CGRectMake(__MainScreen_Width-55, address_lab.frame.origin.y+address_lab.frame.size.height+5, 80, 15);
    weather_lab.textColor = [UIColor whiteColor];
    weather_lab.font = [UIFont systemFontOfSize:14];
    NSString * max_weather = [userDefaultManager GetLocalDataString:@"maxWeather"];
    NSArray  * array = [max_weather componentsSeparatedByString:@"℃"];
    if ([userDefaultManager GetLocalDataString:@"maxWeather"]) {
        weather_lab.text = [NSString stringWithFormat:@"%@/%@",[array firstObject],[userDefaultManager GetLocalDataString:@"minWeather"]];
    }else{
        weather_lab.text = @"暂无数据";
        weather_lab.font = [UIFont systemFontOfSize:15];
    }
    [self.navigationController.view addSubview:weather_lab];
    RELEASE(weather_lab);
    
    weather_img = [[UIImageView alloc]init];
    weather_img.frame = CGRectMake(address_lab.frame.size.width+address_lab.frame.origin.x-5, address_lab.frame.origin.y, 15, 15);
    weather_img.image = [UIImage imageNamed:@"home_sunny"];
    [self.navigationController.view addSubview:weather_img];
    RELEASE(weather_img);
    
    iamge_bg = [[UIImageView alloc]init];
    iamge_bg.frame = CGRectMake(__MainScreen_Width-60, __StatusScreen_Height+3, 60, 40);
    iamge_bg.backgroundColor = [UIColor clearColor];
    iamge_bg.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapIcmi = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ImageCLcikShow:)];
    [iamge_bg addGestureRecognizer:tapIcmi];
    [self.navigationController.view addSubview:iamge_bg];
    RELEASE(iamge_bg);
    [self initWeatherView];
    if (!IsEmpty(GetToken)) {
        //用户信息查询
        [self _userInfoRequest];
        //用户运动，睡眠数据查询
        [self _getTheDayMotionDataRequest];
        [self _getTheDaySleepDataRequest];
    }
    //初始化缓存
    [self _initCacheData];
    //  - 轮播图广告请求、 静港项目请求。
    [self _requestAdDataWithCode:Main_tuijian_ad_code];
    if (_hasCache) {//有缓存，才在viewdidload创建,没有缓存，不能在这里面创建，
        [self creatUIFace];
    }
    //头部刷新
    [self addHeaderFresh];
}

- (UIButton *)nyButton {
    if (!_nyButton) {
//        UIButton *nyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *nyButton;
        nyButton.x = kScreenWidth - 64;
        nyButton.height = 64;
        nyButton.y = kScreenHeight - 64 - nyButton.height - 55;
        nyButton.width = 58;
        [nyButton setImage:[UIImage imageNamed:@"year_yhj"] forState:UIControlStateNormal];
        [nyButton addTarget:self action:@selector(newyearActivityAction) forControlEvents:UIControlEventTouchUpInside];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view addSubview:nyButton];
        });
        _nyButton = nyButton;
    }
    return _nyButton;
}


- (void)newyearActivityAction {
    [self showActivityView:[JGActivityHelper sharedManager].response.activityHotSaleApiBO];
    
    
}



-(void)_displayOrHidden:(BOOL)isHidden{
    log_img.hidden = isHidden;
    address_lab.hidden = isHidden;
    weather_lab.hidden = isHidden;
    weather_img.hidden = isHidden;
    iamge_bg.hidden = isHidden;
}

#pragma mark    更新界面 -----

-(void)creatUIFace
{
//    float table_height = _lit_midel_view.frame.origin.y+_lit_midel_view.frame.size.height;//中间图片的大小地址
    table_height = _topScrollView.frame.origin.y+_topScrollView.frame.size.height;
    
    
#pragma mark    JGMainClickView 首页八个点击View
// mainClickView不可  <320
    _mainClickView = [[JGMainClickView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 340)];
    _mainClickView.delegate = self;
    
    _myTableView = [[UITableView alloc]init];
    _myTableView.frame = CGRectMake(0, table_height+10, __MainScreen_Width, __table_cell1_h*arr_data.count+__table_section_h);
    _myTableView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.25];
    [_myTableView registerNib:[UINib nibWithNibName:@"mainPublicTableViewCell" bundle:nil] forCellReuseIdentifier:mainCell];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.scrollEnabled = NO;
    _myTableView.tableHeaderView = _mainClickView;
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
//    lineView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.8];
    _myTableView.tableFooterView = lineView;
    [_myScrollView addSubview:_myTableView];
    

#pragma mark - 精选商品修改的
    goodsChooseenHeaderView = BoundNibView(@"CareChoosenGoodsHeaderView", UIView);
    goodsChooseenHeaderView.frame = CGRectMake(0, CGRectGetMaxY(_myTableView.frame)+10, kScreenWidth, 30);
    goodsChooseenHeaderView.hidden = YES;
    [_myScrollView addSubview:goodsChooseenHeaderView];
//     careChoosenCollectionView = [[CareChoosenCollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(goodsChooseenHeaderView.frame), kScreenWidth, kCareChoosenGoodsCellHeight*2) collectionViewLayout:nil];
    careChoosenCollectionView = [[CareChoosenCollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(goodsChooseenHeaderView.frame), kScreenWidth, 1) collectionViewLayout:nil];
    careChoosenCollectionView.hidden = YES;
    [_myScrollView addSubview:careChoosenCollectionView];
    
#pragma mark - 好店推荐修改的
    goodStoreHeaderView = BoundNibView(@"GoodStoreRecommendHeaderView", UIView);
    goodStoreHeaderView.frame = CGRectMake(0, CGRectGetMaxY(careChoosenCollectionView.frame)+10, kScreenWidth, 30);
    goodStoreHeaderView.hidden = YES;
    [_myScrollView addSubview:goodStoreHeaderView];
    
//    goodStoreRecommendTableView = [[GoodStoreRecommendTableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(goodStoreHeaderView.frame), kScreenWidth, GoodStoreCellHeight*defaultRecommentCount) style:UITableViewStylePlain];
    
    goodStoreRecommendTableView = [[GoodStoreRecommendTableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(goodStoreHeaderView.frame), kScreenWidth,1) style:UITableViewStylePlain];
//    goodStoreRecommendTableView.backgroundColor = [UIColor redColor];
    goodStoreRecommendTableView.hidden = YES;
    [_myScrollView addSubview:goodStoreRecommendTableView];
    
    _myScrollView.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(goodStoreRecommendTableView.frame)-20);
    
    //TODO:APP登录成功之后进行一次定位
    if (!locationMap)
    {
        [[mapObject sharedMap] BaiduPositionReusltAddID:^(NSString *addressCity, CLLocationCoordinate2D location, NSNumber *cityID) {
            _longtitude = [[mapObject sharedMap] baiduLongitude];
            _latitude = [[mapObject sharedMap] baiduLatitude];
            _cityID = [[mapObject sharedMap] baiduCityID];
            //请求精选商品
            [self _requestCareChoosenGoods];
        }];
        locationMap = YES;
    }
    else
    {
        //请求精选商品
        [self _requestCareChoosenGoods];
    }
}
#pragma mark 首页点击八大类
-(void)SelectButtonClick:(NSInteger)tag{
    
    switch (tag) {
        case 12306:{
//            疾病跳转
            ZongHeZhengVC *zongheZhenVC =  [[ZongHeZhengVC alloc] init];
            zongheZhenVC.selfTestTiID = @52;
            zongheZhenVC.comminType = Commin_From_JiBing;
             [self.navigationController pushViewController:zongheZhenVC animated:YES];
        }
            
            break;
        case 12307:{
//        综合症跳转
            ZongHeZhengVC *zongheZhenVC =  [[ZongHeZhengVC alloc] init];
            zongheZhenVC.selfTestTiID = @51;
            zongheZhenVC.comminType = commin_From_Zong_He_Zheng;
            [self.navigationController pushViewController:zongheZhenVC animated:YES];
        }
            break;
        case 12308:{
//        心理跳转
            ZongHeZhengVC *zongHeZhengVC = [[ZongHeZhengVC alloc] init];
            zongHeZhengVC.comminType = Commin_From_Heart;
            zongHeZhengVC.selfTestTiID = @59;
            [self.navigationController pushViewController:zongHeZhengVC animated:YES];
//            sunViewController * sunVc = [[sunViewController alloc]init];
//            sunVc.btn_tag = 800;
//            sunVc.name_str = @"心理";
//            sunVc.careChoosenCode = Life_Psychology_careChoosenGoods_Code;
//            sunVc.goodStoreRecommendCode = Life_Psychology_goodStoreRecommend_Code;
//            sunVc.midel_img_name = @"life_psy";
//            sunVc.logo_textArr = [NSArray arrayWithObjects:@"心理篇",@"新发现",@"新体验", nil];
//            sunVc.witch_vc = 4;
//            sunVc.name_Array = [NSArray arrayWithObjects:@"检测方法",@"相关资讯",@"好店推荐", nil];
//            [self.navigationController pushViewController:sunVc animated:YES];
        }
            break;
        case 12309:{
//        医学美容跳转
            JGCustomTestFaceController *face = [[JGCustomTestFaceController alloc] init];
            [self.navigationController pushViewController:face animated:YES];
            
//            ZhengZhuangVC *zhengZhuangVC = [[ZhengZhuangVC alloc] init];
////            zhengZhuangVC.zz_ModelType = Face_Model_type;
//            zhengZhuangVC.listType = FigureType;
//            zhengZhuangVC.zz_ModelType = Figure_Model_type;
//            [self.navigationController pushViewController:zhengZhuangVC animated:YES];
//            testchildViewController * testChildVc = [[testchildViewController alloc]init];
//            [self.navigationController pushViewController:testChildVc animated:YES];
        }
            break;
        case 12310:{
//        体验跳转
            UNLOGIN_HANDLE
            DefuController *defuVC = [[DefuController alloc] init];
            [self.navigationController pushViewController:defuVC animated:YES];
        }
            break;
        case 12311:{
//            智能穿戴跳转
            UNLOGIN_HANDLE
            devicesViewController * devicesVc = [[devicesViewController alloc]init];
            [Util asRootOfVC:devicesVc];
        }
            break;
        case 12312:{
//        食物计算器跳转
            ListVC *listVC = [[ListVC alloc] init];
            listVC.listType = FoodCalculatorType;
            [self.navigationController pushViewController:listVC animated:YES];
        }
            break;
        case 12313:{
//            膳食建议跳转
            foodViewController * foodVc = [[foodViewController alloc]init];
            [self.navigationController pushViewController:foodVc animated:YES];
        }
            break;
        default:
            break;
    }
    
}
#pragma mark - 请求精选商品
-(void)_requestCareChoosenGoods{
    VApiManager *vapManager = [[VApiManager alloc] init];
    SnsCrcListRequest *request = [[SnsCrcListRequest alloc] init:GetToken];
    request.api_lat = _latitude;
    request.api_lon = _longtitude;
    request.api_cityId = _cityID;
    request.api_posCode = Main_careChoosenGoods_Code;
    [vapManager snsCrcList:request success:^(AFHTTPRequestOperation *operation, SnsCrcListResponse *response) {
        
        NSInteger itemCount = response.advList.count;
        if (itemCount > 0) {//有推荐商品
            
            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:response.advList.count];
            NSInteger goodsCount=0;
            for (NSDictionary *dic in response.advList) {
                NSInteger recommendTypeNum = [dic[@"adType"] integerValue];
                if (recommendTypeNum != 2) {//过滤非商品的
                    continue;
                }
                goodsCount ++;
                GoodsDetailModel *model = [[GoodsDetailModel alloc] initWithJSONDic:dic[@"shopGoods"]];
                model.goodsMainPhotoPath = dic[@"adImgPath"];
                [arr addObject:model];
            }
            
            itemCount = goodsCount;
//            goodsChooseenHeaderView.frame = CGRectMake(0, CGRectGetMaxY(_myTableView.frame)+10, kScreenWidth, 30);
//            careChoosenCollectionView.frame = CGRectMake(0, CGRectGetMaxY(goodsChooseenHeaderView.frame), kScreenWidth, heightN *kCareChoosenGoodsCellHeight);
            
            goodsChooseenHeaderView.frame = CGRectMake(0, CGRectGetMaxY(_myTableView.frame)+10, kScreenWidth, 1);
            careChoosenCollectionView.frame = CGRectMake(0, CGRectGetMaxY(goodsChooseenHeaderView.frame), kScreenWidth,1);
            
            goodsChooseenHeaderView.hidden = YES;
            careChoosenCollectionView.hidden = YES;
            careChoosenCollectionView.dataArr = (NSArray *)arr;
            [careChoosenCollectionView reloadData];
            
        }else {//没有，隐藏，高度置为1
            [self _careChoosenGoodsNodataSoleve];
        }
        //请求好店推荐
        
        [self _requestGoodStoreRecommend];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self _careChoosenGoodsNodataSoleve];
        //请求好店推荐
        [self _requestGoodStoreRecommend];
    }];
}


#pragma mark - 请求好店推荐
-(void)_requestGoodStoreRecommend {
    
    VApiManager *vapManager = [[VApiManager alloc] init];
    SnsCrcListRequest *request = [[SnsCrcListRequest alloc] init:GetToken];
    request.api_lat = _latitude;
    request.api_lon = _longtitude;
    request.api_cityId = _cityID;
    request.api_posCode = Main_goodStoreRecommend_Code;
    [vapManager snsCrcList:request success:^(AFHTTPRequestOperation *operation, SnsCrcListResponse *response) {
#pragma mark 好店推荐这个接口返回错误
        NSInteger itemCount = response.advList.count;
        if (itemCount > 0) {
            NSInteger storeCount=0;
            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:response.advList.count];
            for (NSDictionary *dic in response.advList) {
                NSInteger recommendTypeNum = [dic[@"adType"] integerValue];
                if (recommendTypeNum != 5) {//过滤非店铺的
                    continue;
                }
                storeCount ++;
                NSDictionary *dicStore = dic[@"pStoreInfo"];
                PStoreInfoModel *model = [[PStoreInfoModel alloc] initWithJSONDic:dicStore];
                model.photoPath = dic[@"adImgPath"];
                [arr addObject:model];
            }
            
            itemCount = storeCount;
//            goodStoreHeaderView.frame = CGRectMake(0, CGRectGetMaxY(careChoosenCollectionView.frame)+10, kScreenWidth, 30);
//            goodStoreRecommendTableView.frame = CGRectMake(0, CGRectGetMaxY(goodStoreHeaderView.frame), kScreenWidth, itemCount *GoodStoreCellHeight);
            
            goodStoreHeaderView.frame = CGRectMake(0, CGRectGetMaxY(careChoosenCollectionView.frame)+10, kScreenWidth, 1);
            goodStoreRecommendTableView.frame = CGRectMake(0, CGRectGetMaxY(goodStoreHeaderView.frame), kScreenWidth,1);
#pragma mark - 为什么要写这个，很重要，因为假如你某次刷新没数据隐藏了它，，那么下次有数据了，你不能光只顾改变它的高度，，而忘了把它给显示，这里曾经忽视了，找了很久
            goodStoreHeaderView.hidden = YES;
            goodStoreRecommendTableView.hidden = YES;
            
            goodStoreRecommendTableView.dataArr = (NSArray *)arr;
//            [goodStoreRecommendTableView reloadData];
            
        }else {//没数据处理
            [self _goodStoreRecommendNoDataSoleve];
        }
        
        [self _setContentSize];
//        [self performSelector:@selector(_setContentSize) withObject:nil afterDelay:0.5];
        

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self _goodStoreRecommendNoDataSoleve];
        [self _setContentSize];
    }];
}

#pragma mark - 设置scrollView的contentSize
-(void)_setContentSize {
    _myScrollView.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(goodStoreRecommendTableView.frame)-20);
}


#pragma mark - 精选商品没数据处理
- (void)_careChoosenGoodsNodataSoleve {
    careChoosenCollectionView.hidden = YES;
    goodsChooseenHeaderView.hidden = YES;
    goodsChooseenHeaderView.frame = CGRectMake(0, CGRectGetMaxY(_myTableView.frame), kScreenWidth, 1);
    careChoosenCollectionView.frame = CGRectMake(0, CGRectGetMaxY(goodsChooseenHeaderView.frame), kScreenWidth, 1);
}


#pragma mark - 好店推荐没数据处理
-(void)_goodStoreRecommendNoDataSoleve {
    
    goodStoreHeaderView.hidden = YES;
    goodStoreRecommendTableView.hidden = YES;
    goodStoreHeaderView.frame = CGRectMake(0, CGRectGetMaxY(careChoosenCollectionView.frame), kScreenWidth, 1);
    goodStoreRecommendTableView.frame = CGRectMake(0, CGRectGetMaxY(goodStoreHeaderView.frame), kScreenWidth, 1);
}

#pragma mark 天气跳转到空气板块
-(void)push{
    UNLOGIN_HANDLE
    devicesViewController * devicesVc = [[devicesViewController alloc]init];
    [Util asRootOfVC:devicesVc];
}
-(void)ImageCLcikShow:(UITapGestureRecognizer *)gesture{
    if(weatherIsOpen){
        [self ImageCLcikHide];
        
        return;
    }
    weatherIsOpen = YES;
    [UIView animateWithDuration:0.25 animations:^{
       top_view.frame = CGRectMake(0, 0, __MainScreen_Width,__MainScreen_Height);
    }];
}
- (void)ImageCLcikHide{
    weatherIsOpen = NO;
    [UIView animateWithDuration:0.25 animations:^{
        top_view.frame = CGRectMake(0, -__MainScreen_Height, __MainScreen_Width,__MainScreen_Height);
    }];
}
-(void)initWeatherView
{
    
//    sunViewController * sunVc = [[sunViewController alloc]init];
//    sunVc.careChoosenCode = Life_Air_careChoosenGoods_Code;
//    sunVc.goodStoreRecommendCode = Life_Air_goodStoreRecommend_Code;
//    NSString * cityStr = [userDefaultManager GetLocalDataString:@"city"];
//    sunVc.btn_tag = 100;
//    if (cityStr.length == 0) {
//        sunVc.name_str = @"空气-深圳";
//    }else{
//        sunVc.name_str = [NSString stringWithFormat:@"空气-%@",cityStr];
//    }
//    sunVc.logo_textArr = [NSArray arrayWithObjects:@"空气篇",@"新发现",@"新体验", nil];
//    sunVc.witch_vc = 1;
//    sunVc.name_Array = [NSArray arrayWithObjects:@"检测方法",@"相关资讯",@"好店推荐",   nil];
//    [self.navigationController pushViewController:sunVc animated:YES];
    top_view = [[UIView alloc]init];
//    top_view.backgroundColor = [UIColor colorWithRed:64.0/255 green:159.0/255 blue:178.0/255 alpha:1];
    top_view.backgroundColor = kGetColorWithAlpha(10, 10, 10, 0);
    top_view.frame = CGRectMake(0,-__MainScreen_Height, __MainScreen_Width, __MainScreen_Height);
    
    [self.view addSubview:top_view];
    //TODO:----------------天气背景图片
    UIImageView *weatherBackImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, _topScrollView.frame.origin.y+_topScrollView.frame.size.height)];
    NSInteger weather_str1 = [[userDefaultManager GetLocalDataString:@"weather_st1"] integerValue];;
    weatherBackImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"weather%02ld",weather_str1]];
    [top_view addSubview:weatherBackImageView];
    
    //天气温度
    UILabel * weather_tem = [[UILabel alloc]init];
    weather_tem.frame = CGRectMake(45, 15, __MainScreen_Width * 2 / 3 - 45 , 45);
    weather_tem.textColor = [UIColor whiteColor];
    weather_tem.font = [UIFont systemFontOfSize:40];
    if ([userDefaultManager GetLocalDataString:@"maxWeather"]) {
        weather_tem.text = [NSString stringWithFormat:@"%@~%@",[userDefaultManager GetLocalDataString:@"maxWeather"],[userDefaultManager GetLocalDataString:@"minWeather"]];
    }else{
        weather_tem.text = @"暂无数据";
    }
    [top_view addSubview:weather_tem];
    
    NSDateComponents *comps = [self getCurrentDate];
    NSArray * arrWeek=[NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    //当前日期
    UILabel * weather_date = [[UILabel alloc ]initWithFrame:CGRectMake(CGRectGetMinX(weather_tem.frame), CGRectGetMaxY(weather_tem.frame), CGRectGetWidth(weather_tem.frame), 20)];
    weather_date.textColor = [UIColor whiteColor];
    weather_date.font = [UIFont systemFontOfSize:18];
    weather_date.text = [NSString stringWithFormat:@"%04ld年%02ld月%02ld日",comps.year,comps.month,comps.day];
    [top_view addSubview:weather_date];
    //周几和天气
    UILabel * weather_week = [[UILabel alloc ]initWithFrame:CGRectMake(CGRectGetMinX(weather_tem.frame), CGRectGetMaxY(weather_date.frame), CGRectGetWidth(weather_tem.frame), 20)];
    weather_week.textColor = [UIColor whiteColor];
    weather_week.font = [UIFont systemFontOfSize:18];
    NSString *statusStr = [userDefaultManager GetLocalDataString:@"weather"];
    weather_week.text = [NSString stringWithFormat:@"%@   %@",arrWeek[comps.weekday-1],statusStr ? statusStr:@""];
    [top_view addSubview:weather_week];
    
    //天气图片
    UIImageView *weather_StatusImage = [[UIImageView alloc ]initWithFrame:CGRectMake(__MainScreen_Width * 2 / 3 + 30, CGRectGetMinY(weather_tem.frame) , __MainScreen_Width  / 3 - 60, __MainScreen_Width / 3 - 60)];
    weather_StatusImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"weatherStatus%02ld",weather_str1]];
    [top_view addSubview:weather_StatusImage];
    
    float line_lab_spase = __MainScreen_Width/3;
    NSString * str = [userDefaultManager GetLocalDataString:@"pm"];
    NSString * str2 = [userDefaultManager GetLocalDataString:@"sd_num"];
    NSString * str3 = [userDefaultManager GetLocalDataString:@"weather_wind"];
    NSArray * array = [NSArray arrayWithObjects:@"风向",@"PM2.5",@"湿度", nil];
    NSArray * array_weather = [NSArray arrayWithObjects:str3,str,str2, nil];
    NSArray * array_weather2 = [NSArray arrayWithObjects:@"东风",@"80",@"47%", nil];
    CGFloat y = (_topScrollView.frame.size.height - CGRectGetMaxY(weather_week.frame) - 40) / 2  + CGRectGetMaxY(weather_week.frame);
    for (int i = 0; i < 3; i ++) {
        if (i < 2) {
            UILabel * line_lab = [[UILabel alloc]init];
            line_lab.frame = CGRectMake((i+1)*line_lab_spase, y, 0.5, 40);
            line_lab.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.8];
            [top_view addSubview:line_lab];
            RELEASE(line_lab);
        }
        UILabel * name_lab = [[UILabel alloc]init];
        name_lab.frame = CGRectMake(i*line_lab_spase+5, y, line_lab_spase, 13);
        name_lab.text = [array objectAtIndex:i];
        name_lab.textAlignment = NSTextAlignmentCenter;
        name_lab.textColor = [UIColor whiteColor];
        name_lab.font = [UIFont systemFontOfSize:14];
        [top_view addSubview:name_lab];
        RELEASE(name_lab);
        
        UILabel * weather_label = [[UILabel alloc]init];
        weather_label.frame = CGRectMake(i*line_lab_spase+5, name_lab.frame.origin.y+name_lab.frame.size.height+5, line_lab_spase, 20);
        NSString * str = [userDefaultManager GetLocalDataString:@"pm"];
        if (str.length == 0) {
            weather_label.text = [array_weather2 objectAtIndex:i];
        }else{
            weather_label.text = [array_weather objectAtIndex:i];
        }
        weather_label.textAlignment = NSTextAlignmentCenter;
        weather_label.textColor = [UIColor whiteColor];
        weather_label.font = [UIFont systemFontOfSize:17];
        [top_view addSubview:weather_label];
        RELEASE(weather_lab);
    }
    
}
-(void)TapCliclK
{
    UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"该功能暂未开放！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
}


#pragma mark  - 初始化缓存信息
-(void)_initCacheData{
    
    _cache = [TMCache sharedCache];
    
    
    //广告
//    NSArray *arr = [_cache objectForKey:Tuijianwei_ad_cache_shouyeID];
//    headImgArr = [[PositionAdvertBO objectArrayWithKeyValuesArray:arr] mutableCopy];
//    if (arr) {//如果不为空，赋给headImgArr
//        [self calCulateHeadScrollSizeWithArr];
//    }
    //靖港项目
    _jingGangProjectImgUrlStr = [_cache objectForKey:Main_jingGangProject_cacheID];
    
    //每日精华
    arr_data = [_cache objectForKey:Tuijianwei_perdayessene_cache_shouyeID];
    
    if (arr_data.count > 0) {
        _hasCache = YES;
    }
}


#pragma mark -- 头部请求
#pragma mark - 头部刷新
- (void)addHeaderFresh{
    
    WEAK_SELF;
    [_myScrollView addHeaderWithCallback:^{
        [weak_self _requestAdDataWithCode:Main_tuijian_ad_code];
        [weak_self _requestAdDataWithCode:Main_jingGang_proj_code];
        [weak_self _requestCareChoosenGoods];
//        weakLab.text = [[mapObject sharedMap] baiduCity];
    }];
    [self _requestAdDataWithCode:Main_tuijian_ad_code];
    [self _requestAdDataWithCode:Main_jingGang_proj_code];

}


#pragma mark - 轮播图广告请求、 静港项目请求。
-(void)_requestAdDataWithCode:(NSString *)addCode{
    
    NSString *token = [userDefaultManager GetLocalDataString:@"Token"];
    SnsRecommendListRequest *request = [[SnsRecommendListRequest alloc] init:token];
    request.api_posCode = addCode;
    [_vapManager snsRecommendList:request success:^(AFHTTPRequestOperation *operation, SnsRecommendListResponse *response) {
        
        if (response.errorCode.integerValue == 2) {
            [Util enterLoginPage];
            return;
        }
        
        // 轮播图图片请求----
        if ([addCode isEqualToString:Main_tuijian_ad_code]) {//如果是首页广告

            [_myScrollView headerEndRefreshing];
            
            headImgArr = [[PositionAdvertBO objectArrayWithKeyValuesArray:response.advList] mutableCopy];
            //重新计算头部contentSize
            [self calCulateHeadScrollSizeWithArr];
#pragma mark - 暂时屏蔽掉头部缓存
            //缓存头部广告
//            [_cache setObject:response.advList forKey:Tuijianwei_ad_cache_shouyeID];
            
        }else{//若是靖港项目
#pragma mark 中间小图片
            NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
            NSArray  * img_arr = [dict objectForKey:@"advList"];
            
#pragma mark 获取数组第一个座位静港项目的图片
            NSString * img_str = [[img_arr objectAtIndex:0] objectForKey:@"adImgPath"];
            //2倍url
            NSString * clearImgUrlStr = [NSString stringWithFormat:@"%@_%ix%i",img_str,(int)_lit_midel_img.frame.size.width*2,(int)_lit_midel_img.frame.size.height*2];
           [_lit_midel_img sd_setImageWithURL:[NSURL URLWithString:clearImgUrlStr] placeholderImage:[UIImage imageNamed:@"yunAd"]];
            //缓存靖港项目图片
            [_cache setObject:clearImgUrlStr forKey:Main_jingGangProject_cacheID];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}


#pragma mark - 处理头部scroll view
-(void)calCulateHeadScrollSizeWithArr {

    //获取图片url数组
    NSMutableArray *clearImgUrlArr = [NSMutableArray arrayWithCapacity:headImgArr.count];
    for (PositionAdvertBO *model in headImgArr) {
        
        NSString *clearImgUrl = [NSString stringWithFormat:@"%@_%ix%i",model.adImgPath,(int)_topScrollView.frame.size.width*2,(int)_topScrollView.frame.size.height*2];
        [clearImgUrlArr addObject:clearImgUrl];
        
    }
    _topScrollView.autoScrollTimeInterval = 5.0;
    _topScrollView.delegate = self;
    _topScrollView.imageURLStringsGroup = (NSArray *)clearImgUrlArr;
    
}




#pragma mark - Top ScrollView delegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    PositionAdvertBO *model = headImgArr[index];
    WebDayVC *web = [[WebDayVC alloc]init];
    web.strUrl = [NSString stringWithFormat:@"%@%@",Base_URL,model.adUrl];
//    PositionAdvertBO *bo = headImgArr[inx];
    
    /**
     "nativeType"  "广告显示类型(1:Html5页面,2:原生页面)")
     */
    
    NSString *adUrl = model.adUrl;
    AppDelegate * app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    if ([adUrl isEqualToString:@"BLOOD"]) {
        //血压测量
        HeatTestVC *heatTestVC = [[HeatTestVC alloc] init];
        heatTestVC.testType = BloodPressureTest;
        [self.navigationController pushViewController:heatTestVC animated:YES];
        return;
    }else if ([adUrl isEqualToString:@"SHOP"]){
        //跳转到健康商城
        [app gogogoWithTag:3];
        return;
    }else if ([adUrl isEqualToString:@"RIM"]){
        //跳转到周边
        [app gogogoWithTag:2];
        return;
    }else if ([adUrl isEqualToString:@"NEW_YEAR"]){
        //新年活动
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"春节活动" forKey:@"hotName"];
        NSString *strNewUrl = [NSString stringWithFormat:@"%@/newyear/cash_coupon.htm",Shop_url];
        JGActivityWebController *vc = [[JGActivityWebController alloc] initWithAdvertBO:nil withHeaderRequest:strNewUrl ApiBO:dic isPushType:NO];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    
    
    NSString *natative = TNSString(model.nativeType);
    if ([natative isEqualToString:@"2"]) {
        // 双十二
        JGActivityCommonController *activityController = [[JGActivityCommonController alloc] initWithApiBO:[[JGActivityColumnHelper sharedInstanced] apiBO]];
        [self.navigationController pushViewController:activityController animated:YES];
        
        //  圣诞
//        JGActivityDetailController *activityDetailController = [[JGActivityDetailController alloc] init];
//        [self.navigationController pushViewController:activityDetailController animated:YES];
        
    }else if(([natative isEqualToString:@"1"])) {
        
        if ([adUrl rangeOfString:@"http"].length > 0) {
//            JGActivityWebController *webController = [[JGActivityWebController alloc] initWithAdvertBO:model withHeaderRequest:adUrl ApiBO:[[JGActivityColumnHelper sharedInstanced] apiBO]];
//            [self.navigationController pushViewController:webController animated:YES];
        }else {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:model.adUrl forKey:@"adUrl"];
            [dic setObject:model.adType forKey:@"adType"];
            [dic setObject:model.adTitle forKey:@"adTitle"];
            [dic setObject:model.adText forKey:@"adText"];
            [dic setObject:model.adImgPath forKey:@"adImgPath"];
            [dic setObject:model.itemId forKey:@"itemId"];
            
            int type = [model.adType intValue];
            if (type == 1) {
                web.dic = dic;
            }
            [[NSUserDefaults standardUserDefaults]setObject:[dic objectForKey:@"adTitle"] forKey:@"circleTitle"];
            UINavigationController *nas = [[UINavigationController alloc]initWithRootViewController:web];
//            nas.navigationBar.barTintColor = [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1];
            [self presentViewController:nas animated:YES completion:nil];
        }
    }
}

-(void)preSentVCWithRootVC:(UIViewController *)vc{
    
    UINavigationController *modalNav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:modalNav animated:YES completion:nil];

    
}//弹出导航模态



#pragma mark - 用户信息查询
-(void)_userInfoRequest{
    
    VApiManager *vapManager = [[VApiManager alloc] init];
    UsersCustomerSearchRequest *request = [[UsersCustomerSearchRequest alloc] init:GetToken];
    
    [vapManager usersCustomerSearch:request success:^(AFHTTPRequestOperation *operation, UsersCustomerSearchResponse *response) {
        NSDictionary *userInfoDic = (NSDictionary *)response.customer;
        UserModel *userInfoModel = [[UserModel alloc] initWithJSONDic:userInfoDic];
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            //可以添加自定义categories
            [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                           UIUserNotificationTypeSound |
                                                           UIUserNotificationTypeAlert)
                                               categories:nil];
        } else {
            //categories 必须为nil
            [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                           UIRemoteNotificationTypeSound |
                                                           UIRemoteNotificationTypeAlert)
                                               categories:nil];
        }
#else
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
#endif
//        d_ 开发
//        t_ 测试
//        p_ 生产
        NSString *userAliasStr = [NSString stringWithFormat:@"%@%@",kJPushEnvirStr,userInfoModel.uid.stringValue];
        //设置别名
        [APService setTags:nil alias:userAliasStr callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
        
        JGLog(@"别名----%@",userAliasStr);
        
        //加入账号统计统计
        [MobClick profileSignInWithPUID:TNSString(userInfoModel.uid)];
        
        // 595
        NSDictionary *userDic = (NSDictionary *)response.customer;
        if (userDic[@"weight"]) {
            _jgBlutoothManger.userBodyModel.weight = [userDic[@"weight"] floatValue];
        }
        
        if (userDic[@"height"]) {
            _jgBlutoothManger.userBodyModel.height = [userDic[@"height"] intValue];
        }
        
        if (userDic[@"age"]) {
            _jgBlutoothManger.userBodyModel.age = [userDic[@"age"] intValue];
        }
        
        NSNumber *sex = userDic[@"sex"];
        if ([sex intValue] == 1) {
            _jgBlutoothManger.userBodyModel.genderType = GenderTypeMan;
        }else{
            _jgBlutoothManger.userBodyModel.genderType = GenderTypeWoman;
        }
        
        [kUserDefaults setObject:response.customer forKey:userInfoKey];
        [kUserDefaults synchronize];
                
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark - 激光推送别名响应
- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    
}



#pragma mark - 获取当天运动数据
-(void)_getTheDayMotionDataRequest{
    
    EquipDayQueryRequest *request = [[EquipDayQueryRequest alloc] init:GetToken];
    [_vapManager equipDayQuery:request success:^(AFHTTPRequestOperation *operation, EquipDayQueryResponse *response) {
        JGLog(@"motion data -  %@",response.stepNumber);
        _jgBlutoothManger.userBodySyncModel.steps = response.stepNumber.integerValue;
        _jgBlutoothManger.userBodySyncModel.licheng = (double)response.distance.integerValue;
        _jgBlutoothManger.userBodySyncModel.kaluoli = (double)response.calories.integerValue;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}



#pragma mark - 获取当天睡眠数据
-(void)_getTheDaySleepDataRequest{
    EquipSleepQueryRequest *request = [[EquipSleepQueryRequest alloc] init:GetToken];
    [_vapManager equipSleepQuery:request success:^(AFHTTPRequestOperation *operation, EquipSleepQueryResponse *response) {

        NSDictionary *dic = (NSDictionary *)response.sleepRecordBO;
        NSInteger totalSleepSecond = [dic[@"sleepSecond"] integerValue];
        NSInteger deepleepSecond = [dic[@"deepSleepSecond"] integerValue];
        NSInteger shallowSleepSecond = [dic[@"shallowSleepSecond"] integerValue];
        
        _jgBlutoothManger.userBodySyncModel.totalSleepTime = totalSleepSecond / 60;
        _jgBlutoothManger.userBodySyncModel.deepSleepTime = deepleepSecond / 60;
        _jgBlutoothManger.userBodySyncModel.lightSleepTime = shallowSleepSecond / 60;

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}


#pragma mark - UITableViewDataSource

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    if (arr_data.count>5) {
//        return 6;
//    }else
//    {
//        return arr_data.count +1;
//    }
//}


//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    mainPublicTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:mainCell];
//    if (indexPath.section == 0) {
//        if (indexPath.row < arr_data.count) {
//            if (arr_data.count >0) {
//                NSDictionary *dictss = arr_data[indexPath.row];
//                [cell.left_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@_%ix%i",[dictss objectForKey:@"adImgPath"],(int)cell.left_img.frame.size.width*2,(int)cell.left_img.frame.size.height*2]] placeholderImage:[UIImage imageNamed:@"background"]];
//                cell.name_lab.text = [dictss objectForKey:@"adTitle"];
//               cell.sub_lab.text = [dictss objectForKey:@"adText"];
//            }
//        }else{
//            cell.left_img.image = nil;
//            cell.name_lab.text = nil;
//            cell.sub_lab.text = nil;
//            cell.bg_img.hidden = YES;
//            cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
//        }
//    }
//    return cell;
//}


#pragma mark - UITableViewDelegate


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0)
    if(indexPath.section == 2)
    {
        NSDictionary *ser = arr_data[indexPath.row];
        NSString *str = [NSString stringWithFormat:@"%@%@",Base_URL,[ser objectForKey:@"adUrl"]];
        [[NSUserDefaults standardUserDefaults]setObject:[ser objectForKey:@"adTitle"] forKey:@"circleTitle"];
        WebDayVC *web = [[WebDayVC alloc]init];
        web.strUrl = str;
        int type = [[ser objectForKey:@"adType"] intValue];
        if (type == 1) {
            web.dic = ser;
        }
        UINavigationController *nas = [[UINavigationController alloc]initWithRootViewController:web];
//        nas.navigationBar.barTintColor = [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1];
        [self presentViewController:nas animated:YES completion:nil];
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    float  height = 0;
//    if (indexPath.row < arr_data.count ) {
//        height = __table_cell1_h;
//    }else{
//        height = 10;
//    }
//    return height;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 1){
        return 0;
        
    }
    return __table_section_h;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return 1;
    }
    return 0.1;
}



//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    mainPublicTableViewHeader *headerView = [[NSBundle mainBundle] loadNibNamed:@"mainPublicTableViewHeader" owner:self options:nil][0];
//    [headerView.rightBtn addActionHandler:^(NSInteger tag) {
//        CustomTabBar * customTabBar = [CustomTabBar instance];
//        [customTabBar setSelectedTab:4];
//    }];
//    return headerView;
//}

//控制表格线条从左边开始
//-(void)viewDidLayoutSubviews
//{
//    if ([_myTableView respondsToSelector:@selector(setSeparatorInset:)]) {
//        [_myTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
//    }
//    
//    if ([_myTableView respondsToSelector:@selector(setLayoutMargins:)]) {
//        [_myTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
//    }
//}

//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        [cell setSeparatorInset:UIEdgeInsetsZero];
//    }
//    
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//    }
//}


#pragma mark - adverManager
- (void) DidFinishLoadingWithArray:(NSMutableArray *)array WithKeyStr:(NSString *)keyStr
{
    
}

- (void)headBtnClick
{
#pragma mark - leftSM
    AppDelegate *appDelegate = kAppDelegate;
    if (!_headYorN) {
        [appDelegate.drawerController closeDrawerAnimated:YES completion:nil];
    }else{
        [appDelegate.drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }
    _headYorN = !_headYorN ;
}


#pragma mark -scrollViewDelegate

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - debug operation
- (void)updateOnClassInjection {
    UIViewController *rootVC = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *VC = [[NSClassFromString(@"PersonalInfoViewController") alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:VC];
    [rootVC presentViewController:nav animated:YES completion:^{}];
}
#pragma mark -weatherManager获取当地天气情况
- (void) DidFinishLoadingWithWeather:(weather *)weather
{
    [userDefaultManager SetLocalDataString:weather.city key:@"city"];
    [userDefaultManager SetLocalDataString:weather.minWeather key:@"minWeather"];
    [userDefaultManager SetLocalDataString:weather.maxWeather key:@"maxWeather"];
    [userDefaultManager SetLocalDataString:weather.weather key:@"weather"];
    [userDefaultManager SetLocalDataString:weather.wind key:@"weather_wind"];
    [userDefaultManager SetLocalDataString:weather.pm key:@"pm"];
    [userDefaultManager SetLocalDataString:weather.sd_num key:@"sd_num"];
    [userDefaultManager SetLocalDataString:weather.pm_lev key:@"pm_lev"];
    [userDefaultManager SetLocalDataString:weather.st1 key:@"weather_st1"];
    [userDefaultManager SetLocalDataString:weather.pm_num key:@"weather_num"];
    [userDefaultManager SetLocalDataString:weather.pm_pubtime key:@"weather_pubtime"];
    
    NSString * max_weather = [userDefaultManager GetLocalDataString:@"maxWeather"];
    NSArray  * array = [max_weather componentsSeparatedByString:@"℃"];
    if ([userDefaultManager GetLocalDataString:@"maxWeather"]) {
        weather_lab.text = [NSString stringWithFormat:@"%@℃/%@",[array firstObject],[userDefaultManager GetLocalDataString:@"minWeather"]];
    }else{
        weather_lab.text = @"暂无数据";
        weather_lab.font = [UIFont systemFontOfSize:15];
    }
    NSInteger weatherSt1 = [weather.st1 integerValue];
    weather_img.image = [UIImage imageNamed:[NSString stringWithFormat:@"weatherStatus%02ld",weatherSt1]];
}

- (void)DidFailWithError:(NSError *)error {

}

#pragma mark --------------------- 初始化基类视图，数据信息  ---------------------
-(void)_initBaseVCInfo {
    
//    [self initBaseVCInfo];
    //基类最大的滑动视图
    [self initMyScrollView];
    
//    头部滑动视图
    [self initHeadScrollView];
    
//  [self initMiddleView];

    
//    [self initJingGangView];
    
    [self _setCirlcleData];
    
}


#pragma mark ----------------------- 八大分类 -----------------------
#pragma mark - 配置八大分类数据源
-(void)_setCirlcleData {
    NSArray *mainCircleItems = @[@{@"gcName":@"快速体检",@"mobileIcon":@"home_1"},
                                                    @{@"gcName":@"智能穿戴",@"mobileIcon":@"home_2"},
                                                    @{@"gcName":@"健康自测",@"mobileIcon":@"home_3"},
                                                    @{@"gcName":@"我的档案",@"mobileIcon":@"home_4"},
                                                    @{@"gcName":@"乐购商城",@"mobileIcon":@"home_5"},
                                                    @{@"gcName":@"到店体验",@"mobileIcon":@"home_6"},
                                                    @{@"gcName":@"健康社区",@"mobileIcon":@"home_7"},
                                                    @{@"gcName":@"健康咨询",@"mobileIcon":@"home_8"}];

    self.middleDataArr = mainCircleItems;

}


//#pragma mark - 点击八大分类点击事件
//-(void)clickCircleAtIndex:(NSInteger)circleIndex {
//    
//    //圈子号
//    switch (circleIndex) {
//        case 0://快速体检
//        {
//            UNLOGIN_HANDLE
//            DefuController *defuVC = [[DefuController alloc] init];
//            [self.navigationController pushViewController:defuVC animated:YES];
//        }
//            break;
//        case 1://智能穿戴
//        {
//            UNLOGIN_HANDLE
//            devicesViewController * devicesVc = [[devicesViewController alloc]init];
//            [Util asRootOfVC:devicesVc];
//
//        }
//            break;
//        case 2://健康自测
//        {
//            [self.customTabBar setSelectedTab:2];
//        }
//            break;
//        case 3://我的档案
//        {
//            UNLOGIN_HANDLE
//            NewCenterVC *newC = [[NewCenterVC alloc]init];
//            newC.index = 4;
//            newC.witch = @"mainVc";
//            [self.navigationController pushViewController:newC animated:YES];
//        }
//            break;
//        case 4://乐购商城
//        {
//            //0代表乐购商城
//            [kNotification postNotificationName:selectShoppingNotification object:@0];
//            [self.customTabBar setSelectedTab:3];
//        }
//            break;
//        case 5://到店体验
//        {
//            //1代表到店体验
//            [kNotification postNotificationName:selectShoppingNotification object:@1];
//            [self.customTabBar setSelectedTab:3];
//        }
//            break;
//        case 6://健康社区
//        {
//            [self.customTabBar setSelectedTab:4];
//        }
//            break;
//        case 7://健康咨询
//        {
//            UNLOGIN_HANDLE
//            consultationViewController * consultationVc = [[consultationViewController alloc]init];
//            [self.navigationController pushViewController:consultationVc animated:YES];
//        }
//            break;
//        default:
//            break;
//    }
//    
//}
//
//



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray * name_array = [NSArray arrayWithObjects:@"健康任务",@"健康任务",@"每日精华", nil];
    mainPublicTableViewHeader *headerView = [[NSBundle mainBundle] loadNibNamed:@"mainPublicTableViewHeader" owner:self options:nil][0];
    headerView.statusImageView.hidden = YES;
    headerView.statusLabel.hidden = YES;
    if(section == 0){
        headerView.titleImageView.image = [UIImage imageNamed:@"healthTask"];
    }
    if(section == 2){
        headerView.titleImageView.image = [UIImage imageNamed:@"everyday"];
        headerView.statusImageView.hidden = NO;
        headerView.statusLabel.hidden = NO;
    }
    headerView.titleNameLabel.text = name_array[section];
    if (section == 0) {
        headerView.titleNameLabel.textColor = COMMONTOPICCOLOR;
        headerView.rightBtn.hidden = YES;
        [headerView.rightBtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            UNLOGIN_HANDLE
        }];
    }else if (section == 1){
        headerView.titleNameLabel.textColor = COMMONTOPICCOLOR;
        headerView.rightBtn.hidden = YES;
    }else{
        headerView.titleNameLabel.textColor = COMMONTOPICCOLOR;
        headerView.rightBtn.hidden = NO;
        [headerView.rightBtn addActionHandler:^(NSInteger tag) {
            CustomTabBar * customTabBar = [CustomTabBar instance];
            [customTabBar setSelectedTab:3];
        }];
    }
    if(section == 0){
        headerView.rightBtn.hidden = YES;
    }
    return headerView;
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



-(void)viewDidLayoutSubviews
{
    if ([_myTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_myTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([_myTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_myTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float  height = 0;
    switch (indexPath.section) {
        case 1:
        {
            if (indexPath.row < 1) {
                height = __text_table_cell1_h;
            }else{
                height = 10;
            }
        }
            break;
        case 0:
        {
            if (indexPath.row < 2) {
                height = __text_table_cell2_h;
            }else{
                height = 10;
            }
        }
            break;
        case 2:
        {
            height = __table_cell3_h;
        }
            break;
            
        default:
            break;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 2)
    {
        mainPublicTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:mainCell];

            if (indexPath.row < arr_data.count) {
                if (arr_data.count >0) {
                    NSDictionary *dictss = arr_data[indexPath.row];
                    [cell.left_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@_%ix%i",[dictss objectForKey:@"adImgPath"],(int)cell.left_img.frame.size.width*2,(int)cell.left_img.frame.size.height*2]] placeholderImage:[UIImage imageNamed:@"blank_default200"]];
                    cell.name_lab.text = [dictss objectForKey:@"adTitle"];
                   cell.sub_lab.text = [dictss objectForKey:@"adText"];
                }
            }else{
                cell.left_img.image = nil;
                cell.name_lab.text = nil;
                cell.sub_lab.text = nil;
                cell.bg_img.hidden = YES;
                cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
            }
        return cell;
    }
 
    userTestTableViewCell * cell = nil;
    if (!cell) {
        NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"userTestTableViewCell" owner:self options:nil];
        cell = [arr objectAtIndex:indexPath.section];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section == 0) {
            if (indexPath.row < 2) {
                tableView.rowHeight = __text_table_cell2_h;
            }else{
                tableView.rowHeight = 10;
            }
        }else if (indexPath.section == 1){
            if (indexPath.row < 1) {
                tableView.rowHeight = __text_table_cell1_h;
            }else{
                tableView.rowHeight = 10;
            }
        }
        if (indexPath.section == 1) {
            if (indexPath.row < 1) {
                [cell.expertBtn addTarget:self action:@selector(expertBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.zoujinBtn addTarget:self action:@selector(zoujinBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                cell._left_valuelab.textColor = test_color_1;
                cell._midel_valuelab.textColor = test_color_1;
                cell._right_valuelab.textColor = test_color_1;
                _mainClickView.numberlabel.text = [NSString stringWithFormat:@"%ld",(long)_jgBlutoothManger.userBodySyncModel.steps];
                [_mainClickView.kmButton setTitle: [NSString stringWithFormat:@"%ldKm",(long)_jgBlutoothManger.userBodySyncModel.licheng]forState:UIControlStateNormal];
                [_mainClickView.calButton setTitle:[NSString stringWithFormat:@"%ldKcal",(long)_jgBlutoothManger.userBodySyncModel.kaluoli] forState:UIControlStateNormal];
            }else{
                cell._left_linelab.hidden = YES;
                cell._reight_linelab.hidden = YES;
                cell._left_downlab.hidden = YES;
                cell._right_downlab.hidden = YES;
                cell._midel_downlab.hidden = YES;
                cell._left_valuelab.hidden = YES;
                cell._midel_valuelab.hidden = YES;
                cell._right_valuelab.hidden = YES;
                cell._left1_img.hidden = YES;
                cell._midel1_img.hidden = YES;
                cell._reight1_img.hidden = YES;
                cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
            }
        }else if (indexPath.section == 0){
            if (indexPath.row < 2) {
                cell._left_Btn.tag = indexPath.row*2;
                [cell._left_Btn addTarget:self action:@selector(cellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                cell._right_Btn.tag = indexPath.row*2+1;
                [cell._right_Btn addTarget:self action:@selector(cellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                JGHealthTaskManager *_JGHealthTaskManager = [JGHealthTaskManager shareInstances];
                if (indexPath.row == 0) {
                    NSInteger progressEye = 100 * (_JGHealthTaskManager.eyeCompletedCount*1.0 / _JGHealthTaskManager.eyesightMaintainceCompletedArr.count);
                    NSInteger progressHear = 100 * (_JGHealthTaskManager.hearingCompletedCount*1.0 / _JGHealthTaskManager.hearingMaintainceCompletedArr.count);
                    [cell._left_view setPercent:progressEye witch:0 animated:YES];
                    [cell._right_view setPercent:progressHear witch:1 animated:YES];
                    cell._left_marklab.text = [NSString stringWithFormat:@"%ld/%ld",(long)_JGHealthTaskManager.eyeCompletedCount,(unsigned long)_JGHealthTaskManager.eyesightMaintainceCompletedArr.count];
                    cell._left_depictlab.text = [NSString stringWithFormat:@"已完成%ld%@",(long)progressEye,@"%"];
                    cell._right_marklab.text = [NSString stringWithFormat:@"%ld/%ld",(long)_JGHealthTaskManager.hearingCompletedCount,(unsigned long)_JGHealthTaskManager.hearingMaintainceCompletedArr.count];
                    cell._right_depictlab.text = [NSString stringWithFormat:@"已完成%ld%@",(long)progressHear,@"%"];
                    cell._left_namelab.text = @"视力保健";
                    cell._right_namelab.text = @"听力保健";
                    cell._left2_Img.image = [UIImage imageNamed:@""];
                    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(22, 28, 25, 15)];
                    img.image = [UIImage imageNamed:@"eye"];
                    [cell._left_view addSubview:img];
                    cell._right2_Img.image = [UIImage imageNamed:@"ear"];
                }else if (indexPath.row == 1){
                    NSInteger progressBlooth = 100 * (_JGHealthTaskManager.bloodControlCompletedCount*1.0 / _JGHealthTaskManager.blooControlceCompletedArr.count);
                    NSInteger progressWeight = 100 * (_JGHealthTaskManager.weightControlCompletedCount*1.0 / _JGHealthTaskManager.weightControlCompletedArr.count);
                    [cell._left_view setPercent:progressBlooth witch:2 animated:YES];
                    [cell._right_view setPercent:progressWeight witch:3 animated:YES];
                   
                    cell._left_marklab.text = [NSString stringWithFormat:@"%ld/%ld",(long)_JGHealthTaskManager.bloodControlCompletedCount,(unsigned long)_JGHealthTaskManager.blooControlceCompletedArr.count];
                    cell._left_depictlab.text = [NSString stringWithFormat:@"已完成%ld%@",(long)progressBlooth,@"%"];
                    cell._right_marklab.text = [NSString stringWithFormat:@"%ld/%ld",(long)_JGHealthTaskManager.weightControlCompletedCount,(unsigned long)_JGHealthTaskManager.weightControlCompletedArr.count];
                    cell._right_depictlab.text = [NSString stringWithFormat:@"已完成%ld%@",(long)progressWeight,@"%"];
                     cell._left_namelab.text = @"血压控制";
                    cell._right_namelab.text = @"体重控制";
                    cell._left2_Img.image = [UIImage imageNamed:@"blood"];
                    cell._right2_Img.image = [UIImage imageNamed:@"Weight"];
                }
            }else{
                cell._left_namelab.hidden = YES;
                cell._left2_Img.hidden = YES;
                cell._left_marklab.hidden = YES;
                cell._left_depictlab.hidden = YES;
                cell._left_Btn.hidden = YES;
                cell._left_view.hidden = YES;
                cell._right_namelab.hidden = YES;
                cell._right2_Img.hidden = YES;
                cell._right_marklab.hidden = YES;
                cell._right_depictlab.hidden = YES;
                cell._right_Btn.hidden = YES;
                cell._right_view.hidden = YES;
                cell._line_lab.hidden = YES;
                cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
            }
        }
    }
    return cell;
    
}
- (void)expertBtnClick:(UIButton *)click{
    UNLOGIN_HANDLE
    consultationViewController * consultationVc = [[consultationViewController alloc]init];
    [self.navigationController pushViewController:consultationVc animated:YES];
}
- (void)zoujinBtnClick:(UIButton *)click{
    projectViewController * devicesVc = [[projectViewController alloc]init];
    [self.navigationController pushViewController:devicesVc animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    _myTableView.frame = CGRectMake(0, table_height, __MainScreen_Width, __text_table_cell1_h*1+__text_table_cell2_h*2+__table_cell3_h*arr_data.count+__table_section_h*2+345);
    
    _myScrollView.contentSize = CGSizeMake(__MainScreen_Width, table_height+_myTableView.frame.size.height);
    NSInteger num = 0;
    switch (section) {
        case 1:
        {
            num = 1;
        }
            break;
        case 0:
        {
            num = 2+1;
        }
            break;
        case 2:
        {
            num = arr_data.count;
        }
            break;
        default:
            break;
    }
    
    return num;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
#pragma mark - 健康任务 点击
- (void)cellBtnClick:(UIButton*)btn
{
    someTestViewController * someTestVc = [[someTestViewController alloc]init];
    someTestVc.bigTaskNum = btn.tag;
    // 添加友盟统计
    if (btn.tag == 0) {
        [MobClick event:kSightHealthMobClickKey];
        someTestVc.keyStr = @"视力保健";
        someTestVc.img_name = @"test_back_eye";
        someTestVc.img_name2 = @"test_icon_eye";
        someTestVc.name_array = [NSMutableArray arrayWithObjects:@"眼保健操",@"闭眼移动",@"随机移动",@"左右移动",@"上下移动",@"圆圈聚焦",@"紧闭双眼",@"两个物体", nil];
    }else if (btn.tag == 1){
        [MobClick event:kListeningHealthMobClickKey];
        
        someTestVc.keyStr = @"听力保健";
        someTestVc.img_name = @"test_back_ear";
        someTestVc.img_name2 = @"test_icon_ear";
        someTestVc.name_array = [NSMutableArray arrayWithObjects:@"捏耳廓",@"捏耳屏",@"松耳廓",@"拧耳朵",@"拉耳廓", nil];
    }else if (btn.tag == 2){
        [MobClick event:kBloodPressureControlMobClickKey];
        
        someTestVc.keyStr = @"血压控制";
        someTestVc.img_name = @"test_back_blood";
        someTestVc.img_name2 = @"test_icon_blood";
        someTestVc.name_array = [NSMutableArray arrayWithObjects:@"降压操", nil];
    }else{
        [MobClick event:kWeightControlControlMobClickKey];
        
        someTestVc.keyStr = @"体重控制";
        someTestVc.img_name = @"test_back_weight";
        someTestVc.img_name2 = @"test_icon_weight";
        someTestVc.name_array = [NSMutableArray arrayWithObjects:@"快速减肥操",@"睡前减肥操", nil];
    }
    
    
    [self.navigationController pushViewController:someTestVc animated:YES];
    
}

-(NSDateComponents *)getCurrentDate
{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] ;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.timeZone = [[NSTimeZone alloc ] initWithName:@"zh_CH"];
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday;
    comps = [calendar components:unitFlags fromDate:date];
    return comps;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    if(CGRectContainsPoint(top_view.frame, point)){
        if(!CGRectContainsPoint(CGRectMake(0, 0, __MainScreen_Width, _topScrollView.frame.size.height), point)){
            [self ImageCLcikHide];
        }
    }
    else{
        if(weatherIsOpen){
            [self ImageCLcikHide];
        }
        return;
    }
}
/**
 *  签到
 */
- (void)registerSign
{
        // 友盟统计
    [MobClick event:kSignInEventMobClickKey];
}




@end
