//
//  CollectionGoodsViewController.m
//  jingGang
//
//  Created by thinker on 15/8/4.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "CollectionGoodsViewController.h"
#import "GlobeObject.h"
#import "PublicInfo.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "Masonry.h"
#import "CollectionGoodsCellTableViewCell.h"
#import "OptionViewController.h"
#import "OrderViewController.h"
#import "VApiManager.h"
#import "UIImageView+WebCache.h"
#import "WSJShoppingCartViewController.h"
#import "NodataShowView.h"
@interface CollectionGoodsViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSMutableArray *dataSource;
@property (nonatomic) OptionViewController *optionVC;
@property (nonatomic) NSIndexPath *selectedIndexPath;
@property (nonatomic) VApiManager *vapiManager;

@end

@implementation CollectionGoodsViewController

static NSString *cellIdentifier = @"CollectionGoodsCellTableViewCell";
-(VApiManager *)vapiManager
{
    if (_vapiManager ==nil) {
        _vapiManager = [[VApiManager alloc]init];
    }
    return _vapiManager;
}

#pragma mark - life cycle
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad{
    [self.view addSubview:self.tableView];
    
    [self setUIContent];
    [self setViewsMASConstraint];
    
    //debug
}

- (void)viewWillAppear:(BOOL)animated{
    [self startRequest];
}

- (void)viewDidAppear:(BOOL)animated {
    
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = NO;
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
    CollectionGoodsCellTableViewCell *goodsCell = (CollectionGoodsCellTableViewCell *)cell;
    NSDictionary *dict = self.dataSource[indexPath.row];
    goodsCell.backgroundColor = self.tableView.backgroundColor;
    goodsCell.phoneVIP.hidden = ![dict[@"hasMobilePrice"] boolValue];
    goodsCell.goodsPrice.text = [NSString stringWithFormat:@"¥ %.2f",[dict[@"goodsCurrentPrice"] floatValue]];
    if ([dict[@"hasMobilePrice"] boolValue])
    {
        goodsCell.goodsPrice.text = [NSString stringWithFormat:@"¥ %.2f",[dict[@"goodsMobilePrice"] floatValue]];
    }
    goodsCell.goodsDescription.text = dict[@"goodsName"];
    [goodsCell.goodsLogo sd_setImageWithURL:[NSURL URLWithString:TwiceImgUrlStr(dict[@"goodsMainPhotoPath"],goodsCell.goodsLogo.frame.size.width,goodsCell.goodsLogo.frame.size.width) ]];
    goodsCell.indexPath = indexPath;
    
    if (!goodsCell.isAssociatedAction) {
        goodsCell.associatedAction = YES;
        
        goodsCell.optionBlock = ^(NSIndexPath *cellIndexPath) {
            self.selectedIndexPath = cellIndexPath;
            [self optionAction];
        };
    }
    
}


#pragma mark - CustomDelegate



#pragma mark - event response

- (void)cancelWatch:(NSIndexPath *)index
{
    SelfFavaDeleteRequest *deleteRequest = [[SelfFavaDeleteRequest alloc] init:GetToken];
    deleteRequest.api_id = self.dataSource[index.row][@"id"];
    deleteRequest.api_type = @"3";
    [_vapiManager selfFavaDelete:deleteRequest success:^(AFHTTPRequestOperation *operation, SelfFavaDeleteResponse *response) {
        NSLog(@"删除收藏商品成功%@",response);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
    for (NSInteger i = 1; i < self.dataSource.count - index.row; i++) {
        NSIndexPath *loopIndex = [NSIndexPath indexPathForRow:index.row+i inSection:index.section];
        CollectionGoodsCellTableViewCell *goodsCell = (CollectionGoodsCellTableViewCell *)[self.tableView cellForRowAtIndexPath:loopIndex];
        NSIndexPath *newIndex = [NSIndexPath indexPathForRow:index.row+i-1 inSection:index.section];
        goodsCell.indexPath = newIndex;
    }
    [self.dataSource removeObjectAtIndex:index.row];
    [self.tableView deleteRowsAtIndexPaths:@[index]
                          withRowAnimation:UITableViewRowAnimationLeft];
}

- (void)optionAction
{
    CGRect frame = self.view.frame;
    UIView *optionView = self.optionVC.view;
    optionView.frame = CGRectMake(frame.origin.x, 0, frame.size.width, frame.size.height);
    [self.view addSubview:optionView];
    [self.view bringSubviewToFront:optionView];
}

#pragma mark - private methods
- (void)startRequest
{
    //TODO: 从获取收藏商铺的信息
    [self.dataSource removeAllObjects];
    SelfFavaListRequest *favaListReqeust = [[SelfFavaListRequest alloc] init:GetToken];
    favaListReqeust.api_type = @(3);
    favaListReqeust.api_pageNum = @(1);
    favaListReqeust.api_pageSize = @(10);
    [self.vapiManager selfFavaList:favaListReqeust success:^(AFHTTPRequestOperation *operation, SelfFavaListResponse *response) {
        NSLog(@"收藏的商品 ---- %@",response.selfFavaGoodsList);
        for (NSDictionary *d in response.selfFavaGoodsList)
        {
            [self.dataSource addObject:d];
        }
        if (self.dataSource.count > 0) {
            [self.tableView reloadData];
        }else {
            [NodataShowView showInContentView:self.view withReloadBlock:nil alertTitle:@"暂无收藏"];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
    
}
- (void)setUIContent
{
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar.barTintColor = status_color;
    navBar.tintColor = [UIColor whiteColor];
    navBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    self.title = @"我收藏的商品";
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

- (OptionViewController *)optionVC {
    if (_optionVC == nil) {
        _optionVC = [[OptionViewController alloc] initWithNibName:@"OptionViewController" bundle:nil];
        [self addChildViewController:_optionVC];
        
        WEAK_SELF;
        _optionVC.cancelBlock = ^() {
            [weak_self cancelWatch:weak_self.selectedIndexPath];
        };
        _optionVC.addShoppingBlock = ^(){
            [weak_self addShoppingCart];
        };
        _optionVC.buyCurrentBlock = ^(){
            [weak_self addShoppingCart];
            WSJShoppingCartViewController *shoppingCartVC = [[WSJShoppingCartViewController alloc] initWithNibName:@"WSJShoppingCartViewController" bundle:nil];
            [weak_self.navigationController pushViewController:shoppingCartVC animated:YES];
        };
    }
    
    return _optionVC;
}
- (void) addShoppingCart
{
    ShopCartAddRequest *cartAddRequest = [[ShopCartAddRequest alloc] init:GetToken];
    cartAddRequest.api_count = @(1);
    cartAddRequest.api_goodId = self.dataSource[self.selectedIndexPath.row][@"id"];
    cartAddRequest.api_gsp = @"123";
    [_vapiManager shopCartAdd:cartAddRequest success:^(AFHTTPRequestOperation *operation, ShopCartAddResponse *response) {
        NSLog(@"加入购物车成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
}

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, __MainScreen_Height)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 95.5;
        _tableView.rowHeight = 95.5;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        UINib *nibCell = [UINib nibWithNibName:cellIdentifier bundle:nil];
        [_tableView registerNib:nibCell forCellReuseIdentifier:cellIdentifier];
        
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        [_tableView setTableFooterView:view];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    
    return _tableView;
}

#pragma mark - debug operation

- (void)jumpVC
{
    UIViewController *VC = [[OrderViewController alloc] initWithNibName:@"OrderViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
}

@end
