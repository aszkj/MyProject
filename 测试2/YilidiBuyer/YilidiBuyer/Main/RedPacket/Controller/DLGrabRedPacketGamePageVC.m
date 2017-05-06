//
//  ViewController.m
//  Snow
//
//  Created by 周 俊杰 on 13-9-16.
//  Copyright (c) 2013年 周 俊杰. All rights reserved.
//

#define RedPacketStartPositionY -IMAGE_Height
#define RedPacketEndPositionY kScreenHeight-230

#import "DLGrabRedPacketGamePageVC.h"
#import "RedPacketImageView.h"
#import "RedPacketRainNeedRadomInfo.h"
#import "UIView+Boom.h"
#import "RedPacketAnimateRelatedModel.h"
#import "DLGrabRedPacketResultPageVC.h"
#import "GiFHUD.h"
#import "RedPacketSoundPlayer.h"
#import "DLCouponModel.h"
#import "RedPacketGameManager.h"


@interface DLGrabRedPacketGamePageVC (){
    NSMutableArray *_redPacketExcuteAnimateImgViewArray;
}

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) NSTimer  *redPacketAnimateTimer;
@property (nonatomic, strong) NSTimer  *gameCountDownTimer;
@property (nonatomic, strong) NSTimer  *rotateLeftTimeViewTimer;

//红包个数
@property (nonatomic,assign) NSInteger gotRedPacketCount;
@property (weak, nonatomic) IBOutlet UILabel *grabedRedPacketCountLabel;

//底部钱罐imgView
@property (weak, nonatomic) IBOutlet UIImageView *bottomMoneyPacketImgView;

//距离游戏结束倒计时
@property (weak, nonatomic) IBOutlet UIImageView *leftTimeBgImgView;
@property (weak, nonatomic) IBOutlet UILabel *leftTimeLabel;
@property (nonatomic,assign) NSInteger gameEndLeftTimeCount;

//将要开始倒计时
@property (weak, nonatomic) IBOutlet UILabel *gameFromBeginLeftTimeCountLabel;
@property (nonatomic,assign) NSInteger gameFromBeginLeftTimeCount;
@property (weak, nonatomic) IBOutlet UIImageView *fromBeginTimeQuanOutSideImgView;
@property (weak, nonatomic) IBOutlet UIImageView *fromBeginTimeQuanInSideImgView;

@property (nonatomic,strong) NSMutableArray * redPacketOriginalImgViewArray;
@property (nonatomic,strong) NSMutableArray * areExcutingAnimateRedPacketImgViewArray;

@property (nonatomic,strong) RedPacketRainNeedRadomInfo * redPacketRainNeedRadomInfo;
//点击执行动画的imgView
@property (nonatomic,strong) UIImageView *gotRedPacketAnimationImgView;
//执行爆炸动画的imgView
@property (nonatomic,strong) UIImageView *excuteBombAnimateImgView;

@property (nonatomic,assign) BOOL gameHasBegan;

@property (weak, nonatomic) IBOutlet UIImageView *gameHasEndBgImgView;

@property (nonatomic,strong) RedPacketSoundPlayer *redPacketSoundPlayer;

@property (nonatomic,strong) NSMutableArray *grabRedPacketGotCouponList;

@property (nonatomic,strong) RedPacketGameManager *redPacketGameManager;

@property (nonatomic,assign) long enterGameTime;

@end

@implementation DLGrabRedPacketGamePageVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self _init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appEnterForeGround:)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark ------------------------Init---------------------------------
- (void)_init {
    self.pageTitle = @"抢红包";
    [self _initWhetherHaveTheGame];
}

- (void)_initWhetherHaveTheGame {
    if (self.hasRedPacketGame) {
        self.gameHasEndBgImgView.hidden = YES;
        [self _initGameInfo];
    }else {
        self.gameHasEndBgImgView.hidden = NO;
    }
}

