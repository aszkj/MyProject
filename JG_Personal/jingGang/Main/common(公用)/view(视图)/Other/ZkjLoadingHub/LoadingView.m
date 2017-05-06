//
//  LoadingView.m
//  加载图片测试
//
//  Created by ZZCM on 15/2/5.
//  Copyright (c) 2015年 ZZCM. All rights reserved.
//

#import "LoadingView.h"
#import "Masonry.h"
#define DeafaultAlertMessage @"正在载入.."

@interface LoadingView(){

    UIImageView *loadingImgView;
}

@end

@implementation LoadingView


-(id)initWithCoder:(NSCoder *)aDecoder{

    self = [super initWithCoder:aDecoder];
    if (self) {
        
//        self.systemIndicator.hidden = YES;
    }

    return self;
}

-(void)beginLoading
{
   
    if (_loadingType == LoadingSystemtype) {
        self.indicatorBaseView.hidden = NO;
        self.systemIndicator.hidden = NO;
        [self.systemIndicator startAnimating];
        self.loadingAloneImgView.hidden = YES;
        self.loadingWithAlertMessageView.hidden = YES;
        return;
    }
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 0.5;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = HUGE_VAL;
    
    if (_loadingType == LoadingAlone) {
        loadingImgView = _loadingAloneImgView;
    }else if (_loadingType == LoadingWithAlertMessage){
        loadingImgView = _loadingWithAlertImgView;
        if ( self.loadingMessage == nil ) {
            self.loadinLabel.text = DeafaultAlertMessage;
        }else{
            self.loadinLabel.text = _loadingMessage;
        }
        
    }
    
    [loadingImgView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}


-(void)endLoading
{
    
    if (_loadingType == LoadingSystemtype) {
        [self.systemIndicator stopAnimating];
        self.indicatorBaseView.hidden = YES;
        self.systemIndicator.hidden = YES;
        [self removeFromSuperview];
        return;
    }

    [loadingImgView.layer removeAllAnimations];
    [UIView animateWithDuration:1.0 animations:^{
        self.hidden = YES;
        [self removeFromSuperview];
    }];
    
}

-(void)setBgColor:(UIColor *)bgColor{
    
    self.backgroundColor = bgColor;
}


-(void)showLoadingFullInView:(UIView *)superView
             withLoadingType:(LoadingType)loadingType
{
    [self _setLoadingType:loadingType];
    [self _initInView:superView withTop:0 botton:0 left:0 right:0];
    [self beginLoading];
}

-(void)setLoadingMessage:(NSString *)loadingMessage{

    _loadingMessage = loadingMessage;
    [self beginLoading];

}

-(void)_setLoadingType:(LoadingType)loadingType{

    _loadingType = loadingType;
    if (loadingType == LoadingAlone) {
        
        self.loadingWithAlertMessageView.hidden = YES;
        
    }else if (loadingType == LoadingWithAlertMessage){
        
        self.loadingAloneImgView.hidden = YES;
    }
}


-(void)showLoadingPartInView:(UIView *)superView
                  withTopgap:(CGFloat)topGap
                   bottonGap:(CGFloat)bottonGap
                     leftGap:(CGFloat)leftGap
                    rightGap:(CGFloat)rightGap
             withLoadingType:(LoadingType)loadingType
{
    [self _setLoadingType:loadingType];
    [self _initInView:superView withTop:topGap botton:bottonGap left:leftGap right:rightGap];
    [self beginLoading];
}


-(void)_initInView:(UIView *)superView
          withTop:(CGFloat)topGap
           botton:(CGFloat)bottonGap
             left:(CGFloat)leftGap
            right:(CGFloat)rightGap
{
    
    [superView addSubview:self];
    
//    self.translatesAutoresizingMaskIntoConstraints = NO;
//    NSDictionary *varDic = @{@"top":@(topGap),
//                             @"botton":@(bottonGap),
//                             @"left":@(leftGap),
//                             @"right":@(rightGap)};
//    [superView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[self]-botton-|" options:0 metrics:varDic views:NSDictionaryOfVariableBindings(self)]];
//    [superView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-left-[self]-right-|" options:0 metrics:varDic views:NSDictionaryOfVariableBindings(self)]];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(superView).with.insets(UIEdgeInsetsMake(topGap, leftGap, bottonGap, rightGap));
    }];
    
    
}





@end
