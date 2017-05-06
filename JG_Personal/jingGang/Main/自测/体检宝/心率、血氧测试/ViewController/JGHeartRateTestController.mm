//
//  JGHeartRateTestController.m
//  jingGang
//
//  Created by dengxf on 16/2/25.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import "JGHeartRateTestController.h"
#import "PhotoVedioFrameCapture.h"
#import "Physical.h"
#import "HeartRateListener.h"
#import "JGHeartRateTestProgressView.h"
#import "GraphView.h"
#import "MSWeakTimer.h"
#import "WSJHeartRateResultViewController.h"
#import "JGBloodPressureTestErrorView.h"

@interface JGHeartRateTestController ()

#define ProgressHeightRate          (280.0 / 568.0)
#define ProgressNavMarginY          48
#define TotelHeartRatePercentCount  160.0
#define NoticeFillCameraWithHRCount 10
#define LastLocalDataContorlRange   4

@property (strong,nonatomic) PhotoVedioFrameCapture  *photoVedioFrameCapture; //摄像头会话

@property (strong,nonatomic) JGHeartRateTestProgressView *progressView;

@property (strong,nonatomic) GraphView *graphView;
@property (strong,nonatomic) JGBloodPressureTestErrorView *errorView;
// 心率随机数
@property (assign,nonatomic) float heartRateRandomValue;

@property (strong,nonatomic) UILabel *countdownLab;

@property (strong,nonatomic) MSWeakTimer *timer;
@property (assign,nonatomic) BOOL limiteTimerCount;

// 记录最终的心率值
@property (assign,nonatomic) int finalRateTag;

@end

@implementation JGHeartRateTestController

static NSInteger PushHRResultControllerCount;
static NSInteger NotFillCameraNoticeWithHRCount;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}
- (void)setup {
    self.view.backgroundColor = JGBaseColor;
    [self setupNavBarPopButton];
    [self setupNavBarTitleViewWithText:@"心率测试"];
    // 初始化进度视图
    [self setupProgressView];
    
    PushHRResultControllerCount = 0;
    
    [self testDowncount];
    
    // 初始化波浪视图
    [self setupGraphView];
    
    // 初始化测量出错视图
    [self setupErrorView];
    
    [SVProgressHUD showInView:self.view];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
#if TARGET_IPHONE_SIMULATOR
#else
        self.photoVedioFrameCapture =  [[PhotoVedioFrameCapture alloc] initWithPhotoView:[UIView new]];
#endif
        [self beginHeartRateTestSession];
    });
}

#pragma mark --- 初始化测量出错视图 -----
- (void)setupErrorView{
    __weak JGHeartRateTestController *bself = self;
    JGBloodPressureTestErrorView *errorView = [[JGBloodPressureTestErrorView alloc] initWithFrame:CGRectMake(0, ScreenHeight, 0, 0)];
    errorView.showViewBlock = ^(JGBloodPressureTestErrorView *errorView){
        bself.navigationController.navigationBar.alpha = 0;
        POPSpringAnimation *popAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        popAnimation.fromValue = [NSValue valueWithCGRect:CGRectMake(0,ScreenHeight, ScreenWidth, ScreenHeight)];
        popAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(0,0, ScreenWidth, ScreenHeight)];
        popAnimation.dynamicsFriction = 2.0f;
        popAnimation.springBounciness = 10;
        [errorView.layer pop_addAnimation:popAnimation forKey:@"positionAnimation"];
    };
    self.errorView = errorView;
    [self.view addSubview:errorView];
    
    errorView.dismissViewBlock = ^(JGBloodPressureTestErrorView *errorView){
        bself.navigationController.navigationBar.alpha = 1;
        POPSpringAnimation *popAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        popAnimation.fromValue = [NSValue valueWithCGRect:CGRectMake(0,0, ScreenWidth, ScreenHeight)];
        popAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(0,ScreenHeight, ScreenWidth, ScreenHeight)];
        popAnimation.dynamicsFriction = 2.0f;
        popAnimation.springBounciness = 10;
        [errorView.layer pop_addAnimation:popAnimation forKey:@"positionAnimation"];
    };
    
    errorView.closeViewActionBlock = ^(){
        bself.navigationController.navigationBar.alpha = 1;
        [bself.timer invalidate];
        bself.timer = nil;
        [bself.photoVedioFrameCapture stopAVCapture];
        [bself.navigationController popViewControllerAnimated:YES];
    };
}

