//
//  JGHeartRateTestProgressView.m
//  jingGang
//
//  Created by dengxf on 16/2/25.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import "JGHeartRateTestProgressView.h"
#import "MCPercentageDoughnutView.h"
#import "MSWeakTimer.h"

#define kFirstRoundRadius     120
#define kFirstRoundLineWidth  .8
#define kSecondRoundRadius    170
#define kLabTextChangeSpeed    6

@interface JGHeartRateTestProgressView ()

@property (strong,nonatomic) MCPercentageDoughnutView *heartRateProgressView;

@property (strong,nonatomic) UILabel *dataLab;

@property (strong,nonatomic) UIImageView *heartImg;

@property (strong,nonatomic) MSWeakTimer *timer;

@end


@implementation JGHeartRateTestProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor clearColor];
    self.heartRate = .5;
    // 第二个圆弧
    MCPercentageDoughnutView *secondView = [[MCPercentageDoughnutView alloc] init];
    secondView.width = kSecondRoundRadius;
    secondView.height = secondView.width;
    secondView.x = (self.width - kSecondRoundRadius) / 2;
    secondView.y = (self.height - kSecondRoundRadius) / 2;
    secondView.percentage = self.heartRate;
    secondView.showTextLabel           = NO;
    secondView.fillColor = JGColor(247, 84, 130, .95);
    secondView.unfillColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    [self addSubview:secondView];
    self.heartRateProgressView = secondView;
    
    // 第一个内圆
    CAShapeLayer *firstRound = [CAShapeLayer new];
    firstRound.lineCap = kCALineCapRound;
    firstRound.fillColor = [UIColor whiteColor].CGColor;
    firstRound.strokeColor = [UIColor lightGrayColor].CGColor;
    firstRound.lineWidth = kFirstRoundLineWidth;
    CGFloat firstWidth = kFirstRoundRadius;
    CGPoint center = CGPointMake(self.width/2, self.height/2);
    UIBezierPath *firstPath =  [UIBezierPath bezierPathWithArcCenter:center radius:(firstWidth - 3)/ 2 startAngle:0 endAngle:M_PI * 2 clockwise:YES];;
    firstRound.path = firstPath.CGPath;
    [self.layer addSublayer:firstRound];
    
    UIView *textContentView = [[UIView alloc] init];
    CGFloat viewWidth = 86;
    CGFloat viewHeight = viewWidth;
    textContentView.x = (self.width - viewWidth) / 2;
    textContentView.y = (self.height -viewHeight) / 2;
    textContentView.width = viewWidth ;
    textContentView.height = viewHeight;
    textContentView.backgroundColor = JGClearColor;
    [self addSubview:textContentView];
    
    UILabel *dataLab = [[UILabel alloc] init];
    dataLab.width = textContentView.width / 2;
    dataLab.height = 35;
    dataLab.x = 0;
    dataLab.y = 22;
    dataLab.textAlignment = NSTextAlignmentCenter;
    dataLab.font = JGFont(30);
    dataLab.font = [UIFont boldSystemFontOfSize:24];
    dataLab.text = @"00";
    dataLab.backgroundColor = JGClearColor;
    [textContentView addSubview:dataLab];
    self.dataLab = dataLab;
    
    UILabel *detailLab = [[UILabel alloc] init];
    detailLab.x = -2;
    detailLab.y = CGRectGetMaxY(dataLab.frame) - 8;
    detailLab.width = 80;
    detailLab.height = 24;
    detailLab.textAlignment = NSTextAlignmentLeft;
    detailLab.text = @"次/分钟";
    detailLab.font = JGFont(16);
    detailLab.font = [UIFont boldSystemFontOfSize:16];
    detailLab.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.45];
    [textContentView addSubview:detailLab];
    
    UIImageView *heartImg = [[UIImageView alloc] init];
    heartImg.x = CGRectGetMaxX(dataLab.frame) + 10;
    heartImg.y = dataLab.y + 10;
    heartImg.width = 27;
    heartImg.height = 27;
    heartImg.image = [UIImage imageNamed:@"jg_heartRate"];
    [textContentView addSubview:heartImg];
    self.heartImg = heartImg;
    
//    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleDisplayLink:)];
    self.timer = [MSWeakTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(handleDisplayLink:) userInfo:nil repeats:YES dispatchQueue:dispatch_get_main_queue()];
}

- (void)handleDisplayLink:(id)displayLink {
    static int i = 0;
    i++;
    POPSpringAnimation *scalAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    if (i%2 == 0) {
        scalAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0.8, 0.8)];
        scalAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1.5, 1.5)];
    }else {
        scalAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.5, 1.5)];
        scalAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.8, 0.8)];
    }
    scalAnimation.springSpeed = 8;
    scalAnimation.springBounciness = 6;
    [self.heartImg pop_addAnimation:scalAnimation forKey:@"scaleXY"];
}

-(void)dealloc {
    [self.heartImg pop_removeAnimationForKey:@"scaleXY"];
    [self.timer invalidate];
}

- (void)setHeartRateData:(int)rateData {
    static NSInteger count = 0;
    count ++;
    if (count > kLabTextChangeSpeed) {
        self.dataLab.text = [NSString stringWithFormat:@"%d",rateData];
        count = 0;
    }
}

- (void)setHeartRate:(CGFloat)heartRate {
    self.heartRateProgressView.percentage = heartRate;
}
@end
