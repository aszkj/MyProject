//
//  IntegralGoodsDetailController.m
//  jingGang
//
//  Created by 张康健 on 15/11/2.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "DLGoodsdetailVC.h"
#import "GoodsPhotoTextDetailView.h"
#import "Util.h"
#import "ShopCartGoodsNumberChangeView.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "ShopCartGoodsManager.h"
#import "CommunityDataManager.h"
#import "ShopCartView.h"
#import "ProjectRelativeDefineNotification.h"
#import "DLShopCarVC.h"
#import "GlobleConst.h"
#import "DLGoodsdetailVC+shopCartAddDifferentGoodsTypeDeal.h"
#import <Masonry/Masonry.h>
#import "UIViewController+unLoginHandle.h"
#import "ShopCartGoodsManager+shopCartInfo.h"
const CGFloat noPictureTextDetailViewMinHeight = 50;
const CGFloat noPictureTextDetailViewMaxHeight = 180;

#define kBottomViewHeight 50
//图文详情高度
#define kIntegralPhotoTextDetailViewHeight (kScreenHeight-kNavBarAndStatusBarHeight)

//触发上拉高度
#define Integral_OffetTrrigerScrollToDown 70

@interface DLGoodsdetailVC ()<UIScrollViewDelegate>

//scrollView最大可滑动的距离
@property (nonatomic, assign)CGFloat ableScrollHeight;

@property (weak, nonatomic) IBOutlet UIView *gdScrollContentView;
@property (weak, nonatomic) IBOutlet UIView *noPictureTextDetailView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *noPictureTextDetailViewHeightConstraint;

@property (nonatomic, strong)GoodsPhotoTextDetailView *goodsPhotoTextDetailView;
@property (nonatomic, strong)GoodsPhotoTextDetailView *truegoodsPhotoTextDetailView;
@property (weak, nonatomic) IBOutlet UIScrollView *gdScrollView;
@property (weak, nonatomic) IBOutlet SDCycleScrollView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UIView *storeView;
@property (weak, nonatomic) IBOutlet UILabel *markHasPictureTextDetailLabel;

@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsStandLabel;
@property (weak, nonatomic) IBOutlet UILabel *originalPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *vipPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *freeShippingAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *businessTimeLabel;
@property (weak, nonatomic) IBOutlet ShopCartView *shopCartView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lookPhotoTextDetailLineViewToTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomGapConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *addShopCartButton;
@property (nonatomic, strong)ShopCartGoodsManager *shopCartGoodsManager;

@property (nonatomic, assign)BOOL isShowThePictureText;

@property (nonatomic, assign)BOOL hasPictureTextDetail;
@property (nonatomic, strong)MASConstraint *pictureTextViewToTopConstraint;

@end

@implementation DLGoodsdetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    
    [self showHubWithDefaultStatus];
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    if (!self.isShowThePictureText) {
        self.navigationController.navigationBar.hidden = YES;
    }else {
        
    }
    
    
    //请求商品详情数据
    [self _requestIntegralGoodsDetailData];
    [self.shopCartView initShopCartGoods];


}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    if (!self.isShowThePictureText) {
        self.navigationController.navigationBar.hidden = NO;
    }
    
   
}


#pragma mark ----------------------- Init Method -----------------------
- (void)_init {
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 40)];
    titleLable.font = [UIFont systemFontOfSize:18.0];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.textColor = UIColorFromRGB(0x333333);
    titleLable.text = @"商品详情";
    self.navigationItem.titleView = titleLable;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithNormalImage:@"nav_Back" target:self action:@selector(_backPage)];
    
    
    self.shopCartView.neetoShowYellowBg = NO;
    self.lookPhotoTextDetailLineViewToTopConstraint.constant = (kScreenHeight/iPhone6_Height)*193;
    [self.shopCartView initShopCartGoods];
    @weakify(self);
    [RACObserve(self.shopCartGoodsManager, totalPrice) subscribeNext:^(NSNumber * totalPrice) {
        @strongify(self);
        if (totalPrice.floatValue < 0) {
            totalPrice = @(0.00);
        }
        self.totalPriceLabel.text = jFormat(@"￥%.2f",totalPrice.floatValue);
    }];
    WEAK_SELF
    self.shopCartView.gotoShopCartPageBlock = ^{
        [weak_self _enterShopCartPage];
    };
}

