//
//  DLMainTabBarController.m
//  YilidiSeller
//
//  Created by User on 16/3/17.
//  Copyright © 2016年 Dellidc. All rights reserved.
//

#import "DLMainTabBarController.h"
#import "DLBaseNavController.h"
#import "DLHomeVC.h"
#import "DLShopCarVC.h"
#import "DLMeVC.h"
#import "UIView+Extension.h"
#import "DLTabbarItemView.h"
#import "ProjectRelativeMaco.h"
#import "ProjectRelativeDefineNotification.h"
#import "UIView+BlockGesture.h"
#import "DLGoodsAllClassVC.h"
#import "DLLoginVC.h"
#import "ShopCartGoodsManager.h"
#import "DLOrderListVC.h"
#import "UIViewController+unLoginHandle.h"
#import "DLLoginVC.h"
#import "DLShopCarVC.h"
#import "DLShopCartVirtualVC.h"
const CGFloat kTabBarViewHeight = 49;

@interface DLMainTabBarController ()

@property (nonatomic, strong)UIImageView *tabbarBgImgView;
@property (nonatomic, strong)UIView *tabbarReplaceView;
@property (nonatomic, strong)UIImageView *selectedTabbarItemBgImgView;

@property (nonatomic, strong)UIButton *shopCartMessageButton;
@property (nonatomic, strong)DLTabbarItemView *shopCartItemView;

@property (nonatomic, strong)ShopCartGoodsManager *shopCartGoodsManager;

@property (nonatomic, strong)DLTabbarItemView *lastSelectedTabbarItemView;

@end

@implementation DLMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTabBarViewController];
    
    [self _customTabBarView];
    
    [self _init];
    

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self _registerNotification];
    [self _initShopCartNumber];
    [self _removeSytemTabbuttons];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    [kNotification removeObserver:self];
    self.tabbarReplaceView.hidden = YES;
}

#pragma mark ------------------------Init---------------------------------
-(void)_init {
    self.shopCartBadgeNumber = 0;
    self.tabBar.tintColor = [UIColor redColor];
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBar.translucent = false;
    self.delegate = self;
}

- (void)_initShopCartNumber {
    self.shopCartBadgeNumber = self.shopCartGoodsManager.shopCartGoodsNumber;
}

- (void)setUpTabBarViewController {
    
    //首页
    DLHomeVC *homePage = [[DLHomeVC alloc]init];
    homePage.hidesBottomBarWhenPushed = YES;
    DLBaseNavController *homePageNav = [[DLBaseNavController alloc]initWithRootViewController:homePage];
    
    //购物车
    //    DLShopCarVC *cartVC = [[DLShopCarVC alloc]init];
    DLShopCartVirtualVC *cartVC = [[DLShopCartVirtualVC alloc]init];
    cartVC.hidesBottomBarWhenPushed = YES;
    
    DLBaseNavController *cartVCNav = [[DLBaseNavController alloc]initWithRootViewController:cartVC];
    
    //订单
    DLOrderListVC *orderVC = [[DLOrderListVC alloc] init];
    orderVC.hidesBottomBarWhenPushed = YES;
    
    DLBaseNavController *orderNav= [[DLBaseNavController alloc]initWithRootViewController:orderVC];
    
    //我的
    DLMeVC *meVC = [[DLMeVC alloc]init];
    meVC.hidesBottomBarWhenPushed = YES;
    
    DLBaseNavController *meVCNav = [[DLBaseNavController alloc]initWithRootViewController:meVC];
    
    self.viewControllers = @[homePageNav,cartVCNav,orderNav,meVCNav];
    
}

#pragma mark -------------------Public Method----------------------

- (void)hiddenBottomView {
    if (self.tabbarReplaceView.hidden) {
        return;
    }
    self.tabbarReplaceView.hidden = YES;
}


- (void)showBottomView {
    if (!self.tabbarReplaceView.hidden) {
        return;
    }
    self.tabbarReplaceView.hidden = NO;
    
}




#pragma mark ------------------------Private-------------------------
- (void)_registerNotification {
    [kNotification addObserver:self selector:@selector(shopCartGoodsNumberChange:) name:KNotificationShopCartBadgeValueNeedChange object:nil];
    [kNotification addObserver:self selector:@selector(switchCommunityShopCartGoodsNumberChange:) name:KNotificationSwitchCommunity object:nil];
}

