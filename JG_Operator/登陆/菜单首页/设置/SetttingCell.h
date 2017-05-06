//
//  SetttingCell.h
//  Operator_JingGang
//
//  Created by 鹏 朱 on 15/9/19.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKO_BaseTableViewCell.h"

@interface SetttingCell : XKO_BaseTableViewCell

@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *content;
@property (strong, nonatomic) UIImageView *sharImg;

// 赋值
- (void)resetDataAndFrame:(NSString *)invitaeCode;

// 获取cell高度
- (CGFloat)getHeightOfCell;
    
@end