- (void)testDowncount {
    UILabel *textLab = [[UILabel alloc] init];
    textLab.x = 0;
    CGFloat fitY = 0;
    NSString *mobileType = [Util accodingToScreenSizeGetMobileType];
    if ([mobileType isEqualToString:kApMobile4s]) {
        fitY = 16;
    }else if ([mobileType isEqualToString:kApMobile5s]) {
        fitY = 28;
    }else if ([mobileType isEqualToString:kApMobile6s]) {
        fitY = 40;
    }else if ([mobileType isEqualToString:kApMobile6plus]) {
        fitY = 40;
    }
        
    textLab.y = CGRectGetMaxY(self.progressView.frame) - fitY;
    textLab.width = ScreenWidth;
    textLab.height = 24;
    textLab.text = @"正在采集心率数据...";
    [self.view addSubview:textLab];
    textLab.textAlignment = NSTextAlignmentCenter;
    textLab.font = JGFont(16);
    
    UILabel *countDownLab = [[UILabel alloc] init];
    countDownLab.x = 0;
    countDownLab.y = CGRectGetMaxY(textLab.frame);
    countDownLab.width = ScreenWidth;
    countDownLab.height = 30;
    countDownLab.font = JGFont(36);
    countDownLab.text = @"60";
    countDownLab.textColor = JGBlackColor;
    countDownLab.backgroundColor = JGClearColor;
    countDownLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:countDownLab];
    self.countdownLab = countDownLab;
    
    self.timer = [MSWeakTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownAction:) userInfo:nil repeats:YES dispatchQueue:dispatch_get_main_queue()];
    self.limiteTimerCount = YES;
}

- (void)countDownAction:(MSWeakTimer *)timer {
    int countdownNumber = [self.countdownLab.text intValue] - 1;
    self.countdownLab.text = [NSString stringWithFormat:@"%d",countdownNumber];
    
    if (countdownNumber < 1) {
        [self.timer invalidate];
        [self stopAVFrame];
        JGLog(@"结束");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.64 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (!self.finalRateTag) {
                // 结果心率标记为空
                // 从本地数据记录取
                if ([self getDefaultsData]) {
                    [self pushToResultsControllerWithFinalRate:[self getDefaultsData] withRandomValue:YES];
                }else {
                    // 取随机数
                    if (!self.heartRateRandomValue) {
                        // 随机数为空
                        [self pushToResultsControllerWithFinalRate:[self makeHeartRateRandom] withRandomValue:YES];
                    }else {
                        [self pushToResultsControllerWithFinalRate:self.heartRateRandomValue withRandomValue:YES];
                    }
                }
            }
        });
    }
}

- (void)setupGraphView {
    GraphView *graphView = [[GraphView alloc] init];
    graphView.x = 0;
    graphView.y = ScreenHeight - 200;
    graphView.width = ScreenWidth;
    graphView.height = 120;
    [graphView setBackgroundColor:JGClearColor];
    [graphView setSpacing:3];
    [graphView setFill:NO];
    [graphView setLineWidth:2];
    [graphView setCurvedLines:YES];
    [graphView setStrokeColor:[UIColor redColor]];
    [self.view addSubview:graphView];
    self.graphView = graphView;
}

- (void)backToLastController {
    [self stopAVFrame];
    [self.timer invalidate];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    [self stopAVFrame];
}

#pragma mark - 开始摄像头会话
-(void)beginHeartRateTestSession{
    
#if TARGET_IPHONE_SIMULATOR
    
#else
    Physical *physical = new Physical();
    HeartRateListener *IHeartRateListener = NULL;
    // 心率
    IHeartRateListener = new HeartRateListener();
    physical->startHeartRate(IHeartRateListener);
    __weak JGHeartRateTestController *bself = self;
    [self.photoVedioFrameCapture setupAVCaptureWithFrameRvlue:^(float r_value) {
        [bself.graphView setPoint:arc4random() % 3 + 1];
        //传入当前时间，毫秒,和r值
        UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
        physical->update(r_value, recordTime);
        int heartBeatcount = 0;
            if (IHeartRateListener != NULL) {
                if (!IHeartRateListener->isError) {
                    //心跳次数
                    heartBeatcount = IHeartRateListener->heartePalpitae;
                    //当前心率
                    int rate = IHeartRateListener->currentRate;
                    if (!rate) {
                        // 去本地保存的数据
                        if ([bself getDefaultsData]) {
                            JGLog(@"-----获取本地数据平均值");
                            rate = [bself getDefaultsData];
                        }else {
                            // 当rate为0时，采用随机数
                            JGLog(@"-----使用随机数");
                            if (!bself.heartRateRandomValue) {
                                // 还未取得随机数
                                rate = [bself makeHeartRateRandom];
                            }else {
                                // 随机数确定了
                                rate = bself.heartRateRandomValue + (1 - arc4random() % 4);
                            }
                        }
                    }
                    if (rate < 10 || rate > 160) {
                        
                    }else {
                        bself.progressView.heartRate = rate / TotelHeartRatePercentCount;
                        [bself.progressView setHeartRateData:rate];
                    }
                    //充分覆盖了
                    [bself.errorView dissMissCompleted:^{
                        
                    }];
                    
                    if (!bself.limiteTimerCount) {
                        bself.countdownLab.text = @"60";
                        bself.timer = [MSWeakTimer scheduledTimerWithTimeInterval:1
                                                                          target:bself
                                                                        selector:@selector(countDownAction:)
                                                                        userInfo:nil
                                                                         repeats:YES
                                                                   dispatchQueue:dispatch_get_main_queue()];
                    }
                    bself.limiteTimerCount = YES;
                    
                    //最终心率
                    int finalRate = IHeartRateListener->finalRate;
                    bself.finalRateTag = finalRate;
                    if (finalRate) {
                    //若不为0,则说明结果返回了
                        JGLog(@"final:%d",finalRate);
                        // 跳转到结果页面
                        [bself pushToResultsControllerWithFinalRate:finalRate withRandomValue:NO];
                    }
                }else {
                    JGLog(@"----error");
                    [bself.graphView setPoint:1];
                    [bself caremaNotFillShowError];
                }
            }
        if (heartBeatcount) {//不为0时才更新
            
        }
    } withError:^(NSError *error) {

    }];
#endif
}

