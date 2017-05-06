//
//  commodityListView.m
//  jingGang
//
//  Created by thinker on 15/8/3.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "commodityListView.h"
#import "commodityListTableViewCell.h"
#import "VApiManager.h"
#import "MJRefresh.h"
#import "PublicInfo.h"
#import "GlobeObject.h"
#import "WSJSiftListModel.h"
#import "NodataShowView.h"


static BOOL _isRequestData;
@interface commodityListView ()<UITableViewDataSource,UITableViewDelegate>
{
    BOOL          _isHeader;
    VApiManager * _vapManager;
    NSInteger     _page;
    NSString    * _orderBy;         //价格:goods_current_price|销量:goods_salenum|综合:add_time
    NSString    * _orderType;       //排序类型|降序asc|升序desc
}
@property (weak, nonatomic  ) IBOutlet UIButton    *synthesizeBtn;
@property (weak, nonatomic  ) IBOutlet UIButton    *salesBtn;
@property (weak, nonatomic  ) IBOutlet UIButton    *priceBtn;
@property (nonatomic, assign) BOOL        priceSortBool;
@property (weak, nonatomic  ) IBOutlet UIButton    *siftBtn;
@property (weak, nonatomic  ) IBOutlet UIView      *lowView;
@property (weak, nonatomic  ) IBOutlet UITableView *tableView;



@property (nonatomic, strong) NSMutableArray *dataSource;


@end

@implementation commodityListView

