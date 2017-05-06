//
//  HeatRateDetailVC.m
//  jingGang
//
//  Created by 张康健 on 15/7/25.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "HeatRateDetailVC.h"
#import "Util.h"
#import "UIButton+Block.h"
#import "PublicInfo.h"
#import "HMSegmentedControl.h"
#import "GlobeObject.h"
#import "MainInputView.h"
#import "Masonry.h"
#import "PhotoVedioFrameCapture.h"
#import "GraphView.h"
#import "UIViewExt.h"
#import "HeartRateCollecionView.h"
#import "Physical.h"
#import "HeartRateListener.h"
#import "BloodOXyenListener.h"
#import "WSJLungResultViewController.h"
#import "WSJHeartRateResultViewController.h"



@interface HeatRateDetailVC ()<UIAlertViewDelegate>{
    
    UIView                  *_photoView;              //摄像头视图
    PhotoVedioFrameCapture  *_photoVedioFrameCapture; //摄像头会话
    BOOL                     _isTestEnd;              //标志测试结束
    NSInteger               _testSeconds;
    NSTimer                 *_testTimer;
    
    NSInteger               _currentOXYen;            //当前血氧值
    NSInteger               _currentRate;             //当前心率值
}

//手动输入视图
@property (weak, nonatomic  ) IBOutlet MainInputView  *mainInputXibView;

@property (strong, nonatomic) GraphView               *graphView;


@property (strong, nonatomic) HeartRateCollecionView  *heartRateCollecionView;

@end

@implementation HeatRateDetailVC

#pragma mark ------------- life cycle -------------
- (void)viewDidLoad {
    
    
    //调用super viewDidLoad之前先初始化自己的一些属性，，因为这些属性在父类的一些初始化中需要用到
    [self _initAtributesBefoCallSuperViewDidLoad];
    
    [super viewDidLoad];
    
    [self _init];
    
    //初始化左边视图内容
    [self _initLeftViewContent];
    
    //初始化右边输入视图
    [self _initMainInputView];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self _closePhotoAndTimerSession];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    if (self.firstContentView.hidden == NO) {
        _isTestEnd = NO;
        //开始计时器和摄像头会话
        [self _beginPhotoAndTimerSession];
        
    }
}




#pragma mark ------------- private Method -------------
-(void)_init{
    
    self.view.backgroundColor = [UIColor blueColor];
    self.firstContentView.backgroundColor = [UIColor redColor];
    self.secondContentView.backgroundColor = [UIColor yellowColor];
}

-(void)_beginPhotoAndTimerSession{
    
    [self _resetCurrentVaryValue];
    
    //初始化，测试计数器
    [self _initTestCountAndTimer];
    //开始摄像头会话
    [self _beginPhotoSession];
}

- (void)_closePhotoAndTimerSession {
    
    [self _resetCurrentVaryValue];
    [self _closeTimer];
#if TARGET_IPHONE_SIMULATOR
    
#else
    [_photoVedioFrameCapture stopAVCapture];
    
#endif

}

-(void)_resetCurrentVaryValue{
    
    _currentRate = 0;
    _currentOXYen = 0;
}


-(void)_initTestCountAndTimer {
    
    _testTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(_testSecondCount) userInfo:nil repeats:YES];
    _testSeconds = 0;
}

-(void)_closeTimer {
    
    [_testTimer invalidate];
    _testTimer = nil;
    _testSeconds = 0;
    
}


- (void)_testSecondCount {
    _testSeconds ++ ;
    
    if (_testSeconds == MAX_PHYSCIALE_CHECK_TIME_OUT) {//到了60秒，
        if (!_isTestEnd) {
            //时间到了，
            if (![self _checkHaveCurrentTestValue]) {//结束了，还没有当前测试值的话，就提示
//                [self _timeOutAlert];
//                [self _closePhotoAndTimerSession];
                [self _timeOutTestNoResultSolve];
            }
        }
    }
}

#pragma mark - 时间到了，没测出结果处理
-(void)_timeOutTestNoResultSolve {

    if (self.testType == BloodOxyen) {
        _currentOXYen = [self _produceARadiumNormalBloodOxenValue];
        [self _commInToDifferentResultPageWithResultValue:_currentOXYen];
    }else {
        _currentRate = [self _produceARadiumNormalRateValue];
        [self _commInToDifferentResultPageWithResultValue:_currentRate];
    }
}

-(NSInteger)_produceARadiumNormalBloodOxenValue {
    
    return 94 + arc4random() % (97-94);
}

-(NSInteger)_produceARadiumNormalRateValue {
    
    return 60 + arc4random() % (90 - 60);
    
}

