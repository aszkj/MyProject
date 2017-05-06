//
//  HeatTestVC.m
//  jingGang
//
//  Created by 张康健 on 15/7/25.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "HeatTestVC.h"
#import "GlobeObject.h"
#import "MainInputView.h"
#import "Masonry.h"
#import "Util.h"
#import "UIButton+Block.h"
#import "PublicInfo.h"
#import "HeatRateDetailVC.h"
#import "BloodPressureInputView.h"
#import "BloodPressureTestVC.h"
#import "WSJLungResultViewController.h"
#import "WSJHeartRateResultViewController.h"
#import "WSJBloodPressureViewController.h"
#import "JGBloodPressureTestController.h"
#import "JGHeartRateTestController.h"

@interface HeatTestVC ()
@property (weak, nonatomic ) IBOutlet UIButton            *phoneTestBtn;
@property (weak, nonatomic ) IBOutlet UIButton            *manInputTest;
@property (weak, nonatomic ) IBOutlet UIView              *sliderBar;
@property (weak, nonatomic ) IBOutlet NSLayoutConstraint  *sliderToleftConstraint;
@property (nonatomic,strong) NSArray                      *tabbuttonArr;
@property (nonatomic,strong) NSArray                      *contenViewArrs;
//手机测试视图
@property (weak, nonatomic ) IBOutlet UIView              *phoneTestView;
//手动输入视图基视图
@property (weak, nonatomic ) IBOutlet UIView              *mainInputView;
//手动输入视图
@property (weak, nonatomic ) IBOutlet MainInputView       *mainInputXibView;

@property (weak, nonatomic ) IBOutlet NSLayoutConstraint  *imgToTopConstraint;

@property (weak, nonatomic ) IBOutlet NSLayoutConstraint  *textToImgEedgeConstraint;

@end

@implementation HeatTestVC

#pragma mark ------------- life cycle -------------
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    
    [self _initTitleView];
    
    [self _initLeftNavItem];
    
    //初始化手动输入视图，从nib文件中加载
    if (self.testType == HeartRateTest || self.testType == BloodOxyen) {//心率或者血氧手动输入
        
        [self _initHeartRateInputView];
        
    }else if (self.testType == BloodPressureTest){//血压手动输入
        
        [self _initBloodPressureInputView];
        
    }
    
}


#pragma mark ------------- private Method -------------
-(void)_init{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _tabbuttonArr = @[self.phoneTestBtn,self.manInputTest];
    _contenViewArrs = @[self.phoneTestView,self.mainInputView];
    
    CGFloat imgToTopEdge = (47.0 / iPhone6_Height) * kScreenHeight;
    CGFloat textToImgEdge = (27.0 / iPhone6_Height) * kScreenHeight;
    self.imgToTopConstraint.constant = imgToTopEdge;
    self.textToImgEedgeConstraint.constant = textToImgEdge;
}


-(void)_initLeftNavItem{

    [self setupNavBarPopButton];
    [self setupNavBarRightButtonWithTitle:@"详细介绍"];
//    // Do any additional setup after loading the view.
//    UIButton *button_na = [[UIButton alloc]initWithFrame:CGRectMake(20, 30, 35, __NavScreen_Height-15)];
//    [button_na setImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
//    //    [button_na addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
//    WEAK_SELF
//    [button_na addActionHandler:^(NSInteger tag) {
//        [weak_self.navigationController popViewControllerAnimated:YES];
//    }];
//    
//    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:button_na];
//    self.navigationItem.leftBarButtonItem = bar;
    
}
- (void)navRightAction:(id)arg {
    [self showHud];
    VApiManager *manager = [[VApiManager alloc] init];
    NSNumber *typeId;
    switch (self.testType) {
        case HeartRateTest:
            // 心率
            typeId = @(7);
            break;
        case BloodOxyen:
            // 血氧
            typeId = @(9);
            break;
        case BloodPressureTest:
            // 血压测试
            typeId = @(6);
            break;
        default:
            break;
    }
    PhysicalDescriptionRequest *res = [[PhysicalDescriptionRequest alloc] init:GetToken];
    res.api_phySicalTypeId = typeId;
    
    [manager physicalDescription:res success:^(AFHTTPRequestOperation *operation, PhysicalDescriptionResponse *response) {
        [self hiddenHud];
        JGLog(@"res:%@",response);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        JGLog(@"error:%@",error);
        [self hiddenHud];
    }];
}

- (void)dealloc
{
    
}


-(void)_initTitleView{
    
    if (self.testType == HeartRateTest) {
        
        [Util setNavTitleWithTitle:@"心率测试" ofVC:self];
    }else if (self.testType == BloodPressureTest){
        
        [Util setNavTitleWithTitle:@"血压测试" ofVC:self];
        
    }else if (self.testType == BloodOxyen){
        
        [Util setNavTitleWithTitle:@"血氧测试" ofVC:self];
    }
}

