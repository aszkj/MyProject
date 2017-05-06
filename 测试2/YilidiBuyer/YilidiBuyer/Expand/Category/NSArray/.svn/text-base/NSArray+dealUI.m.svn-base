//
//  NSArray+dealUI.m
//  YilidiBuyer
//
//  Created by mm on 16/10/23.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "NSArray+dealUI.h"

@implementation NSArray (dealUI)

- (void)changeFontSizeInUIArrForDetaFontNumber:(CGFloat)detaFontSize {
    
    for (id arrView in self) {
        if ([arrView isMemberOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)arrView;
            label.font = [UIFont systemFontOfSize:label.font.pointSize+detaFontSize];
        }else if ([arrView isMemberOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)arrView;
            button.titleLabel.font =[UIFont systemFontOfSize:button.titleLabel.font.pointSize+detaFontSize];
        }
    }
}


@end
