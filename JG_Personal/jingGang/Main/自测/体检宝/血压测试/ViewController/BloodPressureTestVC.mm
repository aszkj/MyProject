//
//  BloodPressureTestVC.m
//  jingGang
//
//  Created by 张康健 on 15/7/27.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "BloodPressureTestVC.h"
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
#import "BloodPressureInputView.h"
#import "HeartRateCollecionView.h"
#import "BloodPressureCollectionView.h"
#import "Physical.h"
#import "BloodPressureListener.h"
#import "WSJBloodPressureViewController.h"
#define kTopViewHeight 31


typedef enum : NSUInteger {
    NeverTouchState,  //从没触摸屏幕
    TouchingState,    //正在触摸屏幕
    EndTouchState,    //触摸结束
} TouchTypeState;

@interface BloodPressureTestVC (){
    
    UIView                       *_photoView;                //摄像头视图
    PhotoVedioFrameCapture       *_photoVedioFrameCapture;   //摄像头会话
    UILabel                      *_topLabel;
    UIImageView                  *_topImgView;
    BloodPressureCollectionView  *_lowPressureProgressView;  //低压view
    BloodPressureCollectionView  *_highPressureProgressView; //高压view
    NSInteger               _testSeconds;
    NSTimer                 *_testTimer;
    
    NSInteger                   _finalLowPressure;
    NSInteger                   _finalHighPressure;
}

//手动输入视图
@property (weak, nonatomic  ) IBOutlet BloodPressureInputView  *bloodPressureInputView;
//绘图view
@property (strong, nonatomic) GraphView                        *graphView;

//按住手指imgView
@property (strong, nonatomic) UIImageView                      *fingerPressImgView;

//触摸类型状态
@property (assign, nonatomic) TouchTypeState                    touchTypeState;

@end

@implementation BloodPressureTestVC

#pragma mark ------------- life cycle -------------
- (void)viewDidLoad {
    //调用super viewDidLoad之前先初始化自己的一些属性，，因为这些属性在父类的一些初始化中需要用到
    [self _initAtributesBefoCallSuperViewDidLoad];
    
    [super viewDidLoad];
    
    [self _init];
    
    //初始化左边视图内容
    [self _initLeftViewContent];
    
    //初始化右边输入视图
    [self _initBloodPressureMainInputView];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self _closePhotoAndTimerSession];
}

#pragma mark ------------- private Method -------------
-(void)_init{
    _finalLowPressure = 0;
    _finalHighPressure = 0;
    self.view.backgroundColor = [UIColor blueColor];
    //    self.firstContentView.backgroundColor = [UIColor redColor];
    //    self.secondContentView.backgroundColor = [UIColor yellowColor];
    //触摸状态初始化
    self.touchTypeState = NeverTouchState;
}

#pragma mark ----------------------- 定时器部分 -----------------------
-(void)_beginPhotoAndTimerSession{
    //初始化，测试计数器
    [self _initTestCountAndTimer];
    //开始摄像头会话
    [self _beginPhotoSession];
}

- (void)_closePhotoAndTimerSession {
    [self _closeTimer];
#if TARGET_IPHONE_SIMULATOR
#else
    [_photoVedioFrameCapture stopAVCapture];
#endif

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
    if (_testSeconds == MAX_PHYSCIALE_CHECK_TIME_OUT) {//到了最大测试秒，
        if (self.touchTypeState != EndTouchState) {
            WSJBloodPressureViewController *bloodPrssureVc = [[WSJBloodPressureViewController alloc] init];
            bloodPrssureVc.lowPressure = _finalLowPressure;
            bloodPrssureVc.highPressure = _finalHighPressure;
            [self.navigationController pushViewController:bloodPrssureVc animated:YES];
        }
    }
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
    self.navTitle = @"血压测试";
    self.tabbarTitles = @[@"手机测试",@"手动输入"];
}


#pragma mark - 左边视图内容
- (void)_initLeftViewContent {
    
    //顶部视图
    [self _loadTopView];
    
    //摄像头视图
    [self _loadPhotoView];
    
    //下面波浪视图
    [self _loadWaveDrawView];
    
    //手指视图
    [self _loadFingerView];
    
    
#if TARGET_IPHONE_SIMULATOR
    
#else
    _photoVedioFrameCapture =  [[PhotoVedioFrameCapture alloc] initWithPhotoView:_photoView];
#endif
}