- (void)awakeFromNib
{
    [self initUI];
}
- (void)reloadData
{
    [self.tableView headerBeginRefreshing];
}
- (void)clearData
{
    self.ID = nil;
    self.keyword = nil;
    self.properties = nil;
    _page = 1;
    self.transfee = nil;
    self.inventory = @(-1);
}
#pragma mark - 店铺列表数据（店铺商品）
- (void) requestStoreListData:(BOOL)b
{
    MerchStoreListRequest *storeRequest = [[MerchStoreListRequest alloc] init:GetToken];
    storeRequest.api_pageNum = @(_page);
    storeRequest.api_pageSize = @(10);
    storeRequest.api_orderBy = _orderBy;
    storeRequest.api_orderType = _orderType;
    storeRequest.api_ugcId = self.categoryID;
    storeRequest.api_id = self.ID;
    [_vapManager merchStoreList:storeRequest success:^(AFHTTPRequestOperation *operation, MerchStoreListResponse *response) {
        NSLog(@"店铺 ---- %@",response);
        if ([self.tableView isHeaderRefreshing])
        {
            [self.dataSource removeAllObjects];
        }
        for (NSDictionary *dict  in response.goodsList)
        {
            [self.dataSource addObject:dict];
        }
        if (b)
        {
            [self.tableView headerEndRefreshing];
        }
        [self.tableView footerEndRefreshing];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
    }];
}
#pragma mark - 搜索结果数据请求(关键字搜索)
- (void) requestSearchResultData:(BOOL)b
{
    SearchGoodsKeywordRequest *keywordRequest = [[SearchGoodsKeywordRequest alloc] init:GetToken];
    keywordRequest.api_pageNum = @(_page);
    keywordRequest.api_pageSize = @(10);
    keywordRequest.api_keyword = self.keyword;
    keywordRequest.api_orderBy = _orderBy;
    keywordRequest.api_goodsInventory = @(-1);
    keywordRequest.api_orderType = _orderType;
    keywordRequest.api_goodsTransfee = self.transfee;
    keywordRequest.api_goodsInventory = self.inventory;
    keywordRequest.api_properties = self.properties;
    [NodataShowView hideInContentView:self];
    [_vapManager searchGoodsKeyword:keywordRequest success:^(AFHTTPRequestOperation *operation, SearchGoodsKeywordResponse *response) {
        if ([self.tableView isHeaderRefreshing])
        {
            [self.dataSource removeAllObjects];
        }
        for (NSDictionary *d in response.keywordGoodsList)
        {
            [self.dataSource addObject:d];
            NSLog(@"search ---- %@",d);
        }
        NSLog(@"cheshi ---- %@",response);
        if (b)
        {
            [self.tableView headerEndRefreshing];
        }
        [self.tableView footerEndRefreshing];
        if (self.dataSource.count > 0) {
            [self.tableView reloadData];
        }else{
            [NodataShowView showInContentView:self withReloadBlock:nil alertTitle:@"暂无此类商品，请看看别的吧"];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
    }];
}
#pragma mark - 商品列表结果请求数据（商品分类）
- (void) requestShopCategoryData:(BOOL)b
{
    NSLog(@"cheshi --properties-- %@",self.properties);
    SearchClassGoodsRequest *searchRequest = [[SearchClassGoodsRequest alloc] init:GetToken];
    searchRequest.api_pageNum = @(_page);
    searchRequest.api_pageSize = @(10);
    searchRequest.api_keyword = self.keyword;
    searchRequest.api_gcId = self.ID;
    searchRequest.api_orderBy = _orderBy;
    searchRequest.api_goodsInventory = @(-1);
    searchRequest.api_orderType = _orderType;
    searchRequest.api_goodsTransfee = self.transfee;
    searchRequest.api_goodsInventory = self.inventory;
    searchRequest.api_properties = self.properties;
    [_vapManager searchClassGoods:searchRequest success:^(AFHTTPRequestOperation *operation, SearchClassGoodsResponse *response) {
        NSLog(@"cheshi ---- %@",response);
        if ([self.tableView isHeaderRefreshing])
        {
            [self.dataSource removeAllObjects];
        }
        Search *dict = response.searchGoodsList;
        for (NSDictionary *d in [dict valueForKey:@"searchGoodsList"])
        {
            [self.dataSource addObject:d];
            NSLog(@"cheshi ---- %@",d);
        }
        //筛选是否有数据，没数据网络请求
        if (self.shopgoodsProperty.count == 0)
        {
            self.shopgoodsProperty = [NSMutableArray array];
            //筛选数据
            [self.shopgoodsProperty removeAllObjects];
            for (NSDictionary *d in [dict valueForKey:@"shopgoodsProperty"])
            {
                WSJSiftListModel *model = [[WSJSiftListModel alloc] init];
                model.ID = d[@"id"];
                model.titleName = d[@"name"];
                [model.data addObjectsFromArray:[d[@"value"] componentsSeparatedByString:@","]];
                [self.shopgoodsProperty addObject:model];
            }
            [self.shopgoodsProperty addObject:@(0)];
            [self.shopgoodsProperty addObject:@(0)];
            [[NSNotificationCenter defaultCenter ]postNotificationName:@"siftData" object:self.shopgoodsProperty];
        }
        
        
        if (b)
        {
            [self.tableView headerEndRefreshing];
        }
        [self.tableView footerEndRefreshing];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
    }];
}
#pragma mark - 请求网络数据
- (void) requestData:(BOOL)b
{
    switch (self.type)
    {
        case classSearch:
            [self requestShopCategoryData:b];
            break;
        case keywordSearch:
            [self requestSearchResultData:b];
            break;
        case storeList:
            [self requestStoreListData:b];
            break;
        default:
            break;
    }
}
- (void) initUI
{
    _isHeader = YES;
    _vapManager = [[VApiManager alloc] init];
    _type = classSearch;//设置默认类型
    _page = 1;
    _orderBy = @"add_time";
    self.transfee = nil;
    self.inventory = @(-1);
    self.dataSource = [NSMutableArray array];
    self.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    self.synthesizeBtn.selected = YES;
    [self.tableView addHeaderWithCallback:^{
        if (![self.tableView isHeaderRefreshing])
        {
            _page = 1;
            [self requestData:YES];
        }
    }];
    [self.tableView addFooterWithCallback:^{
        _page += 1;
        [self requestData:YES];
    }];
    [self.tableView registerNib:[UINib nibWithNibName:@"commodityListTableViewCell" bundle:nil] forCellReuseIdentifier:@"ListCell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 120;
}

#pragma mark - 菜单按钮事件
- (IBAction)menuButton:(UIButton *)sender
{
    if (sender.selected == NO || sender == self.priceBtn || sender == self.siftBtn)
    {
        self.synthesizeBtn.selected = NO;
        self.salesBtn.selected = NO;
        self.priceBtn.selected = NO;
        self.siftBtn.selected = NO;
        sender.selected = YES;
        CGRect frame = CGRectMake(sender.frame.origin.x, self.lowView.frame.origin.y, sender.frame.size.width, 4);
        [UIView animateWithDuration:0.3 animations:^{
            self.lowView.frame = frame;
        }];
        switch (sender.tag) {
            case 1002: //点击价格
            {
                _orderBy = @"goods_current_price";
                if (self.priceSortBool)
                {
                    [sender setTitle:@"价格↓" forState:UIControlStateSelected];
                    _orderType = @"desc";
                }
                else
                {
                    [sender setTitle:@"价格↑" forState:UIControlStateSelected];
                    _orderType = @"asc";
                }
                self.priceSortBool = ! self.priceSortBool;
            }
                break;
            case 1003: //点击筛选
            {
                if (self.siftAction)
                {
                    self.siftAction(self.shopgoodsProperty);
                }
                self.priceSortBool = NO;
                return;
            }
                break;
            case 1000://点击综合
            {
                self.priceSortBool = NO;
                _orderBy = @"add_time";
            }
                break;
            case 1001://点击销量
            {
                _orderBy = @"goods_salenum";
                self.priceSortBool = NO;
            }
                break;
            default:
                break;
        }
        if ([self.tableView isHeaderRefreshing])
        {
            _isHeader = NO;
            _page = 1;
            [self.dataSource removeAllObjects];
            [self requestData:NO];
        }
        else
        {
            _isHeader = YES;
            [self.tableView headerBeginRefreshing];
        }
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    commodityListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell"];
    NSDictionary *dict = self.dataSource[indexPath.row];
    switch (self.type) {
        case classSearch:
        {
            [cell willCellWithModel:dict];
        }
            break;
        case  keywordSearch:
        {
             [cell willSearchCellWithModel:dict];
        }
            break;
        case  storeList:
        {
            [cell willCellWithModel:dict];
        }
            break;
        default:
            break;
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectRowBlock(self.dataSource[indexPath.row]);
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WHiddenKey" object:nil];
}

@end
