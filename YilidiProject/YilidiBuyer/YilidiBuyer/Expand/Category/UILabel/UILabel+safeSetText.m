//
//  UILabel+safeSetText.m
//  YilidiBuyer
//
//  Created by mm on 17/5/5.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "UILabel+safeSetText.h"

@implementation UILabel (safeSetText)

- (void)kj_safeSetText:(NSString *)text {
    
    if (isEmpty(text)) {
        text = @"";
    }
    self.text = text;
}

@end