#pragma mark - 开始摄像头会话
-(void)_beginPhotoSession{
    
#if TARGET_IPHONE_SIMULATOR
    
#else
    //开始血压测量
    Physical *physical = new Physical();
    BloodPressureListener *bloodListner = new BloodPressureListener();
    physical->startBloodPressure(bloodListner);
    [_photoVedioFrameCapture setupAVCaptureWithFrameRvlue:^(float r_value) {
        //绘画
        [_graphView setPoint:r_value];
        JGLog(@"point:%f",r_value);
        //传入当前时间，毫秒,和r值
        UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
        physical->update(r_value, recordTime);
        
        //更新血压UI数据
        [self updateBloodPressureDataOnUI:bloodListner];
        
    } withError:^(NSError *error) {
        [Util ShowAlertWithOnlyMessage:error.localizedDescription];
    }];
#endif
}


#pragma mark - 更新血压UI数据
-(void)updateBloodPressureDataOnUI:(BloodPressureListener *)bloodListner{
    
    //心跳
    int heartPialPal = bloodListner->heartePalpitae;
    
    //当前最低血压，最高血压
    int currentLowPressure = bloodListner->currentLowPressure;
    int currentHightPreesure = bloodListner->currentHightPressure;
    
    _finalLowPressure = currentLowPressure;
    _finalHighPressure = currentHightPreesure;
    
    //最终最低血压，最高血压
    int finalLowPressure = bloodListner->finalLowPressure;
    int finalHightPressure = bloodListner->finalHightPressure;
    
    
    if (bloodListner->isError == true) {//未充分覆盖
        if (self.touchTypeState != NeverTouchState && self.touchTypeState != EndTouchState) {
            self.touchTypeState = NeverTouchState;
        }
        
    }else{//充分覆盖了
        if (self.touchTypeState == NeverTouchState) {
            self.touchTypeState = TouchingState;
        }
        
        _lowPressureProgressView.bloodPrssureValueLabel.text = [NSString stringWithFormat:@"%d",currentLowPressure];
        _highPressureProgressView.bloodPrssureValueLabel.text = [NSString stringWithFormat:@"%d",currentHightPreesure];
        [_highPressureProgressView.rmBloodTestProgressView updateWithTotalBytes:100 downloadedBytes:heartPialPal%100];
        [_lowPressureProgressView.rmBloodTestProgressView updateWithTotalBytes:100 downloadedBytes:heartPialPal%100];
    }
    
    if (finalHightPressure || finalLowPressure) {
        if (self.touchTypeState == EndTouchState) {//防止重复调用这里
            return;
        }
        //最终测量高压和低压
        self.touchTypeState = EndTouchState;
#if TARGET_IPHONE_SIMULATOR
        
#else
        [_photoVedioFrameCapture stopAVCapture];
        
#endif
        //血压测试完毕
        WSJBloodPressureViewController *bloodPrssureVc = [[WSJBloodPressureViewController alloc] init];
        bloodPrssureVc.lowPressure = finalLowPressure;
        bloodPrssureVc.highPressure = finalHightPressure;
        [self.navigationController pushViewController:bloodPrssureVc animated:YES];
    }
}



#pragma mark - 波浪视图
-(void)_loadWaveDrawView{
    
    _graphView = [[GraphView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_photoView.frame), self.view.frame.size.width, self.firstContentView.height-200)];
    [_graphView setBackgroundColor:[UIColor whiteColor]];
    [_graphView setSpacing:10];
    [_graphView setStrokeColor:[UIColor redColor]];
    [_graphView setFill:NO];
    [_graphView setLineWidth:2];
    [_graphView setCurvedLines:YES];
    [self.firstContentView addSubview:_graphView];
}

-(void)_loadTopView{
    
    UIView *topView = BoundNibView(@"TopView", UIView);
    [self.firstContentView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.firstContentView);
        make.height.mas_equalTo(@31);
    }];
    
    _topLabel = (UILabel *)[topView viewWithTag:1];
    _topImgView = (UIImageView *)[topView viewWithTag:2];
    
}

#pragma mark - 摄像头视图
- (void)_loadPhotoView {
    
    _photoView = [[UIView alloc] initWithFrame:CGRectMake(0, kTopViewHeight, kScreenWidth,200)];
    _photoView.backgroundColor = [UIColor blackColor];
    [self.firstContentView addSubview:_photoView];
    
    //添加中心参照view
    UIView *middelReferenceView = [UIView new];
    [_photoView addSubview:middelReferenceView];
    [middelReferenceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(_photoView);
        make.width.mas_equalTo(@1);
        make.centerX.mas_equalTo(_photoView);
        
    }];
    
    //高压view
    _highPressureProgressView = BoundNibView(@"BloodPressureCollectionView", BloodPressureCollectionView);
    [_photoView addSubview:_highPressureProgressView];
    [_highPressureProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.right.mas_equalTo(middelReferenceView.mas_left).with.offset(-5);
        make.centerY.mas_equalTo(_photoView);
    }];
    
    //低压view
    _lowPressureProgressView = BoundNibView(@"BloodPressureCollectionView", BloodPressureCollectionView);
    _lowPressureProgressView.pressureLabel.text = @"低压(mmhg)";
    [_photoView addSubview:_lowPressureProgressView];
    [_lowPressureProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.left.mas_equalTo(middelReferenceView.mas_right).with.offset(5);
        make.centerY.mas_equalTo(_photoView);
    }];
    
    
}


