//
//  JGNearbyServiceController.m
//  jingGang
//
//  Created by HanZhongchou on 16/1/20.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import "JGNearbyServiceController.h"
#import "UnderLineOrderManagerViewController.h"
#import "OffLineOrderController.h"
@interface JGNearbyServiceController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *arrayTitleData;

@end

@implementation JGNearbyServiceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"周边服务";
    
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view from its nib.
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.backgroundColor = self.view.backgroundColor;
    }
    return _tableView;
}
- (NSArray *)arrayTitleData
{
    if (!_arrayTitleData) {
        _arrayTitleData = [NSArray arrayWithObjects:@"线上服务订单",@"线下服务订单", nil];
    }
    return _arrayTitleData;
}

#pragma mark ---UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayTitleData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifile = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifile];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifile];
    }
    
    cell.textLabel.text = self.arrayTitleData[indexPath.row];
    return cell;
}


#pragma mark ---UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *controller;
    if (indexPath.row == 0) {//线上服务订单
        controller = [[UnderLineOrderManagerViewController alloc]init];
    }else if (indexPath.row == 1){//线下服务详情
        OffLineOrderController *offLineOrderController = [[OffLineOrderController alloc] init];
        offLineOrderController.orderType = PersonalOrderOffLineType;
        controller = offLineOrderController;
    }
    [self.navigationController pushViewController:controller animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