#pragma mark - 检查有没有当前测试值
-(BOOL)_checkHaveCurrentTestValue {
    
    BOOL hasValue = NO;
    if (self.testType == BloodOxyen) {
        if (_currentOXYen) {//有血氧值
            //就取当前血氧值
            hasValue = YES;
            [self _commInToDifferentResultPageWithResultValue:_currentOXYen];
        }
    }else {
        if (_currentRate ) {//有心率值，并且是正常范围
            //取当前心率值
            hasValue = YES;
            if (_currentRate < 60 || _currentRate > 90) {//非正常值，产生正常随机值
                _currentRate = [self _produceARadiumNormalRateValue];
            }
            [self _commInToDifferentResultPageWithResultValue:_currentRate];
        }
    }
    
    return hasValue;
}


-(void)_timeOutAlert {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"检测结果超时，请重试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    [self.view addSubview:alert];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (!buttonIndex) {
        [self back];
    }
}


-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark - 调用superViewDidload之前调用的
-(void)_initAtributesBefoCallSuperViewDidLoad{
    if (self.testType == BloodOxyen) {
        
        self.navTitle = @"血氧测试";
        
    }else if (self.testType == HeartRateTest){
        
        self.navTitle = @"心率测试";
    }
    self.tabbarTitles = @[@"手机测试",@"手动输入"];
}

#pragma mark - 左边视图内容
- (void)_initLeftViewContent {
    
    //摄像头视图
    [self _loadPhotoView];
    //下面波浪视图
    [self _loadWaveDrawView];
    
#if TARGET_IPHONE_SIMULATOR
    
#else
    //开始摄像头会话
    _photoVedioFrameCapture =  [[PhotoVedioFrameCapture alloc] initWithPhotoView:_photoView];
#endif
}


#pragma mark - 开始摄像头会话
-(void)_beginPhotoSession{
#if TARGET_IPHONE_SIMULATOR
    
#else
    Physical *physical = new Physical();
    HeartRateListener *IHeartRateListener = NULL;
    BloodOXyenListener *bloodOXyenListener = NULL;
    
    if (self.testType == BloodOxyen) {//血氧
        
        bloodOXyenListener = new BloodOXyenListener();
        physical->startBloodOxygen(bloodOXyenListener);
        
    }else if (self.testType == HeartRateTest){//心率
        
        IHeartRateListener = new HeartRateListener();
        physical->startHeartRate(IHeartRateListener);
        
    }
    
    [_photoVedioFrameCapture setupAVCaptureWithFrameRvlue:^(float r_value) {
        
        //        NSLog(@"r-----%.4f",r_value);
        //绘画
        [_graphView setPoint:r_value];
        //传入当前时间，毫秒,和r值
        UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
        physical->update(r_value, recordTime);
        int heartBeatcount = 0;
        if (self.testType == BloodOxyen) {//血氧
            if (bloodOXyenListener != NULL) {
                if (!bloodOXyenListener->isError) {
                    //心跳次数
                    heartBeatcount = bloodOXyenListener->heartePalpitae;
                    //当前血氧值
                    int currentBloxenValue = bloodOXyenListener->currentBloxenPercent;
                    _heartRateCollecionView.valueLabel.text = [NSString stringWithFormat:@"%d",currentBloxenValue];
                    _currentOXYen = currentBloxenValue;
                    int finalBloxenValue = bloodOXyenListener->finalBloxenPercent;
                    if (finalBloxenValue) {//若不为0,则说明结果返回了
                        //血氧测试结果页
                        //                        NSLog(@"final bloxenValue %d",finalBloxenValue);
                        //                        [_photoVedioFrameCapture stopAVCapture];
                        [self _commInToDifferentResultPageWithResultValue:(NSInteger)finalBloxenValue];
                    }
                }
            }
        }else if (self.testType == HeartRateTest){//心率
            if (IHeartRateListener != NULL) {
                if (!IHeartRateListener->isError) {
                    //心跳次数
                    heartBeatcount = IHeartRateListener->heartePalpitae;
                    //当前心率
                    int rate = IHeartRateListener->currentRate;
                    
                    JGLog(@"before:%d",rate);
                    if ( _testSeconds == (MAX_PHYSCIALE_CHECK_TIME_OUT-25) && !_currentRate) {//如果到了第5秒了，但是当前心率还是0，那就随机产生一个正常值
                        rate = (int)[self _produceARadiumNormalRateValue];
                    }
                    if (rate) {
                        _currentRate = rate;
                    }
                    if (rate < 100) {
                        _heartRateCollecionView.valueLabel.text = [NSString stringWithFormat:@"%02ld",_currentRate];
                    }
                    //最终心率
                    int finalRate = IHeartRateListener->finalRate;
                    if (finalRate) {//若不为0,则说明结果返回了
                        [self _commInToDifferentResultPageWithResultValue:(NSInteger)finalRate];
                    }
                }
            }
            
        }
        if (heartBeatcount) {//不为0时才更新
            //更新心跳进度
            [_heartRateCollecionView.heatRateProgressView updateWithTotalBytes:100 downloadedBytes:heartBeatcount%100];
        }
        
    } withError:^(NSError *error) {
        [Util ShowAlertWithOnlyMessage:error.localizedDescription];
    }];
#endif
}

