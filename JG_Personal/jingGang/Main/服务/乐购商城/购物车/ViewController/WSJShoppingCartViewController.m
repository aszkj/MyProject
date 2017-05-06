//
//  WSJShoppingCartViewController.m
//  jingGang
//
//  Created by thinker on 15/8/7.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJShoppingCartViewController.h"
#import "PublicInfo.h"
#import "WSJShoppingCartHeaderView.h"
#import "WSJShoppingCartTableViewCell.h"
#import "WSJShoppingCartEditTableViewCell.h"
#import "WSJShoppingCartModel.h"
#import "VApiManager.h"
#import "GlobeObject.h"
#import "VApiManager.h"
#import "MJRefresh.h"
#import "OrderConfirmViewController.h"
#import "KJGoodsDetailViewController.h"
#import "KJShoppingAlertView.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "WSJEvaluateListViewController.h"
#import "WSJShopHomeViewController.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "WIntegralCartViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>


@interface WSJShoppingCartViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    BOOL _one;
    VApiManager         *_vapiManager;
    NSMutableDictionary *_saveHeaderView;
}
@property (weak, nonatomic) IBOutlet UIButton *subbmitButton;
@property (weak, nonatomic  ) IBOutlet UITableView    *tableview;
@property (weak, nonatomic  ) IBOutlet UILabel        *priceLabel;
@property (weak, nonatomic  ) IBOutlet UIButton       *allButton;
//数据源
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableSet   *dataSelect;

@end

NSString *const shoppingCartCell        =  @"WSJShoppingCartTableViewCell";
NSString *const shoppingCartEditCell    =  @"WSJShoppingCartEditTableViewCell";

@implementation WSJShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

