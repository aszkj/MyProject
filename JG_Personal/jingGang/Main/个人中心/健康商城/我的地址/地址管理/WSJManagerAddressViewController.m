//
//  WSJManagerAddressViewController.m
//  jingGang
//
//  Created by thinker on 15/8/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJManagerAddressViewController.h"
#import "PublicInfo.h"
#import "WSJAddressTableViewCell.h"
#import "VApiManager.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "GlobeObject.h"
#import "WSJAddAddressViewController.h"
#import "MJRefresh.h"
#import "KJShoppingAlertView.h"


@interface WSJManagerAddressViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    VApiManager *_vapiManager;
    NSInteger    _defusltID;//默认地址id
}

@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

NSString * const  WSJAddressCell = @"WSJAddressTableViewCell";

@implementation WSJManagerAddressViewController

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict;
    if (self.dataSource.count > 0)
    {
        dict = self.dataSource[indexPath.row];
    }
    WSJAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:WSJAddressCell];
    cell.scrollView.contentOffset = CGPointMake(0, 0);
    [cell cellWithDictionary:dict];
    //设置默认地址
    if (_defusltID == [dict[@"id"] intValue])
    {
        cell.selectBtn.selected = YES;
        cell.nameLabel.text = [NSString stringWithFormat:@"(默认地址)%@",dict[@"trueName"]];
        cell.scrollView.backgroundColor = UIColorFromRGB(0Xf5f5f5);
    }
    else
    {
        cell.selectBtn.selected = NO;
        cell.nameLabel.text = [NSString stringWithFormat:@"%@",dict[@"trueName"]];
        cell.scrollView.backgroundColor = [UIColor whiteColor];
    }
    cell.indexPath = indexPath;
#pragma mark - 删除cell
    WEAK_SELF
    cell.deleteAction = ^(NSIndexPath *index){
        [weak_self deleteAddress:index];
    };
#pragma mark - 设置默认地址
    cell.defaultAddress = ^(NSIndexPath *index){
        _defusltID = [dict[@"id"] intValue];
        [weak_self.tableView reloadData];
        [weak_self setShopDefaultAddress:dict[@"id"]];
    };
#pragma mark -  选中地址回调方法
    cell.selectAction = ^(NSIndexPath *index){
        if (weak_self.selectAddress)
        {
            weak_self.selectAddress(dict);
            [weak_self.navigationController popViewControllerAnimated:YES];
        }
    };
#pragma mark - 编辑地址栏
    cell.editAction = ^(NSIndexPath *index){
        WSJAddAddressViewController *addAddressVC = [[WSJAddAddressViewController alloc]initWithNibName:@"WSJAddAddressViewController" bundle:nil];
        addAddressVC.dict = dict;
        addAddressVC.isDefault = [dict[@"id"] intValue] == _defusltID ? 1 : 0;
        addAddressVC.addAddress = ^(NSDictionary *dict,BOOL b){
            [weak_self.dataSource removeObjectAtIndex:index.row];
            [weak_self.dataSource insertObject:dict atIndex:index.row];
            if (b)
            {
                _defusltID = [dict[@"id"] intValue];
            }
            [weak_self.tableView reloadData];
        };
        [weak_self.navigationController pushViewController:addAddressVC animated:YES];
    };
    return cell;
}

