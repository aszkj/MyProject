//
//  JGActivityDetailController.m
//  jingGang
//
//  Created by dengxf on 15/12/9.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "JGActivityDetailController.h"
#import "GlobeObject.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "JGActivityTools.h"
#import "JGActivityCollectionView.h"
#import "ActHotSaleGoodsInfoApiBO1.h"
#import "MJRefresh.h"
#import "VApiManager.h"
#import "KJGoodsDetailViewController.h"
#import "Util.h"
#import "JGChristmasMananger.h"
#import "JGDropdownMenu.h"
#import "IntegralGoodsDetailController.h"
#import "MBProgressHUD.h"
#import "UIViewController+JGShowHubExtension.h"

typedef NS_ENUM(NSUInteger, ReqestType) {
    ReqestPulldownType = 0,  // 下拉刷新
    ReqestPullupType   // 上拉加载
};

@interface JGActivityDetailController ()<JGDropdownMenuDelegate>

@property (strong,nonatomic) JGActivityHotSaleApiBO *apiBO;

@property (assign, nonatomic) NSInteger requestPage;

@property (assign, nonatomic) NSInteger requestNumber;

@property (strong,nonatomic) NSMutableArray *shops;

@property (strong,nonatomic) JGActivityCollectionView *collectionView;

@property (strong,nonatomic) VApiManager *netManager;

@property (assign,nonatomic) BOOL isPush;

/**
 *  是否查询全部
 */
@property (assign, nonatomic) BOOL shouldQueryAllShops;

/**
 *  最小积分
 */
@property (copy , nonatomic) NSString *minIntegral;

/**
 *  最小积分
 */
@property (copy , nonatomic) NSString *maxIntegral;

/**
 *  用户当前积分
 */
@property (assign, nonatomic) NSInteger currentIntegral;

@property (strong,nonatomic)  JGDropdownMenu *menu;

@property (strong,nonatomic) UIImageView *bgImageView;
@property (strong,nonatomic) UIButton *movedTopButton;


@end

@implementation JGActivityDetailController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configContent];
}

