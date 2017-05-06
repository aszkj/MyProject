//
//  HMSegmentedControl+setAttribute.m
//  jingGang
//
//  Created by 张康健 on 15/8/7.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "HMSegmentedControl+setAttribute.h"
#import "GlobeObject.h"

@implementation HMSegmentedControl (setAttribute)

-(void)setDefaultAtrribute
{
    self.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
    self.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.selectionIndicatorColor = kGetColor(94, 180, 231);
    self.selectedTextColor = kGetColor(94, 180, 231);
    self.font = [UIFont systemFontOfSize:16];
    self.selectionIndicatorHeight = 4.0f;
    
}

@end
