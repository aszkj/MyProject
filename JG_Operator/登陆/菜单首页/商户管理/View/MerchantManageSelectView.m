//
//  MerchantManageSelectView.m
//  Operator_JingGang
//
//  Created by 张康健 on 15/9/20.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "MerchantManageSelectView.h"
#import "UIColor+UIImage.h"

@interface MerchantManageSelectView() {

    NSArray *_buttonArr;

}

@property (weak, nonatomic) IBOutlet UIButton *lishuShanghuButton;
@property (weak, nonatomic) IBOutlet UIButton *xianeiShanghuButton;

@end

@implementation MerchantManageSelectView


-(void)awakeFromNib {
    //kGetColor(196, 237, 244)
    _buttonArr = @[_lishuShanghuButton,_xianeiShanghuButton];
}

- (IBAction)selectAction:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    UIButton *lastSelectButton = [Util getSeletedButtonAtBtnArr:_buttonArr];
    lastSelectButton.selected = NO;
    
    sender.selected = YES;
    
    NSInteger selectedIndex = [_buttonArr indexOfObject:sender];
    if (self.selectTopWitchBlock) {
        self.selectTopWitchBlock(selectedIndex);
    }
}



@end