#pragma mark - ------------查看购物车列表，请求数据--------
- (void) requestData
{
    self.allButton.selected = NO;
    if (![self.tableview isHeaderRefreshing])
    {
        [self.dataSource removeAllObjects];
        [self.dataSelect removeAllObjects];
        ShopFindUserCartQueryRequest *cartRequest = [[ShopFindUserCartQueryRequest alloc] init:GetToken];
        WEAK_SELF
        [_vapiManager shopFindUserCartQuery:cartRequest success:^(AFHTTPRequestOperation *operation, ShopFindUserCartQueryResponse *response) {
            NSLog(@"购物车 ---- %@",response.cartList);
            for (NSDictionary *dict in response.cartList)
            {
                //添加该商品的信息
                WSJShoppingCartInfoModel *infoModel = [[WSJShoppingCartInfoModel alloc] init];
                infoModel.ID = dict[@"id"];
                infoModel.imageURL = dict[@"goods"][@"goodsMainPhotoPath"];
                infoModel.name = dict[@"goods"][@"goodsName"];
                infoModel.specInfo = dict[@"specInfo"];
                infoModel.goodsCurrentPrice = dict[@"price"];
                infoModel.hasMobilePrice = dict[@"goods"][@"hasMobilePrice"];
                infoModel.goodsInventory = dict[@"goods"][@"goodsInventory"];
                if ([dict[@"goods"][@"goodsMobilePrice"] floatValue] > 0)//手机专享价价格
                {
                    infoModel.goodsCurrentPrice = dict[@"goods"][@"goodsMobilePrice"];
                }
                infoModel.count = dict[@"count"];
                infoModel.data = dict;
    
                NSLog(@"数据：%@",infoModel);
                //判断是否属于同一个店铺
                WSJShoppingCartModel *model = nil;
                for (WSJShoppingCartModel *m in weak_self.dataSource)
                {
                    if ([m.name isEqualToString:dict[@"storeName"]])
                    {
                        model = m;
                    }
                    if (dict[@"storeName"] == nil && m.name == nil)
                    {
                        model = m;
                    }
                }
                if (model == nil)
                {
                    model = [[WSJShoppingCartModel alloc] init];
                    model.name = dict[@"storeName"];
                    model.goodsType = [dict[@"goods"][@"goodsType"] boolValue];
                    model.goodsStoreId = dict[@"goods"][@"goodsStoreId"];
                    [weak_self.dataSource addObject:model];
                }
                [model.data addObject:infoModel];
            }
            [weak_self.tableview headerEndRefreshing];
            [weak_self.tableview reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [weak_self.tableview headerEndRefreshing];
        }];
    }
}
#pragma mark - 结算事件
- (IBAction)accountAction:(UIButton *)sender
{
//    WIntegralCartViewController *MERVC = [[WIntegralCartViewController alloc] initWithNibName:@"WIntegralCartViewController" bundle:nil];
//    [self.navigationController pushViewController:MERVC animated:YES];
//    return;
    
    NSMutableString *mutableStr = [NSMutableString string];
    for (NSString *str in self.dataSelect)
    {
        [mutableStr appendFormat:@"%@,",str];
    }
    if (mutableStr.length > 2) {
        [mutableStr deleteCharactersInRange:NSMakeRange(mutableStr.length - 1, 1)];
    }
    NSLog(@"result ---- %@",mutableStr);
    if (self.dataSelect.count == 0)
    {
        [KJShoppingAlertView showAlertTitle:@"亲，您还没有选择宝贝哦" inContentView:self.view.window];
        return;
    }
    OrderConfirmViewController *orderConfirmVC = [[OrderConfirmViewController alloc] initWithNibName:@"OrderConfirmViewController" bundle:nil];
    orderConfirmVC.gcIds = mutableStr;
    [self.navigationController pushViewController:orderConfirmVC animated:YES];
    [self calculatePrice];
}

#pragma mark - 全选按钮
- (IBAction)allAction:(UIButton *)sender
{
    sender.selected = ! sender.selected;
    [self.dataSelect removeAllObjects];
    for (WSJShoppingCartModel *model  in self.dataSource)
    {
        model.isAll = sender.selected;
        //所有的商品id都添加
        if (sender.selected)
        {
            for (WSJShoppingCartInfoModel *m in model.data)
            {
                [self.dataSelect addObject:[m.ID stringValue]];
            }
        }
        [self.tableview reloadData];
    }
    [self calculatePrice];
}
#pragma mark - 实例化UI
- (void) initUI
{
    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(__MainScreen_Width/2 - 30, __StatusScreen_Height, 60, 40)];
    l.text = @"购物车";
    l.font = [UIFont systemFontOfSize:18];
    l.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = l;
    _vapiManager = [[VApiManager alloc] init];
    self.dataSource = [NSMutableArray array];
    self.dataSelect = [NSMutableSet set];
    _saveHeaderView = [NSMutableDictionary dictionary];
    self.priceLabel.adjustsFontSizeToFitWidth = YES;
    self.tableview.sectionHeaderHeight = 60;
    self.tableview.rowHeight = 120;
    self.tableview.tableFooterView = [UIView new];
    WEAK_SELF
    [self.tableview addHeaderWithCallback:^{
        [weak_self requestData];
    }];
    [self.tableview registerNib:[UINib nibWithNibName:@"WSJShoppingCartTableViewCell" bundle:nil] forCellReuseIdentifier:shoppingCartCell];
    [self.tableview registerNib:[UINib nibWithNibName:@"WSJShoppingCartEditTableViewCell" bundle:nil] forCellReuseIdentifier:shoppingCartEditCell];
    //返回上一级控制器按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(btnClick) target:self];
    //设置背景颜色
    self.view.backgroundColor = background_Color;
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    WSJShoppingCartModel *model = self.dataSource[section];
    return model.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource.count > indexPath.section)
    {
        WSJShoppingCartModel *model = self.dataSource[indexPath.section];
        if (model.edit) //编辑状态
        {
            return [self editWithModel:model cellForRowAtIndexPath:indexPath];
        }
        else        //默认状态
        {
            return [self defaultWithModel:model cellForRowAtIndexPath:indexPath];
        }
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:shoppingCartCell];
    return cell;
}