-(void)_loadFingerView{
    
    //手指按住imgView
    _fingerPressImgView = [UIImageView new];
    _fingerPressImgView.backgroundColor = [UIColor clearColor];
    [self.firstContentView addSubview:_fingerPressImgView];
    _fingerPressImgView.image = [UIImage imageNamed:@"iconfont-xiaolvdashiicon02 (1)_看图王"];
    [_fingerPressImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60/0.83));
        //        make.center.mas_equalTo(self.firstContentView);
        make.centerY.mas_equalTo(_photoView.mas_bottom).with.offset(72/2-10);
        make.centerX.mas_equalTo(self.firstContentView);
    }];
    
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //    NSLog(@"finger begin ");
    [self moveWithTouchs:touches];
    
    //开始摄像头会话
    //    [self _beginPhotoSession];
    [self _beginPhotoAndTimerSession];
    self.touchTypeState = TouchingState;
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //    NSLog(@"finger move ");
    [self moveWithTouchs:touches];
    if (self.touchTypeState == EndTouchState) {//触摸过程中若是其他状态则返回
        return;
    }
    
    if (self.touchTypeState != TouchingState) {
        self.touchTypeState = TouchingState;
    }
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self moveWithTouchs:touches];
    
    //关闭摄像头会话
    //    [_photoVedioFrameCapture stopAVCapture];
    [self _closePhotoAndTimerSession];
    
    self.touchTypeState = EndTouchState;
    
}

#pragma mark - 正在触摸 配置，
-(void)_isTouchingConfigure{
    
    _topLabel.text = @"正在采集血压数据..";
    _topImgView.hidden = YES;
    _photoView.backgroundColor = [UIColor clearColor];
    
}
#pragma mark - 结束触摸 配置，
-(void)_endTouchConfigure{
    
    _topLabel.text = @"未采集到稳定血压，请按住屏幕开始测量";
    _topImgView.hidden = YES;
    _photoView.backgroundColor = [UIColor redColor];
    
}
#pragma mark - 触摸面积不足配置，
-(void)_touchAreaNotEnoughConfigure{
    
    _topLabel.text = @"你手指未充分覆盖摄像头，请覆盖摄像头";
    _topImgView.hidden = NO;
    
}

-(void)moveWithTouchs:(NSSet *)touches{
    
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.firstContentView];
    _fingerPressImgView.center = touchPoint;
    
}

- (void)_initBloodPressureMainInputView {
    
    _bloodPressureInputView = BoundNibView(@"BloodPressureInputView", BloodPressureInputView);
    [self.secondContentView addSubview:_bloodPressureInputView];
    _bloodPressureInputView.bloodPressureInputResultBlock = ^(NSInteger lowPressure, NSInteger highPressure){
        //进入测试结果页
        WSJBloodPressureViewController *bloodPressureResultVC = [[WSJBloodPressureViewController alloc] init];
        bloodPressureResultVC.lowPressure = lowPressure;
        bloodPressureResultVC.highPressure = highPressure;
        [self.navigationController pushViewController:bloodPressureResultVC animated:YES];
    };
    //    WEAK_SELF
    [_bloodPressureInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.secondContentView);
    }];
    
}


#pragma mark - segement delegate
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    
    if (segmentedControl.selectedSegmentIndex == 0) {
        if (!self.firstContentView.hidden) {//重复点第一个
            return;
        }else{
            self.firstContentView.hidden = NO;
            self.secondContentView.hidden = YES;
            //重置touch状态
            //            self.touchTypeState = EndTouchState;
            
        }
        
    }else if (segmentedControl.selectedSegmentIndex == 1){
        if (!self.secondContentView.hidden) {//重复点第二个
            return;
        }else{
            self.firstContentView.hidden = YES;
            //关闭视频会话
            //            [_photoVedioFrameCapture stopAVCapture];
            [self _closePhotoAndTimerSession];
            self.secondContentView.hidden = NO;
            
        }
        
    }
    
}


#pragma mark - setter Method
-(void)setTouchTypeState:(TouchTypeState)touchTypeState{
    
    switch (touchTypeState) {
        case TouchingState:
            //正在采集数据UI配置
            [self _isTouchingConfigure];
            break;
        case EndTouchState:
            //结束采集数据UI配置
            [self _endTouchConfigure];
            break;
        case NeverTouchState:
            //接触面积不够配置
            [self _touchAreaNotEnoughConfigure];
            break;
        default:
            break;
    }
    
    _touchTypeState = touchTypeState;
}



@end
