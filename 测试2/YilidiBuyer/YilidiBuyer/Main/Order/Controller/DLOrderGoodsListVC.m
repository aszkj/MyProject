//
//  DLOrderGoodsListVC.m
//  YilidiBuyer
//
//  Created by yld on 16/5/18.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLOrderGoodsListVC.h"
#import "MycommonTableView.h"
#import "DLGoodsAllshowCell.h"
#import "UIBarButtonItem+WNXBarButtonItem2.h"
#import "GoodsModel.h"

@interface DLOrderGoodsListVC ()
@property (weak, nonatomic) IBOutlet MycommonTableView *goodsListTableView;

@end

@implementation DLOrderGoodsListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    
    [self _requestGoodsList];
}

-(void)_init {
    self.pageTitle = @"商品清单";
    [self _initGoodsListTableView];
}

-(void)_initRightItemWithGoodsCount:(NSInteger)goodsCount {
    UIBarButtonItem *rightItem = [UIBarButtonItem initWithTitle:jFormat(@"共%ld件",goodsCount) titleColor:[UIColor whiteColor] target:self action:nil];
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem barButtonItemSpace:-12],rightItem];
}


-(void)_initGoodsListTableView {
    
    self.goodsListTableView.cellHeight =  GoodsAllshowHeight;
    self.goodsListTableView.dataLogicModule.isRequestByPage = NO;
    [self.goodsListTableView configurecellNibName:@"DLGoodsAllshowCell" configurecellData:^(UITableView *tableView,id cellModel, UITableViewCell *cell) {
        GoodsModel *model = (GoodsModel *)cellModel;
        DLGoodsAllshowCell *goodsCell = (DLGoodsAllshowCell *)cell;
        [goodsCell setGoodsAllshowCell:model];
        
    } clickCell:^(UITableView *tableView,id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        
    }];
}

- (void)_requestGoodsList {
    
    self.requestParam = @{@"orderNo":self.orderNo};
    [AFNHttpRequestOPManager getInfoWithSubUrl:kUrl_OrderGoodsList parameters:self.requestParam block:^(id result, NSError *error) {
        NSArray *resutlArr = result[@"data"];
        NSArray *transferedArr = [GoodsModel objectGoodsModelWithGoodsArr:resutlArr];
        [self.goodsListTableView configureTableAfterRequestData:transferedArr];
        [self _initRightItemWithGoodsCount:transferedArr.count];
    }];
    
}

@end