- (void)showHud{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
}
- (void)hideHud{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = status_color;
    [self.menu dismiss];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = JGColor(173, 0, 19, 1);
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
                ActHotSaleGoodsInfoApiBO1 *good = [[ActHotSaleGoodsInfoApiBO1 alloc] initWithDict:shopDic];
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
                ActHotSaleGoodsInfoApiBO1 *good = [[ActHotSaleGoodsInfoApiBO1 alloc] initWithDict:shopDic];
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


- (void)lisentCollectionContentOffsetChanged:(NSNotification *)noti {
    NSNumber *number = noti.userInfo[@"integarlContentOffsetY"];
    CGFloat contentOffsetY = [number floatValue];
    
    if (contentOffsetY > 600) {
        if (self.movedTopButton.alpha == 0 ) {
            //
            [UIView animateWithDuration:0.3 animations:^{
                self.movedTopButton.alpha = 1;
            }];
        }
    }else {
        if (self.movedTopButton.alpha == 1) {
            [UIView animateWithDuration:0.3 animations:^{
                self.movedTopButton.alpha = 0;
            }];
        }
    }
}
/**
 *  初始化并配置页面
 */
- (void)configContent {
    // 默认选择选择全部
    self.shouldQueryAllShops = YES;
    self.minIntegral = @"";
    self.maxIntegral = @"";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [kNotification addObserver:self selector:@selector(lisentCollectionContentOffsetChanged:) name:@"kIntegarlCollectionContentOffsetYKey" object:nil];

    
    [kUserDefaults setInteger:1 forKey:@"kButtonFilterTagKey"];
    [kUserDefaults synchronize];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:bgImageView];
    bgImageView.image = [UIImage imageNamed:@"christmas_bggroundImg"];
    self.bgImageView = bgImageView;
    self.bgImageView.userInteractionEnabled = YES;
    
    __weak typeof(self) bself = self;
    
    // 查询活动信息
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat margin = 10;
        CGFloat itemWidth = (ScreenWidth - 2 * margin) / 2;
        layout.itemSize = CGSizeMake(itemWidth, itemWidth + 24);
        
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
    
        JGActivityCollectionView *collectionView = [[JGActivityCollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - NavBarHeight) collectionViewLayout:layout];
    
        __weak typeof(JGActivityCollectionView *)weakCollectionView = collectionView;
    
        [self showHud];
        [[JGChristmasMananger sharedInstanced] queryActivityInformationSuccess:^(ActivityHotSaleApiBO *apiBO) {
            StrongSelf;
            weakCollectionView.activityApiBO = apiBO;
            
            [strongSelf configApiBO:apiBO withNavTitleFontSize:20];
            
            [strongSelf.bgImageView addSubview:collectionView];
            strongSelf.collectionView = collectionView;
            
            //  进入页面请求所以商品
            [[JGChristmasMananger sharedInstanced] queryIntegarlListWithPageSize:@4 pageNum:@1 minIntegral:self.minIntegral maxIntegral:self.maxIntegral findAll:self.shouldQueryAllShops Suceess:^(NSArray *integralBOList) {
                JGLog(@"reload");
                [strongSelf hideHud];
                strongSelf.collectionView.shops = integralBOList;
                
                if (!strongSelf.collectionView) {
                    [strongSelf.bgImageView addSubview:collectionView];
                    strongSelf.collectionView = collectionView;
                }
                [strongSelf.collectionView reloadData];
                [strongSelf queryIntegral];
            } fail:^{
                JGLog(@"fail");
                StrongSelf;
                [strongSelf hideHud];
                
                [strongSelf showHudAltert:strongSelf.view message:@"网络不给力哦,无法获取数据!"];
            }];
            
            // 点击collectionItem
            collectionView.selectedItemShopBlock = ^(IntegralListBO *listBO){
                StrongSelf;
                IntegralGoodsDetailController *inteGralGoodsVc = [[IntegralGoodsDetailController alloc] init];
                inteGralGoodsVc.integralGoodsID = listBO.apiId;
                [strongSelf.navigationController pushViewController:inteGralGoodsVc animated:YES];
            };
            
            collectionView.showFilterView = ^(UIButton *filterButton){
                StrongSelf;
                JGDropdownMenu *menu = [JGDropdownMenu menu];
                [menu configTouchViewDidDismissController:YES];
                menu.delegate = strongSelf;
                JGShopActiveContentController *activeController = [[JGShopActiveContentController alloc] initWithControllerType:ControllerCustomViewType withModelObject:nil];
                activeController.filterButtonClickBlock = ^(FilterButtonType type,NSString *title){
                    [strongSelf showHud];
                    
                    strongSelf.requestPage = 1;
                    
                    switch (type) {
                        case FilterUserShouldConvertType:
                            // 我能兑换的
                        {
                            // 最小为0  最大为我的积分
                            [strongSelf hideHud];
                            
                            [[JGChristmasMananger sharedInstanced] queryUserIntegaralInfoWithTokenSuccess:^{
                                
                                strongSelf.minIntegral = @"0";
                                strongSelf.maxIntegral = [NSString stringWithFormat:@"%ld",strongSelf.currentIntegral];
                                strongSelf.shouldQueryAllShops = NO;
                                
                                [[JGChristmasMananger sharedInstanced] queryIntegarlListWithPageSize:@4 pageNum:[NSNumber numberWithInteger:strongSelf.requestPage] minIntegral:strongSelf.minIntegral maxIntegral:strongSelf.maxIntegral findAll:strongSelf.shouldQueryAllShops Suceess:^(NSArray *integralBOList) {
                                    strongSelf.collectionView.shops = integralBOList;
                                    [strongSelf.collectionView reloadData];
                                } fail:^{
                                }];
                                [strongSelf hideHud];
                                
                            } fail:^{
                                [strongSelf hideHud];
                            }];
                            UNLOGIN_HANDLE
                            
                        }
                            break;
                        case FilterAllShopType:
                        {
                            strongSelf.minIntegral = @"";
                            strongSelf.maxIntegral = @"";
                            strongSelf.shouldQueryAllShops = YES;
                            [[JGChristmasMananger sharedInstanced] queryIntegarlListWithPageSize:@4 pageNum:[NSNumber numberWithInteger:strongSelf.requestPage] minIntegral:strongSelf.minIntegral maxIntegral:strongSelf.maxIntegral findAll:strongSelf.shouldQueryAllShops Suceess:^(NSArray *integralBOList) {
                                strongSelf.collectionView.shops = integralBOList;
                                [strongSelf.collectionView reloadData];
                                [strongSelf hideHud];
                                
                            } fail:^{
                                [strongSelf hideHud];
                            }];
                            
                        }
                            // 全部
                            break;
                            
                        case FilterSectionType:
                            // 分段
                        {
                            NSArray *sections = [title componentsSeparatedByString:@"-"];
                            strongSelf.minIntegral = sections[0];
                            strongSelf.maxIntegral = sections[1];
                            strongSelf.shouldQueryAllShops = NO;
                            [[JGChristmasMananger sharedInstanced] queryIntegarlListWithPageSize:@4 pageNum:[NSNumber numberWithInteger:strongSelf.requestPage] minIntegral:strongSelf.minIntegral maxIntegral:strongSelf.maxIntegral findAll:strongSelf.shouldQueryAllShops Suceess:^(NSArray *integralBOList) {
                                strongSelf.collectionView.shops = integralBOList;
                                [strongSelf.collectionView reloadData];
                                [strongSelf hideHud];
                                
                            } fail:^{
                                [strongSelf hideHud];
                            }];
                        }
                            break;
                        case FilterMostUpType:
                            // 5000 以上的
                        {
                            strongSelf.minIntegral = @"5001";
                            strongSelf.maxIntegral = @"";
                            strongSelf.shouldQueryAllShops = NO;
                            [[JGChristmasMananger sharedInstanced] queryIntegarlListWithPageSize:@4 pageNum:[NSNumber numberWithInteger:strongSelf.requestPage] minIntegral:strongSelf.minIntegral maxIntegral:strongSelf.maxIntegral findAll:strongSelf.shouldQueryAllShops Suceess:^(NSArray *integralBOList) {
                                strongSelf.collectionView.shops = integralBOList;
                                [strongSelf.collectionView reloadData];
                                [strongSelf hideHud];
                                
                            } fail:^{
                                [strongSelf hideHud];
                                
                            }];
                        }
                        default:
                            break;
                    }
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [menu dismiss];
                    });
                };
                
                activeController.view.width = ScreenWidth;
                activeController.view.height = 75;
                menu.contentController = activeController;
                [menu showFromView:filterButton withDuration:0.25];
                strongSelf.menu = menu;
            };
            
            [collectionView addHeaderWithCallback:^{
                StrongSelf;
                // 下拉刷新
                [strongSelf showHud];
                strongSelf.requestPage = 1;
                [[JGChristmasMananger sharedInstanced] queryIntegarlListWithPageSize:@4 pageNum:[NSNumber numberWithInteger:strongSelf.requestPage] minIntegral:strongSelf.minIntegral maxIntegral:strongSelf.maxIntegral findAll:strongSelf.shouldQueryAllShops Suceess:^(NSArray *integralBOList) {
                    [strongSelf.collectionView headerEndRefreshing];
                    strongSelf.collectionView.shops = integralBOList;
                    [strongSelf.collectionView reloadData];
                    [strongSelf hideHud];
                } fail:^{
                    [strongSelf.collectionView headerEndRefreshing];
                    [strongSelf hideHud];
                    
                }];
                
            }];
            
            [collectionView addFooterWithCallback:^{
                StrongSelf;
                // 上拉加载更多
                [strongSelf showHud];
                strongSelf.requestPage = strongSelf.requestPage + 1;
                [[JGChristmasMananger sharedInstanced] queryIntegarlListWithPageSize:@4 pageNum:[NSNumber numberWithInteger:strongSelf.requestPage] minIntegral:strongSelf.minIntegral maxIntegral:strongSelf.maxIntegral findAll:strongSelf.shouldQueryAllShops Suceess:^(NSArray *integralBOList) {
                    [strongSelf.collectionView footerEndRefreshing];
                    [strongSelf hideHud];
                    
                    if (!integralBOList.count) {
                        
                        [strongSelf showHudAltert:strongSelf.view message:@"已经滑到最底端了..."];
                        
                    }else{
                        NSMutableArray *mutalArray = [NSMutableArray arrayWithArray:strongSelf.collectionView.shops];
                        [mutalArray addObjectsFromArray:integralBOList];
                        strongSelf.collectionView.shops = [mutalArray copy];
                        [strongSelf.collectionView reloadData];
                        
                    }
                    
                } fail:^{
                    [strongSelf.collectionView footerEndRefreshing];
                    if (strongSelf.requestPage > 1) {
                        strongSelf.requestPage -= 1;
                    }
                    [strongSelf hideHud];
                    
                }];
            }];

        } fail:^{
            JGLog(@"fail");
            [bself configApiBO:nil withNavTitleFontSize:20];
            [bself hideHud];
        }];
    

    
    self.requestPage = 1;
    self.isPush = NO;
    
    self.navigationController.navigationBar.barTintColor = kGetColor(94, 180, 231);
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(backToMain) target:self];
    
    UIButton *topButton = [UIButton buttonWithType:UIButtonTypeCustom];
    topButton.x = ScreenWidth - 12 - 40;
    topButton.y = ScreenHeight - 49 - 42 - 64;
    topButton.width = 38;
    topButton.height = 38;
    [topButton setImage:[UIImage imageNamed:@"TOP"] forState:UIControlStateNormal];
    [topButton addTarget:self action:@selector(backtoCollctionViewTop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topButton];
    topButton.alpha = 0;
    self.movedTopButton = topButton;
}

