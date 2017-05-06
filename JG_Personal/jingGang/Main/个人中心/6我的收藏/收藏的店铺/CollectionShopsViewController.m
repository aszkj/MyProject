//
//  CollectionShopsViewController.m
//  jingGang
//
//  Created by thinker on 15/8/3.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "CollectionShopsViewController.h"
#import "GlobeObject.h"
#import "PublicInfo.h"
#import "CollectionShopTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "CollectionGoodsViewController.h"
#import "Masonry.h"
#import "VApiManager.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "WSJShopHomeViewController.h"
#import "NodataShowView.h"

@interface CollectionShopsViewController () <UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _page;
}


@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSMutableArray *dataSource;
@property (nonatomic) VApiManager *vapiManager;

@end

@implementation CollectionShopsViewController

static NSString *cellIdentifier = @"CollectionShopTableViewCell";

#pragma mark - life cycle
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad{
    
    [self.view addSubview:self.tableView];
    
    [self setUIContent];
    [self setViewsMASConstraint];
}

- (void)viewWillAppear:(BOOL)animated{
    [self startRequest];
}

- (void)viewDidAppear:(BOOL)animated {
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    
}

- (void)viewDidLayoutSubviews {
}

#pragma mark - UITableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:cellIdentifier cacheByIndexPath:indexPath configuration:^(id cell) {
        [self loadCellContent:cell indexPath:indexPath];

    }];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:cellIdentifier cacheByIndexPath:indexPath configuration:^(id cell) {
        [self loadCellContent:cell indexPath:indexPath];

    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                  cellIdentifier];
    
    [self loadCellContent:cell indexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)loadCellContent:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    //这里把数据设置给Cell
    CollectionShopTableViewCell *shopCell = (CollectionShopTableViewCell *)cell;
    NSDictionary *dict = self.dataSource[indexPath.row];
    [shopCell.shopLogo sd_setImageWithURL:[NSURL URLWithString:TwiceImgUrlStr(dict[@"storeLogoPath"],shopCell.shopLogo.frame.size.width,shopCell.shopLogo.frame.size.width)]];
    shopCell.shopName.text = dict[@"storeName"];
    shopCell.shopType.image = [UIImage imageNamed:@"Assistor"];
    shopCell.backgroundColor = self.tableView.backgroundColor;
    shopCell.indexPath = indexPath;
    
    if (!shopCell.isAssociatedAction) {
        
        shopCell.cancelShop = ^(NSIndexPath *cellIndexPath){
            [self cancelShop:cellIndexPath];
        };
        shopCell.accessShop = ^(NSIndexPath *cellIndexPath){
            [self accessShop:cellIndexPath];
        };
        
        shopCell.associatedAction = YES;
    }

}


#pragma mark - CustomDelegate



#pragma mark - event response

- (void)accessShop:(NSIndexPath *)index
{
    WSJShopHomeViewController *VC = [[WSJShopHomeViewController alloc]
                            initWithNibName:@"WSJShopHomeViewController"
                            bundle:nil];
    NSDictionary *dict = self.dataSource[index.row];
    VC.api_storeId = dict[@"id"];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)cancelShop:(NSIndexPath *)index
{
    NSDictionary *dict = self.dataSource[index.row];
    SelfFavaDeleteRequest *deleteRequest = [[SelfFavaDeleteRequest alloc] init:GetToken];
    deleteRequest.api_id = dict[@"id"];
    deleteRequest.api_type = @"4";
    [_vapiManager selfFavaDelete:deleteRequest success:^(AFHTTPRequestOperation *operation, SelfFavaDeleteResponse *response) {
        NSLog(@"删除收藏店铺成功%@",response);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
    for (NSInteger i = 1; i < self.dataSource.count - index.row; i++) {
        NSIndexPath *loopIndex = [NSIndexPath indexPathForRow:index.row+i inSection:index.section];
        CollectionShopTableViewCell *shopCell = (CollectionShopTableViewCell *)[self.tableView cellForRowAtIndexPath:loopIndex];
        NSIndexPath *newIndex = [NSIndexPath indexPathForRow:index.row+i-1 inSection:index.section];
        shopCell.indexPath = newIndex;
    }
    
    [self.dataSource removeObjectAtIndex:index.row];
    [self.tableView deleteRowsAtIndexPaths:@[index]
                          withRowAnimation:UITableViewRowAnimationLeft];
}

#pragma mark - private methods

- (void)startRequest
{
    //TODO: 从获取收藏商铺的信息
    [self.dataSource removeAllObjects];
    SelfFavaListRequest *favaListReqeust = [[SelfFavaListRequest alloc] init:GetToken];
    favaListReqeust.api_type = @(4);
    favaListReqeust.api_pageNum = @(_page);
    favaListReqeust.api_pageSize = @(10);
    [self.vapiManager selfFavaList:favaListReqeust success:^(AFHTTPRequestOperation *operation, SelfFavaListResponse *response) {
        NSLog(@"收藏店铺 ---- %@",response.selfStroeList);
        for (NSDictionary *d in response.selfStroeList)
        {
            [self.dataSource addObject:d];
        }
        if (self.dataSource.count > 0) {
            [self.tableView reloadData];
        }else{
            [NodataShowView showInContentView:self.view withReloadBlock:nil alertTitle:@"暂无收藏"];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];

}

- (void)exitAction
{
    [self dismissViewControllerAnimated:YES completion:^{

    }];

}

- (void)setUIContent
{
    
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar.barTintColor = status_color;
    navBar.tintColor = [UIColor whiteColor];
    navBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    if (self.navigationController.viewControllers.count == 1) {
        
        UIImage* img = [UIImage imageNamed:@"navigationBarBack"];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(20, 30, 35, __NavScreen_Height-15);
        [btn setBackgroundImage:img forState:UIControlStateNormal];
        [btn addTarget: self action: @selector(exitAction) forControlEvents: UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
        self.navigationItem.leftBarButtonItem = item;
    }
    
    self.title = @"我收藏的店铺";
    //    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain  target:self  action:nil];
    //    self.navigationItem.backBarButtonItem = backButton;
    [self setLeftBarAndBackgroundColor];

}

- (void)setViewsMASConstraint
{
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(padding);

    }];

}

#pragma mark - getters and settters

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
//        _dataSource = [[NSMutableArray alloc]
//                       initWithArray:@[
//                                       @"三星医院医疗旗舰店",
//                                       @"中国人民医院",
//                                       @"美国红十字医院",
//                                       ]];
        _dataSource = [NSMutableArray array];
    }

    return _dataSource;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _page = 1;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, __MainScreen_Height)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 95.5;
        _tableView.rowHeight = 95.5;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
       
        UINib *nibCell = [UINib nibWithNibName:@"CollectionShopTableViewCell" bundle:nil];
        [_tableView registerNib:nibCell forCellReuseIdentifier:cellIdentifier];
        
        
    
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        [_tableView setTableFooterView:view];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }

    return _tableView;
}
- (VApiManager *)vapiManager
{
    if (_vapiManager == nil) {
        _vapiManager = [[VApiManager alloc] init];
    }
    return _vapiManager;
}

#pragma mark - debug operation

- (void)jumpVC
{
    UIViewController *VC = [[CollectionGoodsViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

@end