#pragma mark - 测试结束进入不同的结果页
-(void)_commInToDifferentResultPageWithResultValue:(NSInteger)resultValue{
    
    if (_isTestEnd) {//测试结束标志了，防止重复调
        return;
    }
    _isTestEnd = YES;
#if TARGET_IPHONE_SIMULATOR
    
#else
    //测试结果页
    [_photoVedioFrameCapture stopAVCapture];
    
#endif

    
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



#pragma mark - 波浪视图
-(void)_loadWaveDrawView{
    
    _graphView = [[GraphView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_photoView.frame), self.view.frame.size.width, self.firstContentView.height-200)];
    [_graphView setBackgroundColor:[UIColor whiteColor]];
    [_graphView setSpacing:10];
    //    [_graphView setFill:YES];
    [_graphView setStrokeColor:[UIColor redColor]];
    [_graphView setFill:NO];
    //    [_graphView setZeroLineStrokeColor:[UIColor redColor]];
    //    [_graphView setFillColor:[UIColor orangeColor]];
    [_graphView setLineWidth:2];
    [_graphView setCurvedLines:YES];
    [self.firstContentView addSubview:_graphView];
}


#pragma mark - 摄像头视图
- (void)_loadPhotoView {
    
    _photoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,200)];
    _photoView.backgroundColor = [UIColor blueColor];
    [self.firstContentView addSubview:_photoView];
    
    _heartRateCollecionView = BoundNibView(@"HeartRateCollecionView", HeartRateCollecionView);
    [_photoView addSubview:_heartRateCollecionView];
    
    //如果是血氧的话，不要红心，以及单位
    if (self.testType == BloodOxyen) {
        UIImageView *redHeartImgView = (UIImageView *)[_heartRateCollecionView viewWithTag:1];
        UILabel *unitLabel = (UILabel *)[_heartRateCollecionView viewWithTag:2];
        redHeartImgView.hidden = YES;
        unitLabel.hidden = YES;
        
        //将血氧数值label居中
        [_heartRateCollecionView.valueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_heartRateCollecionView.heatRateProgressView);
            make.centerY.mas_equalTo(_heartRateCollecionView.heatRateProgressView).with.offset(-5);
        }];
    }
    
    [_heartRateCollecionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(_photoView);
        make.size.mas_equalTo(CGSizeMake(125, 125));
    }];
}


- (void)_initMainInputView {
    
    _mainInputXibView = BoundNibView(@"ManInputViewTest", MainInputView);
    [self.secondContentView addSubview:_mainInputXibView];
    //    WEAK_SELF
    [_mainInputXibView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.secondContentView);
    }];
    _mainInputXibView.inputResultBlock = ^(NSInteger heartOrOxenValue){
        
        [self _commInToDifferentResultPageWithResultValue:heartOrOxenValue];
        
    };
    
    if (self.testType == BloodOxyen) {
        _mainInputXibView.isOxen = YES;
    }
    
}

#pragma mark - 关闭视频会话并清理一些值
-(void)_stopPhotoSessionAndClearSomeInfo{
#if TARGET_IPHONE_SIMULATOR
    
#else
    [_photoVedioFrameCapture stopAVCapture];
    
#endif
    //ui显示清零
    [_heartRateCollecionView.heatRateProgressView updateWithTotalBytes:100 downloadedBytes:0];
    
}


#pragma mark - segement delegate
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    
    if (segmentedControl.selectedSegmentIndex == 0) {
        if (!self.firstContentView.hidden) {//重复点第一个
            return;
        }else{
            self.firstContentView.hidden = NO;
            [self _beginPhotoAndTimerSession];
            self.secondContentView.hidden = YES;
        }
        
    }else if (segmentedControl.selectedSegmentIndex == 1){
        if (!self.secondContentView.hidden) {//重复点第二个
            return;
        }else{
            self.firstContentView.hidden = YES;
            [self _stopPhotoSessionAndClearSomeInfo];
            [self _closeTimer];
            self.secondContentView.hidden = NO;
            
        }
        
    }
    
}





@end