- (void)_initGameInfo {
    [self _initGameCountDownInfo];
    [self _startGameCountDonwTimer];
    [self _initRedPacketSoundPlayer];
    [self _startLeftTimeViewTimer];
    [self _gameLeftTimeViewShow:NO];
    [self _fromGameBeginLeftTimeViewShow:YES];
    [self.redPacketGameManager resetGrabRedPacketGameFlowStatus];
}

- (void)_initGameCountDownInfo {
    self.gameFromBeginLeftTimeCount = 5;
    self.gameEndLeftTimeCount = self.grabRedPacketGameInfoModel.maxTimePerTimes;
    self.gameHasBegan = NO;
    self.gotRedPacketCount = 0;
}


- (void)_initGrabRedPacketInfo {
    if (_grabRedPacketGotCouponList && _grabRedPacketGotCouponList.count) {
        [_grabRedPacketGotCouponList removeAllObjects];
    }
    self.redPacketOriginalImgViewArray=[[NSMutableArray alloc]init];
    self.areExcutingAnimateRedPacketImgViewArray = [[NSMutableArray alloc] init];
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
    [self.view addGestureRecognizer:self.tapGesture];
    self.redPacketRainNeedRadomInfo = [[RedPacketRainNeedRadomInfo alloc] init];
}

- (void)_initRedPacketImgView {
    _redPacketExcuteAnimateImgViewArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; ++ i) {
        @autoreleasepool {
            RedPacketImageView *imageView = [[RedPacketImageView alloc] initWithImage:IMAGE(@"hb")];
            imageView.frame = CGRectMake(0, RedPacketStartPositionY, IMAGE_WIDTH, IMAGE_Height);
            RedPacketAnimateRelatedModel *redPacketAnimateRelatedModel = [[RedPacketAnimateRelatedModel alloc] init];
            imageView.redPacketAnimateRelatedModel = redPacketAnimateRelatedModel;
            imageView.redPacketAnimateRelatedModel.redPacketAnimateTotalDistance = RedPacketEndPositionY - RedPacketStartPositionY;
            [self.view addSubview:imageView];
            [_redPacketOriginalImgViewArray addObject:imageView];
            [_redPacketExcuteAnimateImgViewArray addObject:imageView];
        }
    }
    [self.view bringSubviewToFront:self.bottomMoneyPacketImgView];
}

#pragma mark ------------------------Private-------------------------
#pragma mark --start timer
- (void)_startGameCountDonwTimer {
    self.gameCountDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(gameCountDown) userInfo:nil repeats:YES];
}

- (void)_startRedPacketAnimateTimer {
    self.redPacketAnimateTimer=[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(makeRedPacketRain) userInfo:nil repeats:YES];
}

- (void)_startLeftTimeViewTimer {
    self.rotateLeftTimeViewTimer = [NSTimer scheduledTimerWithTimeInterval:0.08 target:self selector:@selector(rotateLeftTimeView) userInfo:nil repeats:YES];
}

- (void)_initRedPacketSoundPlayer {
    _redPacketSoundPlayer = [[RedPacketSoundPlayer alloc] init];
}

#pragma mark --configure view
- (void)_gameLeftTimeViewShow:(BOOL)show {
    self.leftTimeLabel.hidden = !show;
    self.leftTimeBgImgView.hidden = !show;
}

- (void)_fromGameBeginLeftTimeViewShow:(BOOL)show {
    self.fromBeginTimeQuanOutSideImgView.hidden = !show;
    self.fromBeginTimeQuanInSideImgView.hidden = !show;
    self.gameFromBeginLeftTimeCountLabel.hidden = !show;
}


- (void)_configureFromGameBeginLeftTimeView {
    self.gameFromBeginLeftTimeCountLabel.text = jFormat(@"%ld",self.gameFromBeginLeftTimeCount);
}

- (void)_configureGameLeftTimeView {
    self.leftTimeLabel.text = jFormat(@"还剩%ld秒",self.gameEndLeftTimeCount);
}

