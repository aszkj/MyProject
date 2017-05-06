//
//  DefuController.m
//  jingGang
//
//  Created by wangying on 15/6/27.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "DefuController.h"
#import "PublicInfo.h"
#import "Util.h"
#import "GlobeObject.h"
#import "HMSegmentedControl.h"
//#import "eyechartViewController.h"//视力体检
#import "PSTestItemTableView.h"
#import "CKCalendarView.h"
#import "PSDataTestItemTableView.h"
#import "UIViewExt.h"
#import "HearingTestVC.h"
#import "HeatTestVC.h"
#import "menuViewController.h"//菜单控制器
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "VApiManager.h"
#import "PhysicalSaveRequest.h"
#import "NSDate+Addition.h"
#import "DateCalendarController.h"
#import "SimilarHeartRateEditView.h"
#import "Masonry.h"
#import "SimilarBloodPressureView.h"
#import "PSDataTestItemCell.h"
#import "UIButton+Block.h"
#import "CalendarHomeViewController.h"
#import "CalendarViewController.h"
#import "CalenderHeaderCell.h"
#import "QuickBodyTestHomeController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#define kTopCalenderHeight 480
#define kDataCellHeight 44

@interface DefuController ()<UIWebViewDelegate>{
    VApiManager *_vapManager;
    BOOL         _isCalenderBack;//标志是否是弹出日历返回
    UIView *_calenderBackgroudView;
    NSArray     *_typeNumArr;
    SimilarHeartRateEditView *oneEditTestTypeView;
    CalendarHomeViewController  *chvc;
}
@property (nonatomic,strong) HMSegmentedControl       *topBarHMSegmentedControl;
@property (nonatomic,strong) PSTestItemTableView      *psTestItemTableView;
@property (nonatomic,strong) UIScrollView             *dataScrollView;
@property (nonatomic,strong) CKCalendarView           *dataTopCalenderView;
@property (nonatomic,strong) PSDataTestItemTableView  *dataTestItemTableView;
@property (nonatomic,strong) NSString                 *requestDataDateStr;
@property (nonatomic,strong) UIWebView *web;
@end

@implementation DefuController

#pragma mark ------ 体检工具 -------

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    
    [self _loadLeftNavItem];
    
    [self _loadTitleView];
    
    
//    [self _loadTopTabar];
    
    //加载体检tableView
    [self _loadPhysicalTestTableView];
    
    //加载右边数据表视图
    [self _loadDataTableView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self _requestTestHistoryData];
}

#pragma mark ------------------- private Method -------------------
-(void)_init{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //弹出日历通知
    [kNotification addObserver:self selector:@selector(pelletCalenderView) name:@"pelletCallender" object:nil];
    //时间改变通知
    [kNotification addObserver:self selector:@selector(timeChangedObserve:) name:@"timeChangedNotification" object:nil];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.requestDataDateStr = [NSDate currentDateStringWithFormat:@"yyyy-MM-dd"];
}

-(void)_loadLeftNavItem{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(btnClick) target:self];
}

-(void)_loadTitleView{
    [Util setNavTitleWithTitle:@"体检" ofVC:self];
}

-(void)_loadFounctionNotOpenBgImgView{
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    UIImageView *view =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"selecMain.jpg"]];
    view.contentMode = UIViewContentModeScaleToFill;
    view.frame = CGRectMake(0, 72, __MainScreen_Width, 400);
    view.userInteractionEnabled = YES;
    [self.view addSubview:view];
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Bavk)];
    [view addGestureRecognizer:tap];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self makeJsEnvirement];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}