#pragma mark - 设置默认地址id
- (void) setShopDefaultAddress:(NSNumber *)ID
{
    ShopDefaultAddressRequest *defaultRequest = [[ShopDefaultAddressRequest alloc] init:GetToken];
    defaultRequest.api_id = ID;
    [_vapiManager shopDefaultAddress:defaultRequest success:^(AFHTTPRequestOperation *operation, ShopDefaultAddressResponse *response) {
        NSLog(@"设置默认地址 ---- %@",response);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
}
#pragma mark - 删除地址cell
- (void)deleteAddress:(NSIndexPath *)index
{
    if ([self.dataSource[index.row][@"id"] integerValue] == [self.addressID integerValue])
    {
        if (self.deleteAddress)
        {
            self.deleteAddress();
        }
    }
    //删除服务器数据
    WEAK_SELF
    ShopDeleteAddressRequest *deleteRequest = [[ShopDeleteAddressRequest alloc] init:GetToken];
    deleteRequest.api_ids = [self.dataSource[index.row][@"id"] stringValue];
    [_vapiManager shopDeleteAddress:deleteRequest success:^(AFHTTPRequestOperation *operation, ShopDeleteAddressResponse *response) {
        [weak_self requestData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
    
    //更新UI操作
    for (NSInteger i = 1; i < self.dataSource.count - index.row; i++) {
        NSIndexPath *loopIndex = [NSIndexPath indexPathForRow:index.row+i inSection:index.section];
        WSJAddressTableViewCell *shopCell = (WSJAddressTableViewCell *)[self.tableView cellForRowAtIndexPath:loopIndex];
        NSIndexPath *newIndex = [NSIndexPath indexPathForRow:index.row+i-1 inSection:index.section];
        shopCell.indexPath = newIndex;
    }
    [self.dataSource removeObjectAtIndex:index.row];
    [self.tableView deleteRowsAtIndexPaths:@[index]
                              withRowAnimation:UITableViewRowAnimationLeft];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
#pragma mark - 请求地址数-->>>>如果没默认地址设置第一个地址为默认地址
- (void) requestData
{
//    请求地址列表
    [self.dataSource removeAllObjects];
    WEAK_SELF
    ShopUserAddressAllRequest *request = [[ShopUserAddressAllRequest alloc] init:GetToken];
    request.api_def = @(0);
    [_vapiManager shopUserAddressAll:request success:^(AFHTTPRequestOperation *operation, ShopUserAddressAllResponse *response) {
        for (NSDictionary *dict in response.userAddressAll)
        {
            [weak_self.dataSource addObject:dict];
        }
        //查看默认地址
        request.api_def = @(1);
        [_vapiManager shopUserAddressAll:request success:^(AFHTTPRequestOperation *operation, ShopUserAddressAllResponse *response) {
            NSDictionary *dict = (NSDictionary *)response.defaultAddress;
            if (dict[@"id"])
            {
                _defusltID = [dict[@"id"] intValue];
            }
            else if(weak_self.dataSource.count > 0)
            {
                NSDictionary *d = self.dataSource[0];
                _defusltID = [d[@"id"] intValue];
                [weak_self setShopDefaultAddress:d[@"id"]];
            }
            NSLog(@"默认地址id----success--- %@",dict[@"id"]);
            [weak_self.tableView headerEndRefreshing];
            [weak_self.tableView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"默认地址id --error-- %@",error);
        }];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [weak_self.tableView headerEndRefreshing];
    }];
}

#pragma mark - 添加地址
- (void) addAddress
{
    WEAK_SELF
    WSJAddAddressViewController *addAddressVC = [[WSJAddAddressViewController alloc]initWithNibName:@"WSJAddAddressViewController" bundle:nil];
    addAddressVC.addAddress = ^(NSDictionary *dict,BOOL b){
        [KJShoppingAlertView showAlertTitle:@"成功新增收货地址！" inContentView:weak_self.view.window];
        [weak_self requestData];
    };
    [self.navigationController pushViewController:addAddressVC animated:YES];
}

#pragma mark - ------------------
- (void) initUI
{
    _vapiManager = [[VApiManager alloc] init];
    //返回上一级控制器按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(btnClick) target:self];
    //设置背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, __MainScreen_Height - 64) style:UITableViewStylePlain];
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 54)];
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    addBtn.frame = CGRectMake(10, 11, __MainScreen_Width - 20, 43);
    addBtn.backgroundColor = status_color;
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
    [addBtn setTitle:@"+新增收货地址" forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    addBtn.layer.cornerRadius = 5;
    [footer addSubview:addBtn];
    footer.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = footer;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WSJAddressTableViewCell" bundle:nil] forCellReuseIdentifier:WSJAddressCell];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 82;
    WEAK_SELF
    [self.tableView addHeaderWithCallback:^{
        [weak_self requestData];
    }];
    [self.tableView headerBeginRefreshing];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.dataSource = [NSMutableArray array];
}


//返回上一级界面
- (void) btnClick
{
    if (self.type == personalCenter)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(__MainScreen_Width/2 - 30, __StatusScreen_Height, 60, 40)];
    l.text = @"收货地址";
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
