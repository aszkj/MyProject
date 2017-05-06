//
//  Platform Controller.m
//  Merchants_JingGang
//
//  Created by dengxf on 15/10/29.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "PlatformController.h"
#import "NoticeModel.h"
#import "NoticeCell.h"

@interface PlatformController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableView;

/**
 *   数据源 --
 */
@property (strong,nonatomic) NSMutableArray *dataArray;

@end

@implementation PlatformController
#pragma mark --- 懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 83;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorInset = UIEdgeInsetsMake(5, 0, 0, 0);
        _tableView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupContent];
}
/**
 *  初始化页面、数据--
 */
- (void)setupContent {
    self.view.backgroundColor = background_Color;
    self.tableView.x = 0;
    self.tableView.y = 0;
    self.tableView.width = kScreenWidth;
    self.tableView.height = kScreenHeight - kNavBarAndStatusBarHeight;
    
    for (int i = 0 ; i < 8; i++) {
        NoticeModel *noticeModel = [[NoticeModel alloc] init];
        noticeModel.headTitle = @"联合国医疗大会在深圳隆重举行";
        noticeModel.time = @"2015年10月29日  15:49";
        noticeModel.operators = @"云E生";
        [self.dataArray addObject:noticeModel];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    JGLog(@"viewWillAppear");
    
    [super viewWillAppear:animated];
}

#pragma mark  --- TableViewDelegate --

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
    headView.backgroundColor = VCBackgroundColor;
    return headView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellId = @"NoticeCell";
    NoticeCell *cell   = [tableView dequeueReusableCellWithIdentifier:CellId];
    if (!cell) {
        cell = [[NoticeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
    }
    cell.noticeModel = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *noticeDetailController = [[UIViewController alloc] init];
    noticeDetailController.title = @"公告详情";
    noticeDetailController.view.backgroundColor = background_Color;
    
    [self.navigationController pushViewController:noticeDetailController animated:YES];
}

@end

