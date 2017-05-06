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
#import "NSArray+SUIAdditions.h"
#import "DLEvaluationDetailsView.h"
#import "FavoriteAlertView.h"
#import "NSString+Teshuzifu.h"
#import "CWStarRateView.h"
#import "CycleScrollPageShowView.h"


//#define noPictureTextDetailViewMinHeight  (kScreenHeight - kScreenWidth - 49 - 63 - 113 - 50)
const CGFloat noPictureTextDetailViewMinHeight = 45;
const CGFloat noPictureTextDetailViewMaxHeight = 180;

#define kBottomViewHeight 50
//图文详情高度
#define kIntegralPhotoTextDetailViewHeight (kScreenHeight-kNavBarAndStatusBarHeight)

//触发上拉高度
#define Integral_OffetTrrigerScrollToDown 70

@interface DLGoodsdetailVC ()<UIScrollViewDelegate,SDCycleScrollViewDelegate>

//scrollView最大可滑动的距离
@property (nonatomic, assign)CGFloat ableScrollHeight;

@property (weak, nonatomic) IBOutlet UIView *gdScrollContentView;
@property (weak, nonatomic) IBOutlet UIView *noPictureTextDetailView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *noPictureTextDetailViewHeightConstraint;
@property (weak, nonatomic) IBOutlet CWStarRateView *storeCommentStarView;
@property (weak, nonatomic) IBOutlet CycleScrollPageShowView *imgPageShowView;
@property (nonatomic, strong)GoodsPhotoTextDetailView *goodsPhotoTextDetailView;
@property (nonatomic, strong)GoodsPhotoTextDetailView *truegoodsPhotoTextDetailView;
@property (weak, nonatomic) IBOutlet UIScrollView *gdScrollView;
@property (weak, nonatomic) IBOutlet SDCycleScrollView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UIView *storeView;
@property (weak, nonatomic) IBOutlet UILabel *markHasPictureTextDetailLabel;
@property (nonatomic,strong) DLEvaluationDetailsView *evaluationDetailsView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsStandLabel;
@property (weak, nonatomic) IBOutlet UILabel *originalPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *vipPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *freeShippingAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *businessTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *storeImgView;
@property (weak, nonatomic) IBOutlet ShopCartView *shopCartView;

@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (nonatomic,assign) BOOL isRequestingFavorite;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *storeNameLabelMaxWidthConstraint;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentContentViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *commentContentView;
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
    
    self.headerView.placeholderImage = IMAGE(@"placeHolder_square");

    self.shopCartView.neetoShowYellowBg = NO;
    self.lookPhotoTextDetailLineViewToTopConstraint.constant = (kScreenHeight/iPhone6_Height)*193;
    
//    @weakify(self);
//    [RACObserve(self.shopCartGoodsManager, totalPrice) subscribeNext:^(NSNumber * totalPrice) {
//        @strongify(self);
//        if (totalPrice.floatValue < 0) {
//            totalPrice = @(0.00);
//        }
//        self.totalPriceLabel.text = jFormat(@"￥%.2f",totalPrice.floatValue);
//    }];
      [self _initCommentView];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self _requestStoreDetailInfo];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
}

- (void)_backPage {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)_initCommentView {
    self.evaluationDetailsView.goodsId = self.goodsId;
    WEAK_SELF
    self.evaluationDetailsView.goodsDetailCommentHeightBlock = ^(CGFloat commentHeight){
        weak_self.commentContentView.hidden = commentHeight < 1.0f;
        weak_self.commentContentViewHeightConstraint.constant = commentHeight;
    };
}


#pragma mark -------------------Api Method----------------------
- (void)_requestIntegralGoodsDetailData {
    self.requestParam = @{@"saleProductId":self.goodsId};
    [AFNHttpRequestOPManager postWithParameters:self.requestParam subUrl:kUrl_GoodsDetail block:^(NSDictionary *resultDic, NSError *error) {
        self.goodsModel = [[GoodsModel alloc] initWithDefaultDataDic:resultDic[EntityKey]];
        [self _assignGoodsUI];
        [self dissmiss];
    }];
}

- (void)_requestFavorite{
    
    self.isRequestingFavorite = YES;
    if (isEmpty(self.goodsModel.productId)) {
        return;
    }
    self.requestParam = @{@"productId":self.goodsModel.productId};
    [AFNHttpRequestOPManager postWithParameters:self.requestParam subUrl:KUlr_FavoriteGoods block:^(NSDictionary *resultDic, NSError *error) {
        self.isRequestingFavorite = NO;
        if (error.code == 1) {
            [self _configureAfterRequestGoodsFavorite:YES];
        }
    }];
}

- (void)_requestCancelFavorite {
    self.isRequestingFavorite = YES;
    if (isEmpty(self.goodsModel.productId)) {
        return;
    }
    self.requestParam = @{@"productIds":self.goodsModel.productId};
    [AFNHttpRequestOPManager postWithParameters:self.requestParam subUrl:Kurl_CancelFavoriteGoods block:^(NSDictionary *resultDic, NSError *error) {
        self.isRequestingFavorite = NO;
        if (error.code == 1) {
            [self _configureAfterRequestGoodsFavorite:NO];
        }
    }];
}

