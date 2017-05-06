//
//  TakeRecordTableViewCell.h
//  Merchants_JingGang
//
//  Created by thinker on 15/9/6.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XKJHTakeStatus) {
    XKJHTakeStatusUnknown   = -2,
    XKJHTakeStatusWait      = 0,
    XKJHTakeStatusSuccess   = 1,
    XKJHTakeStatusFail      = -1,
};

@interface TakeRecordTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *takeRecordLabel;
@property (nonatomic) XKJHTakeStatus takeStatus;

- (void)configData:(id)object;

@end
