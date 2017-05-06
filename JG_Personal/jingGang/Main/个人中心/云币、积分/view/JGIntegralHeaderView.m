//
//  JGIntegralHeaderView.m
//  jingGang
//
//  Created by dengxf on 15/12/25.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "JGIntegralHeaderView.h"
#import "GlobeObject.h"
typedef void(^LeftBlock)(void);

@interface JGIntegralHeaderView ()

@property (copy , nonatomic) LeftBlock leftBlock;

@end

@implementation JGIntegralHeaderView

- (instancetype)initWithHeaderViewValue:(NSString *)string {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
//        self.leftBlock = leftBlock;
        self.totleValue = string;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)setValueType:(ViewValueType)valueType
{
    _valueType = valueType;
    [self setup];
}

- (void)setTotleValue:(NSString *)totleValue {
    _totleValue = totleValue;
}

- (void)setup{
//    UIButton *titleButton = [self createButton:CGRectMake(0, 16, ScreenWidth, 25)];
    
    
//    if (_valueType == IntegralViewType) {
//        [titleButton setTitle:title forState:UIControlStateNormal];
//        [titleButton setImage:[UIImage imageNamed:@"jifen_icon"] forState:UIControlStateNormal];
//    }else if (_valueType == CloudValueViewType){
//        [titleButton setTitle:title forState:UIControlStateNormal];
//        [titleButton setImage:[UIImage imageNamed:@"yunbi_icon"] forState:UIControlStateNormal];
//    }
////
//    titleButton.userInteractionEnabled = NO;
//    [titleButton setContentEdgeInsets:UIEdgeInsetsMake(0, - (ScreenWidth / 2 + 30), 0, 0)];
//    titleButton.titleLabel.font = [UIFont systemFontOfSize:22];
//    [titleButton setTitleColor:status_color forState:UIControlStateNormal];
    
    UIImage *image;
    CGFloat totlePrice = [self.totleValue floatValue];
    NSString *title ;
    if (_valueType == IntegralViewType) {
        image =  [UIImage imageNamed:@"jifen_icon"];
        title = [NSString stringWithFormat:@" %.0f",totlePrice];
    }else if (_valueType == CloudValueViewType){
        image = [UIImage imageNamed:@"yunbi_icon"] ;
        title = [NSString stringWithFormat:@" %.2f",totlePrice];
    }
    
    UIImageView *img = [[UIImageView alloc] initWithImage:image];
    img.x = 10;
    img.y = 16;
    img.width = 15;
    img.height = 18;
    [self addSubview:img];
    
    UILabel *lab = [[UILabel alloc] init];
    lab.x = CGRectGetMaxX(img.frame) + 1;
    lab.y = img.y;
    lab.width = 240;
    lab.height = img.height;
    lab.textAlignment = NSTextAlignmentLeft;
    lab.font = [UIFont systemFontOfSize:22];
    lab.textColor = status_color;
    [self addSubview:lab];
    lab.text = title;
    
    
    

//
////    // 返回按钮
////    UIButton *leftBackButton = [self createButton:CGRectMake(20, 32, 40, 25)];
////    [leftBackButton setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
////    [leftBackButton addTarget:self action:@selector(leftBackClick) forControlEvents:UIControlEventTouchUpInside];
//    
//    // 云币规则
//    UIButton *ruleButton = [self createButton:CGRectMake(ScreenWidth - 75, 26, 65, 20)];
//    ruleButton.showsTouchWhenHighlighted = YES;
//    ruleButton.backgroundColor = [UIColor clearColor];
//    
//    if (_valueType == IntegralViewType) {
//        [ruleButton setTitle:@"积分规则" forState:UIControlStateNormal];
//    }else if (_valueType == CloudValueViewType){
//        [ruleButton setTitle:@"云币规则" forState:UIControlStateNormal];
//    }
//    [ruleButton addTarget:self action:@selector(RuleButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    ruleButton.titleLabel.font = [UIFont systemFontOfSize:10];
//    [ruleButton setContentEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
//    
//    // 总共云币
//    self.valueLab = [self createLabel:CGRectMake(0, CGRectGetMaxY(leftBackButton.frame) + 5, ScreenWidth, 24) title:@"0" font:JGFont(24)];
//    self.valueLab.textColor = [UIColor whiteColor];
//    
//    // 介绍lab
//    
    NSString *strDetail;
    if (_valueType == IntegralViewType) {
        strDetail = @"小积分，大作用，多领一些囤起来";
    }else{
        strDetail = @"多推荐,多消费,多收益,花云e生的钱!";
    }
    UILabel *detailLeb = [self createLabel:CGRectMake(10, CGRectGetMaxY(img.frame), ScreenWidth, 20) title:strDetail font:JGFont(13)];
    detailLeb.textColor = [[UIColor grayColor] colorWithAlphaComponent:0.75];
    
    UILabel *bottomLab = [self createLabel:CGRectMake(0, CGRectGetMaxY(detailLeb.frame) + 6, ScreenWidth, self.height - CGRectGetMaxY(detailLeb.frame) - 6 ) title:@"   收支明细" font:[UIFont systemFontOfSize:14]];
    bottomLab.backgroundColor = kGetColor(233, 234, 235);
    bottomLab.textColor = [UIColor blackColor];
}

- (UILabel *)createLabel:(CGRect)frame title:(NSString *)title  font:(UIFont *)font{
    UILabel *instanceLabel = [[UILabel alloc] initWithFrame:frame];
    instanceLabel.textAlignment = NSTextAlignmentLeft;
    instanceLabel.font = font;
    instanceLabel.text = title;
    instanceLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:instanceLabel];
    return instanceLabel;
}

- (UIButton *)createButton:(CGRect)frame {
    UIButton *instanceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    instanceButton.frame = frame;
    [self addSubview:instanceButton];
    return instanceButton;
}

- (void)RuleButtonClick
{
    if([self.delegate respondsToSelector:@selector(JGIntegralHeaderViewRuleButtonClick)]){
        [self.delegate JGIntegralHeaderViewRuleButtonClick];
    }
}

- (void)leftBackClick {
    if (self.leftBlock) {
        self.leftBlock();
    }
}

@end
