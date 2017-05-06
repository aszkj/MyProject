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
    self.font = [UIFont systemFontOfSize:16];
    self.selectionIndicatorHeight = 4.0f;
    
}

- (void)autoAdapTitleWidthStyle {
    
    CGFloat topTitleTotalWidth = 0.0f;
    UIFont *calFont = self.font;
    for (NSString *titleString in self.sectionTitles) {
        CGFloat stringWidth = [titleString sizeWithAttributes:@{NSFontAttributeName: calFont}].width + 10;
        topTitleTotalWidth += stringWidth;
    }
    self.segmentWidthStyle = topTitleTotalWidth < [UIScreen mainScreen].bounds.size.width ? HMSegmentedControlSegmentWidthStyleFixed : HMSegmentedControlSegmentWidthStyleDynamic;
    
}


@end
