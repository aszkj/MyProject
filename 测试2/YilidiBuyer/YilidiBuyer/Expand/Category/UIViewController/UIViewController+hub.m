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
@implementation UIViewController (loadingHub)

- (MBProgressHUD *)MB_showLoadingHubWithText:(NSString *)loadingText {

    UIImage  *image=[UIImage imageNamed:@"loading"];
    UIImageView  *gifview=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,image.size.width, image.size.height)];
    gifview.image=image;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.color = [UIColor clearColor];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView=gifview;
    
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0];
    rotationAnimation.duration = 0.8;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 99999;
    
    [hud.customView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
//    [self sui_setAssociatedCopyObject:hud key:loadingHubKey];
    [self sui_setAssociatedRetainObject:hud key:loadingHubKey];
    return hud;
}

- (void)MB_hideLoadingHub {
    MBProgressHUD *loadingHub = [self sui_getAssociatedObjectWithKey:loadingHubKey];
    [loadingHub hide:YES];
}

- (void)MB_hideHubForText:(NSString *)hideText{
    
    MBProgressHUD *loadingHub = [self sui_getAssociatedObjectWithKey:loadingHubKey];

    if (hideText!=nil) {
        
        [loadingHub hide:YES afterDelay:0.2];
        UIView *loadingBgView = [self sui_getAssociatedObjectWithKey:loadingHubViewKey];

        loadingBgView =[[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2-60, kScreenHeight/2-20,120,80)];
        [self sui_setAssociatedRetainObject:loadingBgView key:loadingHubViewKey];
        UIImage *image = [UIImage imageNamed:@"loadingComplete"];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, 0, 40, 40)];
        imageView.image = image;
        [loadingBgView addSubview:imageView];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 42, 120, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:15];
        label.textColor = UIColorFromRGB(0xcccccc);
        label.text = hideText;
        [loadingBgView addSubview:label];
        loadingBgView.hidden=NO;
        [[UIApplication sharedApplication].keyWindow addSubview:loadingBgView];
        [self performSelector:@selector(mb_hideLoadingView) withObject:self afterDelay:1];
        
        
    }else{
        [loadingHub hide:YES afterDelay:0.8];
        
    }
}

- (void)mb_hideLoadingView{
    UIView *loadingBgView = [self sui_getAssociatedObjectWithKey:loadingHubViewKey];
    loadingBgView.hidden=YES;
}



@end