#pragma mark - RedPacketGameWillBeginSound
- (void)_playRedPacketGameWillBeginSound {
    if (self.gameFromBeginLeftTimeCount == 1) {
        [self.redPacketSoundPlayer playRedPacketGameWillBeginLastSound];
    }else {
        [self.redPacketSoundPlayer playRedPacketGameWillBeginSound];
    }
}


#pragma mark --configure timer
- (void)_closeRotateLeftTimeViewTimer {
    [self.rotateLeftTimeViewTimer invalidate];
    self.rotateLeftTimeViewTimer = nil;
}

- (void)_clearSoundPlayer {
    [self.redPacketSoundPlayer clearAllSoundPlayer];
}

- (void)_closegameCountDownAndredPacketAnimateTimer {
    [self.gameCountDownTimer invalidate];
    [self.redPacketAnimateTimer invalidate];
    self.gameCountDownTimer = nil;
    self.redPacketAnimateTimer = nil;
}

#pragma mark --configure game start/end
- (void)_startRedPacketGameConfigure {
    [self _gameLeftTimeViewShow:YES];
    [self _fromGameBeginLeftTimeViewShow:NO];
    [self _closeRotateLeftTimeViewTimer];
    
    [self _initGrabRedPacketInfo];
    [self _initRedPacketImgView];
    [self _startRedPacketAnimateTimer];
    [self.redPacketGameManager markHasBeganGrabedRedPacket];
    [self.redPacketSoundPlayer playRedPacketGamePlayingSound];
    self.gameHasBegan = YES;
    self.enterGameTime = (long)[self currentTimeInterval];
}

- (void)_endRedPacketGameConfigure {
    [self _closegameCountDownAndredPacketAnimateTimer];
    [self _clearSoundPlayer];
    [self.redPacketGameManager markRedPacketGameNormalEnded];
    [self performSelector:@selector(_enterGrabRedPacketResultPage) withObject:nil afterDelay:1];
}

#pragma mark --deal grabRedPacket Got Coupons
- (void)_dealGrabRedPacketGotCoupons:(NSArray *)coupons {
    
    for (NSDictionary *coupDic in coupons) {
        NSInteger coupCount = [coupDic[@"ticketCount"] integerValue];
        if (coupCount) {
            for (NSInteger i=0; i<coupCount; i++) {
                DLCouponModel *couponModel = [[DLCouponModel alloc] initWithDefaultDataDic:coupDic];
                couponModel.ticketCount = 1;
                [self.grabRedPacketGotCouponList addObject:couponModel];
            }
        }
    }
}


#pragma mark --timer reponse
- (void)gameCountDown{
    
    if (self.gameFromBeginLeftTimeCount > 0) {
        [self _playRedPacketGameWillBeginSound];
        self.gameFromBeginLeftTimeCount --;
    }else {
        if (!self.gameHasBegan) {
            [self _startRedPacketGameConfigure];
        }
        self.gameEndLeftTimeCount --;
        if (!self.gameEndLeftTimeCount) {//游戏结束
            [self _endRedPacketGameConfigure];
        }
    }
    
}

static int leftTimeViewRotateNumberCount = 1;
- (void)rotateLeftTimeView {
    CGFloat agle = leftTimeViewRotateNumberCount * (M_PI/18);
    //旋转圈子
    self.fromBeginTimeQuanOutSideImgView.transform = CGAffineTransformMakeRotation(agle);
    leftTimeViewRotateNumberCount ++;
}


