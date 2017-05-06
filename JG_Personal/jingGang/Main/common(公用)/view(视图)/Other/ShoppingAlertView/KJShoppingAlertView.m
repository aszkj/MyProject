//
//  KJShoppingAlertView.m
//  jingGang
//
//  Created by 张康健 on 15/8/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "KJShoppingAlertView.h"
#import "Masonry.h"
#import "GlobeObject.h"

@implementation KJShoppingAlertView

+ (void)showAlertTitle:(NSString *)title inContentView:(UIView *)contentView{
    
    KJShoppingAlertView *sel = [self shareAlertView];
    
    sel.alertLabel.text = title;
    
    [contentView addSubview:sel];
    [sel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(CGSizeMake(320, 320));
        make.center.mas_equalTo(contentView);
    }];
    
    [sel performSelector:@selector(alertEndWithAnimation) withObject:nil afterDelay:0.7];
    
}


+ (KJShoppingAlertView *)shareAlertView {

    return BoundNibView(@"KJShoppingAlertView", KJShoppingAlertView);

}


-(void)alertEndWithAnimation{

   [UIView animateWithDuration:0.3 animations:^{
       
       self.bgView.transform = CGAffineTransformMakeScale(0.7, 0.7);
       
   } completion:^(BOOL finished) {
       
       self.bgView.alpha = 0.0;
       [self removeFromSuperview];
       
   }];
}



@end
