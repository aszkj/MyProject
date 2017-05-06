//
//  WeimiMainTableViewCell.h
//  weimi
//
//  Created by ray on 16/1/18.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WEMEFeed.h>
#import <WEMEReply.h>
#import "WEMEModelExtension.h"

@interface WeimiMainTableViewCell : UITableViewCell

typedef NS_ENUM(NSInteger,WeimiMessageType) {
    WeimiMessageTypeText = 1,
    WeimiMessageTypeVoice = 2,
    WeimiMessageTypeImage = 3,
};

typedef void (^DeleteBlock)();
//typedef void (^GroupResponseBlock)();

@property (nonatomic) CAShapeLayer *hasReadLayer;
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UIImageView *avatarImage;
@property (nonatomic, copy) DeleteBlock deleteBlock;
@property (nonatomic) WeimiMessageType feedType;

/**
 *  设置内容
 *
 *  @param entity  类型为WEMEFeed是主题类型,WEMEReply是回复类型
 */
- (void)setEntity:(id)entity;

@end

@interface WeimiMainFeedTableViewCell : WeimiMainTableViewCell



@end