- (void)_backPage {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark -------------------Api Method----------------------
#pragma mark - 请求商品详情数据
- (void)_requestIntegralGoodsDetailData {
    self.requestParam = @{@"saleProductId":self.goodsId};
 
    [AFNHttpRequestOPManager postWithParameters:self.requestParam subUrl:kUrl_GoodsDetail block:^(NSDictionary *resultDic, NSError *error) {
        self.goodsModel = [[GoodsModel alloc] initWithDefaultDataDic:resultDic[EntityKey]];
        [self _assignGoodsUI];
        [self dissmiss];
    }];
}

#pragma mark -------------------PageNavigate Method----------------------
- (void)_enterShopCartPage {
    DLShopCarVC *shopCartPage = [[DLShopCarVC alloc] init];
    [self navigatePushViewController:shopCartPage animate:YES];
}


#pragma mark -------------------Private Method----------------------
-(void)_assignGoodsUI{
    //头部
    [self _assignHeaderViewData];
    self.goodsNameLabel.text = self.goodsModel.goodsName;
    self.originalPriceLabel.text = jFormat(@"¥%.2f",self.goodsModel.goodsOriginalPrice.floatValue);
    self.vipPriceLabel.text = jFormat(@"¥%.2f",self.goodsModel.goodsVipPrice.floatValue);
    self.goodsStandLabel.text = jFormat(@"%@",self.goodsModel.goodsStand);
    [self _configureUiWhenCheckTheStock];
    [self _assignStoreUI];
    self.hasPictureTextDetail = !isEmpty(self.goodsModel.productDetail);
}

- (void)_configureUiWhenCheckTheStock {
    NSInteger nowGoodsCount = [self.shopCartGoodsManager goodsNumberOfGoodsModel:self.goodsModel];
    BOOL canAddShopCart = nowGoodsCount < self.goodsModel.goodsStock.integerValue;
    self.addShopCartButton.enabled = canAddShopCart;
    self.addShopCartButton.backgroundColor = canAddShopCart ? KSelectedBgColor  : UIColorFromRGB(0xf1f1f1);
    self.addShopCartButton.alpha = canAddShopCart ? 1 : 0.5;
}


- (void)_assignStoreUI {
    self.storeNameLabel.text = kCurrentStore.storeName;
    self.businessTimeLabel.text = jFormat(@"服务时间：%@-%@",kCurrentStore.storeBusinessBeginTime,kCurrentStore.storeBusinessEndTime);
    self.freeShippingAmountLabel.text = jFormat(@"本店满%.1f免运费",kCurrentStore.deduceTransCostAmount.floatValue/1000);
    
}

- (void)_configureUIByWhetherHasThePictureTextDetail {
    self.noPictureTextDetailView.hidden = self.hasPictureTextDetail;
    self.markHasPictureTextDetailLabel.hidden = !self.hasPictureTextDetail;
    if (self.hasPictureTextDetail) {
        if (kScreenWidth == iPhone6p_width) {
            self.bottomGapConstraint.constant = 30;
            self.bottomViewHeightConstraint.constant = 140;
        }
        self.noPictureTextDetailViewHeightConstraint.constant = noPictureTextDetailViewMinHeight;
        [self _loadPhotoTextView];
    }else {
        self.noPictureTextDetailViewHeightConstraint.constant = noPictureTextDetailViewMaxHeight;
    }

}

#pragma mark -------------------Private Method----------------------
- (void)_alertAddDifferentTypeGoods {
    
    AlertViewManager *alertManager =  [[AlertViewManager alloc] init];
    
    NSString *alertStr = [self addDifferentGoodsTypeAlertStr];
    
    WEAK_SELF
    //两个action
    [alertManager showAlertViewWithControllerTitle:@"提示" message:alertStr controllerStyle:UIAlertControllerStyleAlert isHaveTextField:NO actionTitle:@"确定" actionStyle:UIAlertActionStyleDefault alertViewAction:^(UIAlertAction *action) {
        [[ShopCartGoodsManager sharedManager] clearAllShopCartData];
        [weak_self _addGoodsLogic];
    } otherActionTitle:@"取消" otherActionStyle:UIAlertActionStyleDefault otherAlertViewAction:^(UIAlertAction *action) {
        
    }];
}

- (void)_addGoodsLogic {
    
    if ([self dealPennyGoods]) {
        return;
    }
    
    [self.shopCartGoodsManager addShopCartGoodsWithGoodsModel:self.goodsModel isInShopCartPage:NO];
    [kNotification postNotificationName:KNotificationShopCartBadgeValueNeedChange object:@(NO)];
    [self _configureUiWhenCheckTheStock];
}

#pragma mark - 头部视图数据
-(void)_assignHeaderViewData {
    self.headerView.imageURLStringsGroup = [self.goodsModel.goodsThumbnail componentsSeparatedByString:@";"];
}

#pragma mark - 图文详情view
-(void)_loadPhotoTextView{
    _goodsPhotoTextDetailView = BoundNibView(@"GoodsPhotoTextDetailView", GoodsPhotoTextDetailView);
    [self.gdScrollContentView addSubview:_goodsPhotoTextDetailView];
    [_goodsPhotoTextDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.gdScrollContentView.mas_bottom);
        make.left.right.mas_equalTo(self.gdScrollContentView);
        make.height.mas_equalTo(kIntegralPhotoTextDetailViewHeight);
    }];
}