- (void)_requestStoreDetailInfo {
    self.requestParam = @{@"storeId":kCommunityStoreId};
    [AFNHttpRequestOPManager postWithParameters:self.requestParam subUrl:KUrl_GetStoreDetailInfo block:^(NSDictionary *resultDic, NSError *error) {
        StoreModel *storeModel = [[StoreModel alloc] initWithDefaultDataDic:resultDic[EntityKey]];
        [self _assignStoreCommentStartViewWithStore:storeModel];
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
    self.favoriteButton.selected = self.goodsModel.userHasFavorite;
    [self _configureUiWhenCheckTheStock];
    [self _assignStoreUI];
    self.hasPictureTextDetail = !isEmpty(self.goodsModel.productDetail);
}

- (void)_configureUiWhenCheckTheStock {
    NSInteger nowGoodsCount = [self.shopCartGoodsManager goodsNumberOfGoodsModel:self.goodsModel];
    BOOL canAddShopCart = nowGoodsCount < self.goodsModel.goodsStock.integerValue;
    self.addShopCartButton.enabled = canAddShopCart;
    self.addShopCartButton.backgroundColor = canAddShopCart ? KSelectedBgColor  : KViewBgColor;
    self.addShopCartButton.alpha = canAddShopCart ? 1 : 0.5;
}

- (void)_assignStoreCommentStartViewWithStore:(StoreModel *)storeModel {
    self.storeNameLabelMaxWidthConstraint.constant = kScreenWidth - 164;
    self.storeCommentStarView.frame = CGRectMake(CGRectGetMaxX(self.storeNameLabel.frame)+4, 14, 100, 15);
    self.storeCommentStarView.originalImgName = @"starMakeCommentNormal";
    self.storeCommentStarView.hilightedImgName = @"starMakeCommentHilight";
    self.storeCommentStarView.isCanbeTouch = NO;
    self.storeCommentStarView.scorePercent = storeModel.storeScore;
    
}

- (void)_assignStoreUI {
    self.storeNameLabel.text = kCurrentStore.storeName;
    self.businessTimeLabel.text = jFormat(@"服务时间：%@-%@",[kCurrentStore.storeBusinessBeginTime cutOutHourMinuteStr] , [kCurrentStore.storeBusinessEndTime cutOutHourMinuteStr]);
    self.freeShippingAmountLabel.text = jFormat(@"本店满%.1f免运费",kCurrentStore.deduceTransCostAmount.floatValue/1000);
    NSString *storeStatusImgName = kCurrentStoreOnbusinessTimeNumber == 0 ? @"营业" : @"已打烊";
    self.storeImgView.image = IMAGE(storeStatusImgName);
}

- (void)_configureAfterRequestGoodsFavorite:(BOOL)isFavorite {
    NSString *alertStr = isFavorite ? @"收藏成功" : @"取消收藏成功";
    self.favoriteButton.selected = isFavorite;
    [FavoriteAlertView showAlertTitle:alertStr inContentView:self.view];
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
    NSArray *imgUrlArr = nil;
    if (isEmpty(self.goodsModel.saleProductImageList)) {
        if (self.goodsModel.goodsThumbnail) {
            imgUrlArr = @[self.goodsModel.goodsThumbnail];
        }
    }else {
        imgUrlArr = [self.goodsModel.saleProductImageList sui_map:^NSString *(NSDictionary * obj, NSUInteger index) {
            return obj[@"saleProductImageUrl"];
        }];
    }
    self.headerView.imageURLStringsGroup = imgUrlArr;
    self.headerView.delegate = self;
//    self.imgPageShowView.totolPage = imgUrlArr.count;
    self.headerView.autoScroll = NO;
    self.headerView.showPageControl = NO;
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

- (DLEvaluationDetailsView *)evaluationDetailsView {

    if (!_evaluationDetailsView) {
        _evaluationDetailsView = BoundNibView(@"DLEvaluationDetailsView", DLEvaluationDetailsView);
        [self.commentContentView addSubview:_evaluationDetailsView];
        [_evaluationDetailsView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.mas_equalTo(self.commentContentView);
            make.bottom.left.right.mas_equalTo(self.self.commentContentView);
            make.top.mas_equalTo(0);
        }];
    }
    return _evaluationDetailsView;

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

- (IBAction)favoriteAction:(id)sender {
    
    if (![self unloginHandle]) {
        return;
    }

    if (self.isRequestingFavorite) {
        return;
    }
    
    BOOL goodsHasFavorite = self.favoriteButton.selected;
    
    if (goodsHasFavorite) {
        [self _requestCancelFavorite];
    }else {
        [self _requestFavorite];
    }
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

#pragma mark - SDCycleScrollView Delegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    
    self.imgPageShowView.currentPage = index + 1;

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