- (void)_removeSytemTabbuttons {
//     //1. 先将TabBarView上的子视图移除
//        for (UIView *subView in self.tabBar.subviews) {
//            // 反射机制
//            if ([subView isMemberOfClass:NSClassFromString(@"UITabBarButton")]) {
//                // 移除视图视图
//                [subView removeFromSuperview];
//            }else if ([subView isMemberOfClass:NSClassFromString(@"UITabBarItem")]){
//                [subView removeFromSuperview];
//    
//            }
//        }
    [self.tabBar removeFromSuperview];
    
}

- (void)createTabbarItem:(CGFloat)width i:(int)i tabbarItemTitles:(NSArray *)tabbarItemTitles tabbarItemImgNames:(NSArray *)tabbarItemImgNames tabbarItemSelecteImgNames:(NSArray *)tabbarItemSelecteImgNames
{
    // 4. 创建主题按钮
    DLTabbarItemView *item = [[DLTabbarItemView alloc] initWithFrame:CGRectMake(width * i, 0, width, self.tabbarReplaceView.frame.size.height)];
    item.userInteractionEnabled = YES;
    WEAK_SELF;
    WEAK_OBJ(item)
    [item addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weak_self click:weak_item.itemIconButton];
    }];
    if (i == ShopCartPageIndex) {
        [item addSubview:self.shopCartMessageButton];
        self.shopCartMessageButton.frame = CGRectMake((width-14)/2+10, 7, 16, 16);
        [self.shopCartMessageButton setTitle:@"" forState:UIControlStateNormal];
        if (!self.shopCartItemView) {
            self.shopCartItemView = item;
        }
    }
    
    if (i == MainPageIndex) {
        item.selected = YES;
        self.lastSelectedTabbarItemView = item;
    }
    
    item.title = tabbarItemTitles[i];
    item.iconImgName = tabbarItemImgNames[i];
    item.selectedIconImgName = tabbarItemSelecteImgNames[i];
    item.itemIconButton.tag = i + 10;
    item.itemIconButton.userInteractionEnabled = NO;
    item.itemTitleButton.userInteractionEnabled = NO;
    [self.tabbarReplaceView addSubview:item];
}

- (void)_customTabBarView
{
    self.tabbarReplaceView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-kTabBarViewHeight, kScreenWidth, kTabBarViewHeight)];
    [self.view addSubview:self.tabbarReplaceView];
    // 1. 设置背景
    self.tabbarBgImgView = [[UIImageView alloc] initWithFrame:self.tabbarReplaceView.bounds];
    self.tabbarBgImgView.backgroundColor = [UIColor whiteColor];
    [self.tabbarReplaceView addSubview:self.tabbarBgImgView];
    
    // 2. 添加自定义按钮
    NSUInteger count = [[self viewControllers] count];
    CGFloat width = kScreenWidth / count;
    
    NSArray *tabbarItemImgNames = @[@"首页",@"购物车",@"订单",@"我的"];
    NSArray *tabbarItemSelecteImgNames = @[@"选中首页",@"选中购物车",@"选中订单",@"选中我的"];
    
    NSArray *tabbarItemTitles = @[@"首页",@"购物车",@"订单",@"我的"];
    // 3. 设置选中视图
    self.selectedTabbarItemBgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, kTabBarViewHeight)];
    self.selectedTabbarItemBgImgView.contentMode = UIViewContentModeScaleAspectFit;
    self.selectedTabbarItemBgImgView.backgroundColor = [UIColor darkGrayColor];;
    self.selectedTabbarItemBgImgView.alpha = 0.6;
    
    for (int i = 0; i < count; i++) {
        [self createTabbarItem:width i:i tabbarItemTitles:tabbarItemTitles tabbarItemImgNames:tabbarItemImgNames tabbarItemSelecteImgNames:tabbarItemSelecteImgNames];
    }
}

/**
 *  购物车消息上下摇动画
 */