- (void)_loadNoPhotoTextDetailView {
    UIImageView *noPhotoTextDetailImgView = [UIImageView new];
    [self.gdScrollContentView addSubview:noPhotoTextDetailImgView];
    noPhotoTextDetailImgView.image = IMAGE(@"buyer_logo");
    [noPhotoTextDetailImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.storeView.mas_bottom);
        make.left.mas_equalTo(50);
        make.size.mas_equalTo(CGSizeMake(200, 222));
        make.bottom.mas_equalTo(-20);
    }];
}
 
#pragma mark 添加真正的图文详情view
-(void)addTruePhotoTextView{
      self.navigationController.navigationBar.hidden = NO;
      self.isShowThePictureText = YES;
    if (!_truegoodsPhotoTextDetailView) {

        _truegoodsPhotoTextDetailView = BoundNibView(@"GoodsPhotoTextDetailView", GoodsPhotoTextDetailView);
        [self.view addSubview:_truegoodsPhotoTextDetailView];
        WEAK_SELF
        [_truegoodsPhotoTextDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
            weak_self.pictureTextViewToTopConstraint =  make.top.mas_equalTo(kNavBarAndStatusBarHeight);
            make.left.right.mas_equalTo(self.view);
            make.height.mas_equalTo(kIntegralPhotoTextDetailViewHeight);
        }];
        //图文详情部分
        _truegoodsPhotoTextDetailView.ptPhotoDetailWebUrlStr= self.goodsModel.productDetail;
        _truegoodsPhotoTextDetailView.upBlock = ^(NSInteger selectedIndex){
            //拉上来的时候，，将真实的隐藏
            weak_self.truegoodsPhotoTextDetailView.hidden = YES;
            weak_self.navigationController.navigationBar.hidden = YES;
            [weak_self.gdScrollView setContentOffset:CGPointMake(0, weak_self.ableScrollHeight) animated:YES];
            weak_self.isShowThePictureText = NO;
        };
        
    }else{
        
        _truegoodsPhotoTextDetailView.hidden = NO;
    }
}

#pragma mark -------------------Setter/Getter Method----------------------
-(ShopCartGoodsManager *)shopCartGoodsManager {
    
    if (!_shopCartGoodsManager) {
        _shopCartGoodsManager = [ShopCartGoodsManager sharedManager];
    }
    return _shopCartGoodsManager;
}

- (void)setHasPictureTextDetail:(BOOL)hasPictureTextDetail {
    _hasPictureTextDetail = hasPictureTextDetail;
    [self _configureUIByWhetherHasThePictureTextDetail];
    
}



#pragma mark ----------------------- Action Method -----------------------
- (IBAction)backAction:(id)sender {
    [self goBack];
}

- (IBAction)enterShopCartAction:(id)sender {
    if (![self unloginHandle]) {
        return;
    }
    [self _enterShopCartPage];
}

- (IBAction)addShopCartAction:(id)sender {
    
    if (![self currentCommunityStoreOnBussiness]) {
        return;
    }
    
    if ([ShopCartGoodsManager sharedManager].shopCartGoodsNumber) {
        if (![self isTheSameTypeGoodsOfAddingShopCart]) {
            [self _alertAddDifferentTypeGoods];
            return;
        }
    }
    
    [self _addGoodsLogic];
}

#pragma mark - scrollView delegate
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (!self.hasPictureTextDetail) {
        return;
    }
    JLog(@"will end drag content offset %.2f",scrollView.contentOffset.y);
    if (!(int)_ableScrollHeight) {
        _ableScrollHeight = scrollView.contentSize.height-scrollView.frame.size.height;
    }
    //scrollScrollTopBottonOffset
    if (scrollView.contentOffset.y > _ableScrollHeight + Integral_OffetTrrigerScrollToDown)            {
        //#warning 松手后它可能会往下滑动，，而我是想让他定在那里然后往上滑
        targetContentOffset->y = scrollView.contentOffset.y;
    
        [self performSelector:@selector(_scrollToUp) withObject:nil afterDelay:0.2];
    }
}

-(void)_scrollToUp {

    [self.gdScrollView setContentOffset:CGPointMake(0, _ableScrollHeight+kIntegralPhotoTextDetailViewHeight) animated:YES];
    [self performSelector:@selector(addTruePhotoTextView) withObject:nil afterDelay:0.3];
}

- (void)_scrollToDown {
     [self.gdScrollView setContentOffset:CGPointMake(0, self.ableScrollHeight) animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
