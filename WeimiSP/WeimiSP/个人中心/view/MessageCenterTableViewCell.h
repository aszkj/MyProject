//
//  MessageCenterTableViewCell.h
//  WeimiSP
//
//  Created by thinker on 16/2/23.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    MessageCenterTypeCompany, //公司指令
    MessageCenterTyepPlatform //平台消息
} MessageCenterType;

@interface MessageCenterTableViewCell : UITableViewCell

- (void)CellCustomWithType:(MessageCenterType)type WithData:(NSString *)content;

@end
