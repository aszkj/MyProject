//
//  AcceptOrdeCell.h
//  weimi
//
//  Created by ray on 16/1/18.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WEMEFeed.h>
#import <WEMEReply.h>
#import "WEMEModelExtension.h"

@class AcceptOrdeEntity;
@class YYLabel;
@interface AcceptOrdeCell : UITableViewCell

typedef NS_ENUM(NSInteger,WeimiMessageType) {
    WeimiMessageTypeText = 1,
    WeimiMessageTypeVoice = 2,
    WeimiMessageTypeImage = 3,
};
typedef void (^DeleteBlock)();

@property (nonatomic) UILabel *timeLabel;
@property (nonatomic) UIButton *deleteImageBtn;
@property (nonatomic) UILabel *contentLabel;
@property (nonatomic, copy) DeleteBlock deleteBlock;

/**
 *  设置内容
 *
 *  @param entity  类型为WEMEFeed是主题类型,WEMEReply是回复类型
 */
- (void)setEntity:(AcceptOrdeEntity *)entity;

@end

@interface WeimiAcceptOrdeTableViewCell : AcceptOrdeCell



@end
