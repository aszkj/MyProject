//
//  NSString+attributedStr.h
//  YilidiBuyer
//
//  Created by mm on 17/5/2.
//  Copyright © 2017年 yld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (attributedStr)

- (NSAttributedString *)kj_attributedStrInRange:(NSRange)range
                                     attributes:(NSDictionary *)attributes;
- (NSAttributedString *)kj_attributedStrInRange:(NSRange)range
                                           font:(UIFont *)font
                                          color:(UIColor *)color;
- (NSAttributedString *)kj_attributedStrInRange:(NSRange)range
                                          color:(UIColor *)color;


@end
