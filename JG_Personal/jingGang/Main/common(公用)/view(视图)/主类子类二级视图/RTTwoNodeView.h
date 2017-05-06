//
//  RTTwoNodeView.h
//  JingGangIB
//
//  Created by thinker on 15/9/11.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MainCellBlock)(NSInteger index);
typedef void(^SecondCellBlock)(NSInteger index);

@interface RTTwoNodeView : UIView

@property (nonatomic) UITableView *mainTableView;
@property (nonatomic) UITableView *secondTableView;

@property (nonatomic) NSArray *mainArray;
@property (nonatomic) NSArray *secondArray;
@property (copy) MainCellBlock maincellBlock;
@property (copy) SecondCellBlock secondcellBlock;

- (void)setMainSelectIndex:(NSInteger)mainSelectIndex;
- (void)setSecondSelectIndex:(NSInteger)secondSelectIndex;

- (instancetype)initWithMainArray:(NSArray *)mainArray secondArray:(NSArray *)secondArray;

@end
