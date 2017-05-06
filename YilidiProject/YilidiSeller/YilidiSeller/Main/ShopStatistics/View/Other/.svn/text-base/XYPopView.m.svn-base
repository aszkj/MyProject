//
//  XYPopView.m
//  pop
//
//  Created by  yld on 16/6/3.
//  Copyright © 2016年  yld.All rights reserved.
//

#import "XYPopView.h"
#import "ProjectStandardUIDefineConst.h"
#define kWindow [[UIApplication sharedApplication].delegate window]
#define kButtonHeight 30
#define kFont [UIFont systemFontOfSize:12]

@implementation XYPopView
{
    NSArray *buttonItems;
    CGFloat popViewX;
    CGFloat popViewY;
    BOOL isShow;
    UIButton *button;
    
    UIView *viewBG;
}

- (instancetype)initWithSuperView:(UIView *)superView
{
    if (self = [super init]) {
        [self loadUI:superView];
    }
    return self;
}

- (instancetype)initWithSuperView:(UIView *)superView items:(NSArray *)items
{
    if (self = [super init]) {
        buttonItems = [NSArray arrayWithArray:items];
        [self loadUI:superView];
    }
    return self;
}
/**
 *  设置按钮数组
 *
 *  @param items 数组按钮
 */
- (void)setItems:(NSArray *)items
{
    _items = items;
    buttonItems = [NSArray arrayWithArray:items];
}
/**
 *  设置弹出视图的背景色
 *
 *  @param backColor 背景色,默认白色
 */
- (void)setBackColor:(UIColor *)backColor
{
    _backColor = backColor;
    self.backColor = backColor;
}
/**
 *  弹出视图边框颜色
 *
 *  @param PopBorderColor 默认黑色
 */
- (void)setPopBorderColor:(UIColor *)PopBorderColor
{
    _PopBorderColor = PopBorderColor;
    self.layer.borderColor = UIColorFromRGB(0xdcdcdc).CGColor;
    
}
/**
 *  显示弹出视图,再次点击消失
 */
- (void)showPopView:(BOOL)show
{
    isShow = show;
    if (isShow) {
       
       viewBG  = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
        [viewBG addSubview:self];
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(_onClickImage)];
        viewBG.hidden=NO;
        singleTap.numberOfTouchesRequired = 1;
        viewBG.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.75];
        [viewBG addGestureRecognizer:singleTap];
        [kWindow addSubview:viewBG];
    
        
        
        [UIView animateWithDuration:0.333 animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, buttonItems.count * kButtonHeight);
        }];
        
    }else{
        
        [UIView animateWithDuration:0.333 animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 0);
        } completion:^(BOOL finished) {
            viewBG.hidden=YES;
            [self removeFromSuperview];
        }];
        
        
    
    }
    isShow = !isShow;
}

-(UIImage*)createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)_onClickImage {
    
    [self showPopView:NO];
}


//按钮点击事件
- (void)buttonClick:(UIButton *)sender
{
    int days;
    if (sender.tag==0) {
        days=0;
    }else if (sender.tag==1){
        days=2;
    }else if (sender.tag==2){
        days=6;
    }

    
    NSDate * date = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //设置时间间隔
    NSTimeInterval time = days * 24 * 60 * 60;
    //得到之前的当前时间
    
    NSDate * lastYear = [date dateByAddingTimeInterval:-time];
    
    //转化为字符串
    NSString * startDate = [dateFormatter stringFromDate:lastYear];
    NSString * endDate = [dateFormatter stringFromDate:date];
    
   NSString *timer = [NSString stringWithFormat:@"%@,%@",startDate,endDate];

    
    if (_popviewBlock) {
        _popviewBlock(sender.tag,timer);
        [self showPopView:isShow];
    }
}
/**
 *  布局
 *
 *  @param superView superView description
 */
- (void)loadUI:(UIView *)superView
{
    isShow = NO;
    popViewX = superView.frame.origin.x;
    popViewY = superView.frame.origin.y;
    if (iPhone6p_width==kScreenWidth) {
        popViewX = superView.frame.origin.x-5;
    }
    UIView *sup = superView;
    while ([sup.superview isKindOfClass:[UIView class]]) {
        popViewX += sup.superview.frame.origin.x;
        popViewY += sup.superview.frame.origin.y;
        NSLog(@"%f", popViewX);
        sup = sup.superview;
    }
    self.frame = CGRectMake(popViewX,  popViewY, superView.frame.size.width, 0);
    [self setButton];
    self.layer.borderWidth = 1;
    self.layer.borderColor = UIColorFromRGB(0xf1f1f1).CGColor;
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
}
/**
 *  设置按钮
 */
- (void)setButton
{
    
        for (int i = 0; i < buttonItems.count; i++) {
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:buttonItems[i] forState:UIControlStateNormal];
        button.titleLabel.font = kFont;
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.borderWidth = 0.5;
        button.layer.borderColor = UIColorFromRGB(0xdcdcdc).CGColor;
        button.frame = CGRectMake(0, kButtonHeight * i, self.frame.size.width, kButtonHeight);
        
       
        [self addSubview:button];
    }
    if ([buttonItems lastObject]) {
        [button setTitleColor:KCOLOR_PROJECT_RED forState:UIControlStateNormal];
    }
}

@end