static int i = 0;
- (void)makeRedPacketRain
{
    i = i + 1;
    NSInteger pertimeRadomProducedRedPacketNumber = [self.redPacketRainNeedRadomInfo getPertimeRadomProducedRedPacketNumber];
    if (!pertimeRadomProducedRedPacketNumber || pertimeRadomProducedRedPacketNumber > _redPacketExcuteAnimateImgViewArray.count) {
        return;
    }
    
    NSArray *pertimeRadomProducedRedPacketPositionNumbers = [self.redPacketRainNeedRadomInfo getPertimeRadomProducedRedPacketPositionNumbers];
    NSArray *pertimeFetchedFrontRedPacketImgViews = [_redPacketExcuteAnimateImgViewArray subarrayWithRange:NSMakeRange(0, pertimeRadomProducedRedPacketNumber)];
    NSInteger screenDivedRedPacketRoadCount = [self.redPacketRainNeedRadomInfo getScreenDivedRedPacketRoadCount];
    for (NSInteger fetchedRedPacketIndex=0; fetchedRedPacketIndex<pertimeRadomProducedRedPacketNumber; fetchedRedPacketIndex++) {
        RedPacketImageView *fectchedPerRedPacketImgView = pertimeFetchedFrontRedPacketImgViews[fetchedRedPacketIndex];
//        fectchedPerRedPacketImgView.transform = CGAffineTransformMakeRotation(M_2_PI);
        fectchedPerRedPacketImgView.hidden = NO;
        fectchedPerRedPacketImgView.alpha = 1.0f;
        NSInteger pertimeRadomProducedRedPacketPositionNumber = [pertimeRadomProducedRedPacketPositionNumbers[fetchedRedPacketIndex] integerValue];
        //初始x
        double redPacketPositionX = pertimeRadomProducedRedPacketPositionNumber * IMAGE_WIDTH;
        fectchedPerRedPacketImgView.frame = CGRectMake(redPacketPositionX, RedPacketStartPositionY, IMAGE_WIDTH, IMAGE_Height);
        fectchedPerRedPacketImgView.redPacketAnimateRelatedModel.redPacketAnimatePositionX = redPacketPositionX;
        //结束y
        double redPacketPositionEndY = (pertimeRadomProducedRedPacketPositionNumber > 0 && pertimeRadomProducedRedPacketPositionNumber < screenDivedRedPacketRoadCount-1) ? RedPacketEndPositionY : RedPacketEndPositionY+230;
        fectchedPerRedPacketImgView.redPacketAnimateRelatedModel.redPacketAnimateEndPositionY = redPacketPositionEndY;
        fectchedPerRedPacketImgView.redPacketAnimateRelatedModel.redPacketAnimatePostionNumber = pertimeRadomProducedRedPacketPositionNumber;
        fectchedPerRedPacketImgView.tag = i + fetchedRedPacketIndex + arc4random() % 10000;
        fectchedPerRedPacketImgView.redPacketAnimateRelatedModel.redPacketIdentifier = [NSString stringWithFormat:@"%ld",fectchedPerRedPacketImgView.tag];
    }
    
    for (RedPacketImageView *redPacketImgView in pertimeFetchedFrontRedPacketImgViews) {
        [self rainRedPacketImgViewl:redPacketImgView];
    }
    
    [_redPacketExcuteAnimateImgViewArray removeObjectsInArray:pertimeFetchedFrontRedPacketImgViews];
}

#pragma mark - NotGrabed RedPacket Animate Configure
- (void)notGrabedRedPacketAnimateConfigure {
    [self.redPacketSoundPlayer playClickNotGrabedRedPacketSound];
    self.gotRedPacketAnimationImgView.hidden = YES;
    [self _redPacketBombAnimateWithRedpacketImgView:self.gotRedPacketAnimationImgView];

}

#pragma mark - backConfigure
- (void)_backConfigure {
    [self _closeRotateLeftTimeViewTimer];
    [self _clearSoundPlayer];
    [self _closegameCountDownAndredPacketAnimateTimer];
}

#pragma mark - got redpacket configure
- (void)_gotRedPacketConfigure {
    self.gotRedPacketCount ++;
    [self.redPacketGameManager markHasGotRedPacket];
}

