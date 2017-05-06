//
//  WSJBabyCategoryViewController.m
//  jingGang
//
//  Created by thinker on 15/8/6.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJBabyCategoryViewController.h"
#import "PublicInfo.h"
#import "GlobeObject.h"
#import "WSJBabyHeaderView.h"
#import "WSJBabyCategoryTableViewCell.h"
#import "Masonry.h"
#import "VApiManager.h"
#import "WSJBabyCategoryModel.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"

@interface WSJBabyCategoryViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    VApiManager *_vapiManager;
}

@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation WSJBabyCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self getData];
}
#pragma mark - 网络请求数据
- (void) getData
{
    if (self.data.count)
    {
        [self.dataSource addObjectsFromArray:self.data];
        [self.tableView reloadData];
    }
    else
    {
        MerchStoreCommonInfoRequest *commoInfoRequest = [[MerchStoreCommonInfoRequest alloc] init:GetToken];
        WEAK_SELF
        commoInfoRequest.api_storeId = self.api_storeId;
        [_vapiManager merchStoreCommonInfo:commoInfoRequest success:^(AFHTTPRequestOperation *operation, MerchStoreCommonInfoResponse *response) {
            for (NSDictionary *dict in response.storeInfo)
            {
                WSJBabyCategoryModel *model = [[WSJBabyCategoryModel alloc] init];
                model.className = dict[@"className"];
                model.ID = dict[@"id"];
                for (NSDictionary *d in dict[@"childs"])
                {
                    [model.dataChilds addObject:d];
                }
                [weak_self.dataSource addObject:model];
            }
            [weak_self.tableView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            ;
        }];
    }
    
}
#pragma mark - 实例化UI
- (void) initUI
{
    self.dataSource = [NSMutableArray array];
    _vapiManager = [[VApiManager alloc] init];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, __MainScreen_Height - 64) style:UITableViewStylePlain];
    WSJBabyHeaderView *headerView = [[NSBundle mainBundle] loadNibNamed:@"WSJBabyHeaderView" owner:nil options:nil][0];
    WEAK_SELF
    headerView.block = ^(void){
        NSLog(@"点击全部 ---- %d",0);
        if (weak_self.siftAction)
        {
            weak_self.siftAction(nil);
            [weak_self.navigationController popViewControllerAnimated:YES];
        }
    };
    headerView.type = k_Header;
    self.tableView.tableHeaderView = headerView;
//    WSJBabyHeaderView *footerView = [[NSBundle mainBundle] loadNibNamed:@"WSJBabyHeaderView" owner:nil options:nil][0];
//    footerView.type = k_footer;
//    self.tableView.tableFooterView = footerView;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.allowsSelection = NO;
    self.tableView.sectionHeaderHeight = 60;
    [self.view addSubview:self.tableView];
    
    //返回上一级控制器按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(btnClick) target:self];

    //设置背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    WSJBabyCategoryModel *model = self.dataSource[section];
    if (model.dataChilds.count == 0)
    {
        return 0;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSJBabyCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        cell = [[WSJBabyCategoryTableViewCell alloc] init];
    }
    WSJBabyCategoryModel *model = self.dataSource[indexPath.section];
    cell.data = model.dataChilds;
    WEAK_SELF
    cell.selectAction = ^(NSInteger indx){
        NSDictionary *dict = model.dataChilds[indx];
        NSLog(@"选中cell ---- %@",dict[@"id"]);
        if (weak_self.siftAction)
        {
            weak_self.siftAction(dict[@"id"]);
            [weak_self.navigationController popViewControllerAnimated:YES];
        }
    };
    return cell;
}
#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    WEAK_SELF
    WSJBabyHeaderView *v = [[NSBundle mainBundle] loadNibNamed:@"WSJBabyHeaderView" owner:nil options:nil][0];
    v.type = k_sectionHeader;
    WSJBabyCategoryModel *model = self.dataSource[section];
    v.nameLabel.text = model.className;
    v.block = ^(void){
        NSLog(@"选中宝贝分类 ---- %@",model.ID);
        if (weak_self.siftAction)
        {
            weak_self.siftAction(model.ID);
            [weak_self.navigationController popViewControllerAnimated:YES];
        }
    };
    return v;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource.count > 0)
    {
        WSJBabyCategoryModel *model = self.dataSource[indexPath.section];
        NSArray *array = model.dataChilds;
        NSInteger row = array.count / 2 + array.count % 2;
        return 50 * row + 20;
    }
    return 0;
}

//返回上一级界面
- (void) btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(__MainScreen_Width/2 - 30, __StatusScreen_Height, 60, 40)];
    l.text = @"宝贝分类";
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
