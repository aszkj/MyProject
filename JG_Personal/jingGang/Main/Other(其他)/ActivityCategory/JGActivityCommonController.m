//
//  JGActivityCommonController.m
//  jingGang
//
//  Created by dengxf on 15/12/29.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "JGActivityCommonController.h"
#import "MJRefresh.h"
#import "VApiManager.h"
#import "GlobeObject.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "JGNewYearCollectionView.h"
#import "KJGoodsDetailViewController.h"
#import "ActHotSaleGoodsInfoApiBO+api.h"

typedef NS_ENUM(NSUInteger, ReqestType) {
    ReqestPulldownType = 0,  // 下拉刷新
    ReqestPullupType   // 上拉加载
};

@interface JGActivityCommonController ()

@property (strong,nonatomic) VApiManager *netManager;
@property (strong,nonatomic) NSMutableArray *shops;
@property (strong,nonatomic) JGActivityHotSaleApiBO *apiBO;
@property (assign, nonatomic) NSInteger requestPage;
@property (strong,nonatomic) JGNewYearCollectionView *collectionView;

@end

@implementation JGActivityCommonController

- (NSMutableArray *)shops {
    if (!_shops) {
        _shops = [NSMutableArray array];
    }
    return _shops;
}

- (VApiManager *)netManager {
    if (!_netManager) {
        _netManager = [[VApiManager alloc] init];
    }
    return _netManager;
}

- (instancetype)initWithApiBO:(JGActivityHotSaleApiBO *)apiBO {
    if (self = [super init]) {
        self.apiBO = apiBO;
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 35)];
        titleLable.textColor = [UIColor whiteColor];
        titleLable.font = [UIFont systemFontOfSize:22.0f];
        titleLable.text = apiBO.hotName;
        titleLable.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = titleLable;
        RELEASE(titleLable);
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = status_color;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = JGColor(173, 0, 19, 1);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configContent];
}

/**
 *  初始化并配置页面内同
 */
- (void)configContent {
    self.requestPage = 1;
    [self reqsPage:1 pageSize:4 type:ReqestPulldownType];
    
    self.view.backgroundColor = kGetColorWithAlpha(255, 64, 75, 1);
    self.navigationController.navigationBar.barTintColor = kGetColor(94, 180, 231);
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(backToMain) target:self];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    // 5s 128 6 100 6p 86
    NSString *mobileType = [Util accodingToScreenSizeGetMobileType];
    CGFloat autoHeight = 0;
    
    if ([mobileType isEqualToString:kApMobile4s] || [mobileType isEqualToString:kApMobile5s]) {
        autoHeight = 92;
    }else if ([mobileType isEqualToString:kApMobile6s]) {
        autoHeight = 96;
    }else if ([mobileType isEqualToString:kApMobile6plus]) {
        autoHeight = 96;
    }
    
    layout.itemSize = CGSizeMake((ScreenWidth - 3 * 10) / 2, (ScreenWidth - 3 * 10) / 2 + autoHeight);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.minimumLineSpacing = 10;
    JGNewYearCollectionView *collectionView = [[JGNewYearCollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) collectionViewLayout:layout];
    collectionView.apiBO = self.apiBO;
    collectionView.backgroundColor =  kGetColorWithAlpha(254, 63, 76, 1);

    __weak typeof(self) bself = self;
    [collectionView addHeaderWithCallback:^{
        // 下拉刷新
        bself.requestPage = 1;
        [bself reqsPage:bself.requestPage pageSize:4 type:ReqestPulldownType];
    }];

    [collectionView addFooterWithCallback:^{
        bself.requestPage = bself.requestPage + 1;
        [bself reqsPage:bself.requestPage pageSize:4 type:ReqestPullupType];
    }];

    [self.view addSubview:collectionView];

    self.collectionView = collectionView;
    self.collectionView.selectedItemShopBlock = ^(ActHotSaleGoodsInfoApiBO *apiBO){
        KJGoodsDetailViewController *goodsDetailController = [[KJGoodsDetailViewController alloc] init];
        goodsDetailController.goodsID = apiBO.apiId;
        [bself.navigationController pushViewController:goodsDetailController animated:YES];
    };
}

- (void)reqsPage:(NSInteger)resPage pageSize:(NSInteger)pageSize type:(ReqestType)reqestType{
    
    SalePromotionActivityAdGoodsInfoListRequest *req  = [[SalePromotionActivityAdGoodsInfoListRequest alloc] init:GetToken];
    req.api_actHotSaleId =[NSNumber numberWithInteger:self.apiBO.aid];
    req.api_pageNum = [NSNumber numberWithInteger:resPage];
    req.api_pageSize = [NSNumber numberWithInteger:pageSize];
    
    __weak typeof(self) bself = self;
    [self.netManager salePromotionActivityAdGoodsInfoList:req success:^(AFHTTPRequestOperation *operation, SalePromotionActivityAdGoodsInfoListResponse *response) {
        
        if (reqestType == ReqestPulldownType) {
            // 下拉刷新
            [bself.collectionView headerEndRefreshing];
            // 清除之前的数据
            [bself.shops removeAllObjects];
            
            NSMutableArray *mutArray = [NSMutableArray array];
            for (NSDictionary *shopDic in response.goodsList) {
                ActHotSaleGoodsInfoApiBO *good = [[ActHotSaleGoodsInfoApiBO alloc] initWithDict:shopDic];
                [mutArray addObject:good];
            }
            bself.shops = mutArray;
            
            bself.collectionView.shops = bself.shops;
            
            [bself.collectionView reloadData];
            
        }else if (reqestType == ReqestPullupType) {
            // 上拉加载更过
            [bself.collectionView footerEndRefreshing];
            // 将数据追加到之前数组中
            NSMutableArray *mutArray = [NSMutableArray array];
            for (NSDictionary *shopDic in response.goodsList) {
                ActHotSaleGoodsInfoApiBO *good = [[ActHotSaleGoodsInfoApiBO alloc] initWithDict:shopDic];
                [mutArray addObject:good];
            }
            [bself.shops addObjectsFromArray:mutArray];
            bself.collectionView.shops = bself.shops;
            [bself.collectionView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (reqestType == ReqestPulldownType) {
            // 下拉刷新
            [bself.collectionView headerEndRefreshing];
        }else if (reqestType == ReqestPullupType) {
            // 上拉加载更过
            [bself.collectionView footerEndRefreshing];
            bself.requestPage -= 1;
        }
    }];
}


- (void)backToMain {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