#pragma mark - RedPacket Rain Animation
- (void)rainRedPacketImgViewl:(RedPacketImageView *)animateRedPacketImageView
{
    [UIView beginAnimations:animateRedPacketImageView.redPacketAnimateRelatedModel.redPacketIdentifier context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    //    animateRedPacketImageView.redPacketAnimateRelatedModel.redPacketAnimateBeginTime = (double)[self currentTimeInterval];
    CGFloat animateDuration = (arc4random()%200)/100.0 + 1;
    animateRedPacketImageView.redPacketAnimateRelatedModel.redPacketAnimateDuration = animateDuration;
    //    animateRedPacketImageView.redPacketAnimateRelatedModel.redPacketAnimateEndTime = animateDuration + animateRedPacketImageView.redPacketAnimateRelatedModel.redPacketAnimateBeginTime;
    animateRedPacketImageView.redPacketAnimateRelatedModel.redPacketAnimateAverageSpeed = animateRedPacketImageView.redPacketAnimateRelatedModel.redPacketAnimateTotalDistance / animateDuration;
    [UIView setAnimationDuration:animateDuration];
    [UIView setAnimationDelegate:self];
    animateRedPacketImageView.frame = CGRectMake(animateRedPacketImageView.frame.origin.x, animateRedPacketImageView.redPacketAnimateRelatedModel.redPacketAnimateEndPositionY, animateRedPacketImageView.frame.size.width, animateRedPacketImageView.frame.size.height);
    [UIView commitAnimations];
    //    [_areExcutingAnimateRedPacketImgViewArray addObject:animateRedPacketImageView];
}
#pragma mark - RedPacket Click Animation
-(void)showGotRedPacketAnimationFromPostion:(CGPoint)clickPosition{
    NSMutableArray *groupAnimationArr = [NSMutableArray arrayWithCapacity:0];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    UIBezierPath *addShopAnimateBezier = [UIBezierPath bezierPath];
    CGPoint beginPoint = clickPosition;
    [addShopAnimateBezier moveToPoint:beginPoint];
    //结束x坐标，导航栏最右边购物车哪里
    CGFloat endX = kScreenWidth - 50;
    [addShopAnimateBezier addQuadCurveToPoint:CGPointMake(endX,40) controlPoint:CGPointMake((endX-beginPoint.x)/2+beginPoint.x,(beginPoint.y-40)/2+40)];
    animation.path = addShopAnimateBezier.CGPath;
    [groupAnimationArr addObject:animation];
    
//    CABasicAnimation *trainAnimation = [CABasicAnimation animationWithKeyPath:@"transform.y"];
//    trainAnimation.duration = 0.1;
//    trainAnimation.fromValue = @(beginPoint.y);
//    trainAnimation.toValue = @(beginPoint.y-50);
//    [groupAnimationArr addObject:trainAnimation];
    
    for (float i=0.0; i<=1.0; i+=0.1) {
        @autoreleasepool {
            CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
            rotationAnimation.beginTime = i+0.2;
            rotationAnimation.duration = 0.2;
            rotationAnimation.fromValue = @((i * 10) * M_PI);
            rotationAnimation.toValue = @((i*10)*M_PI + M_PI);
            [groupAnimationArr addObject:rotationAnimation];
            
            CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            scaleAnimation.beginTime = i+0.2;
            scaleAnimation.fromValue = @(1 - i);
            scaleAnimation.duration = 0.1;
            scaleAnimation.toValue = @(1-i-0.1);
            [groupAnimationArr addObject:scaleAnimation];
            
            CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
            alphaAnimation.beginTime = i+0.2;
            alphaAnimation.fromValue = @(1 - i);
            alphaAnimation.duration = 0.1;
            alphaAnimation.toValue = @(1-i-0.1);
            [groupAnimationArr addObject:alphaAnimation];
        }
    }
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = (NSArray *)groupAnimationArr;
    groups.duration = 1.0;
    groups.removedOnCompletion=NO;
    groups.fillMode=kCAFillModeForwards;
    groups.delegate = self;
    [self.gotRedPacketAnimationImgView.layer addAnimation:groups forKey:@"group"];
}

#pragma mark - Restart Animation When app enter foreground
- (void)_findActualUnfinishedAnimatedRedPacketImgViewWhenAppEnterForground {
    double currentTime = (double)[self currentTimeInterval];
    for (RedPacketImageView*areExcutingAnimateRedPacketImgView in self.areExcutingAnimateRedPacketImgViewArray) {
        if (currentTime < areExcutingAnimateRedPacketImgView.redPacketAnimateRelatedModel.redPacketAnimateEndTime) {
            NSLog(@"没有完成动画的红包---%@",areExcutingAnimateRedPacketImgView.redPacketAnimateRelatedModel.redPacketIdentifier);
            [self _restartAnimationOfUnfinishedAnimatedRedPacketImgView:areExcutingAnimateRedPacketImgView];
            
        }
    }
}

- (void)_restartAnimationOfUnfinishedAnimatedRedPacketImgView:(RedPacketImageView *)unfinishedAnimatedRedPacketImgView{
    double currentTime = (double)[self currentTimeInterval];
    RedPacketAnimateRelatedModel *unfinishedAnimateRedPacketAnimateRelatedModel = unfinishedAnimatedRedPacketImgView.redPacketAnimateRelatedModel;
    double animateHasExcutedTime = currentTime - unfinishedAnimateRedPacketAnimateRelatedModel.redPacketAnimateBeginTime;
    double newStartPositionY = unfinishedAnimateRedPacketAnimateRelatedModel.redPacketAnimateAverageSpeed * animateHasExcutedTime + 10;
    unfinishedAnimatedRedPacketImgView.frame = CGRectMake(unfinishedAnimateRedPacketAnimateRelatedModel.redPacketAnimatePositionX, newStartPositionY, IMAGE_WIDTH, IMAGE_Height);
    double animateDuration = unfinishedAnimateRedPacketAnimateRelatedModel.redPacketAnimateDuration - animateHasExcutedTime;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:animateDuration];
    [UIView setAnimationDelegate:self];
    unfinishedAnimatedRedPacketImgView.frame = CGRectMake(unfinishedAnimateRedPacketAnimateRelatedModel.redPacketAnimatePositionX, RedPacketEndPositionY, IMAGE_WIDTH, IMAGE_Height);
    [UIView commitAnimations];
}