- (void)_initHeartRateInputView {
    
    _mainInputXibView = BoundNibView(@"ManInputViewTest", MainInputView);
    [_mainInputView addSubview:_mainInputXibView];
    
    [_mainInputXibView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(_mainInputView);
    }];
    WEAK_SELF
    _mainInputXibView.inputResultBlock = ^(NSInteger heartOrOxenValue){
    
        //进入心率或者血氧结果页
        [weak_self _commInToHeartOrOxenResultPageWithResultValue:heartOrOxenValue];
    
    };
    //如果是血氧的话，改变label的显示
    if (self.testType == BloodOxyen) {
        //内部进行处理
        _mainInputXibView.isOxen = YES;
    }
    
}//心率手动输入view


#pragma mark - 测试结束进入心率或者血氧结果页
-(void)_commInToHeartOrOxenResultPageWithResultValue:(NSInteger)resultValue{
    
    if (self.testType == BloodOxyen) {
        
        WSJLungResultViewController *lungResultVC = [[WSJLungResultViewController alloc] initWithNibName:@"WSJLungResultViewController" bundle:nil];
        lungResultVC.type = bloodOxygenType;
        lungResultVC.heartRateValue = resultValue;
        [self.navigationController pushViewController:lungResultVC animated:YES];
        
    }else if (self.testType == HeartRateTest){
        
        //心率结果
        WSJHeartRateResultViewController *heartResult =[[WSJHeartRateResultViewController alloc] initWithNibName:@"WSJHeartRateResultViewController" bundle:nil];
        heartResult.heartRateValue = resultValue;
        [self.navigationController pushViewController:heartResult animated:YES];
        
    }
    
}

-(void)_initBloodPressureInputView{
    
    BloodPressureInputView *bloodPressureInputView = BoundNibView(@"BloodPressureInputView", BloodPressureInputView);
    [_mainInputView addSubview:bloodPressureInputView];
    bloodPressureInputView.bloodPressureInputResultBlock = ^(NSInteger lowPressure, NSInteger highPressure){
        //进入测试结果页
        WSJBloodPressureViewController *bloodPressureResultVC = [[WSJBloodPressureViewController alloc] init];
        bloodPressureResultVC.lowPressure = lowPressure;
        bloodPressureResultVC.highPressure = highPressure;
        [self.navigationController pushViewController:bloodPressureResultVC animated:YES];
    };
    
    [bloodPressureInputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(_mainInputView);
    }];
}//血压手动输入view


#pragma mark - Action Method
- (IBAction)testAction:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    //得到选中的button
    UIButton *lastSeletedButton = [Util getSeletedButtonAtBtnArr:_tabbuttonArr];
    if (button.selected) {//如果本身选中，返回
        return;
    }
    button.selected = YES;
    lastSeletedButton.selected = NO;
    
    
    [UIView animateWithDuration:0.2 animations:^{
        //sliderBar移动
        self.sliderToleftConstraint.constant = button.frame.origin.x;
        [self.view layoutIfNeeded];
        
    }];
    
    //得到之前显示的view,将其隐藏
    UIView *lastDisplayView = [Util getDisplayedViewAtViewArrs:_contenViewArrs];
    lastDisplayView.hidden = YES;
    
    //显示点击button对应的view
     NSInteger selectedIndex = [_tabbuttonArr indexOfObject:button];
    UIView *willDisplayView = [_contenViewArrs objectAtIndex:selectedIndex];
    willDisplayView.hidden = NO;
}

- (IBAction)beginPhoneTest:(id)sender {
    
    if (self.testType == HeartRateTest || self.testType == BloodOxyen) {
        //心率
        if (self.testType == HeartRateTest) {
            // 心率
            JGHeartRateTestController *htController = [[JGHeartRateTestController alloc] init];
            [self.navigationController pushViewController:htController animated:YES];
        }else {
            // 血氧
            HeatRateDetailVC *heatRateDetailVC = [[HeatRateDetailVC alloc] init];
            heatRateDetailVC.testType = self.testType;
            [self.navigationController pushViewController:heatRateDetailVC animated:YES];
        }
    }else if (self.testType == BloodPressureTest){
        //血压
        /**
         BloodPressureTestVC *bloodPressureTestVC = [[BloodPressureTestVC alloc] init];
         [self.navigationController pushViewController:bloodPressureTestVC animated:YES];
         */
//        BloodPressureTestVC *bloodPressureTestVC = [[BloodPressureTestVC alloc] init];
//        [self.navigationController pushViewController:bloodPressureTestVC animated:YES];
        JGBloodPressureTestController *bptController = [[JGBloodPressureTestController alloc] init];
        [self.navigationController pushViewController:bptController animated:YES];
    }
    
}//开始手机测试


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