#pragma mark - 编辑状态下的cell
-(UITableViewCell *)editWithModel:(WSJShoppingCartModel *)model cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WEAK_SELF
    WSJShoppingCartEditTableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:shoppingCartEditCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexPath = indexPath;
    WSJShoppingCartInfoModel *infoM = model.data[indexPath.row];
    [cell willCellWith:infoM];
    //编辑状态点击选中按钮
    cell.selectShopping = ^(NSString *ID,BOOL b){
        WSJShoppingCartHeaderView *headerView = _saveHeaderView[@(indexPath.section)];
        [headerView noSelect];
        [model setNoSelect];
        infoM.isSelect = b;
        weak_self.allButton.selected = NO;
        if (b)
        {
            [weak_self.dataSelect addObject:ID];
        }
        else
        {
            [weak_self.dataSelect removeObject:ID];
        }
        [weak_self calculatePrice];
        
    };
    //编辑状态点击删除
    cell.deleteCell = ^(NSIndexPath *index){
        [weak_self cancelShop:index];
    };
    //编辑商品个数
    cell.changeCount = ^(NSInteger count, NSNumber *ID){
        ShopGoodsCountAdjustRequest *request = [[ShopGoodsCountAdjustRequest alloc] init:GetToken];
        request.api_gcId = ID;
        request.api_count = @(count);
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:weak_self.view animated:YES];
        [hud show:YES];
        [_vapiManager shopGoodsCountAdjust:request success:^(AFHTTPRequestOperation *operation, ShopGoodsCountAdjustResponse *response) {
            NSLog(@"数量更改 ---- %@",response);
            [weak_self calculatePrice];
            [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
        }];
    };
    return cell;
}

#pragma mark - 普通状态下的cell
-(UITableViewCell *)defaultWithModel:(WSJShoppingCartModel *)model cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WEAK_SELF
    WSJShoppingCartTableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:shoppingCartCell];
    WSJShoppingCartInfoModel *infoM = model.data[indexPath.row];
    [cell willCellWith:infoM];
    //普通状态点击选中按钮
    cell.selectShopping = ^(NSString *ID,BOOL b){
        WSJShoppingCartHeaderView *headerView = _saveHeaderView[@(indexPath.section)];
        [headerView noSelect];
        weak_self.allButton.selected = NO;
        [model setNoSelect];
        infoM.isSelect = b;
        if (b)
        {
            [weak_self.dataSelect addObject:ID];

        }
        else
        {
            [weak_self.dataSelect removeObject:ID];
        }
        [weak_self calculatePrice];
    };
    return cell;
}