#pragma mark - Game Whether End Deal When app enter foreground
- (void)_gameWhetherEndDeal {
    if (self.gameHasBegan) {
        
    }
}


#pragma mark ------------------------Api----------------------------------
- (void)_requestGrabRedPacketSuccessBlock:(void (^)(bool sucess))successBlock {
    self.requestParam = @{@"activityId":self.grabRedPacketGameInfoModel.activityId};
    [AFNHttpRequestOPManager postWithParameters:self.requestParam subUrl:kUrl_GetGrabRedPacket block:^(NSDictionary *resultDic, NSError *error) {
        if (error.code == 1) {
            NSArray *gotCouponList = resultDic[EntityKey];
            if (!isEmpty(gotCouponList) && gotCouponList.count) {//抢到了红包
                successBlock(YES);
                [self _gotRedPacketConfigure];
                [self _dealGrabRedPacketGotCoupons:gotCouponList];
            }else {
                successBlock(NO);
            }
        }else {
            successBlock(NO);
        }
    }];
}

#pragma mark ------------------------Page Navigate---------------------------
- (void)_enterGrabRedPacketResultPage {
    DLGrabRedPacketResultPageVC *grabRedPacketResultPageVC = [[DLGrabRedPacketResultPageVC alloc] init];
    grabRedPacketResultPageVC.grabedCoupList = [self.grabRedPacketGotCouponList copy];
    WEAK_SELF
    grabRedPacketResultPageVC.goonGrabRedPacketBlock = ^(DLGrabRedPacketGameInfoModel *redPacketGameInfoModel,BOOL hasRedPacketGame){
        weak_self.grabRedPacketGameInfoModel = redPacketGameInfoModel;
        weak_self.hasRedPacketGame = hasRedPacketGame;
        [weak_self _initWhetherHaveTheGame];
    };
    
    grabRedPacketResultPageVC.backBlock = ^{
//        weak_self.grabRedPacketGameInfoModel = nil;
//        weak_self.hasRedPacketGame = NO;
//        [weak_self _initWhetherHaveTheGame];
        [super goBack];
        [weak_self _backConfigure];
        
    };
    [self navigatePushViewController:grabRedPacketResultPageVC animate:YES];
}

