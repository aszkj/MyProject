//
//  RTTwoNodeView.m
//  JingGangIB
//
//  Created by thinker on 15/9/11.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "RTTwoNodeView.h"
#import "Masonry.h"
#import "PublicInfo.h"

@interface RTTwoNodeView () <UITableViewDelegate,UITableViewDataSource>



@end

static NSString *cellid = @"TiteOnlyCell";
#define tableGrayColor UIColorFromRGB(0xf5f5f5)

@implementation RTTwoNodeView

- (instancetype)initWithMainArray:(NSArray *)mainArray secondArray:(NSArray *)secondArray{
    if (self = [super init]) {
        _mainArray = mainArray;
        _secondArray = secondArray;
        [self addSubview:self.mainTableView];
        [self addSubview:self.secondTableView];
        [self setViewsMASConstraint];
    }
    return self;
}

- (void)setMainSelectIndex:(NSInteger)mainSelectIndex {
    [self.mainTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:mainSelectIndex inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
}
- (void)setSecondSelectIndex:(NSInteger)secondSelectIndex {
    [self.secondTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:secondSelectIndex inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self getHeightTableView:tableView atIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self getHeightTableView:tableView atIndexPath:indexPath];
}

- (CGFloat)getHeightTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    return 46;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.mainTableView && self.maincellBlock) {
        self.maincellBlock(indexPath.row);
    } else if (tableView == self.secondTableView && self.secondcellBlock) {
        self.secondcellBlock(indexPath.row);
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.mainTableView) {
        return self.mainArray.count;
    } else {
        return self.secondArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
    }
    
    if (self.mainTableView == tableView) {
        cell.textLabel.text = self.mainArray[indexPath.row];
        if (self.secondArray == nil) {
            cell.separatorInset = UIEdgeInsetsZero;
        }

    } else {
        cell.textLabel.text = self.secondArray[indexPath.row];
        cell.contentView.backgroundColor = tableView.backgroundColor;
        cell.textLabel.highlightedTextColor = status_color;

    }
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = tableGrayColor;
    cell.textLabel.textColor = textBlackColor;
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    return cell;
}

- (void)tapDisppear {
    if (self.superview) {
        [self removeFromSuperview];
    }
}

- (void)setViewsMASConstraint {
    UIView *superView = self;
    UIView *toplineView = [self colorView:UIColorFromRGB(0xdcdcdc)];
    [superView addSubview:toplineView];
    [toplineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.top.equalTo(superView);
        make.height.equalTo(@(0.5));
    }];
    [self.mainTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView);
        if (self.mainArray.count > 6) {
            make.height.equalTo(@(46*6));
        } else {
            make.height.equalTo(@(46*self.mainArray.count));
        }
        if(self.secondArray == nil) {
            make.right.equalTo(superView);
        } else {
            make.right.equalTo(superView.mas_centerX);
        }
        make.top.equalTo(toplineView.mas_bottom);
    }];
    [self.secondTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainTableView.mas_right);
        make.height.equalTo(self.mainTableView);
        make.right.equalTo(superView);
        make.top.equalTo(toplineView.mas_bottom);
    }];
    UIView *blackView = [self colorView:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDisppear)];
    [blackView addGestureRecognizer:tap];
    [superView addSubview:blackView];
    
    [blackView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mainTableView.mas_bottom);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.bottom.equalTo(superView);
    }];
}

- (void)setMainArray:(NSArray *)mainArray {
    _mainArray = mainArray;
    if (mainArray != nil) {
        [self.mainTableView reloadData];
    }
}

- (void)setSecondArray:(NSArray *)secondArray {
    _secondArray = secondArray;
    if (secondArray != nil) {
        [self.secondTableView reloadData];
    }
}

- (UIView *)colorView:(UIColor *)backgroundColor {
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = backgroundColor;
    return view;
}

- (UITableView *)mainTableView {
    if (_mainTableView == nil) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        _mainTableView.estimatedRowHeight = 45.5;
        _mainTableView.rowHeight = 45.5;
        _mainTableView.backgroundColor = [UIColor whiteColor];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (_secondArray == nil) {
            _mainTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            _mainTableView.separatorColor = UIColorFromRGB(0xdcdcdc);
        }
        
        UIView *footView = [UIView new];
        footView.backgroundColor = [UIColor clearColor];
        [_mainTableView setTableFooterView:footView];
    }
    return _mainTableView;
}

- (UITableView *)secondTableView {
    if (_secondTableView == nil) {
        _secondTableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _secondTableView.dataSource = self;
        _secondTableView.delegate = self;
        _secondTableView.estimatedRowHeight = 45.5;
        _secondTableView.rowHeight = 45.5;
        _secondTableView.backgroundColor = tableGrayColor;
        _secondTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        UIView *footView = [UIView new];
        footView.backgroundColor = [UIColor clearColor];
        [_mainTableView setTableFooterView:footView];
    }
    return _secondTableView;
}


@end
