//
//  XKJHShopCategoryTableViewCell.h
//  Merchants_JingGang
//
//  Created by thinker on 15/9/7.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XKJHShopCategoryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleNameLabel;
//选中该行进行回调
@property (nonatomic, copy) void(^selectBlock)(BOOL b);

@end