#pragma mark ------------------------View Event---------------------------
-(void)click:(UITapGestureRecognizer *)tapGesture {
    CGPoint touchPoint = [tapGesture locationInView:self.view];
    for (RedPacketImageView * imgView in _redPacketOriginalImgViewArray) {
        if ([imgView.layer.presentationLayer hitTest:touchPoint]) {
            [self _clickedAtRedPacketImgView:imgView andPostion:touchPoint];
            return;
        }
    }
}

- (void)_clickedAtRedPacketImgView:(RedPacketImageView *)redPacketImgView andPostion:(CGPoint)clickPosition{
    self.gotRedPacketAnimationImgView.image = redPacketImgView.image;
    if (arc4random()%100 >= self.grabRedPacketGameInfoModel.interfaceInvokedProbability) {
        self.gotRedPacketAnimationImgView.image = redPacketImgView.image;
        self.gotRedPacketAnimationImgView.center = clickPosition;
        self.gotRedPacketAnimationImgView.hidden = NO;
        self.gotRedPacketAnimationImgView.alpha = 1.0;
        redPacketImgView.hidden = YES;
        [self notGrabedRedPacketAnimateConfigure];
    }else {
        WEAK_SELF
        [self _requestGrabRedPacketSuccessBlock:^(bool success){

            self.gotRedPacketAnimationImgView.center = clickPosition;
            redPacketImgView.hidden = YES;
            weak_self.gotRedPacketAnimationImgView.hidden = NO;
            weak_self.gotRedPacketAnimationImgView.alpha = 1.0;
            if (success) {
                [weak_self.redPacketSoundPlayer playClickGrabedRedPacketSound];
                [weak_self showGotRedPacketAnimationFromPostion:clickPosition];
            }else {
                [weak_self notGrabedRedPacketAnimateConfigure];
            }
        }];
    }
}

- (void)_redPacketBombAnimateWithRedpacketImgView:(UIImageView *)imageView1{
    self.excuteBombAnimateImgView.center = imageView1.center;
    //开始播放动画
    [ self.excuteBombAnimateImgView startAnimating];
}

- (void)goBack {
    [self _backConfigure];
    [super goBack];
}

#pragma mark ------------------------Delegate-----------------------------
- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    if (!animationID) {
        return;
    }
    RedPacketImageView *imageView = (RedPacketImageView *)[self.view viewWithTag:[animationID intValue]];
    if (isEmpty(imageView)) {
        return;
    }
    imageView.alpha = 1.0f;
    [UIView animateWithDuration:0.3 animations:^{
        imageView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [_redPacketExcuteAnimateImgViewArray addObject:imageView];
        double currentTime = (double)[self currentTimeInterval];
        if (currentTime > imageView.redPacketAnimateRelatedModel.redPacketAnimateEndTime) {
            [_areExcutingAnimateRedPacketImgViewArray removeObject:imageView];
        }else {
            //[self _restartAnimationOfUnfinishedAnimatedRedPacketImgView:imageView];
        }
    }];
}

