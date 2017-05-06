//
//  ListSelectOperator.h
//  YilidiBuyer
//
//  Created by mm on 17/2/20.
//  Copyright © 2017年 yld. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BaseModel;
@class MycommonTableView;
@interface ListSelectOperator : NSObject


/**
 初始化要选中的表，以及所有选中button
 */
- (instancetype)initItemTableView:(MycommonTableView *)itemTableView
                  allSelectButton:(UIButton *)allSelectButton;

#pragma mark - 选择删除
/**
 选中取消选中所有的
 */
- (void)allItemSelected:(BOOL)selected;

/**
 选中取消选中单个的
 */
- (void)select:(BOOL)select item:(BaseModel *)item;

/**
 重置所有选中的，一般下拉刷新网络请求后，需要重置所有的选中
 */
- (void)resetAllSelectedItems;

/**
 删除所有选中的,一般对选中的项操作后需要删除，然后调用
 */
- (void)deleteSelectItems;

/**
 获得所有选中的
 */
- (NSArray *)getSelectedItems;

#pragma mark - 滑动删除的
- (void)setSwipItem:(BaseModel *)swipItem;

- (void)deleteSwipItem;




@end
