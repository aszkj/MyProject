//
//  individualSignView.m
//  jingGang
//
//  Created by thinker on 15/10/27.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "individualSignView.h"

@interface individualSignView ()

@end

@implementation individualSignView
- (IBAction)signAction:(id)sender
{
    self.hidden = YES;
    if (self.signBlock)
    {
        self.signBlock(self.integral);
    }
}
- (void)setIntegral:(NSInteger)integral
{
    _integral = integral;
    self.signJifenLabel.attributedText = [self getAttributeString:[NSString stringWithFormat:@"今日签到获得%ld积分",integral] atIntegral:integral];
}
- (void)setDay:(NSInteger)day
{
    _day = day;
    self.signDateLabel.attributedText = [self getAttributeString:[NSString stringWithFormat:@"连续签到%ld天",day] atIntegral:day];
}

- (NSAttributedString *)getAttributeString:(NSString *)orignStr atIntegral:(NSInteger)integral {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:orignStr];
    NSDictionary *attributeDict = [ NSDictionary dictionaryWithObjectsAndKeys:
                                   [UIFont systemFontOfSize:22.0],NSFontAttributeName,
                                   [UIColor redColor],NSForegroundColorAttributeName,nil
                                   ];
    NSRange range = [attributedString.string rangeOfString:[@(integral) stringValue]];
    [attributedString addAttributes:attributeDict range:range];
    return attributedString.copy;
}



@end
