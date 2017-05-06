//
//  WSJCollectionMerchantTableViewCell.h
//  jingGang
//
//  Created by thinker on 15/9/9.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSJCollectionMerchantTableViewCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *index;
//取消收藏
@property (nonatomic, copy) void(^cancelCollection)(NSIndexPath *index);

- (void) willCustomCellWithData:(NSDictionary *)dict;

@end
