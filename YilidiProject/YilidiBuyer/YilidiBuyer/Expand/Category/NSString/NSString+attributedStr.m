//
//  NSString+attributedStr.m
//  YilidiBuyer
//
//  Created by mm on 17/5/2.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "NSString+attributedStr.h"

@implementation NSString (attributedStr)

- (NSAttributedString *)kj_attributedStrInRange:(NSRange)range
                                     attributes:(NSDictionary *)attributes
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self];
    [attrStr addAttributes:attributes range:range];
    return (NSAttributedString *)attrStr;
}
- (NSAttributedString *)kj_attributedStrInRange:(NSRange)range
                                           font:(UIFont *)font
                                          color:(UIColor *)color
{

    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName : color,
                                 NSFontAttributeName : font
                                 };
    return [self kj_attributedStrInRange:range attributes:attributes];

}
- (NSAttributedString *)kj_attributedStrInRange:(NSRange)range
                                          color:(UIColor *)color
{

    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName : color
                                 };
    return [self kj_attributedStrInRange:range attributes:attributes];


}

@end
