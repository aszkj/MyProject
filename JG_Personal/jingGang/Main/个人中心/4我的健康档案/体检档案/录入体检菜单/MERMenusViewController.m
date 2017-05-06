//
//  MERMenusViewController.m
//  jingGang
//
//  Created by ray on 15/10/20.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "MERMenusViewController.h"
#import "RTTwoNodeView.h"
#import "WMERSearchViewController.h"
#import "MERMenusViewModel.h"
#import "WInputMERViewController.h"
#import "WInputXingViewController.h"
#import "MERHomePageViewController.h"

@interface MERMenusViewController ()

@property (nonatomic) RTTwoNodeView *menuList;
@property (nonatomic) MERMenusViewModel *viewModel;

@end

@implementation MERMenusViewController
//NSInteger showViewTag = -1001;


#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.menuList];
    
    [self setViewsMASConstraint];
}

- (void)bindViewModel {
    [super bindViewModel];
    WEAK_SELF;
    [self.KVOController observe:self.viewModel keyPath:@"classArray" block:^(NSArray *newValue) {
        weak_self.menuList.mainArray = newValue;
    }];
    [self.KVOController observe:self.viewModel keyPath:@"detailArray" block:^(NSArray *newValue) {
        weak_self.menuList.secondArray = newValue;
    }];
    [self.viewModel getClassArrayRequest];
}

#pragma mark - event response
- (void)MERSearchAction {
    WMERSearchViewController *VC = [[WMERSearchViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)btnClick {
    NSArray *viewControllers = self.navigationController.viewControllers;
    UIViewController *VC = viewControllers[viewControllers.count-3];
    if ([VC isKindOfClass:[MERHomePageViewController class]]) {
        [self.navigationController popToViewController:VC animated:YES];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - CustomDelegate


#pragma mark - private methods

- (void)setUIAppearance {
    [super setUIAppearance];
    self.title = @"体检菜单";
    UIImage *searchImage = [UIImage imageNamed:@"MER_search"];
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, searchImage.size.width, searchImage.size.height)];
    [rightButton setImage:searchImage forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(MERSearchAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.menuList.mainTableView.separatorColor = [UIColor grayColor];
    self.menuList.mainTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (void)setViewsMASConstraint {
    [self.menuList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    UIView *superview = self.menuList;
    [self.menuList.mainTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superview);
        make.height.equalTo(superview);
        make.width.equalTo(@(145));
        make.top.equalTo(superview);
    }];
    [self.menuList.secondTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.menuList.mainTableView.mas_right);
        make.height.equalTo(self.menuList.mainTableView);
        make.right.equalTo(superview);
        make.top.equalTo(superview);
    }];
    /*[self.mainTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
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
    }];*/
}

#pragma mark - getters and settters

- (MERMenusViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[MERMenusViewModel alloc] init];
    }
    return _viewModel;
}

- (RTTwoNodeView *)menuList {
    if (_menuList == nil) {
        WEAK_SELF;
        _menuList = [[RTTwoNodeView alloc] initWithMainArray:@[@1,@2,@3] secondArray:@[@"12",@"wq"]];
        _menuList.maincellBlock = ^(NSInteger index) {
            [weak_self.viewModel getDetailArrayAtIndex:index];
        };
        _menuList.secondcellBlock = ^(NSInteger index) {
            ResultItem *reslutItem = weak_self.viewModel.resultItemBOArray[index];
            if (reslutItem.type.integerValue == 1) {
                WInputXingViewController *VC = [[WInputXingViewController alloc] init];
                ResultItem *reslutItemInfo = weak_self.viewModel.resultItemBOArray[index];
                VC.api_itemId = reslutItemInfo.apiId;
                [weak_self.navigationController pushViewController:VC animated:YES];
            } else {
                WInputMERViewController *VC = [[WInputMERViewController alloc] init];
                ResultItem *reslutItemInfo = weak_self.viewModel.resultItemBOArray[index];
                VC.api_itemId = reslutItemInfo.apiId;
                [weak_self.navigationController pushViewController:VC animated:YES];
            }
        };
    }
    return _menuList;
}

#pragma mark - debug operation
- (void)updateOnClassInjection {
    
}



@end
