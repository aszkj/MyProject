//
//  PopPluginView.m
//  BaiYing_Thinker
//
//  Created by 鹏 朱 on 15/10/29.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "PopPluginView.h"
#import "UIImage+ImageEffects.h"

@interface PopPluginView ()

@property (nonatomic, strong) UIView *popverView;
@property (nonatomic, strong) UIImageView *blurImage;

@property (nonatomic, assign) float popverViewWidth;
@property (nonatomic, assign) float popverViewHeight;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation PopPluginView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithPopverView:(UIView *)popverView
{
    self = [super init];
    if (self)
    {
        self.frame = CGRectMake(kScreenWidth / 2 - 90, 64, 180, 44*2);
        _overlayView = [[UIControl alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _overlayView.backgroundColor = [UIColor clearColor];

//        _overlayView.alpha = 0.5;
        [_overlayView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        
        _popverView = popverView;

        if (self.popverViewHeight && self.popverViewHeight > 0) {
            _popverView.center = CGPointMake(_overlayView.bounds.size.width/2, _overlayView.bounds.size.height/2 + self.popverViewHeight);;
        }
        else {
            _popverView.center = CGPointMake(_overlayView.bounds.size.width/2, _overlayView.bounds.size.height/2);;
        }
    }
    return self;
}

- (id)initWithPopverView:(UIView *)popverView height:(NSInteger)height
{
    self = [super init];
    if (self)
    {
        self.frame = CGRectMake(kScreenWidth / 2 - 90, 64, 180, 44*2);
        _overlayView = [[UIControl alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _overlayView.backgroundColor = [UIColor blackColor];
        
        _overlayView.alpha = 0.5;
        [_overlayView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        
        _popverViewHeight = height;
        _popverView = popverView;
        if (self.popverViewHeight && self.popverViewHeight > 0) {
            _popverView.center = CGPointMake(_overlayView.bounds.size.width/2, _overlayView.bounds.size.height/2 + self.popverViewHeight);;
        }
        else {
            _popverView.center = CGPointMake(_overlayView.bounds.size.width/2, _overlayView.bounds.size.height/2);;
        }
    }
    return self;
}

- (void)resetPopverView:(UIView *)popverView
{
    _popverView = popverView;
    
    if (self.popverViewHeight && self.popverViewHeight > 0) {
        _popverView.center = CGPointMake(_overlayView.bounds.size.width/2, _overlayView.bounds.size.height/2 + self.popverViewHeight);;
    }
    else {
        _popverView.center = CGPointMake(_overlayView.bounds.size.width/2, _overlayView.bounds.size.height/2);;
    }

    [self show];
}


//- (void)fadeIn
//{
//    _popverView.transform = CGAffineTransformMakeScale(0.1, 0.1);
//    _popverView.alpha = 0;
//    //_popverView.center = CGPointMake(_overlayView.bounds.size.width/2, _overlayView.bounds.size.height/2);;
//
//    [UIView animateWithDuration:.35 animations:^{
//        _popverView.alpha = 1;
//        //_popverView.center = CGPointMake(_overlayView.bounds.size.width/2, _overlayView.bounds.size.height/2 - 50);;
//
//        _popverView.transform = CGAffineTransformMakeScale(1, 1);
//    }];
//}
//
//- (void)fadeOut
//{
//    [UIView animateWithDuration:.35 animations:^{
//        _popverView.transform = CGAffineTransformMakeScale(0.1, 0.1);
//        _popverView.alpha = 0.0;
//        //_popverView.center = CGPointMake(_overlayView.bounds.size.width/2, _overlayView.bounds.size.height/2);;
//
//    } completion:^(BOOL finished) {
//        if (finished) {
//            [_popverView removeFromSuperview];
//            _popverView = nil;
//            
//            [_overlayView removeFromSuperview];
//            _overlayView = nil;
//        }
//    }];
//}
//
//- (void)show
//{
//    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
//    [keywindow addSubview:_overlayView];
//    [keywindow addSubview:_popverView];
//    [self fadeIn];
//}

- (void)fadeIn
{
    [UIView animateWithDuration:0.35 animations:^{
        CGFloat height = kScreenHeight > 480 ? 176 :132;
        if (self.popverViewHeight && self.popverViewHeight > 0) {
            _popverView.center = CGPointMake(kScreenWidth / 2, kScreenHeight / 2);
        }
        else {
            _popverView.center = CGPointMake(kScreenWidth / 2, height);
        }
        _titleLabel.center = CGPointMake(kScreenWidth / 2, 60);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            _popverView.transform = CGAffineTransformMakeRotation(M_PI * 0.01);
            _titleLabel.transform = CGAffineTransformMakeRotation(M_PI * 0.01);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                _popverView.transform = CGAffineTransformMakeRotation(0);
                _titleLabel.transform = CGAffineTransformMakeRotation(0);
            }];
        }];
    }];
    
}
- (void)fadeOut
{
    [UIView animateWithDuration:.35 animations:^{
        if (self.popverViewHeight && self.popverViewHeight > 0) {
            _popverView.center = CGPointMake(kScreenWidth / 2,kScreenHeight+kScreenHeight/2+15 + self.popverViewHeight);
        }
        else {
            _popverView.center = CGPointMake(kScreenWidth / 2,kScreenHeight+kScreenHeight/2+15);
        }
        _titleLabel.center = CGPointMake(kScreenWidth / 2, -50);
    } completion:^(BOOL finished) {
        if (finished) {
            [_overlayView removeFromSuperview];
            [_popverView removeFromSuperview];
            [_blurImage removeFromSuperview];
            [self removeFromSuperview];
        }
    }];
}

- (void)show
{
    if (_dismissWithButton) {
        [_overlayView removeTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }

    [self blurImage:nil];
    [kCurrentKeyWindow addSubview:_overlayView];
    [kCurrentKeyWindow addSubview:_popverView];
    
    if (self.popverViewHeight && self.popverViewHeight > 0) {
        _popverView.center = CGPointMake(kCurrentKeyWindow.bounds.size.width/2.0f, 0-self.bounds.size.height + self.popverViewHeight);
    }
    else {
        _popverView.center = CGPointMake(kCurrentKeyWindow.bounds.size.width/2.0f, 0-self.bounds.size.height);
    }
    _popverView.transform = CGAffineTransformMakeRotation(-M_PI * 0.01);
    
    [self fadeIn];
}

- (void)showInView:(UIView *)view
{
    if (_dismissWithButton) {
        [_overlayView removeTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }

    [self blurImage:view];
    [view addSubview:_overlayView];
    [view addSubview:_popverView];
    if (self.popverViewHeight && self.popverViewHeight > 0) {
        _popverView.center = CGPointMake(view.bounds.size.width/2.0f, 0-self.bounds.size.height + self.popverViewHeight);
    }
    else {
        _popverView.center = CGPointMake(view.bounds.size.width/2.0f, 0-self.bounds.size.height);
    }

    _popverView.transform = CGAffineTransformMakeRotation(-M_PI * 0.01);
    
    [view addSubview:self.titleLabel];
    _titleLabel.center = CGPointMake(kScreenWidth / 2, -50);
    
    [self fadeIn];
}

- (void)dismiss
{
    [self fadeOut];
}

- (void)blurImage:(UIView *)view {
    
    //原始图片
    UIImage *sourceImage = self.backImage;
    //对图片进行处理(图片渲染用时，应在子线程中，此处未做此处理)
    UIImage *blurImage = [sourceImage blurImageAtFrame:CGRectMake(0,0,kScreenWidth,kScreenHeight)];//设置frame可进行局部模糊
    //加载图片
    UIImageView *imageView = [[UIImageView alloc]initWithImage:blurImage];
    imageView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.blurImage = imageView;
    
    if (view) {
        [view addSubview:imageView];
    } else {
        [kCurrentKeyWindow addSubview:imageView];
    }

//    //原始图片
//    UIImage *sourceImage = self.backImage;
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        
//        //对图片进行处理(图片渲染用时，应在子线程中，此处未做此处理)
//        UIImage *blurImage = [sourceImage blurImageAtFrame:CGRectMake(0,0,kScreenWidth,kScreenHeight)];//设置frame可进行局部模糊
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            //加载图片
//            UIImageView *imageView = [[UIImageView alloc]initWithImage:blurImage];
//            self.blurImage = imageView;
//            
//            if (view) {
//                [view addSubview:imageView];
//            } else {
//                [kCurrentKeyWindow addSubview:imageView];
//            }
//
//        });
//    });
    
}
-(UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        _titleLabel.text = @"最新消息";
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.textColor = kWhiteColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