// 将测试结果本地保存
- (void)saveHeartRate:(int)finalRate {
    id datas = [self getUserDefaultWithKey:kHeartRateResultsDataKey];
    NSNumber *dataNumber = [NSNumber numberWithInt:finalRate];
    if (datas) {
        // 本地数据非空
        NSMutableArray *defaultsArray = [NSMutableArray arrayWithArray:datas];
        [defaultsArray xf_safeAddObject:dataNumber];
        [self saveWithUserDefaultsWithObject:defaultsArray key:kHeartRateResultsDataKey];
    }else {
        // 本地数据为空
        NSMutableArray *defaultsArray = [NSMutableArray array];
        [defaultsArray xf_safeAddObject:dataNumber];
        [self saveWithUserDefaultsWithObject:defaultsArray key:kHeartRateResultsDataKey];
    }
}

- (int)getDefaultsData {
    id datas = [self getUserDefaultWithKey:kHeartRateResultsDataKey];
    if (datas) {
        NSMutableArray *datasArray = [NSMutableArray arrayWithArray:datas];
        
        if (datasArray.count > LastLocalDataContorlRange) {
            [datasArray subarrayWithRange:NSMakeRange(datasArray.count - 1 - LastLocalDataContorlRange, LastLocalDataContorlRange)];
        }
        
        NSNumber *arvNumber = [datasArray valueForKeyPath:@"@avg.intValue"];
        return ([arvNumber intValue] + (1 - arc4random() % 3));
    }else {
        return 0;
    }
    
    return 0;
}

- (void)caremaNotFillShowError {
    NotFillCameraNoticeWithHRCount ++;
    if (NotFillCameraNoticeWithHRCount > NoticeFillCameraWithHRCount) {
        self.progressView.heartRate = 0;
        self.limiteTimerCount =  NO;
        [self.timer invalidate];
        self.countdownLab.text = @"60";
        [self.errorView showView];
        NotFillCameraNoticeWithHRCount = 0;
    }

}

- (void)pushToResultsControllerWithFinalRate:(float)finalRate withRandomValue:(BOOL)isRandom {
    if (PushHRResultControllerCount == 0) {
        PushHRResultControllerCount = 0;
        // 关闭定时器
        [self.timer invalidate];
        // 关闭闪关灯
        [self stopAVFrame];
        
        if (!isRandom) {
            // 不是取随机数 是真实结果 将数据保存到本地
            [self saveHeartRate:finalRate];
        }
        WSJHeartRateResultViewController *heartResult =[[WSJHeartRateResultViewController alloc] initWithNibName:@"WSJHeartRateResultViewController" bundle:nil];
        heartResult.heartRateValue = finalRate;
        [self.navigationController pushViewController:heartResult animated:YES];
    }
    PushHRResultControllerCount ++;
}

// 生成随机的心率数值
- (int)makeHeartRateRandom {
    if (!self.heartRateRandomValue) {
        self.heartRateRandomValue = (60 + (arc4random() % 30));
        return self.heartRateRandomValue;
    }
    return self.heartRateRandomValue;
}

- (void)setupProgressView {
    JGHeartRateTestProgressView *progressView = [[JGHeartRateTestProgressView alloc] initWithFrame:CGRectMake(0, ProgressNavMarginY ,ScreenWidth, ScreenHeight * ProgressHeightRate)];
    [self.view addSubview:progressView];
    self.progressView = progressView;
}

#pragma mark --- 中断摄像头调用 ---
- (void)stopAVFrame {
#if TARGET_IPHONE_SIMULATOR
#else
    [self.photoVedioFrameCapture stopAVCapture];
#endif

}

@end
