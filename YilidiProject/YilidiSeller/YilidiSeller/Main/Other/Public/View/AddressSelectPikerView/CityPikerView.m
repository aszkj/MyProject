//
//  CityPikerView.m
//  uipickerView
//
//  Created by yld on 16/4/7.
//  Copyright © 2016年 wujianqiang. All rights reserved.
//

#import "CityPikerView.h"
#import "AddressView.h"

@interface CityPikerView()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addressViewToBottomConstraint;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet AddressView *addressView;

@end

@implementation CityPikerView

- (void)awakeFromNib {
    self.addressViewToBottomConstraint.constant = -240;
}

- (IBAction)sureAction:(id)sender {
    [self _downAnimation];
    if (self.selectRegionBlock) {
        self.selectRegionBlock(self.addressView.provinceDic,self.addressView.cityDic,self.addressView.areaDic);
    }
}

- (IBAction)cancelAction:(id)sender {
    [self _downAnimation];
}

- (void)hide {
    [self _downAnimation];
}

- (void)show {
    
    [self performSelector:@selector(_upAnimation) withObject:nil afterDelay:0.3];
}

- (void)_upAnimation {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.addressViewToBottomConstraint.constant = 0;
        self.maskView.hidden = NO;
        [self layoutIfNeeded];
    }];
}

- (void)_downAnimation {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.addressViewToBottomConstraint.constant = -240;
        [self performSelector:@selector(_downConfigure) withObject:nil afterDelay:0.5];
        [self layoutIfNeeded];
    }];
}

- (void)_downConfigure {
    self.maskView.hidden = YES;
    [self removeFromSuperview];

}

@end
