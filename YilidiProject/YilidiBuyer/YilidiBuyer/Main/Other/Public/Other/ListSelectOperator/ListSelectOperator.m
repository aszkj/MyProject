//
//  ListSelectOperator.m
//  YilidiBuyer
//
//  Created by mm on 17/2/20.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "ListSelectOperator.h"
#import "BaseModel.h"
#import "MycommonTableView.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ListSelectOperator ()


@property (nonatomic,strong)NSMutableArray *selectItems;

@property (nonatomic,strong)MycommonTableView *itemTableView;

@property (nonatomic,strong) BaseModel *swipDeleteItem;

@property (nonatomic,strong)UIButton *allSelectButton;

@property (nonatomic,assign)BOOL isAllSelect;

@end

@implementation ListSelectOperator

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _init];
    }
    return self;
}

- (instancetype)initItemTableView:(MycommonTableView *)itemTableView allSelectButton:(UIButton *)allSelectButton
{
    self = [super init];
    if (self) {
        self.itemTableView = itemTableView;
        self.allSelectButton = allSelectButton;
        [self _init];
    }
    return self;
}

- (void)_init {
    RAC(self.allSelectButton,selected) = RACObserve(self, isAllSelect);
}

#pragma mark ---------------------Public Method------------------------------
- (void)resetAllSelectedItems {

    [[self allItems] setIndexPathInselfContainer];
    self.allSelectButton.selected = NO;

}

- (void)select:(BOOL)select item:(BaseModel *)item {
    item.selected = select;
    if (select) {
        [self.selectItems addObject:item];
        self.isAllSelect = self.selectItems.count == [[self allItems] count];
    }else {
        if (self.selectItems.count >= 1) {
            [self.selectItems removeObject:item];
        }
        self.isAllSelect = NO;
    }
}

- (void)allItemSelected:(BOOL)selected {

    _isAllSelect = selected;
    [self _allItemSelect:selected];
    [self.itemTableView reloadData];
    
}



- (void)deleteSelectItems {
    
    NSMutableArray *willUpdateIndexPaths = [NSMutableArray arrayWithCapacity:self.selectItems.count];
    NSMutableIndexSet *willUpdateIndexSets = [[NSMutableIndexSet alloc] init];
    [self.selectItems enumerateObjectsUsingBlock:^(BaseModel* model, NSUInteger idx, BOOL * _Nonnull stop) {
            [willUpdateIndexPaths addObject:model.modelAtIndexPath];
            [willUpdateIndexSets addIndexes:[NSIndexSet indexSetWithIndex:model.modelAtIndexPath.row]];
    }];
    if (willUpdateIndexSets.count > 0) {
        
        [[self allItems] removeObjectsAtIndexes:willUpdateIndexSets];
        [self.selectItems removeAllObjects];
        [self.itemTableView deleteRowsAtIndexPaths:willUpdateIndexPaths withRowAnimation:UITableViewRowAnimationNone];
        [[self allItems] setIndexPathInselfContainer];
    }
}



- (void)setSwipItem:(BaseModel *)swipItem {
    
    self.swipDeleteItem = swipItem;

}

- (void)deleteSwipItem {

    if (self.swipDeleteItem) {
        if (self.swipDeleteItem.selected) {//滑动时选中了
            if (self.selectItems.count >= 1) {
                [self.selectItems removeObject:self.swipDeleteItem];
            }
        }
        [[self allItems] removeObject:self.swipDeleteItem];
        [self.itemTableView deleteRowsAtIndexPaths:@[self.swipDeleteItem.modelAtIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [[self allItems] setIndexPathInselfContainer];
    }
}



#pragma mark ---------------------Private Method------------------------------
- (void)_allItemSelect:(BOOL)select{
    NSMutableArray *allItems = [self allItems];
    for (BaseModel *item in allItems) {
        item.selected = select;
    }
    [self.selectItems removeAllObjects];
    if (select) {
        [self.selectItems addObjectsFromArray:self.allItems];
    }
}


#pragma mark ---------------------Setter/Getter Method------------------------------
- (NSMutableArray *)allItems {
    return self.itemTableView.dataLogicModule.currentDataModelArr;
}

- (NSMutableArray *)selectItems {
    
    if (!_selectItems) {
        _selectItems = [NSMutableArray arrayWithCapacity:0];
    }
    return _selectItems;
}

- (NSArray *)getSelectedItems {
    return [self.selectItems copy];
}


@end
