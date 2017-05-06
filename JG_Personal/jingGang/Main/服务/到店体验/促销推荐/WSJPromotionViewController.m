//
//  WSJPromotionViewController.m
//  jingGang
//
//  Created by thinker on 15/9/9.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJPromotionViewController.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "PublicInfo.h"
#import "GlobeObject.h"
#import "ServiceDetailController.h"
#import "VApiManager.h"
#import "AppDelegate.h"
#import "mapObject.h"
#import "WSJPromotionTableViewCell.h"
#import "MJRefresh.h"
#import "AppDelegate.h"

#import "WSJCollectionMerchantViewController.h"

//每一页的数量
#define pageSize @(10)

@interface WSJPromotionViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    VApiManager *_vapiManager;
    NSInteger _page;//第几页
    
    NSNumber *_cityID;
    NSNumber *_latitude;
    NSNumber *_longitude;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

static NSString *promotionTableViewCell = @"promotionTableViewCell";

@implementation WSJPromotionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}




#pragma mark - 网络请求数据
- (void)requestData
{
    PersonalPromotionGoodsListRequest *promotionRequest = [[PersonalPromotionGoodsListRequest alloc] init:GetToken];
    promotionRequest.api_cityId = _cityID;
    promotionRequest.api_storeLat = _latitude;
    promotionRequest.api_storeLon = _longitude;
    promotionRequest.api_pageNum = @(_page);
    promotionRequest.api_pageSize = pageSize;
    WEAK_SELF
    [_vapiManager personalPromotionGoodsList:promotionRequest success:^(AFHTTPRequestOperation *operation, PersonalPromotionGoodsListResponse *response) {
        [weak_self.dataSource addObjectsFromArray:response.groupGoodsBOs];
        [weak_self.tableView reloadData];
        [weak_self.tableView headerEndRefreshing];
        [weak_self.tableView footerEndRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"促销推荐 ---- %@",error);
        [weak_self.tableView headerEndRefreshing];
        [weak_self.tableView footerEndRefreshing];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSJPromotionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:promotionTableViewCell];
    if (indexPath.row < self.dataSource.count)
    {
        [cell willCustomCellWithData:self.dataSource[indexPath.row]];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ServiceDetailController *serviceVC = [[ServiceDetailController alloc] initWithNibName:@"ServiceDetailController" bundle:nil];
    serviceVC.serviceID = self.dataSource[indexPath.row][@"id"];
    [self.navigationController pushViewController:serviceVC animated:YES];
}

#pragma mark - 实例化UI
- (void)initUI
{
    _cityID = [[mapObject sharedMap] baiduCityID];
    _latitude = [[mapObject sharedMap] baiduLatitude];
    _longitude = [[mapObject sharedMap] baiduLongitude];

    mapObject *map = [mapObject sharedMap];
    NSLog(@"%@+++++%@+++++%@++++%@",map.baiduCity,map.baiduCityID,map.baiduLatitude,map.baiduLongitude);
    _page = 1;
    _vapiManager = [[VApiManager alloc] init];
    self.dataSource = [NSMutableArray array];
    [self.tableView registerNib:[UINib nibWithNibName:@"WSJPromotionTableViewCell" bundle:nil] forCellReuseIdentifier:promotionTableViewCell];
    WEAK_SELF
    [self.tableView addHeaderWithCallback:^{
        [weak_self.dataSource removeAllObjects];
            _page = 1;
            [weak_self requestData];
    }];
    [self.tableView addFooterWithCallback:^{
        _page ++;
        [weak_self requestData];
    }];
    [self.tableView headerBeginRefreshing];
    self.tableView.rowHeight = 110;
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
    l.text = @"促销推荐";
    l.font = [UIFont systemFontOfSize:18];
    l.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = l;
    self.navigationController.navigationBar.translucent = NO;
    
    //关闭侧滑
    AppDelegate *app = kAppDelegate;
    [app.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [app.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];

}

@end
