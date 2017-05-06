//
//  WSJCollectionMerchantViewController.m
//  jingGang
//
//  Created by thinker on 15/9/9.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJCollectionMerchantViewController.h"
#import "PublicInfo.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "WSJCollectionMerchantTableViewCell.h"
#import "VApiManager.h"
#import "GlobeObject.h"
#import "mapObject.h"
#import "MJRefresh.h"
#import "WSJMerchantDetailViewController.h"
#import "XKJHMapViewController.h"
#import "WSJSelectCityViewController.h"
#import "NodataShowView.h"
#define pageSize @(10)

@interface WSJCollectionMerchantViewController ()
{
    VApiManager *_vapiManager;
    NSInteger _page;
    BOOL _b;
}

//@property (weak, nonatomic) IBOutlet UIImageView *emptyImageView;
//@property (weak, nonatomic) IBOutlet UILabel *emptyLabel;


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

static NSString *collectionMerchantCell = @"WSJCollectionMerchantTableViewCell";

@implementation WSJCollectionMerchantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
#pragma mark - 网络请求数据
- (void)requestData
{
    _b = YES;
    WEAK_SELF
    mapObject *map = [mapObject sharedMap];
    PersonalFavoritesListRequest *favoritesListRequest = [[PersonalFavoritesListRequest alloc ]init:GetToken];
    favoritesListRequest.api_pageNum = @(_page);
    favoritesListRequest.api_pageSize = pageSize;
    favoritesListRequest.api_storeLat = map.baiduLatitude;
    favoritesListRequest.api_storeLon = map.baiduLongitude;
    [_vapiManager personalFavoritesList:favoritesListRequest success:^(AFHTTPRequestOperation *operation, PersonalFavoritesListResponse *response) {
        NSLog(@"收藏店铺 ---- %@",response);
        for (NSDictionary *dict  in response.favaStoreList)
        {
            [weak_self.dataSource addObject:dict];
        }
        if (weak_self.dataSource.count > 0) {
            [weak_self.tableView reloadData];
        }else {
            [NodataShowView showInContentView:self.view withReloadBlock:nil alertTitle:@"暂无收藏"];
        }
        [weak_self.tableView headerEndRefreshing];
        [weak_self.tableView footerEndRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"店铺收藏数据请求错误 ---- %@",error);
        [weak_self.tableView headerEndRefreshing];
        [weak_self.tableView footerEndRefreshing];
    }];

    
}

#pragma mark - 取消收藏
- (void)cancelCollection:(NSIndexPath *)index
{
    PersonalCancelRequest *cancelRequest = [[PersonalCancelRequest alloc ]init:GetToken];
    cancelRequest.api_type = @(6);
    cancelRequest.api_fid = self.dataSource[index.row][@"id"];
    [_vapiManager personalCancel:cancelRequest success:^(AFHTTPRequestOperation *operation, PersonalCancelResponse *response) {
        NSLog(@"collection Cancle ---- %@",response);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"collection Cancle ---- %@",error);
    }];
    for (NSInteger i = index.row ; i < self.dataSource.count-1; i++)
    {
        NSIndexPath *loop = [NSIndexPath indexPathForRow:i + 1 inSection:index.section];
        WSJCollectionMerchantTableViewCell *loopCell =  (WSJCollectionMerchantTableViewCell *)[self.tableView cellForRowAtIndexPath:loop];
        NSIndexPath *new = [NSIndexPath indexPathForRow:i inSection:index.section];
        loopCell.index = new;
    }
    [self.dataSource removeObjectAtIndex:index.row];
    [self.tableView deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationLeft];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (self.dataSource.count == 0 && _b)
//    {
//        [self setEmptyWithHidden:NO];
//    }
//    else
//    {
//        [self setEmptyWithHidden:YES];
//    }
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAK_SELF
    WSJCollectionMerchantTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:collectionMerchantCell];
    [cell willCustomCellWithData:self.dataSource[indexPath.row]];
    cell.index = indexPath;
    cell.cancelCollection = ^(NSIndexPath *index){
        [weak_self cancelCollection:index];
    };
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSJMerchantDetailViewController *merchantVC = [[WSJMerchantDetailViewController alloc] initWithNibName:@"WSJMerchantDetailViewController" bundle:nil];
    merchantVC.api_classId = self.dataSource[indexPath.row][@"id"];
    [self.navigationController pushViewController:merchantVC animated:YES];
}


#pragma mark - 实例化UI
- (void)initUI
{
    _page = 1;
    _vapiManager = [[VApiManager alloc]init];
    self.dataSource = [NSMutableArray array];
    [self.tableView registerNib:[UINib nibWithNibName:@"WSJCollectionMerchantTableViewCell" bundle:nil] forCellReuseIdentifier:collectionMerchantCell];
    self.tableView.rowHeight = 110;
    WEAK_SELF
    [self.tableView addHeaderWithCallback:^{
        _page = 1;
        [weak_self.dataSource removeAllObjects];
        [weak_self requestData];
    }];
    [self.tableView addFooterWithCallback:^{
        _page ++;
        [weak_self requestData];
    }];
    [self.tableView headerBeginRefreshing];
    
    //返回上一级控制器按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(btnClick) target:self];
    //设置背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
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
    l.text = @"我收藏的商户";
    l.font = [UIFont systemFontOfSize:18];
    l.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = l;
//    self.navigationController.navigationBar.translucent = NO;
    
}
#pragma mark - 数据为空时显示空数据
- (void) setEmptyWithHidden:(BOOL)hidden
{
//    self.emptyImageView.hidden = hidden;
//    self.emptyLabel.hidden = hidden;
}
@end
