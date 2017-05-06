//
//  MERHomePageEntity.m
//  jingGang
//
//  Created by ray on 15/10/21.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "MERHomePageEntity.h"
#import <UIKit/UIKit.h>
#import "PublicInfo.h"
#import "NSDate+Utilities.h"

@implementation MERHomePageEntity


- (void)setCreatetime:(NSString *)createtime
{
    _createtime = createtime;
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [fmt dateFromString:createtime];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%2d/%2d \n %ld",(int)date.month,(int)date.day,date.year] attributes:[ NSDictionary dictionaryWithObjectsAndKeys:status_color,NSForegroundColorAttributeName,nil]];
    NSDictionary *attributeDict = [ NSDictionary dictionaryWithObjectsAndKeys:
                                   //                                   [UIFont systemFontOfSize:15.0],NSFontAttributeName,
                                   [UIColor whiteColor],NSForegroundColorAttributeName,
                                   nil
                                   ];
    NSRange range = [attributedString.string rangeOfString:@"\n"];
    range = NSMakeRange(range.location, attributedString.length - range.location);
    [attributedString addAttributes:attributeDict range:range];
    _reportTimeAttributedString = attributedString.copy;
}
@end