- (void)animationWillStart:(NSString *)animationID context:(void *)context {
    if (!animationID) {
        return;
    }
    RedPacketImageView *imageView = (RedPacketImageView *)[self.view viewWithTag:[animationID intValue]];
    imageView.redPacketAnimateRelatedModel.redPacketAnimateBeginTime = (double)[self currentTimeInterval];
    imageView.redPacketAnimateRelatedModel.redPacketAnimateEndTime = imageView.redPacketAnimateRelatedModel.redPacketAnimateDuration + imageView.redPacketAnimateRelatedModel.redPacketAnimateBeginTime;
    
    [_areExcutingAnimateRedPacketImgViewArray addObject:imageView];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (anim == [_gotRedPacketAnimationImgView.layer animationForKey:@"group"]) {
        _gotRedPacketAnimationImgView.hidden = YES;
//        self.gotRedPacketCount ++;
        [_gotRedPacketAnimationImgView.layer removeAllAnimations];
    }
}

#pragma mark ------------------------Notification-------------------------
- (void)appEnterForeGround:(NSNotification *)info {
//    [self _findActualUnfinishedAnimatedRedPacketImgViewWhenAppEnterForground];
    [self _gameWhetherEndDeal];
}

#pragma mark ------------------------Getter / Setter----------------------

- (void)setGameFromBeginLeftTimeCount:(NSInteger)gameFromBeginLeftTimeCount {
    _gameFromBeginLeftTimeCount = gameFromBeginLeftTimeCount;
    [self _configureFromGameBeginLeftTimeView];
}

- (void)setGameEndLeftTimeCount:(NSInteger)gameEndLeftTimeCount {
    _gameEndLeftTimeCount = gameEndLeftTimeCount;
    [self _configureGameLeftTimeView];
}

- (void)setGotRedPacketCount:(NSInteger)gotRedPacketCount {
    _gotRedPacketCount = gotRedPacketCount;
    self.grabedRedPacketCountLabel.text = jFormat(@"%ld",_gotRedPacketCount);
}

- (NSMutableArray *)grabRedPacketGotCouponList {
    
    if (!_grabRedPacketGotCouponList) {
        _grabRedPacketGotCouponList = [NSMutableArray arrayWithCapacity:0];
    }
    return _grabRedPacketGotCouponList;
}

- (RedPacketGameManager *)redPacketGameManager {
    if (!_redPacketGameManager) {
        _redPacketGameManager = [[RedPacketGameManager alloc] init];
    }
    return _redPacketGameManager;
}

- (NSTimeInterval)currentTimeInterval {
    
    NSDate *currentDate = [NSDate date];
    return [currentDate timeIntervalSince1970];
}

- (UIImageView *)gotRedPacketAnimationImgView {
    
    if (!_gotRedPacketAnimationImgView) {
        _gotRedPacketAnimationImgView = [[UIImageView alloc] init];
        _gotRedPacketAnimationImgView.frame = CGRectMake(0, 0, IMAGE_WIDTH, IMAGE_Height);
        [self.view addSubview:_gotRedPacketAnimationImgView];
    }
    return _gotRedPacketAnimationImgView;
}

- (UIImageView *)excuteBombAnimateImgView {
    
    if (!_excuteBombAnimateImgView) {
        _excuteBombAnimateImgView = [[UIImageView alloc] init];
        _excuteBombAnimateImgView.frame = CGRectMake(0, 0, 115, 101);
        //创建一个数组，数组中按顺序添加要播放的图片（图片为静态的图片）
        NSMutableArray *imgArray = [NSMutableArray array];
        for (int i=1; i<4; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"bomb%02d.png",i]];
            [imgArray addObject:image];
        }
        //把存有UIImage的数组赋给动画图片数组
        _excuteBombAnimateImgView.animationImages = imgArray;
        //设置执行一次完整动画的时长
        _excuteBombAnimateImgView.animationDuration = 0.3;
        //动画重复次数 （0为重复播放）
        _excuteBombAnimateImgView.animationRepeatCount = 1;
        [self.view addSubview:_excuteBombAnimateImgView];
    }
    return _excuteBombAnimateImgView;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"红包雨页面内存泄漏了啊。。");
}

@end