-(void)makeJsEnvirement {
    JSContext *context = [self.web valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    WeakSelf;
    context[@"requestCheck"] = ^() {
        NSArray *args = [JSContext currentArguments];
        JSValue *value = args[0];
        StrongSelf;
        if([value.toString isEqualToString:@"Blood"]){
            dispatch_barrier_async(dispatch_get_main_queue(), ^{
                [strongSelf _comminToBloodTestPage];
            });
        }//HearRate
        if([value.toString isEqualToString:@"Ratings"]){
            dispatch_barrier_async(dispatch_get_main_queue(), ^{
                [strongSelf _comminToHearingTestPage];
            });
        }
        if([value.toString isEqualToString:@"Eyesight"]){
            dispatch_barrier_async(dispatch_get_main_queue(), ^{
               [strongSelf _comminToEyeSightTestPage];
            });
        }
        if([value.toString isEqualToString:@"HearRate"]){
            dispatch_barrier_async(dispatch_get_main_queue(), ^{
                [strongSelf _comminToHeartRateTestPage];
            });
        }
        if([value.toString isEqualToString:@"Pulmonary"]){
            dispatch_barrier_async(dispatch_get_main_queue(), ^{
                [strongSelf _comminToLungCapacityTestPage];
            });
        }
        if([value.toString isEqualToString:@"Oximeter"]){
            dispatch_barrier_async(dispatch_get_main_queue(), ^{
               [strongSelf _comminToBloodOxenTestPage];
            });
        }
        
        if([value.toString isEqualToString:@"Quick"]){
            dispatch_barrier_async(dispatch_get_main_queue(), ^{
                QuickBodyTestHomeController *quickTestHomeVC = [[QuickBodyTestHomeController alloc] init];
                [strongSelf.navigationController pushViewController:quickTestHomeVC animated:YES];
            });
        }
//        long longValue = value.toNumber.longLongValue;
//        ZhengZhuangListVC *zhengZhuangListVC = [[ZhengZhuangListVC alloc] init];
//        zhengZhuangListVC.fen_lie_ID = longValue ;
//        //        zhengZhuangListVC.isJingGang = YES;
//        //        zhengZhuangListVC.isOKCLick = 1;
//        zhengZhuangListVC.comminType  = FACE_CLICK_COMIN;
//        //        ZhengZhuangListVC.faceClickType = FACE_CLICK_WOMEN;
//        zhengZhuangListVC.faceClickType = FACE_CLICK_MAN;
//        [self.navigationController pushViewController:zhengZhuangListVC animated:YES];
//        JGLog(@"man");
    };
}
- (void)_loadPhysicalTestTableView {
    
    
//    NSArray *data = @[@{@"itemImgName":@"Thermometer",@"itemName":@"血压测量"},
//                      @{@"itemImgName":@"Blood pressure",@"itemName":@"心率测量"},
//                      @{@"itemImgName":@"eyes",@"itemName":@"视力检测"},
//                      @{@"itemImgName":@"Listening",@"itemName":@"听力检测"},
//                      @{@"itemImgName":@"Lung",@"itemName":@"肺活量测试"},
//                      @{@"itemImgName":@"Oxygen",@"itemName":@"血氧测量"}];
    
//    _psTestItemTableView = [[PSTestItemTableView alloc] initWithFrame:CGRectMake(0, kTopBarHeight+kTopEdge, kScreenWidth, kScreenHeight-kStatuBarAndNavBarHeight-kTopBarHeight-kTopEdge) style:UITableViewStylePlain];
//    _psTestItemTableView = [[PSTestItemTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
//    _psTestItemTableView.data = data;
//    _psTestItemTableView.backgroundColor = [UIColor clearColor];
//    WEAK_SELF
//    _psTestItemTableView.itemClickBlock = ^(NSIndexPath *clickIndexPath){
//        //进入不同的页面
//        [weak_self _cominToDiffentTestPageAtIndexPath:clickIndexPath];
//    };
//    UIView *physicalHeaderView = BoundNibView(@"PhysicalTestHeaderView", UIView);
//    
//    UIButton *quickTestButton = (UIButton *)[physicalHeaderView viewWithTag:1];
//    [quickTestButton addActionHandler:^(NSInteger tag) {
//        // 友盟统计
//        [MobClick event:kSpeedMobClickKey];
//#pragma mark  进入快速体检首页
//        QuickBodyTestHomeController *quickTestHomeVC = [[QuickBodyTestHomeController alloc] init];
//        [weak_self.navigationController pushViewController:quickTestHomeVC animated:YES];
//    }];
//    physicalHeaderView.size = CGSizeMake(kScreenWidth, kScreenWidth/2.7);
//    _psTestItemTableView.tableHeaderView = physicalHeaderView;
//    _psTestItemTableView.tableFooterView = [UIView new];
//    [self.view addSubview:_psTestItemTableView];
    self.navigationController.navigationBar.translucent = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UIWebView *web = [[UIWebView alloc] init];
    web.delegate = self;
    web.x = 0;
    web.y = - NavBarHeight;
    web.scalesPageToFit = YES;
    web.width = ScreenWidth;
//    web.height = ScreenHeight - NavBarHeight;
    web.height = ScreenHeight;
    web.scrollView.scrollEnabled = NO;
//    web.height = _psTestItemTableView.size.height;
    NSString *adUrl = [NSString stringWithFormat:@"%@%@",StaticBase_Url,@"/static/app/check/check_main.htm"];
    NSURL *url = [NSURL URLWithString:adUrl];
    NSURLRequest *reqest = [NSURLRequest requestWithURL:url];
    [web loadRequest:reqest];
    web.backgroundColor = JGColor(165, 11, 34, 1);
    self.web = web;
    [self.view addSubview:self.web];
    
    
//    [_psTestItemTableView addSubview:self.web];
    
     [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}


-(void)_requestTestHistoryData{
    _vapManager = [[VApiManager alloc] init];
    PhysicalListQueryRequest *physicalListQueryRequest = [[PhysicalListQueryRequest alloc] init:GetToken];
    physicalListQueryRequest.api_time = self.requestDataDateStr;
    [_vapManager physicalListQuery:physicalListQueryRequest success:^(AFHTTPRequestOperation *operation, PhysicalListQueryResponse *response) {
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:response.physicalArr.count];
        for (NSDictionary *dic in response.physicalArr) {
            [arr addObject:dic];
        }
        _dataTestItemTableView.dataArr = (NSArray *)arr;
        [_dataTestItemTableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

#pragma mark - 进入不同的测试页面
-(void)_cominToDiffentTestPageAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger pageType = indexPath.row;
    switch (pageType) {
        case 0:
        {
            //血压测量
            [self _comminToBloodTestPage];
            break;
        }
        case 1:
        {
            //心率测量
            [self _comminToHeartRateTestPage];
            break;
        }
        case 12:
            //心理检测
            break;
        case 2:
        {
            //视力检测
            [self _comminToEyeSightTestPage];
            break;
        }
        case 3:
        {
            //听力检测
            [self _comminToHearingTestPage];
            break;
        }
        case 4:
        {
            //肺活量测试
            [self _comminToLungCapacityTestPage];
        }
            break;
        case 6:
            //心电图测试
            break;
        case 5:
        {
            //血氧测量
            [self _comminToBloodOxenTestPage];
            break;
        }
        default:
            break;
    }
}

#pragma mark - 各个页面进入方法
-(void)_comminToHeartRateTestPage{
    // 友盟统计
    [MobClick event:kHeartRateMobClickKey];
    
    //心率测量
    HeatTestVC *heatTestVC = [[HeatTestVC alloc] init];
    heatTestVC.testType = HeartRateTest;
    [self.navigationController pushViewController:heatTestVC animated:YES];

}//心率

-(void)_comminToBloodTestPage{
    // 友盟统计
    [MobClick event:kBloodPressureMobClickKey];
    
    //血压测量
    HeatTestVC *heatTestVC = [[HeatTestVC alloc] init];
    heatTestVC.testType = BloodPressureTest;
    [self.navigationController pushViewController:heatTestVC animated:YES];
}//血压

-(void)_comminToBloodOxenTestPage{
    // 友盟统计
    [MobClick event:kBloodOxygenMobClickKey];
    
    //血氧测量
    HeatTestVC *heatTestVC = [[HeatTestVC alloc] init];
    heatTestVC.testType = BloodOxyen;
    [self.navigationController pushViewController:heatTestVC animated:YES];
}//血氧

-(void)_comminToEyeSightTestPage{
    // 友盟统计
    [MobClick event:kSightMobClickKey];
    //视力检测
    menuViewController *eyeecharVC = [[menuViewController alloc] init];
    eyeecharVC.titleText = @"检查视力";
    eyeecharVC.menuContentArray = @[@"视力表",@"视力检查",@"色盲测试",@"散光测试"];
    eyeecharVC.contentView = @[@"eyeChartView",@"eyeTestView",@"colourBlindnessView",@"astigmatismView"];
    [self.navigationController pushViewController:eyeecharVC animated:YES];
}//视力

-(void)_comminToHearingTestPage{
    // 友盟统计
    [MobClick event:kListeningPressureMobClickKey];
    //听力检测
    HearingTestVC *hearingTestVC = [[HearingTestVC alloc] init];
    [self.navigationController pushViewController:hearingTestVC animated:YES];
    
}//听力


-(void)_comminToLungCapacityTestPage{
    // 友盟统计
    [MobClick event:kVitalCapacityMobClickKey];
    
    //肺活量测试
    menuViewController *eyeecharVC = [[menuViewController alloc] init];
    eyeecharVC.titleText = @"肺活量测试";
    eyeecharVC.menuContentArray = @[@"手机测量",@"手动输入"];
    eyeecharVC.contentView = @[@"lungPhoneView",@"lungManualView"];
    [self.navigationController pushViewController:eyeecharVC animated:YES];
}//肺活量

-(void)_loadDataTableView{
    /**
     * 类型|1视力表2视力检测3色盲测试4散光测试5听力6血压7心率8肺活量9血氧
     */
    _dataTestItemTableView = [[PSDataTestItemTableView alloc] initWithFrame:CGRectMake(0, kTopBarHeight+kTopEdge, kScreenWidth, kScreenHeight-kTopBarHeight-kStatuBarAndNavBarHeight-kTopEdge)];
        NSLog(@"calender botton %.2f",_dataTopCalenderView.bottom);
    _dataTestItemTableView.hidden = YES;
    _dataTestItemTableView.backgroundColor = [UIColor clearColor];
    _dataTestItemTableView.testTypeArr = @[@"色盲",@"视力",@"心率",@"血压",
                                           @"听力",@"散光",@"血氧",@"肺活量"];
    //每个cell对应的测试类型
    _typeNumArr = @[@3,@2,@7,@6,@5,@4,@9,@8];
    _dataTestItemTableView.typeNumArr = _typeNumArr;
    WEAK_SELF
    _dataTestItemTableView.testTypeEditBlock = ^(NSInteger typeNum){
        //加载类型编辑视图
        [weak_self _loadTypeTestEditViewWithTypeNum:typeNum];
    };
    _dataTestItemTableView.tableFooterView = [UIView new];
    
    //没有测试的，进入不同的测试页面
    _dataTestItemTableView.comIntoDiffentTestPageBlock = ^(NSInteger testTypeNum){
        [weak_self _cominToDiffentTestPageWithTestTypeNum:testTypeNum];
    };
    
    //点击疑似和正常按钮，返回block
    _dataTestItemTableView.normalOrDoutfulTypeBlock = ^(SightTestResultType sightTestResultType,NSInteger sightTestNum){
        //色盲和散光编辑后网络请求
        [weak_self _postDataSihgtBlinessAndAstimasWihtTestResultType:sightTestResultType testTypeNum:sightTestNum];
    };
    [self.view addSubview:_dataTestItemTableView];
}//右边数据表视图

-(void)_cominToDiffentTestPageWithTestTypeNum:(NSInteger)testTypeNum{
    switch (testTypeNum) {
        case 1:
        case 2:
        case 6:
            //视力
            [self _comminToEyeSightTestPage];
            break;
        case 3:
            //心率
            [self _comminToHeartRateTestPage];
            break;
        case 4:
            //血压
            [self _comminToBloodTestPage];
            break;
        case 5:
            //听力
            [self _comminToHearingTestPage];
            break;
        case 7:
            //血氧
            [self _comminToBloodOxenTestPage];
            break;
        case 8:
            //肺活量
            [self _comminToLungCapacityTestPage];
            break;
        default:
            break;
    }
}//进入不同的测试页

-(void)_loadTypeTestEditViewWithTypeNum:(NSInteger)typeNum{

    switch (typeNum) {
        case 2:
        case 3:
        case 7:
        case 8:
            [self _loadOneValueInputTestTypeViewWithTypeNum:typeNum];
            break;
        case 4:
        case 5:
            //只有血压和听力是两个值输入
            [self _loadTwoValueInputTestTypeViewWithTypeNum:typeNum];
            break;
        default:
            break;
    }
}//加载类型编辑视图

-(void)_loadOneValueInputTestTypeViewWithTypeNum:(NSInteger)typeNum{
    oneEditTestTypeView = BoundNibView(@"SimilarHeartRateEditView", SimilarHeartRateEditView);
    [self.view.window addSubview:oneEditTestTypeView];
    WeakSelf;

    [oneEditTestTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(bself.view.window);
    }];
    
    __weak typeof(PSDataTestItemTableView *) weakTableView = _dataTestItemTableView;
    oneEditTestTypeView.editEndBlock = ^(NSString *inputValue){
        StrongSelf;
        PSDataTestItemCell *cell = (PSDataTestItemCell *)[weakTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:typeNum inSection:0]];
        if (!cell.doneTestButton.selected) {
            cell.doneTestButton.selected = YES;
            cell.doneTestSecondButton.hidden = YES;
        }
        cell.typeValueLabel.hidden = NO;
        cell.typeValueLabel.text = inputValue;
        //编辑之后请求网络
        [strongSelf _postEditDataOfTwoValueWithTypeNum:typeNum value:inputValue];
    };
    switch (typeNum) {
        case 2:
            //视力
            oneEditTestTypeView.testEditType = EyeSightEditType;
            break;
        case 3:
            oneEditTestTypeView.testEditType = HeatRateEditType;
            break;
        case 7:
            oneEditTestTypeView.testEditType = BloodOxenEditType;
            break;
        case 8:
            oneEditTestTypeView.testEditType = LungCapacityEditType;
            break;
        default:
            break;
    }
    [oneEditTestTypeView performSelector:@selector(beginAnimation) withObject:nil afterDelay:0.2];
}

-(void)_loadTwoValueInputTestTypeViewWithTypeNum:(NSInteger)typeNum{
    SimilarBloodPressureView *twoEditTestTypeView = BoundNibView(@"SimilarBloodPressureView", SimilarBloodPressureView);
    [self.view.window addSubview:twoEditTestTypeView];
    WeakSelf;

    [twoEditTestTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(bself.view.window);
    }];
    
    twoEditTestTypeView.lowAndHighBlock = ^(NSString *lowValue,NSString *highValue){
        StrongSelf;
        PSDataTestItemCell *cell = (PSDataTestItemCell *)[_dataTestItemTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:typeNum inSection:0]];
        if (!cell.doneTestButton.selected) {
            cell.doneTestButton.selected = YES;
            cell.doneTestSecondButton.hidden = YES;
        }
        cell.typeValueLabel.hidden = NO;
        cell.typeValueLabel.text = [NSString stringWithFormat:@"%@/%@",lowValue,highValue];
        //编辑之后请求网络
        [strongSelf _postEditDataOfTwoValueWithTypeNum:typeNum lowValue:lowValue highValue:highValue];
    };
    switch (typeNum) {
        case 4:
            //血压
            twoEditTestTypeView.testEditType = BloodPressureEditType;
            break;
        case 5:
            twoEditTestTypeView.testEditType = HearingEditType;
            break;
        default:
            break;
    }
    [twoEditTestTypeView performSelector:@selector(beginAnimation) withObject:nil afterDelay:0.2];
}//两个输入的类型编辑视图


