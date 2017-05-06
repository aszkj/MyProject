//
//  ComplainSelectedCell.h
//  jingGang
//
//  Created by dengxf on 15/10/31.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ComplainSelectedCell;

@protocol ComplainSelectedCellDelegate<NSObject>

//  选择某一投诉类型--
- (void)complainSelectedCell:(ComplainSelectedCell *)complainSelectedCell didSelectedCells:(NSIndexPath *)selectedCell;

//  取消选择某一投诉类型---
- (void)complainSelectedCell:(ComplainSelectedCell *)complainSelectedCell didCancelSelectedCells:(NSIndexPath *)cancelSelectedCells;


@end

@interface ComplainSelectedCell : UITableViewCell

@property (assign, nonatomic) id<ComplainSelectedCellDelegate> delegate;

// 点击cell设置为显示、隐藏标记--
- (void)stSelectedWithIndexPath:(NSIndexPath *)indexPath;

- (void)hiddenSelectedIndexPath;

@end
