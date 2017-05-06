//
//  PopPluginView.h
//  BaiYing_Thinker
//
//  Created by 鹏 朱 on 15/10/29.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopPluginView : UIView
{
    UIControl *_overlayView;
}

@property (nonatomic, assign) BOOL dismissWithButton;
@property (nonatomic, strong) UIImage *backImage;
@property (nonatomic, strong) UIView *line;

- (void)show;
- (void)showInView:(UIView *)view;
- (void)dismiss;
- (id)initWithPopverView:(UIView *)popverView;
- (void)resetPopverView:(UIView *)popverView;
- (id)initWithPopverView:(UIView *)popverView height:(NSInteger)height;

@end