#pragma mark --------------------- 编辑之后进行网络请求
#pragma mark - 两个值的
-(void)_postEditDataOfTwoValueWithTypeNum:(NSInteger)typeNum lowValue:(NSString *)lowValue highValue:(NSString *)highValue
{
    PhysicalSaveRequest *saveRequest = [[PhysicalSaveRequest alloc] init:GetToken];
    saveRequest.api_time = [NSDate currentDateStringWithFormat:@"yyyy-MM-dd"];
    switch (typeNum) {
        case 4:
            //血压
        {
            saveRequest.api_type = @(6);
            saveRequest.api_minValue = @([lowValue floatValue]);
            saveRequest.api_maxValue = @([highValue floatValue]);
        }
            break;
        case 5:
            //听力
        {
            saveRequest.api_type = @(5);
            saveRequest.api_minValue = @([lowValue floatValue]);
            saveRequest.api_maxValue = @([highValue floatValue]);
        }
            break;
        default:
            break;
    }
    [_vapManager physicalSave:saveRequest success:^(AFHTTPRequestOperation *operation, PhysicalSaveResponse *response) {
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
}

#pragma mark - 一个值的
-(void)_postEditDataOfTwoValueWithTypeNum:(NSInteger)typeNum value:(NSString *)value
{
    PhysicalSaveRequest *saveRequest = [[PhysicalSaveRequest alloc] init:GetToken];
    saveRequest.api_time = [NSDate currentDateStringWithFormat:@"yyyy-MM-dd"];
    switch (typeNum) {
        case 2:
            //视力
        {
            saveRequest.api_type = @(2);
            saveRequest.api_maxValue = @([value floatValue]);
            saveRequest.api_minValue = @([value floatValue]);
        }
            break;
        case 3:
            //心率
        {
            saveRequest.api_type = @(7);
            saveRequest.api_maxValue = @([value floatValue]);
        }
            break;
        case 7:
            //血氧
        {
            saveRequest.api_type = @(9);
            saveRequest.api_maxValue = @([value floatValue]);
        }
            break;
        case 8:
            //肺活量
        {
            saveRequest.api_type = @(8);
            saveRequest.api_maxValue = @([value floatValue]);
        }
            break;
        default:
            break;
    }
    [_vapManager physicalSave:saveRequest success:^(AFHTTPRequestOperation *operation, PhysicalSaveResponse *response) {
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
}


#pragma mark - 色盲和散光的
-(void)_postDataSihgtBlinessAndAstimasWihtTestResultType:(SightTestResultType)sightTestResultType testTypeNum:(NSInteger)typeNum
{
    PhysicalSaveRequest *saveRequest = [[PhysicalSaveRequest alloc] init:GetToken];
    saveRequest.api_time = [NSDate currentDateStringWithFormat:@"yyyy-MM-dd"];
    if (typeNum == 1) {//色盲
        if (sightTestResultType == NormalType) {//正常,没有色盲
            saveRequest.api_type = @(3);
            saveRequest.api_maxValue = @(1);
        }else{
            saveRequest.api_type = @(3);
            saveRequest.api_maxValue = @(2);
        }
    }else{//散光
        if (sightTestResultType == NormalType) {//正常,没有散光
            saveRequest.api_type = @(4);
            saveRequest.api_maxValue = @(1);
            saveRequest.api_middleValue = @(0);
        }else{
            saveRequest.api_type = @(4);
            saveRequest.api_maxValue = @(2);
            saveRequest.api_middleValue = @(1);
        }
    }
    [_vapManager physicalSave:saveRequest success:^(AFHTTPRequestOperation *operation, PhysicalSaveResponse *response) {
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
}

-(void)_loadTableCalenderHeader{
    
    _dataTopCalenderView = [[CKCalendarView alloc] initWithStartDay:startSunday];
    _dataTopCalenderView.frame = CGRectMake(0, 0, kScreenWidth, 22);
    _dataTopCalenderView.heightChangedBlock = ^(CGFloat newHeight){
        
    };
    _dataTestItemTableView.tableHeaderView = _dataTopCalenderView;
}

- (void)_loadTopTabar {
    _topBarHMSegmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"体检",@"数据"]];
    _topBarHMSegmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    _topBarHMSegmentedControl.frame = CGRectMake(0, 0, kScreenWidth, kTopBarHeight);
    _topBarHMSegmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
    _topBarHMSegmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    _topBarHMSegmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _topBarHMSegmentedControl.selectionIndicatorColor = kGetColor(94, 180, 231);
    _topBarHMSegmentedControl.selectedTextColor = kGetColor(94, 180, 231);
    _topBarHMSegmentedControl.font = [UIFont systemFontOfSize:16];
    _topBarHMSegmentedControl.selectionIndicatorHeight = 4.0f;
    [_topBarHMSegmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_topBarHMSegmentedControl];
}


-(void)_calenderBack{
    [UIView animateWithDuration:1.0 delay:0.2 usingSpringWithDamping:0.6 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _calenderBackgroudView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        //移除所有子视图
        [_calenderBackgroudView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        //移除自身
        [_calenderBackgroudView removeFromSuperview];
        //置位返回标志
        _isCalenderBack = NO;

    }];
}//弹出日历返回动作



#pragma mark -------------------  Action Method -------------------
-(void)Bavk
{
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    if (segmentedControl.selectedSegmentIndex == 0) {
        if (!_psTestItemTableView.hidden) {
            return;
        }
        _psTestItemTableView.hidden = NO;
        _dataTestItemTableView.hidden = YES;
    }else{
        if (!_dataTestItemTableView.hidden) {
            return;
        }
        _dataTestItemTableView.hidden = NO;
        _psTestItemTableView.hidden = YES;
    }
}


#pragma mark - 弹出日历通知监听
-(void)pelletCalenderView{
    _calenderBackgroudView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight)];
    _calenderBackgroudView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_calenderBackgroudView];
    _calenderBackgroudView.tag = 5;
    WEAK_SELF
    chvc = [[CalendarHomeViewController alloc] init];
    [chvc setAirPlaneToDay:365 ToDateforString:nil];//飞机初始化方法
    chvc.calendarblock = ^(CalendarDayModel *model){
        //拿到日历cell进行刷新
        CalenderHeaderCell *calenderHeaderCell = (CalenderHeaderCell *)[weak_self.dataTestItemTableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        calenderHeaderCell.currentDate = model.selectedDate;
    };
    chvc.view.frame = _calenderBackgroudView.bounds;
    chvc.edgesForExtendedLayout = UIRectEdgeNone;
    [_calenderBackgroudView addSubview:chvc.view];

    _calenderBackgroudView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:1.0 delay:0.2 usingSpringWithDamping:0.6 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _calenderBackgroudView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
    }];
    //标志要弹出日历返回
    _isCalenderBack = YES;
}

#pragma mark - 时间改变通知监听
-(void)timeChangedObserve:(NSNotification *)notiInfo{
    self.requestDataDateStr = (NSString *)notiInfo.object;
}

-(void)btnClick
{
    if (_isCalenderBack) {//如果是弹出日历返回
        [self _calenderBack];
        return ;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ----------------setter Method-----------------
-(void)setRequestDataDateStr:(NSString *)requestDataDateStr{
    //改变时间之后，就进行网络请求刷新表
    _requestDataDateStr = requestDataDateStr;
    [self _requestTestHistoryData];
}


#pragma mark -dealloc
- (void)dealloc
{
    //移除通知
    [kNotification removeObserver:self];
    
}


@end
