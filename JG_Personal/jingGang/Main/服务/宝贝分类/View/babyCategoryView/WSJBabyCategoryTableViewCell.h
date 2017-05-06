//
//  WSJBabyCategoryTableViewCell.h
//  jingGang
//
//  Created by thinker on 15/8/6.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSJBabyCategoryTableViewCell : UITableViewCell

@property (nonatomic, copy) NSArray *data;

@property (nonatomic, copy) void (^selectAction)(NSInteger indx);
@end
