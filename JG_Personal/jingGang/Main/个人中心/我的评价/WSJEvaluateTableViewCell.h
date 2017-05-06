//
//  WSJEvaluateTableViewCell.h
//  jingGang
//
//  Created by thinker on 15/8/17.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSJEvaluateModel.h"

@interface WSJEvaluateTableViewCell : UITableViewCell

- (void) willCellWithModel:(WSJEvaluateModel *)model;

//点击追加block回调
@property (nonatomic, copy) void (^supplementBlock)(void);
//点击进入商品详情
@property (nonatomic, copy) void (^shopDetailBlock)(NSNumber *ID);

@end
