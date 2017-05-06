//
//  UIViewController+hub.m
//  YilidiBuyer
//
//  Created by yld on 16/6/27.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "UIViewController+hub.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "NSObject+SUIAdditions.h"

@implementation UIViewController (hub)

- (void)showHub {
    [SVProgressHUD show];
}

- (void)showHubWithDefaultStatus {
    [self showHubWithStatus:nil];
}

- (void)showHubWithStatus:(NSString *)status {
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
//    [SVProgressHUD showWithStatus:status];
    [self MB_showLoadingHubWithText:status];
}

- (void)showInfoWithStatus:(NSString *)string {
    [SVProgressHUD showInfoWithStatus:string];
}

- (void)showSuccessInfoWithStatus:(NSString*)string {
    [SVProgressHUD showSuccessWithStatus:string];
}

- (void)showErrorInfoWithStatus:(NSString *)string {
    [SVProgressHUD showErrorWithStatus:string];
}

- (void)dissmiss {
//    [SVProgressHUD dismiss];
    [self MB_hideLoadingHub];
}


@end

const void *loadingHubKey = @"loadingHubKey";
const void *loadingHubViewKey = @"loadingHubViewKey";
const void *animateImgViewKey = @"animateImgViewKey";
@implementation UIViewController (loadingHub)

- (MBProgressHUD *)MB_showLoadingHubWithText:(NSString *)loadingText {

    UIImage  *image=[UIImage imageNamed:@"loading"];
    UIImageView  *gifview=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,image.size.width, image.size.height)];
    [self sui_setAssociatedRetainObject:gifview key:animateImgViewKey];
    gifview.image=image;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.color = [UIColor clearColor];
    hud.mode = MBProgressHUDModeCustomView;
//    hud.customView=gifview;
    
    UIImage  *yldImage=[UIImage imageNamed:@"loading背景"];
    UIImageView  *yldview=[[UIImageView alloc]initWithFrame:CGRectMake(gifview.frame.size.width/2-yldImage.size.width/2,gifview.frame.size.height/2-yldImage.size.height/2,yldImage.size.width, yldImage.size.height)];
    yldview.image=yldImage;
    
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [subView addSubview:yldview];
    [subView addSubview:gifview];
    hud.customView=subView;
    
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0];
    rotationAnimation.duration = 0.8;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 99999;
    rotationAnimation.delegate = self;
    
    [gifview.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    [self sui_setAssociatedRetainObject:hud key:loadingHubKey];
    return hud;
}

- (void)MB_hideLoadingHub {
    MBProgressHUD *loadingHub = [self sui_getAssociatedObjectWithKey:loadingHubKey];
    [loadingHub hide:YES];
}

- (void)MB_hideHubForText:(NSString *)hideText{
    
    MBProgressHUD *loadingHub = [self sui_getAssociatedObjectWithKey:loadingHubKey];

    [loadingHub hide:YES afterDelay:0.8];
        

}

- (void)mb_hideLoadingView{
    UIView *loadingBgView = [self sui_getAssociatedObjectWithKey:loadingHubViewKey];
    loadingBgView.hidden=YES;
}

//动画结束时
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    UIImageView *animateImgView = [self sui_getAssociatedObjectWithKey:animateImgViewKey];
    if (animateImgView) {
        [animateImgView.layer removeAllAnimations];
    }
}

@end