#pragma mark - 删除--------从购物车移除商品------
- (void)cancelShop:(NSIndexPath *)index
{
    //删除服务器数据
    WSJShoppingCartModel *model = self.dataSource[index.section];
    ShopCartRemoveRequest *removeRequest = [[ShopCartRemoveRequest alloc] init:GetToken];
    WSJShoppingCartInfoModel *infoModel = model.data[index.row];
    removeRequest.api_goodsId = [infoModel.ID stringValue];
    WEAK_SELF
    [_vapiManager shopCartRemove:removeRequest success:^(AFHTTPRequestOperation *operation, ShopCartRemoveResponse *response) {
        NSLog(@"deleteCart ---- %@",response);
        [weak_self calculatePrice];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
    //删除UI上的cell
    for (NSInteger i = 1; i < model.data.count - index.row; i++) {
        NSIndexPath *loopIndex = [NSIndexPath indexPathForRow:index.row+i inSection:index.section];
        WSJShoppingCartEditTableViewCell *shopCell = (WSJShoppingCartEditTableViewCell *)[self.tableview cellForRowAtIndexPath:loopIndex];
        NSIndexPath *newIndex = [NSIndexPath indexPathForRow:index.row+i-1 inSection:index.section];
        shopCell.indexPath = newIndex;
    }
    [model.data removeObjectAtIndex:index.row];
    if (model.data.count == 0)//判断某一段数据为空，删除整段
    {
        [self.dataSource removeObjectAtIndex:index.section];
        [self.tableview reloadData];
    }
    else
    {
        [self.tableview deleteRowsAtIndexPaths:@[index]
                              withRowAnimation:UITableViewRowAnimationLeft];
    }
    
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}
#pragma mark - 段头------店铺
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    WSJShoppingCartHeaderView *headerView = [[NSBundle mainBundle] loadNibNamed:@"WSJShoppingCartHeaderView" owner:nil options:nil][0];
    [_saveHeaderView setObject:headerView forKey:@(section)];
    WSJShoppingCartModel *model ;
    if (self.dataSource.count > section)
    {
        model = self.dataSource[section];
    }
    //赋值段头的数据
    [headerView willHearderWithModel:model];
    //编辑事件
    WEAK_SELF
    headerView.editBlock = ^(BOOL b) {
        model.edit = !model.edit;
        NSIndexSet *set = [[NSIndexSet alloc] initWithIndex:section];
        [tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
    };
    //全选事件
    headerView.selectBlock = ^(BOOL b) {
        weak_self.allButton.selected = NO;
        model.isAll = b;
        for (WSJShoppingCartInfoModel *m in model.data)
        {
            [weak_self.dataSelect removeObject:[m.ID stringValue]];
            if (b)
            {
                [weak_self.dataSelect addObject:[m.ID stringValue]];
            }
        }
        [weak_self calculatePrice];
        NSIndexSet *set = [[NSIndexSet alloc] initWithIndex:section];
        [tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
    };
    //点击段头进入店铺
    headerView.selectHeaderBlock = ^(void){
        if (model.goodsStoreId != nil)
        {
            WSJShopHomeViewController *homeVC = [[WSJShopHomeViewController alloc] initWithNibName:@"WSJShopHomeViewController" bundle:nil];
            homeVC.api_storeId = model.goodsStoreId;
            [weak_self.navigationController pushViewController:homeVC  animated:YES];
        }
    };
    return headerView;
}
#pragma mark - 选中商品、商品详情
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSJShoppingCartModel *model = self.dataSource[indexPath.section];
    WSJShoppingCartInfoModel *infoModel = model.data[indexPath.row];
    if (!model.edit)
    {
        NSLog(@"中选%@",infoModel.ID);
        KJGoodsDetailViewController *goodsDetailVC = [[KJGoodsDetailViewController alloc] initWithNibName:@"KJGoodsDetailViewController" bundle:nil];
        goodsDetailVC.goodsID = infoModel.data[@"goods"][@"id"];
        [self.navigationController pushViewController:goodsDetailVC animated:YES];
    }
}


#pragma mark - 计算总价格
- (void) calculatePrice
{
    NSMutableString *mutableStr = [NSMutableString string];
    for (NSString *str in self.dataSelect)
    {
        [mutableStr appendFormat:@"%@,",str];
    }
    if (mutableStr.length > 2) {
        [mutableStr deleteCharactersInRange:NSMakeRange(mutableStr.length - 1, 1)];
    }
    ShopGoodsTotalPriceRequest *totalPrice = [[ShopGoodsTotalPriceRequest alloc] init:GetToken];
    totalPrice.api_gcids = mutableStr;
    WEAK_SELF
    [_vapiManager shopGoodsTotalPrice:totalPrice success:^(AFHTTPRequestOperation *operation, ShopGoodsTotalPriceResponse *response) {
        if ([response.totalPrice floatValue] > 0)
        {
            CGFloat totalPrice = response.totalPrice.doubleValue;
            weak_self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",totalPrice];
        }
        else
        {
            weak_self.priceLabel.text = @"￥0";
        }
        self.subbmitButton.enabled = YES;
        NSString *goodsCountStr = [NSString stringWithFormat:@"结算(%ld)",self.dataSelect.count];
        [self.subbmitButton setTitle:goodsCountStr forState:UIControlStateNormal];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
}



//返回上一级界面
- (void) btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    AppDelegate *app = kAppDelegate;
    [app.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [app.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
    
    self.navigationController.navigationBar.translucent = NO;
    [self.dataSelect removeAllObjects];
    [self.subbmitButton setTitle:@"结算(0)" forState:UIControlStateNormal];
    self.priceLabel.text = @"￥0";
    if (_one) {
        [self requestData];
    }
    else
    {
        _one = YES;
        [self.tableview headerBeginRefreshing];
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
}
- (IBAction)allbuttonAction:(id)sender {
    [self allAction:self.allButton];
}

@end
