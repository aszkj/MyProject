//
//  WSJAddresListViewController.m
//  jingGang
//
//  Created by thinker on 15/8/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJAddresListViewController.h"
#import "UIBarButtonItem+WNXBarButtonItem2.h"

@interface WSJAddresListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    VApiManager *_vapiManager;
    UIView      *_cacheView;
    NSString    *_province;//保存省份
    NSString    *_city;//市区
}
@property (weak, nonatomic  ) IBOutlet UITableView  *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation WSJAddresListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self requestDataApiID:@(0)];
}
//请求省、市、区信息
- (void) requestDataApiID:(NSNumber *)apiID
{
    [self.dataSource removeAllObjects];
    [self.tableView reloadData];
    ShopAddresListRequest *request = [[ShopAddresListRequest alloc] init:GetToken];
    request.api_id = apiID;
    [_vapiManager shopAddresList:request success:^(AFHTTPRequestOperation *operation, ShopAddresListResponse *response) {
        NSArray *array = response.addressList;
        for (NSDictionary *d  in array)
        {
            [self.dataSource addObject:d];
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"addresList --error-- %@",error);
    }];
    
}
//实例化UI
- (void) initUI
{
    _vapiManager    = [[VApiManager alloc] init];
    self.dataSource = [NSMutableArray array];
    //返回上一级控制器按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(btnClick) target:self];
    //设置背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.sectionHeaderHeight = 41;
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_city != nil)
    {
        return 1;
    }
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_city != nil)
    {
        return self.dataSource.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSDictionary *dict = self.dataSource[indexPath.row];
    cell.textLabel.text = dict[@"areaName"];
    return  cell;
}
#pragma  mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view;
    if (_city)
    {
        view = [self createView:_city];
        view.backgroundColor = UIColorFromRGB(0XE5E5E5);
    }
    else if (self.dataSource.count > section)
    {
        NSDictionary *dict = self.dataSource[section];
        view = [self createView:dict[@"areaName"]];
        view.tag = section;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerAction:)];
        [view addGestureRecognizer:tap];
    }
    return view;
}
#pragma mark - 创建UIView
- (UIView *) createView:(NSString *)name
{
    UIView *view= [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 41)];
    view.backgroundColor = [UIColor whiteColor];
    UIView *xian = [[UIView alloc] initWithFrame:CGRectMake(0, 40.5, kScreenHeight, 0.5)];
    xian.backgroundColor = UIColorFromRGB(0XD5D5D5);
    [view addSubview:xian];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 40)];
    label.text = name;
    [view addSubview:label];
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = self.dataSource[indexPath.row];
    NSString *address = [NSString stringWithFormat:@"%@%@%@",_province,_city,dict[@"areaName"]];
    NSLog(@"address ---- %@",address);
    if (self.returnAddress)
    {
        self.returnAddress(address,dict[@"id"]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

//点击段头事件
- (void) headerAction:(UIGestureRecognizer *)ges
{
    NSDictionary *dict = self.dataSource[ges.view.tag];
    if (_province == nil)
    {
        _province = dict[@"areaName"];
        UIView *v = [self createView:_province];
        v.backgroundColor = UIColorFromRGB(0XD5D5D5);
        self.tableView.tableHeaderView = v;
    }
    else if (_city == nil)
    {
        _city = dict[@"areaName"];
        if (self.addressType == bankAddress)
        {
            if (self.returnAddress)
            {
                self.returnAddress([NSString stringWithFormat:@"%@ %@",_province,_city],dict[@"id"]);
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }
    [self requestDataApiID:dict[@"id"]];
}
//返回上一级界面
- (void) btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 30, 20, 60, 40)];
    if (self.addressType == shopDetailsAddress)
    {
        l.text = @"商户所在地";
    }
    else
    {
        l.text = @"开户省、市";
    }
    l.font = [UIFont systemFontOfSize:18];
    l.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = l;
    self.navigationController.navigationBar.translucent = NO;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
}

@end
