//
//  XKJHPullMenuView.m
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/7.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHPullMenuView.h"
#import "XKJHPullCell.h"
#import "UIButton+Block.h"
#import "UIView+BlockGesture.h"
#import <Masonry/Masonry.h>
#import "GlobeMaco.h"
#define pullSelectcellHeight 31
static NSString *XKJHPullCellID = @"XKJHPullCellID";

@interface XKJHPullMenuView()<UITableViewDelegate,UITableViewDataSource>{

}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *maskView;

@end

@implementation XKJHPullMenuView

+ (id)showDownView:(UIView *)downView inContentView:(UIView *)contentView selectDatas:(NSArray *)selectData
{

    XKJHPullMenuView *pullMenuView = [self pullMenuView];
    [contentView addSubview:pullMenuView];
    [pullMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(downView.mas_bottom);
        make.left.right.mas_equalTo(downView);
        make.height.mas_equalTo(pullSelectcellHeight * 3+500);
    }];
    
    pullMenuView.pullDatas = [NSMutableArray arrayWithArray:selectData];
    
    return pullMenuView;
}

-(void)setPullDatas:(NSMutableArray *)pullDatas {
    
    _pullDatas = pullDatas;
    self.tableHeightConstraint.constant = pullSelectcellHeight * pullDatas.count + 10;
    [self reloadData];
}

-(void)layoutSubviews {
    
   [super layoutSubviews];
    
}


+(XKJHPullMenuView *)pullMenuView {
    
    return BoundNibView(@"XKJHPullMenuView", XKJHPullMenuView);
    
}


-(void)awakeFromNib {
    
    [self.pullTableView registerNib:[UINib nibWithNibName:@"XKJHPullCell" bundle:nil] forCellReuseIdentifier:XKJHPullCellID];
    [self insertSubview:self.maskView atIndex:0];
    WEAK_SELF
    [self.maskView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        weak_self.hidden = YES;
    }];
    self.pullTableView.rowHeight = 31;
    self.pullTableView.delegate = self;
    self.pullTableView.dataSource = self;
}

-(void)reloadData {
    
    [self.pullTableView reloadData];
    
}


#pragma mark ----------------------- table delegate & datasource --------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pullDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XKJHPullCell *cell = [self.pullTableView dequeueReusableCellWithIdentifier:XKJHPullCellID forIndexPath:indexPath];
    NSString *text = self.pullDatas[indexPath.row];
    cell.itemLabel.text = text;
    WEAK_SELF
    [cell.actionButton addActionHandler:^(NSInteger tag) {
        if (weak_self.clickIndexPathBlock) {
            weak_self.clickIndexPathBlock(text);
            weak_self.hidden = YES;
        }
    }];
    cell.deleteButton.tag = indexPath.row;
    [cell.deleteButton addActionHandler:^(NSInteger tag) {
        if (weak_self.deleteItemBlock) {
            weak_self.deleteItemBlock(tag);
        }
    }];
    
    return cell;
}

//-(void)_deleteIndexPath:(NSInteger )indexRow {
//    NSLog(@"delete index %ld",indexRow);
//    NSLog(@"%@",self.pullDatas);
//#pragma mark -warn 这里犯了一个致命错误导崩溃，self.pullDatas是可变数组，但你property中用的是copy，那么在用点语法的时候，他肯定会被拷贝，，但拷贝的是一份不可变数组，因为你用的是copy,不可变数组当然不能对其进行删除元素操作，所以谨记
//    [self.pullDatas removeObjectAtIndex:indexRow];
//    [self.pullTableView reloadData];
//    
//    if (self.deleteItemBlock) {
//        self.deleteItemBlock(indexRow);
//    }
//
//}




@end
