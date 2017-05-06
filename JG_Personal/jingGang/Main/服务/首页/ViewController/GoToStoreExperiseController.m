//
//  GoToStoreExperiseController.m
//  jingGang
//
//  Created by Ai song on 16/1/21.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import "GoToStoreExperiseController.h"
#import "HMSegmentedControl.h"
#import "HMSegmentedControl+setAttribute.h"
#import "Util.h"
#import "GlobeObject.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "Masonry.h"
#import "HappyShoppingView.h"
#import "PublicInfo.h"
#import "WSJShoppingCartViewController.h"
#import "GotoStoreExperienceView.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
#import "PublicInfo.h"
#import "ShopCartView.h"
#import "WSJSelectCityViewController.h"
#import "ServiceDetailController.h"
#import "SelectCityView.h"
#import "ServiceCommentController.h"
#import "mapObject.h"
#import "KJDarlingCommentVC.h"
#import "HappyShoppingNewView.h"
#import "JGDropdownMenu.h"
#import "JGActivityDetailController.h"
#import "JGActivityTools.h"
#import "SalePromotionActivityAdMainInfoRequest.h"
//#import "ShoppingOrderDetailController.h"
#import "AFHTTPRequestOperationManager.h"
#import "JGActivityColumnHelper.h"
#import "ChangYunbiPasswordViewController.h"
@interface GoToStoreExperiseController ()<JGDropdownMenuDelegate>
{
    UIButton       *_head_btn;
    BOOL            _headYorN;
    
    UILabel         *_label1;
    UILabel         *_label2;
    UILabel         *_label3;
    
    ShopCartView    *_shopCartView;
    SelectCityView  *_selectCityView;
}
//@property (weak, nonatomic) IBOutlet HMSegmentedControl *topBarControl;

//@property (nonatomic,strong)HappyShoppingView *happyShoppingView;
@property (nonatomic,strong)HappyShoppingNewView *happyShoppingView;

@property (nonatomic,strong)SelectCityView *selectCityView;

@property (nonatomic,strong)GotoStoreExperienceView *gotoStoreExperienceView;

//展示功能未开放视图
//@property (nonatomic,strong)GogostoreUnopenedView *gotoStoreExperienceView;

@property (nonatomic,copy)NSArray *contentViewArr;

@property (strong,nonatomic) JGDropdownMenu *dropdownMenu;

@property (strong,nonatomic) UIButton *movedTopButton;



@end

static NSInteger pushCount = 0;



@implementation GoToStoreExperiseController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化乐购商城view,暂时用懒加载方式
    //[self _initGotoStoreView];
    
    //初始化乐购商城
    
        [self _happyShoppyView];
//    [self _gotoView];
    [self _initInfo];
    
    //头像
    [self _intiHeadView];
    
}


#pragma mark ----------------- private Method -----------------
-(void)_initInfo{
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //    _contentViewArr = @[_happyShoppingView,_gotoStoreExperienceView];
    
    //title
    [Util setNavTitleWithTitle:@"健康商城" ofVC:self];
    
    //    self.navigationController.navigationBar.barTintColor = NavBarColor;
    
    //topbar
//    self.topBarControl.sectionTitles = @[@"乐购商城",@"到店体验"];
//    
//    [self.topBarControl setDefaultAtrribute];
    //    self.topBarControl.selectedSegmentIndex = 1;
    //添加从首页选择商城的通知
    [kNotification addObserver:self selector:@selector(selectShopNotify:) name:selectShoppingNotification object:nil];
}


#pragma mark - 之前代码拷贝
- (void)_intiHeadView {
}

/**
 *  服务首页界面视图记载之前调用
 *
 */
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self _displayOrHidden:NO];
    self.navigationController.navigationBar.barTintColor = COMMONTOPICCOLOR;
    // 友盟统计
    [MobClick beginLogPageView:kMeasureViewController];
    _selectCityView.hidden = YES;
//    if (_topBarControl.selectedSegmentIndex == 1) {
        //显示城市view
//        _selectCityView.hidden = NO;
//    }else {
        if (!IsEmpty(GetToken)) {
            [self _addShopCartView];
        }
        //显示购物车view
//    }
    
    
    NSString *string = [[NSUserDefaults standardUserDefaults] objectForKey:kPushImageUrlKey];
    if (string.length) {
        [self showActivityView:[[JGActivityColumnHelper sharedInstanced] apiBO]];
    }
    
}

