//
//  XKJHOffLinePayDetailController.m
//  Merchants_JingGang
//
//  Created by 鹏 朱 on 15/9/7.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHOffLinePayDetailController.h"
#import "XKJHOffLinePayDetailCell.h"

@interface XKJHOffLinePayDetailController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSMutableArray *pageData;

@end

@implementation XKJHOffLinePayDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, kScreenHeight - kNavBarAndStatusBarHeight);
    
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.delaysContentTouches = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.contentOffset = CGPointMake(0, 0);
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.tableHeaderView = [self getHeaderView];
    _tableView.backgroundColor = background_Color;
    [self.view addSubview:_tableView];
    
    self.title = @"线下刷卡明细";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *OffLinePayDetailCellIdentifier = @"OffLinePayDetailCellIdentifier";
    XKJHOffLinePayDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:OffLinePayDetailCellIdentifier];
    if (cell == nil) {
        cell = [[XKJHOffLinePayDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OffLinePayDetailCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

//    cell.textLabel.text = [self.pageData objectAtIndex:indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 153;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