- (void)showShopCartMessageButtonAnimation
{
    self.shopCartMessageButton.transform =  CGAffineTransformMakeTranslation(0, -3);
    [UIView animateWithDuration:1.0 delay:0.2 usingSpringWithDamping:0.3 initialSpringVelocity:0.6 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.shopCartMessageButton.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}

/**
 *  购物车消息缩放动画
 */
- (void)_showShopCartMessageButtonScaleAnimation {
    
    self.shopCartMessageButton.transform =  CGAffineTransformMakeScale(1.3, 1.3);
    [UIView animateWithDuration:1.0 delay:0.2 usingSpringWithDamping:0.3 initialSpringVelocity:0.6 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.shopCartMessageButton.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}
/**
 *  点击tabbarItem,执行，选中，取消选中
 */
- (void)_clickTabItemSetSelectedDeselectedWithClickedButton:(UIButton *)button {
    
    NSInteger clickIndex = button.tag-10;
    self.selectedIndex = clickIndex;
    DLTabbarItemView *currentSelectedItemView = (DLTabbarItemView *)button.superview;
    NSInteger currentSelecteIndex = currentSelectedItemView.itemIconButton.tag-10;
    NSInteger lastSelecteIndex = self.lastSelectedTabbarItemView.itemIconButton.tag-10;
    
    if (currentSelecteIndex != lastSelecteIndex) {
        currentSelectedItemView.selected = YES;
        self.lastSelectedTabbarItemView.selected = NO;
        self.lastSelectedTabbarItemView = currentSelectedItemView;
    }
}

/**
 *  点击某个tabbar 的时候，假如没登陆的话，是不能展示该页的，比如购物车，和我的
 */
-(BOOL)_canShowThisPageAtTabbarIndex:(NSInteger)tabbarIndex {
    
    if (SESSIONID) {
        return YES;
    }else {
        if (tabbarIndex == MainPageIndex) {
            return YES;
        }else {
            [kNotification postNotificationName:KNotificationCometoLoginPageFromPerhomePage object:@(tabbarIndex)];
            return NO;
        }
    }
    
}


/**
 *  点击tabbarItem,执行一系列动画
 */
- (void)_clickTabItemShowSerialAnimationWithClickedButton:(UIButton *)button {
    DLTabbarItemView *currentSelectedItemView = (DLTabbarItemView *)button.superview;
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.6 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.selectedTabbarItemBgImgView.center = currentSelectedItemView.center;
    } completion:^(BOOL finished) {
        
    }];
    
    button.transform = CGAffineTransformMakeScale(1.3, 1.3);
    UIButton *titleButton = currentSelectedItemView.itemTitleButton;
    titleButton.transform = CGAffineTransformMakeTranslation(0, 2);
    [UIView animateWithDuration:0.8 delay:0.3 usingSpringWithDamping:0.3 initialSpringVelocity:0.7 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        button.transform = CGAffineTransformIdentity;
        titleButton.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
    NSInteger clickIndex = button.tag-10;
    if (clickIndex == ShopCartPageIndex) {
        [self showShopCartMessageButtonAnimation];
        
    }
}

- (void)_showShopCartItemImgAndTitleShakeAnimation {
    if (!self.shopCartItemView) {
        return;
    }
    UIButton *iconButton = self.shopCartItemView.itemIconButton;
    UIButton *titleButton = self.shopCartItemView.itemTitleButton;
    iconButton.transform = CGAffineTransformMakeTranslation(0, 3);
    titleButton.transform = CGAffineTransformMakeTranslation(0, 3);
    [UIView animateWithDuration:0.8 delay:0.3 usingSpringWithDamping:0.3 initialSpringVelocity:0.7 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        iconButton.transform = CGAffineTransformIdentity;
        titleButton.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}

- (BOOL)_selectShopCartPageAtIndex:(NSInteger )selectIndex {
    if (selectIndex == ShopCartPageIndex) {
        NSInteger lastSelecteIndex = self.lastSelectedTabbarItemView.itemIconButton.tag-10;
        [kNotification postNotificationName:KNotificationSelectShopCartHomePage object:@(lastSelecteIndex)];
        return YES;
    }
    return NO;
}

#pragma mark ------------------------Api----------------------------------

#pragma mark ------------------------Page Navigate---------------------------
#pragma mark - Unused
- (void)_enterLoginPageFromTabbarIndex:(NSInteger)tabbarIndex {
    DLLoginVC *loginVC = [[DLLoginVC alloc] init];
    WEAK_SELF
    [loginVC comFromPerHomePageOfIndex:tabbarIndex backBlock:^(NSInteger backHomePageIndex) {
        if (backHomePageIndex == ShopCartPageIndex) {
            NSInteger lastSelecteIndex = weak_self.lastSelectedTabbarItemView.itemIconButton.tag-10;
            [kNotification postNotificationName:KNotificationSelectShopCartHomePage object:@(lastSelecteIndex)];
            return ;
        }
        [weak_self setTabIndex:backHomePageIndex];
        //        [weak_self _selectShopCartPageAtIndex:tabbarIndex];
    }];
    DLBaseNavController *loginNav = [[DLBaseNavController alloc] initWithRootViewController:loginVC];
    [self presentViewController:loginNav animated:YES completion:nil];
    
}

#pragma mark ------------------------View Event---------------------------
- (void)click:(UIButton *)button
{
    //未登录情况处理
    NSInteger clickIndex = button.tag-10;
    if (![self _canShowThisPageAtTabbarIndex:clickIndex]) {
        //        [self _enterLoginPageFromTabbarIndex:clickIndex];
        return;
    }
    
    //登录情况下，进入第一个购物车页,发通知，让它进入真正购物车
    if ([self _selectShopCartPageAtIndex:clickIndex]) {
        return;
    }
    
    [self _clickTabItemSetSelectedDeselectedWithClickedButton:button];
    [self _clickTabItemShowSerialAnimationWithClickedButton:button];
}

#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------
- (void)switchCommunityShopCartGoodsNumberChange:(NSNotification *)info {
    CommunityModel *newCommunityModel = info.object;
    if ([newCommunityModel.communityId isEqualToString:kCommunityId]) {
        return;
    }
    self.shopCartBadgeNumber = 0;
}

- (void)shopCartGoodsNumberChange:(NSNotification *)info {
    BOOL isAdd = [info.object boolValue];
    if (isAdd) {
        [self _showShopCartItemAnimation];
    }
    self.shopCartBadgeNumber = self.shopCartGoodsManager.shopCartGoodsNumber;
}


#pragma mark ------------------------Getter / Setter----------------------

- (void)setTabIndex:(NSInteger)index {
    
    UIButton *indexTabbutton = [self _getButtonOnTabbarWithTabbarIndex:index];
    if (!indexTabbutton) {
        return;
    }
    [self _clickTabItemSetSelectedDeselectedWithClickedButton:indexTabbutton];
}

- (UIButton *)_getButtonOnTabbarWithTabbarIndex:(NSInteger)tabbarIndex {
    NSInteger buttonTag = tabbarIndex + 10;
    UIButton *indexTabbutton = (UIButton *)[self.tabbarReplaceView viewWithTag:buttonTag];
    return indexTabbutton;
}

- (void)_showShopCartItemAnimation {
    [self _showShopCartItemImgAndTitleShakeAnimation];
    [self showShopCartMessageButtonAnimation];
}

- (void)setShopCartItemBadgeValue {
    self.shopCartMessageButton.hidden = !self.shopCartBadgeNumber;
    NSString *shopCartNumberStr = [NSString stringWithFormat:@"%ld",self.shopCartBadgeNumber];
    [self.shopCartMessageButton setTitle:shopCartNumberStr forState:UIControlStateNormal];
}

- (void)setShopCartBadgeNumber:(NSInteger)shopCartBadgeNumber {
    
    _shopCartBadgeNumber = shopCartBadgeNumber;
    [self _showShopCartMessageButtonScaleAnimation];
    [self setShopCartItemBadgeValue];
}

-(UIButton *)shopCartMessageButton {
    
    if (!_shopCartMessageButton) {
        _shopCartMessageButton = [UIButton new];
        _shopCartMessageButton.backgroundColor = UIColorFromRGB(0xff3a30);
        _shopCartMessageButton.layer.masksToBounds = YES;
        _shopCartMessageButton.layer.cornerRadius = 8;
        //        _shopCartMessageButton.titleLabel.font = kSystemFontSize(8);
        _shopCartMessageButton.titleLabel.font = [UIFont boldSystemFontOfSize:8.0f];
        
    }
    return _shopCartMessageButton;
}

- (ShopCartGoodsManager *)shopCartGoodsManager {
    if (!_shopCartGoodsManager) {
        _shopCartGoodsManager = [ShopCartGoodsManager sharedManager];
    }
    return  _shopCartGoodsManager;
}

#pragma mark - UITabarDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    //    UIButton *indexTabbutton = [self _getButtonOnTabbarWithTabbarIndex:tabBarController.selectedIndex];
    //    [self click:indexTabbutton];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
