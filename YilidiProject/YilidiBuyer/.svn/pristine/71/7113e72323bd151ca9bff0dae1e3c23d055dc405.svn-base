//
//  DLClosingAlertView.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/8/4.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLClosingAlertView.h"
#import "UIView+BlockGesture.h"
#import "GlobleConst.h"

@interface DLClosingAlertView()
@property (strong, nonatomic) IBOutlet UILabel *alertTitleLabel;

@end

@implementation DLClosingAlertView

- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *bgView = [self viewWithTag:1];
    WEAK_SELF
    [bgView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weak_self _hide];
    }];
}

- (void)setAlertTitle:(NSString *)alertTitle {
    _alertTitle = alertTitle;
    if (kCurrentShipWay == ShipWay_DeliveryGoodsHome) {
        self.alertTitleLabel.attributedText = [self _attributedAlertTitle];
    }else {
        self.alertTitleLabel.text = _alertTitle;
    }
}

- (NSAttributedString *)_attributedAlertTitle {
   
    NSRange storeBeginBusinessTimeRange = [_alertTitle rangeOfString:[kCurrentStore storeBeginShipTime]];
    NSMutableAttributedString * aAttributedString = [[NSMutableAttributedString alloc] initWithString:_alertTitle];
    if (storeBeginBusinessTimeRange.length > 0) {
        [aAttributedString addAttribute:NSFontAttributeName
                                  value:kSystemFontSize(14)
                                  range:storeBeginBusinessTimeRange];
        [aAttributedString addAttribute:NSForegroundColorAttributeName
                                  value:[UIColor yellowColor]
                                  range:storeBeginBusinessTimeRange];
    }
    return aAttributedString;
}

- (IBAction)confirmButtonClick:(id)sender {
    
    emptyBlock(self.closingBlock);
    [self _hide];
}

- (void)_hide{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    }];
    [self performSelector:@selector(setHidden:) withObject:@(YES) afterDelay:0.6];
}



@end
