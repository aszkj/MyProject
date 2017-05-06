//
//  HMSegmentedControl+setAttribute.m
//  jingGang
//
//  Created by 张康健 on 15/8/7.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "HMSegmentedControl+setAttribute.h"


@implementation HMSegmentedControl (setAttribute)

-(void)setDefaultAtrribute
{
    self.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
    self.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.selectionIndicatorColor = status_color;
    self.selectedTextColor = status_color;
    CGFloat titleFont = 16.0f;
    if (iPhone4 || iPhone5) {
        titleFont = 14;
    }
    self.font = [UIFont systemFontOfSize:titleFont];
    self.selectionIndicatorHeight = 4.0f;
}

@end
