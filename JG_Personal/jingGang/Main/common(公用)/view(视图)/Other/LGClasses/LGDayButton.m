//
//  LGDayButton.m
//  TestArrayCalendar
//
//  Created by AQ on 15-1-18.
//  Copyright (c) 2015年 AQ. All rights reserved.
//

#import "LGDayButton.h"
#import "LGCancelDateButton.h"
@implementation LGDayButton

+ (id)buttonWithType:(UIButtonType)buttonType
{
    LGDayButton *btn = [super buttonWithType:buttonType];
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:[btn titleFont]];
    label.hidden = YES;
    [btn addSubview:label];
    btn.worldDayLabel = label;
    
    label = [[UILabel alloc] init];
    label.hidden = YES;
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:[btn titleFont]*3/4];
    [btn addSubview:label];
    btn.chiDayLabel = label;
//    UIButton *btnTemp = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    return btn;
}

- (CGFloat)titleFont
{
    CGFloat widthTemp = [UIScreen mainScreen].bounds.size.width;
    CGFloat fontTemp = 0;
    if(widthTemp<=320)
    {
        fontTemp = 12;
    }
    else if(widthTemp<=375)
    {
        fontTemp = 14;
    }
    else
    {
        fontTemp = 16;
    }
    
    return fontTemp;
    
}

- (void)layoutSubviews
{
    self.worldDayLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/2);
    self.chiDayLabel.frame = CGRectMake(0, self.frame.size.height/2, self.frame.size.width, self.frame.size.height/2);
}

@end