- (void)didDownloadPushImageUrl:(NSString *)url needDownload:(void(^)())loadBlock push:(void(^)())pushBlock {
    // 取出存在图片的路径
    NSString *saveImageUrl = [[NSUserDefaults standardUserDefaults] objectForKey:kPushImageUrlKey];
    if (saveImageUrl) {
        if ([saveImageUrl isEqualToString:url]) {
            // 如果内存存在图片路径,且一致的话 直接进入详情
            if (pushBlock) {
                pushBlock();
            }
            [[NSUserDefaults standardUserDefaults] setObject:url forKey:kPushImageUrlKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }else {
            // 如果内存存在的图片路径 旦不一致,(新活动出现) 重新加载图片
            if (loadBlock) {
                loadBlock();
            }
        }
    }else {
        // 第一次加载路径图片
        if (loadBlock) {
            loadBlock();
        }
        
    }
}

- (void)showActivityView:(JGActivityHotSaleApiBO *)apiBo {
    
    
    
}
-(void)_addShopCartView {
    
    _shopCartView = [ShopCartView showOnNavgationView:self.navigationController.view];
    //开始请求购物车数量
    [_shopCartView requestAndSetShopCartNumber];
    WEAK_SELF
    _shopCartView.cominToShopCartBlock = ^{
        [weak_self goToShoppingCart];
    };
    
    //每次视图将要出现，请求购物车数量
    [_shopCartView requestAndSetShopCartNumber];
    
}

-(void)_displayOrHidden:(BOOL)isHidden{
    
    _label1.hidden = isHidden;
    _label2.hidden = isHidden;
    _label3.hidden = isHidden;
    _head_btn.hidden = isHidden;
    
}



-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    
    // 友盟统计
    [MobClick endLogPageView:kMeasureViewController];
    
    [self _displayOrHidden:YES];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isShow"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    pushCount = 0;
    
    [[AFHTTPRequestOperationManager manager].operationQueue cancelAllOperations];
    
//    if (_topBarControl.selectedSegmentIndex == 1) {
        //隐藏城市view
        _selectCityView.hidden = YES;
//    }else {
        if (!IsEmpty(GetToken)) {
            [_shopCartView removeFromSuperview];
        }
        
//    }
}

//-(void)_gotoView{
//    
//    _gotoStoreExperienceView = BoundNibView(@"GotoStoreExperienceView", GotoStoreExperienceView);
//    _gotoStoreExperienceView.shoppingHomeVC = self;
//    [self.view addSubview:_gotoStoreExperienceView];
//    WEAK_SELF
//    [_gotoStoreExperienceView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(0);
//        make.left.right.bottom.mas_equalTo(weak_self.view);
//    }];
//    [kNotification addObserver:self selector:@selector(lisentContentOffsetChanged:) name:@"kCollectionViewContentOffset" object:nil];
//    UIButton *topButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    topButton.x = ScreenWidth - 12 - 40;
//    topButton.y = ScreenHeight - 49 - 42 - 64;
//    topButton.width = 38;
//    topButton.height = 38;
//    [topButton setImage:[UIImage imageNamed:@"TOP"] forState:UIControlStateNormal];
//    [topButton addTarget:self action:@selector(backtoTop) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:topButton];
//    topButton.alpha = 0;
//    self.movedTopButton = topButton;
//}
- (void)_initGotoStoreView{
    
    _gotoStoreExperienceView = BoundNibView(@"GotoStoreExperienceView", GotoStoreExperienceView);
    _gotoStoreExperienceView.shoppingHomeVC = self;
    [self.view addSubview:_gotoStoreExperienceView];
    WEAK_SELF
    [_gotoStoreExperienceView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(44);
        make.left.right.bottom.mas_equalTo(weak_self.view);
        
    }];
    
}



-(void)_happyShoppyView{
    
    //    _happyShoppingView = BoundNibView(@"HappyShoppingView", HappyShoppingView);
    _happyShoppingView = BoundNibView(@"HappyShoppingNewView", HappyShoppingNewView);
    
    
    [kNotification addObserver:self selector:@selector(lisentContentOffsetChanged:) name:@"kCollectionViewContentOffset" object:nil];
    
    //    _happyShoppingView.shoppingHomeController = self;
    [self.view addSubview:_happyShoppingView];
    WEAK_SELF
    [_happyShoppingView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.left.right.bottom.mas_equalTo(weak_self.view);
    }];
    
    UIButton *topButton = [UIButton buttonWithType:UIButtonTypeCustom];
    topButton.x = ScreenWidth - 12 - 40;
    topButton.y = ScreenHeight - 49 - 42 - 64;
    topButton.width = 38;
    topButton.height = 38;
    [topButton setImage:[UIImage imageNamed:@"TOP"] forState:UIControlStateNormal];
    [topButton addTarget:self action:@selector(backtoTop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topButton];
    topButton.alpha = 0;
    self.movedTopButton = topButton;
}

- (void)backtoTop {
    [self.happyShoppingView scrollTop];
}

