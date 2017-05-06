//
//  JGBloodPressureTestProgressView.m
//  CAShapeLayer
//
//  Created by dengxf on 16/2/18.
//  Copyright © 2016年 dengxf. All rights reserved.
//

#import "JGBloodPressureTestProgressView.h"
#import "MCPercentageDoughnutView.h"

#define kFirstRoundRadius     100
#define kFirstRoundLineWidth  .8
#define kSecondRoundRadius    150
#define kThirdRoundRadius     200

@interface JGBloodPressureTestProgressView ()

@property (strong,nonatomic) MCPercentageDoughnutView *highProgressView;

@property (strong,nonatomic) MCPercentageDoughnutView *lowProgressView;

@property (strong,nonatomic) UILabel *dataLab;

@end

@implementation JGBloodPressureTestProgressView

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
    self.highPercent = .5;
    self.lowPercent = .5;
    // 第三个圆弧
    MCPercentageDoughnutView *thirdView = [[MCPercentageDoughnutView alloc] init];
    thirdView.width = kThirdRoundRadius;
    thirdView.height = thirdView.width;
    thirdView.x = (self.width - kThirdRoundRadius) / 2;
    thirdView.y = (self.height - kThirdRoundRadius) / 2;
    thirdView.percentage = self.highPercent;
    thirdView.showTextLabel = NO;
    thirdView.fillColor = JGColor(126, 79, 232, 1);
    thirdView.unfillColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    [self addSubview:thirdView];
    self.highProgressView = thirdView;
    
    // 第二个圆弧    
    MCPercentageDoughnutView *secondView = [[MCPercentageDoughnutView alloc] init];
    secondView.width = kSecondRoundRadius;
    secondView.height = secondView.width;
    secondView.x = (self.width - kSecondRoundRadius) / 2;
    secondView.y = (self.height - kSecondRoundRadius) / 2;
    secondView.percentage = self.lowPercent;
    secondView.showTextLabel           = NO;
    secondView.fillColor = JGColor(210, 102, 253, 1);
    
    secondView.unfillColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    [self addSubview:secondView];
    self.lowProgressView = secondView;

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
    CGFloat viewWidth = 78;
    CGFloat viewHeight = viewWidth;
    textContentView.x = (self.width - viewWidth) / 2;
    textContentView.y = (self.height -viewHeight) / 2;
    textContentView.width = viewWidth;
    textContentView.height = viewHeight;
    textContentView.backgroundColor = JGClearColor;
    [self addSubview:textContentView];
    
    UILabel *dataLab = [[UILabel alloc] init];
    dataLab.width = textContentView.width;
    dataLab.height = 35;
    dataLab.x = 0;
    dataLab.y = 16;
    dataLab.textAlignment = NSTextAlignmentCenter;
    dataLab.font = JGFont(22);
    dataLab.font = [UIFont boldSystemFontOfSize:20];
    dataLab.text = @"00/00";
    [textContentView addSubview:dataLab];
    self.dataLab = dataLab;
    
    UILabel *detailLab = [[UILabel alloc] init];
    detailLab.x = 0;
    detailLab.y = CGRectGetMaxY(dataLab.frame) - 8;
    detailLab.width = dataLab.width;
    detailLab.height = 24;
    detailLab.textAlignment = NSTextAlignmentCenter;
    detailLab.text = @"mmhg";
    detailLab.font = JGFont(16);
    detailLab.font = [UIFont boldSystemFontOfSize:16];
    [textContentView addSubview:detailLab];
}

- (void)setLowPercent:(CGFloat)lowPercent {
    self.lowProgressView.percentage = lowPercent;
}

- (void)setHighPercent:(CGFloat)highPercent {
    self.highProgressView.percentage = highPercent;
}

- (void)setHightData:(CGFloat)hightData lowData:(CGFloat)lowData {
    self.dataLab.text = [NSString stringWithFormat:@"%.0f/%.0f",hightData,lowData];
}

@end
