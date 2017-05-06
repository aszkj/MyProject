//
//  DownToUpAlertView.m
//  jingGang
//
//  Created by 张康健 on 15/12/15.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "DownToUpAlertView.h"
#import "Masonry.h"
#import "GlobeObject.h"

@interface DownToUpAlertView()

@property (weak, nonatomic) IBOutlet UILabel *alertLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alertViewToBottonGap;

@end

@implementation DownToUpAlertView

+ (void)showAlertTitle:(NSString *)title inContentView:(UIView *)contentView{
    
    DownToUpAlertView *sel = [self shareAlertView];
    
    sel.alertLabel.text = title;
    [contentView addSubview:sel];
    sel.alertViewToBottonGap.constant = 20;
    sel.bgView.hidden = YES;
    [sel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(contentView);
    }];
    [contentView bringSubviewToFront:sel];
    [sel performSelector:@selector(alertBeginWithAnimation) withObject:nil afterDelay:0.7];
    
}


+ (DownToUpAlertView *)shareAlertView {
    
    return BoundNibView(@"DownToUpAlertView", DownToUpAlertView);
    
}


-(void)alertBeginWithAnimation{
        
    [UIView animateWithDuration:0.3 animations:^{
        self.alertViewToBottonGap.constant = 117;
        self.bgView.hidden = NO;
        [self layoutIfNeeded];

    } completion:^(BOOL finished) {
        [self performSelector:@selector(_endAnimationConfigure) withObject:nil afterDelay:1.5];
    }];
}

-(void)_endAnimationConfigure {
    self.bgView.alpha = 0.0;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self removeFromSuperview];


}


@end
