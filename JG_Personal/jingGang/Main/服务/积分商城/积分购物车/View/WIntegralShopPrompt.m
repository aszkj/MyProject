//
//  WIntegralShopPrompt.m
//  jingGang
//
//  Created by thinker on 15/10/29.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "WIntegralShopPrompt.h"

#import "PublicInfo.h"

@implementation WIntegralShopPrompt

-(void)awakeFromNib
{
    self.backgroundColor = background_Color;
}
- (IBAction)suibiankankan:(id)sender {
    if (self.goShoppint) {
        self.goShoppint();
    }
}

@end
