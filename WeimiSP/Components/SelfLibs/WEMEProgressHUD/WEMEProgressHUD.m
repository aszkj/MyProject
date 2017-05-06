//
//  WEMEProgressHUD.m
//  WeimiSP
//
//  Created by thinker on 16/3/3.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "WEMEProgressHUD.h"

@interface WEMEProgressHUD ()

@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) UIImageView *imageView;

@end


@implementation WEMEProgressHUD

+(id)shareProgressHud
{
    static WEMEProgressHUD *hud = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hud = [[WEMEProgressHUD alloc ]initWithFrame:CGRectMake(0, 0, 120 , 100)];
        hud.backgroundColor = [UIColor clearColor];
        [hud initUI];
    });
    return hud;
}

- (void)initUI
{
    UIView *backView = [[UIView alloc ]initWithFrame:self.frame];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.8;
    backView.layer.cornerRadius = 10;
    backView.clipsToBounds = YES;
    [self addSubview:backView];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    imageView.animationImages = self.images;
    imageView.animationDuration = 2;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.centerY.equalTo(@0);
    }];
    self.imageView = imageView;
    
}

+(id)showHUDAddedTo:(UIView *)view
{
    WEMEProgressHUD *hud = [WEMEProgressHUD shareProgressHud];
    hud.hidden = NO;
    [hud.imageView startAnimating];
    
    hud.center = CGPointMake(CGRectGetWidth(view.frame) / 2, CGRectGetHeight(view.frame) / 2);
    [view addSubview:hud];
    
    return hud;
}

+(void)hideHUDForView:(UIView *)view
{
    WEMEProgressHUD *hud = [WEMEProgressHUD shareProgressHud];
    [hud.imageView stopAnimating];
    hud.hidden = YES;
    [hud removeFromSuperview];
}

-(NSMutableArray *)images
{
    if (!_images) {
        _images = [NSMutableArray array];
        for (NSInteger i = 0; i < 40; i ++)
        {
            NSString *imageName = [NSString stringWithFormat:@"loading_00000_000%02ld",i];
            UIImage *image = [UIImage imageNamed:imageName];
            [_images addObject:image];
        }
    }
    return _images;
}


@end