- (void)backtoCollctionViewTop {
//    [UIView animateWithDuration:0.37 animations:^{
//        [self.collectionView setContentOffset:CGPointMake(0,0)];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
//    }];
}

- (void)configApiBO:(ActivityHotSaleApiBO *)apiBO withNavTitleFontSize:(CGFloat)size {
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 35)];
    titleLable.textColor = [UIColor whiteColor];
    titleLable.font = [UIFont systemFontOfSize:size];
    titleLable.text = apiBO.hotName?apiBO.hotName:@"圣诞活动";
    titleLable.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLable;
    RELEASE(titleLable);
}

// 积分查询
- (void)queryIntegral {
    
    typeof(self) bself = self;
    // 查询积分
    [[JGChristmasMananger sharedInstanced] queryUserIntegaralInfoSuccess:^(UserIntegral *userIntegral) {
        // 用户登录了，且token未失效  能查询到积分
        JGLog(@"--积分:%d",[userIntegral.integral intValue]);
        StrongSelf;
        
        strongSelf.collectionView.integarlCount = [userIntegral.integral intValue];
        strongSelf.currentIntegral = [userIntegral.integral intValue];
        [strongSelf.collectionView reloadData];
        
    } fail:^{
        // 用户还未登录，或者登录了，token失效
        JGLog(@"--token失效");
        StrongSelf;
        strongSelf.collectionView.integarlCount = 0;
        [strongSelf.collectionView reloadData];
    }];

}

/**
 *  返回主页面
 */
- (void)backToMain{
    [JGActivityTools activityPopToMainController];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isClick"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    [[NSUserDefaults standardUserDefaults] setInteger:-1 forKey:@"kButtonFilterTagKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kIntegarlCollectionContentOffsetYKey" object:nil];
}

@end
