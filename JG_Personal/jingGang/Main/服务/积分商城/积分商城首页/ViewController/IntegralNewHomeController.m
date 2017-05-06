//
//  IntegralNewHomeController.m
//  jingGang
//
//  Created by 张康健 on 15/11/23.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "IntegralNewHomeController.h"
#import "IntegralHomeCollectionView.h"
#import "IntegralGoodsDetailController.h"
#import "Util.h"
#import "VApiManager.h"
#import "GlobeObject.h"
#import "MJRefresh.h"
#import "NSObject+MJExtension.h"
#import "MJExtension.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
@interface IntegralNewHomeController (){

    VApiManager *_vapManager;
    NSInteger   _requestFromPage;

}
@property (weak, nonatomic) IBOutlet IntegralHomeCollectionView *integralShopCollectionView;

@end

@implementation IntegralNewHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    
    //请求积分兑换列表
    [self _requestMyIntegralExchangeList];
    
    [self _addHeaderFresh];
}

-(void)viewDidLayoutSubviews {
    
    //头部要放在这里面调
    [self.integralShopCollectionView.headerView headerRequestData];

}


#pragma mark ----------------------- private Method -----------------------
- (void)_requestData {
    
    [self.integralShopCollectionView.headerView headerRequestData];
    
    //请求积分兑换列表
    [self _requestMyIntegralExchangeList];
    
}

- (void)_init {
    _vapManager = [[VApiManager alloc] init];
    self.navigationController.navigationBar.barTintColor = kGetColor(94, 180, 231);
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(back) target:self];
    [Util setNavTitleWithTitle:@"积分商城" ofVC:self];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.integralShopCollectionView setCollectionlayout];
    _requestFromPage = 1;
}

#pragma mark - 添加下拉刷新
- (void)_addHeaderFresh {
    
    [self.integralShopCollectionView addHeaderWithCallback:^{
        _requestFromPage = 1;
        [self _requestData];
    }];
    
    [self.integralShopCollectionView addFooterWithCallback:^{
        [self _requestMyIntegralExchangeList];
    }];
}





- (void)_requestMyIntegralExchangeList {
    
    IntegralListRequest *requst = [[IntegralListRequest alloc] init:GetToken];
    requst.api_pageNum = @(_requestFromPage);
    requst.api_pageSize = @4;
    
    [_vapManager integralList:requst success:^(AFHTTPRequestOperation *operation, IntegralListResponse *response) {
        
        NSLog(@"积分商品列表 %@",response);
        NSArray *integralArr =  [IntegralListBO JGObjectArrWihtKeyValuesArr:response.integralList];
        if (_requestFromPage == 1) {//下拉刷新
            [self.integralShopCollectionView headerEndRefreshing];
            self.integralShopCollectionView.dataArr = [integralArr mutableCopy];
        }else {//上拉加载更多
            [self.integralShopCollectionView footerEndRefreshing];
            [self.integralShopCollectionView.dataArr addObjectsFromArray:integralArr];
        }
        
        [self.integralShopCollectionView reloadData];
        _requestFromPage ++;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [Util ShowAlertWithOnlyMessage:error.localizedDescription];
        
    }];
    
}


#pragma mark ----------------------- Action Method -----------------------
- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