- (void)lisentContentOffsetChanged:(NSNotification *)noti {
    NSNumber *number = noti.userInfo[@"contentOffsetY"];
    CGFloat contentOffsetY = [number floatValue];
    
    if (contentOffsetY > 1050) {
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

-(void)_selectGotoStoreConfigure{
    self.selectCityView.hidden = NO;
    _shopCartView.hidden = YES;
    self.gotoStoreExperienceView.hidden = NO;
    self.happyShoppingView.hidden = YES;
}

-(void)_selectHappyShoppingConfigure{
    self.gotoStoreExperienceView.hidden = YES;
    self.happyShoppingView.hidden = NO;
    self.selectCityView.hidden = YES;
    _shopCartView.hidden = NO;
    
}


#pragma mark ----------------- action Method -----------------
- (IBAction)indexChangeAction:(id)sender {
    
    HMSegmentedControl *segmentedControl = (HMSegmentedControl *)sender;
    if (segmentedControl.selectedSegmentIndex == 1) {//到店体验
        [self _selectGotoStoreConfigure];
    }else{
        [self _selectHappyShoppingConfigure];
    }
    
}

- (void)pushToViewController:(UIViewController *)VC {
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - 进入购物车
- (void)goToShoppingCart {
    
    WSJShoppingCartViewController *shoppingCartVC = [[WSJShoppingCartViewController alloc] init];
    shoppingCartVC.hidesBottomBarWhenPushed = YES;
    [self pushToViewController:shoppingCartVC];
}

#pragma mark - 重写父类通知监听方法

- (void)headBtnClick
{
#pragma mark - leftSM
    AppDelegate *appDelegate = kAppDelegate;
    if (!_headYorN) {
        [appDelegate.drawerController closeDrawerAnimated:YES completion:nil];
    }else{
        [appDelegate.drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }
    _headYorN = !_headYorN ;
}


#pragma mark - 选择商城通知
-(void)selectShopNotify:(NSNotification *)notifycation{
    
//    NSNumber *number = (NSNumber *)notifycation.object;
////    self.topBarControl.selectedSegmentIndex = number.integerValue;
//    if (number.integerValue == 0) {
//        [self _selectHappyShoppingConfigure];
//    }else if (number.integerValue == 1){
//        [self _selectGotoStoreConfigure];
//    }
    [self _selectHappyShoppingConfigure];
}


#pragma mark ----------------------- getter Method -----------------------
-(SelectCityView *)selectCityView {
    
    if (!_selectCityView) {
        _selectCityView = BoundNibView(@"SelectCityView", SelectCityView);
        //        _selectCityView.backgroundColor = [UIColor redColor];
        [self.navigationController.view addSubview:_selectCityView];
        [_selectCityView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(26);
            make.right.mas_equalTo(self.navigationController.view);
            make.size.mas_equalTo(CGSizeMake(75, 32));
        }];
        
        _selectCityView.cityName = [[mapObject sharedMap] baiduCity];
        WEAK_SELF;
        _selectCityView.selectCityActionBlock = ^(){
            //进入城市选择页
            WSJSelectCityViewController *selectedVC = [[WSJSelectCityViewController alloc] init];
            selectedVC.hidesBottomBarWhenPushed = YES;
            selectedVC.city = ^(NSString *city,NSNumber *cityID){
                
                weak_self.selectCityView.cityName = city;
                weak_self.selectCityView.cityID = cityID;
                
                //刷新本页面
                [weak_self.gotoStoreExperienceView setNeedsLayout];
                
            };
            [weak_self pushToViewController:selectedVC];
        };
    }
    
    return _selectCityView;
    
}

-(GotoStoreExperienceView *)gotoStoreExperienceView {
    
    
    if (!_gotoStoreExperienceView) {
        _gotoStoreExperienceView = BoundNibView(@"GotoStoreExperienceView", GotoStoreExperienceView);
        _gotoStoreExperienceView.shoppingHomeVC = self;
        [self.view addSubview:_gotoStoreExperienceView];
        WEAK_SELF
        [_gotoStoreExperienceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(44);
            make.left.right.bottom.mas_equalTo(weak_self.view);
        }];
    }
    return _gotoStoreExperienceView;
}
-(HappyShoppingNewView *)happyShoppingView{
    if (!_happyShoppingView) {
        _happyShoppingView = BoundNibView(@"HappyShoppingNewView", HappyShoppingNewView);
        //        _gotoStoreExperienceView.shoppingHomeVC = self;
        [self.view addSubview:_happyShoppingView];
        WEAK_SELF
        [_happyShoppingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(44);
            make.left.right.bottom.mas_equalTo(weak_self.view);
        }];
    }
    return _happyShoppingView;
}
- (void)dealloc
{
    [kNotification removeObserver:self];
}


@end
