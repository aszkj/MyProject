//
//  MJRefreshNormalHeader.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/4/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "MJRefreshNormalHeader.h"
#import "NSBundle+MJRefresh.h"
const CGFloat size = 22;
@interface MJRefreshNormalHeader()
{
    __unsafe_unretained UIImageView *_arrowView;
    
}
//@property (weak, nonatomic) UIActivityIndicatorView *loadingView;
@property (nonatomic,strong)UIView *loadingView;
@property (nonatomic,strong)UIView *loadingComplete;
@end

@implementation MJRefreshNormalHeader
#pragma mark - 懒加载子控件

- (UIImageView *)arrowView
{
    if (!_arrowView) {
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:[NSBundle mj_arrowImage]];
        [self addSubview:_arrowView = arrowView];
    }
    return _arrowView;
}

- (UIView *)loadingView
{

    if (!_loadingView) {
        
        _loadingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size, size)];
//        UIImage  *image=[UIImage imageNamed:@"旋转"];
        UIImageView  *gifview=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,size, size)];
//        gifview.image=image;
//        
//        CABasicAnimation* rotationAnimation;
//        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0];
//        rotationAnimation.duration = 0.8;
//        rotationAnimation.cumulative = YES;
//        rotationAnimation.repeatCount = 99999;
//        
//        [gifview.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        
        
        
        NSMutableArray *imgArray = [NSMutableArray array];
        for (int i=1; i<9; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"rotating%02d.png",i]];
            [imgArray addObject:image];
        }
        //把存有UIImage的数组赋给动画图片数组
        gifview.animationImages = imgArray;
        //设置执行一次完整动画的时长
        gifview.animationDuration = 0.28;
        //动画重复次数 （0为重复播放）
        gifview.animationRepeatCount = 0;
        
        [gifview startAnimating];
        [_loadingView addSubview:gifview];
        [self addSubview:_loadingView];

        
    }
    
    return _loadingView;

}

- (UIView *)loadingComplete {

    if (!_loadingComplete) {
        
        _loadingComplete =[[UIView alloc]initWithFrame:CGRectMake(0, 0,size,size)];
        UIImage *imageComplete = [UIImage imageNamed:@"完成"];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, size, size)];
        imageView.image = imageComplete;
        [_loadingComplete addSubview:imageView];
        _loadingComplete.hidden = YES;
        
    }
    
    return _loadingComplete;
   
}


//- (UIActivityIndicatorView *)loadingView
//{
//    if (!_loadingView) {
//        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.activityIndicatorViewStyle];
//        loadingView.hidesWhenStopped = YES;
//        [self addSubview:_loadingView = loadingView];
//    }
//    return _loadingView;
//}

#pragma mark - 公共方法
- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle
{
    _activityIndicatorViewStyle = activityIndicatorViewStyle;
    
    self.loadingView = nil;
    [self setNeedsLayout];
}

#pragma mark - 重写父类的方法
- (void)prepare
{
    [super prepare];
    self.loadingView = nil;
//    self.loadingComplete = nil;
    self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    // 箭头的中心点
    CGFloat arrowCenterX = self.mj_w * 0.5;
    if (!self.stateLabel.hidden) {
        CGFloat stateWidth = self.stateLabel.mj_textWith;
        CGFloat timeWidth = 0.0;
        if (!self.lastUpdatedTimeLabel.hidden) {
            timeWidth = self.lastUpdatedTimeLabel.mj_textWith;
        }
        CGFloat textWidth = MAX(stateWidth, timeWidth);
        arrowCenterX -= textWidth / 2 + self.labelLeftInset;
    }
    CGFloat arrowCenterY = self.mj_h * 0.5;
    CGPoint arrowCenter = CGPointMake(arrowCenterX, arrowCenterY);
    
    // 箭头
    if (self.arrowView.constraints.count == 0) {
        self.arrowView.mj_size = CGSizeMake(size, size);
        self.arrowView.center = arrowCenter;
    }
        
    // 圈圈
    if (self.loadingView.constraints.count == 0) {
        self.loadingView.center = arrowCenter;
    }
    if (self.loadingComplete.constraints.count == 0) {
        self.loadingComplete.center = arrowCenter;
    }
//    self.arrowView.tintColor = self.stateLabel.textColor;
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        if (oldState == MJRefreshStateRefreshing) {
            self.arrowView.transform = CGAffineTransformIdentity;
            
            [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
                self.loadingView.alpha = 0.0;
                self.loadingComplete.hidden = NO;
                
                [self addSubview:self.loadingComplete];
                
            } completion:^(BOOL finished) {
                // 如果执行完动画发现不是idle状态，就直接返回，进入其他状态
                if (self.state != MJRefreshStateIdle) return;
                
                self.loadingView.alpha = 1.0;
                self.loadingView.hidden=YES;
                self.loadingComplete.hidden = YES;
                self.arrowView.hidden = NO;
            }];
        } else {

            self.loadingView.hidden=YES;
            self.arrowView.hidden = NO;
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                self.arrowView.transform = CGAffineTransformIdentity;
            }];
        }
    } else if (state == MJRefreshStatePulling) {

        self.loadingView.hidden=YES;
        self.arrowView.hidden = NO;
        [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
            self.arrowView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
        }];
    } else if (state == MJRefreshStateRefreshing) {
        self.loadingView.alpha = 1.0; // 防止refreshing -> idle的动画完毕动作没有被执行
        self.loadingView.hidden=NO;
        self.arrowView.hidden = YES;
    }
}
@end
