//
//  OrderDetailHeader.m
//  jingGang
//
//  Created by 鹏 朱 on 15/9/11.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "OrderDetailHeader.h"
#import "urlManagerHeader.h"

@implementation OrderDetailHeader

- (id)initWithFrame:(CGRect)frame title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *headerBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 55)];
        headerBackView.backgroundColor = VCBackgroundColor;
        [self addSubview:headerBackView];
        
        UIView *contentBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, __MainScreen_Width, 44)];
        contentBackView.backgroundColor = [UIColor whiteColor];
        [self addSubview:contentBackView];
        
        UILabel *titleLb = [UILabel new];
        titleLb.font = kFontSize16;
        titleLb.text = title;
        titleLb.textColor = KColorText999999;
        [contentBackView addSubview:titleLb];
        [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(contentBackView.mas_centerY);
            make.left.equalTo(contentBackView.mas_left).with.offset(KMarginLeft);
            make.width.equalTo(@100);
        }];
    }
    return self;
}

@end
