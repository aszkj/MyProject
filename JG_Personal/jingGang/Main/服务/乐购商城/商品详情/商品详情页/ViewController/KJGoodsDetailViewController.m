//
//  KJGoodsDetailViewController.m
//  jingGang
//
//  Created by 张康健 on 15/8/5.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "KJGoodsDetailViewController.h"
#import "PublicInfo.h"
#import "shareView.h"
#import "Masonry.h"
#import "KJGoodDetailPhotoTextDetailView.h"
#import "GlobeObject.h"
#import "SDCycleScrollView.h"
#import "KJGuessYouLikeCollectionView.h"
#import "KJAddShoppingCarView.h"
#import "KJShoppingAlertView.h"
#import "VApiManager.h"
#import "UIImageView+WebCache.h"
#import "GoodsEvaluateModel.h"
#import "NSDate+Addition.h"
#import "GoodsConsultController.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "GoodsConsultlistShowConstroller.h"
#import "OrderDetailController.h"
#import "WSJShoppingCartViewController.h"
#import "KJDarlingCommentVC.h"
#import "WSJShopHomeViewController.h"
#import "ZkgLoadingHub.h"
#import "ShowGoodsPhotoView.h"
#import "Util.h"
#import "WSJEvaluateListViewController.h"
#import "NodataShowView.h"
#import "GoodsSquModel.h"
#import "UIView+BlockGesture.h"
#import "PublicInfo.h"
#import "AppDelegate.h"
#import "ShopCartView.h"
#import "KJPhotoBrowser.h"
#import "JGShareView.h"
#import "TMCache.h"
#import "OrderConfirmViewController.h"
//触发scrollView上拉滑到web详情的偏移量
CGFloat const OffetTrrigerScrollToDown = 70.0f;

CGFloat const NavBarStatusBarHeight = 64.0f;

//最底部view高度
CGFloat const BottonBarHeight = 60.0f;

//scroll 滑到最底部的偏移量
CGFloat const scrollScrollTopBottonOffset = 590.0f;

//没有评论时评论视图的高度
CGFloat const noCommentCommentViewHeight = 34;

//图文详情view高度
//CGFloat const PhotoTextViewHeight = kScreenHeight - NavBarStatusBarHeight - BottonBarHeight;
#define PhotoTextViewHeight (kScreenHeight - NavBarStatusBarHeight - BottonBarHeight)

@interface KJGoodsDetailViewController ()<UIScrollViewDelegate,SDCycleScrollViewDelegate>{
    VApiManager *_vapmanager;
    
    NSMutableDictionary *_goodsCationMutableDic;//商品规格与属性对应的字典
    
    NSArray             *_squArr;        //squ数组，查找商品价格的根据选择的商品属性
    NSMutableArray      *_guessYouLikeArr; //猜您喜欢数组
    
    CGFloat             _goodsActualPrice; //商品实际价格
    NSDictionary        *_requestDataDic; //最开始请求的网络数据
    
    CGFloat _ableScrollHeight;             //scrollView最大可滑动的距离
    BOOL                _isAddedCart;       //是否加入了购物车
    BOOL                _isImidiatelyBuy;   //是否是立即购买
    NSNumber            *_goodsBuyCount;
    BOOL                _isSelectGoodsCation;
    shareView           *_shareView;
    UIView              *_maskView;
    
    CALayer             *animateImgViewlayer; //加入购物车动画imgView layer
    
    ShopCartView        *_shopCartView;
    
    NSInteger           _shopCartCount;
    
    NodataShowView      *_noDataView;
    
    TMCache             *_guessYouLikeArrCache;
}

//标志有商品规格
@property (nonatomic, assign)BOOL hasGoodsCation;

@property (nonatomic, assign)BOOL isShowingAddShoppingCartAnimation;

@property (strong, nonatomic) JGShareView *shareview;
//分享视图
@property (nonatomic, strong)shareView *shareView;

@property (nonatomic, strong)UIView *maskView;

//加入购物车动画曲线
@property (nonatomic,strong) UIBezierPath *addShopAnimateBezier;

//选择的商品规格id
@property (nonatomic, strong)NSString *selectedGoodsCationIdStr;

//scrollContentView
@property (weak, nonatomic) IBOutlet UIView *gdScrollContentView;

//上拉加载更多视图
@property (weak, nonatomic) IBOutlet UIView *gdPullToseeMoreDetailView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerHeightConstraint;

//scrollView
@property (weak, nonatomic) IBOutlet UIScrollView *gdScrollView;

//图文详情view,加在scrollView上的，，这个其实只是个假的只是为了上拉快拉上来那部分展示用的
@property (nonatomic,strong) KJGoodDetailPhotoTextDetailView *kjGoodDetailPhotoTextDetailShowView;
//这部分才是真正起作用的，，，拉上来之后加在self.view上的，之所以这样是因为scrollView滑动超过了自己的内容view,后，，超过的部分响应不了事件，，
@property (nonatomic,strong) KJGoodDetailPhotoTextDetailView *kjGoodDetailPhotoTextDetailTrueView;

//头部视图
@property (weak, nonatomic) IBOutlet SDCycleScrollView *headerScrollView;

//猜您喜欢collectionView
@property (weak, nonatomic) IBOutlet KJGuessYouLikeCollectionView *guessYouLikeCollectionView;
@property (weak, nonatomic) IBOutlet UIView *selectView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selectViewHeightConstraint;

//添加购物车view
@property (nonatomic, strong)KJAddShoppingCarView *addShoppingCarView;
//价格label

#pragma mark ------------------商品描述价格部分---------------------------------
@property (weak, nonatomic) IBOutlet ShowGoodsPhotoView *goodsCommentPhotoView;
@property (weak, nonatomic) IBOutlet UITextView *goodsDescriptionTextView;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;
//积分兑换label
@property (weak, nonatomic) IBOutlet UILabel *integralExchangeLabel;
//手机专享价imgView
@property (weak, nonatomic) IBOutlet UIImageView *phoneSpecialShareImgView;
//已选商品的属性label
@property (weak, nonatomic) IBOutlet UILabel *selectedGoodsPropertyLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectGoodsCationButton;
@property (weak, nonatomic) IBOutlet UILabel *selectGoodsCationLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentPhotoViewHeightConstraint;
#pragma mark --------------------评价部分---------------------------------
//评论视图高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *commentView;
@property (weak, nonatomic) IBOutlet UILabel *commentViewTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *commentFirstHeaderImgView;
@property (weak, nonatomic) IBOutlet UILabel *commentFirstUserNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *firstCommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstCommentGoodsTypeLabel;
@property (weak, nonatomic) IBOutlet UIButton *seeMoreCommentButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *seeMoreCommentViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *addShopCartButton;
@property (weak, nonatomic) IBOutlet UIButton *immiditelyBuyButton;
//店铺button
@property (weak, nonatomic) IBOutlet UIButton *goodsStoreButton;
//店铺view
@property (weak, nonatomic) IBOutlet UIView *storeView;
//自营view
@property (weak, nonatomic) IBOutlet UIView *selSaleView;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
//收藏按钮
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;


@end

@implementation KJGoodsDetailViewController

#pragma mark -------------- life cycle --------------
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    
    //初始化头部视图
    [self _initHeaderView];
    
    //初始化猜您喜欢collectionView
    [self _initGuessYouLikeCollectionView];
    
    //添加图文详情view
    [self _loadPhotoTextView];
    
    //请求网络，基本上除了猜您喜欢的所有数据
    [self _requestGoodData];
    
    //请求猜您喜欢
    [self _requestGuessYourLikeData];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    _isImidiatelyBuy = NO;
    _isSelectGoodsCation = NO;
    _isAddedCart = NO;
    if (!IsEmpty(GetToken)) {
        //添加小购物车视图
        [self _addShopCartView];
    }

    AppDelegate *app = kAppDelegate;
    [app.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [app.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
}


-(void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:YES];
    
    if (!IsEmpty(GetToken)) {
        [_shopCartView removeFromSuperview];
    }

#pragma mark 有您喜欢缓存
    [self _youScanedGoodsCache];
}



#pragma mark -------------- private Method --------------
-(void)_init{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _goodsBuyCount = @1;
    _ableScrollHeight = 0.0;
    _vapmanager = [[VApiManager alloc] init];
    [Util setNavTitleWithTitle:@"商品详情" ofVC:self];
    
    self.navigationController.navigationBar.barTintColor = kGetColor(94, 180, 231);
    //返回
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(detailBack) target:self];
    _guessYouLikeArrCache = [TMCache sharedCache];
//    //navRight,购物车
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem initWithNormalImage:@"iconfont-gouwuche---Assistor" target:self action:@selector(goToShoppingCart)];
    
    //开始网络数据还没到，，加入购物车，，立即购物不让点
    self.addShopCartButton.enabled = NO;
    self.immiditelyBuyButton.enabled = NO;
    
    self.headerHeightConstraint.constant = kScreenWidth;
    _isShowingAddShoppingCartAnimation = NO;
    
    
    //初始化beisaier
    [self _initBezial];
    
    //maskview
    [self _loadMaskView];
    
    //注册商品squ改变通知
    [kNotification addObserver:self selector:@selector(changeGoodsSquObserve:) name:changeGoodsSquNotification object:nil];
    
}

#pragma mark - 浏览过的商品id缓存
-(void)_youScanedGoodsCache{
    
    NSArray *cachedArr = [_guessYouLikeArrCache objectForKey:KHasYoulikeCacheKey];
    BOOL isCached = NO;
    NSString *nowScaningGoodIdStr = self.goodsID.stringValue;
    for (NSString *cachedGoodsID in cachedArr) {
        if ([nowScaningGoodIdStr isEqualToString:cachedGoodsID]) {
            isCached = YES;
        }
    }
    
    if (!isCached) {//没有缓存过
        NSMutableArray *tempArr = [NSMutableArray arrayWithArray:cachedArr];
        [tempArr insertObject:nowScaningGoodIdStr atIndex:0];
        [_guessYouLikeArrCache setObject:(NSArray *)tempArr forKey:KHasYoulikeCacheKey];
    }
}


#pragma mark - 添加小购物车视图
-(void)_addShopCartView{
    
    _shopCartView = [ShopCartView showOnNavgationView:self.navigationController.view];
    
    //开始请求购物车数量
    [_shopCartView requestAndSetShopCartNumber];
    
    WEAK_SELF
    _shopCartView.cominToShopCartBlock = ^{
        [weak_self goToShoppingCart];
    };
    
}


#pragma mark - 请求猜您喜欢数据
- (void)_requestGuessYourLikeData {
    
    LikeGoodsListRequest *request = [[LikeGoodsListRequest alloc] init:GetToken];
    NSArray *guessYourLikeIdArr = [_guessYouLikeArrCache objectForKey:KHasYoulikeCacheKey];
    if (guessYourLikeIdArr.count > 0) {//说明有
        NSString *guessYoulikeIdStr = [guessYourLikeIdArr componentsJoinedByString:@","];
        request.api_likeIds = guessYoulikeIdStr;
    }

    [_vapmanager likeGoodsList:request success:^(AFHTTPRequestOperation *operation, LikeGoodsListResponse *response) {
        
        _guessYouLikeArr = [NSMutableArray arrayWithCapacity:response.goodsList.count];
        for (NSDictionary *dic in response.goodsLikeList) {
            GoodsDetailModel *model = [[GoodsDetailModel alloc] initWithJSONDic:dic];
            [_guessYouLikeArr addObject:model];
        }
        //刷新猜您喜欢collectionView
        self.guessYouLikeCollectionView.data = (NSArray *)_guessYouLikeArr;
        [self.guessYouLikeCollectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
    
    
}
#pragma mark - 请求评论列表
- (void)_requestGoodsCommentList {
    
    GoodsEvaluateRequest *request = [[GoodsEvaluateRequest alloc] init:GetToken];
    request.api_evaluateType = @"goods";
    request.api_goodsId = self.goodsDetailModel.GoodsDetailModelID;
    request.api_pageNum = @1;
    request.api_pageSize = @10;
    NSLog(@"评价 %@",request.api_goodsEva);
    [_vapmanager goodsEvaluate:request success:^(AFHTTPRequestOperation *operation, GoodsEvaluateResponse *response) {
        
        NSLog(@"comment response %@",response);
        
        //评论部分
        [self _makeCommentPartToViewWithCommentArr:response.shopEvaluateList];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        
    }];
    
}

#pragma mark - 请求除猜您喜欢之外的数据
- (void)_requestGoodData {
    ZkgLoadingHub *hub = [[ZkgLoadingHub alloc] initHubInView:self.view withLoadingType:LoadingSystemtype];
    GoodsDetailsRequest *reuqest = [[GoodsDetailsRequest alloc] init:GetToken];
    reuqest.api_goodsId = self.goodsID;
    
    if (_noDataView) {
        [_noDataView removeFromSuperview];
    }
    
    //在还没有请求下来数据，关掉scrollView的滑动属性
    self.gdScrollView.scrollEnabled = NO;
    [_vapmanager goodsDetails:reuqest success:^(AFHTTPRequestOperation *operation, GoodsDetailsResponse *response) {
        NSDictionary *goodsDetailDic = (NSDictionary *)response.goodsDetails;
        _requestDataDic = goodsDetailDic;
        [self _deallGoodsDetailDic:goodsDetailDic];
        //打开scrollview的滑动属性
        self.gdScrollView.scrollEnabled = YES;
        [hub endLoading];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        WEAK_SELF
        [hub endLoading];
        [KJShoppingAlertView showAlertTitle:@"网络错误" inContentView:self.view];
       _noDataView = [NodataShowView showInContentView:self.view withReloadBlock:^{
            [weak_self _requestGoodData];
        } requestResultType:NetworkRequestFaildType];
    }];
    
}


#pragma mark - 头部滑动视图
- (void)_initHeaderView {
    
    _headerScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _headerScrollView.delegate = self;
    // 自定义分页控件小圆标颜色
    _headerScrollView.dotColor = [UIColor whiteColor];
    //禁止自滚动
    _headerScrollView.autoScroll = NO;
    //禁止循环滚动
    _headerScrollView.infiniteLoop = NO;
    _headerScrollView.backgroundColor = [UIColor whiteColor];
}


#pragma mark share view
-(shareView *)shareView {
    if (!_shareView) {
        WEAK_SELF
        _shareView = [shareView instance];
        [self.view addSubview:_shareView];
        [_shareView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view.mas_bottom).offset(200);
            make.height.mas_equalTo(@200);
        }];
        _shareView.cancelShareBlock = ^{
            
            [UIView animateWithDuration:0.3 animations:^{
                [weak_self.shareView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.bottom.mas_equalTo(weak_self.view.mas_bottom).offset(200);
                    weak_self.maskView.hidden = YES;
                }];
                [weak_self.view layoutIfNeeded];
            }];
            
        };
        
    }
    return _shareView;
}


-(void)_loadMaskView{
    
    _maskView = [[UIView alloc] initWithFrame:self.view.bounds];
    _maskView.width = kScreenWidth;
    _maskView.backgroundColor = [UIColor blackColor];
    _maskView.alpha = 0.3;
    [self.view addSubview:_maskView];
    _maskView.hidden = YES;
    WEAK_SELF
    [_maskView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            [weak_self.shareView mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.bottom.mas_equalTo(weak_self.view.mas_bottom).offset(200);
            }];
            weak_self.maskView.hidden = YES;
            [weak_self.view layoutIfNeeded];
            
        }];
        
    }];
}



#pragma mark - 处理请求下来的字典，大部分网络数据本页面
-(void)_deallGoodsDetailDic:(NSDictionary *)goodsDetailDic{
    
    NSLog(@"goods dic %@",goodsDetailDic);
    
    //赋值本页面商品模型
    self.goodsDetailModel = [[GoodsDetailModel alloc] initWithJSONDic:goodsDetailDic];
    
    //网络数据赋给UI
    [self _assignNetWorkDataToView];
    
    //请求评论列表
    [self _requestGoodsCommentList];

    
}

#pragma mark - 网络数据赋给UI
-(void)_assignNetWorkDataToView{
    
    //网络数据到了，，让点
    self.addShopCartButton.enabled = YES;
    self.immiditelyBuyButton.enabled = YES;
    
    //头部
    NSMutableArray *headerGoodsImgArr = [NSMutableArray arrayWithCapacity:self.goodsDetailModel.goodsPhotosList.count];
    for (NSDictionary *dic in _goodsDetailModel.goodsPhotosList) {
        NSString *imgPath = dic[@"accessory"][@"path"];
        imgPath = TwiceImgUrlStr(imgPath, kScreenWidth, kScreenWidth);
        //        NSLog(@"imgpath %@",imgPath);
        [headerGoodsImgArr addObject:imgPath];
    }
//    if (!headerGoodsImgArr.count) {
        if (self.goodsDetailModel.goodsMainPhotoPath) {
            NSString *mainPhotoPath = TwiceImgUrlStr(self.goodsDetailModel.goodsMainPhotoPath, kScreenWidth, kScreenWidth);
            [headerGoodsImgArr insertObject:mainPhotoPath atIndex:0];
        }
//    }
    
    _headerScrollView.imageURLStringsGroup = (NSArray *)headerGoodsImgArr;
    
//    _kjPhotoBrowser = [[KJPhotoBrowser alloc] initWithImgUrls:headerGoodsImgArr imgViewArrs:_headerScrollView.imgViews];
    //描述，价格部分
    self.goodsDescriptionTextView.text = self.goodsDetailModel.goodsName;
    //实际价格，在模型中计算的
    CGFloat actualPrice = self.goodsDetailModel.actualPrice;
    self.goodsPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",actualPrice];
    //判断有没积分兑换价
    if ([self.goodsDetailModel.hasExchangeIntegral integerValue]) {//有积分兑换价
        self.integralExchangeLabel.hidden = NO;
        NSInteger interGrePrice = self.goodsDetailModel.goodsIntegralPrice.integerValue;
        NSInteger interGre = self.goodsDetailModel.exchangeIntegral.integerValue;
        self.integralExchangeLabel.text = [NSString stringWithFormat:@"￥%ld+%ld积分兑换",interGrePrice,interGre];
    }else{
        self.integralExchangeLabel.text = @"";
        self.integralExchangeLabel.hidden = YES;
    }
    
    if ([self.goodsDetailModel.hasMobilePrice integerValue]) {//有手机专享价
        self.phoneSpecialShareImgView.hidden = NO;
    }
    
//    //如果没有商品属性，则隐藏选择视图
//    if (self.goodsDetailModel.cationList.count < 1 ) {
//        self.selectView.hidden = YES;
//        self.selectViewHeightConstraint.constant = 0;
//    }
    
    //赋值选择商品规格label
    NSString *goodsCationStr = @"";
    NSMutableArray *cationListArr = [NSMutableArray arrayWithCapacity:0];
    if (self.goodsDetailModel.cationList.count > 0) {
        for (NSDictionary *dic in self.goodsDetailModel.cationList) {
            [cationListArr addObject:dic[@"name"]];
        }
        goodsCationStr = [cationListArr componentsJoinedByString:@" "];
        self.selectedGoodsPropertyLabel.text = goodsCationStr;
        self.selectGoodsCationLabel.text = @"请选择";
    }else{
        self.selectedGoodsPropertyLabel.text = goodsCationStr;
        self.selectGoodsCationLabel.text = @"已选";
//        self.selectGoodsCationButton.userInteractionEnabled = NO;
    }

    //店铺，，是否自营
    if (self.goodsDetailModel.goodsType.integerValue == 1) {//第三方店铺
        self.selSaleView.hidden = YES;
        self.storeView.hidden = NO;
//        NSString *title = [NSString stringWithFormat:@"%@  >>进入店铺",self.goodsDetailModel.goodsStoreName];
//        [self.goodsStoreButton setTitle:title forState:UIControlStateNormal];
        self.storeNameLabel.text = self.goodsDetailModel.goodsStoreName;
    }else{
        self.selSaleView.hidden = NO;
        self.storeView.hidden = YES;
    }
    
    self.kjGoodDetailPhotoTextDetailShowView.ptPhotoDetailWebUrlStr= self.goodsDetailModel.goodsDetailsMobile;
    self.kjGoodDetailPhotoTextDetailShowView.ptPackageListWebUrlStr = self.goodsDetailModel.packDetails;
}


#pragma mark - 处理评论网络数据以及UI
-(void)_makeCommentPartToViewWithCommentArr:(NSArray *)commentArr{
    
    //评论部分
    NSMutableArray *evaluateArr = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dic in commentArr) {
        GoodsEvaluateModel *model = [[GoodsEvaluateModel alloc] initWithJSONDic:dic];
        [evaluateArr addObject:model];
    }
    
    if (evaluateArr.count > 0) {//有评论
        self.commentViewTitleLabel.text = [NSString stringWithFormat:@"评论(%ld)",evaluateArr.count];
        GoodsEvaluateModel *firstCommentModel = evaluateArr[0];
        [self.commentFirstHeaderImgView sd_setImageWithURL:[NSURL URLWithString:firstCommentModel.headImgPath]];
        self.commentFirstHeaderImgView.layer.cornerRadius = 30 / 2;
        self.commentFirstHeaderImgView.layer.masksToBounds = YES;
        NSString *nickFirstCharator = [firstCommentModel.nickName substringToIndex:1];
        NSString *nicklastCharator = [firstCommentModel.nickName substringFromIndex:firstCommentModel.nickName.length-1];
        if (!nicklastCharator || !nicklastCharator) {
            nickFirstCharator = @"匿";
            nicklastCharator  =@"名";
        }
        self.commentFirstUserNameLabel.text = [NSString stringWithFormat:@"%@**%@",nickFirstCharator,nicklastCharator];
        self.firstCommentLabel.text = firstCommentModel.evaluateInfo;
        NSString *goodsAttributeStr = [Util removeHTML2:firstCommentModel.goodsSpec];
        self.firstCommentGoodsTypeLabel.text = [NSString stringWithFormat:@"%@ %@",firstCommentModel.addTime,goodsAttributeStr];
        NSLog(@"评论图片 str : %@",firstCommentModel.evaluatePhotos);
        
        //包括以";""|"两种方式分割的情况
        NSString *seperatedStr = @";";
        if (firstCommentModel.evaluatePhotos.length > 1) {
            if (iOS8) {
                if ([firstCommentModel.evaluatePhotos containsString:@"|"]) {
                    seperatedStr = @"|";
                }else if (iOS7){
                    NSRange seRange = [firstCommentModel.evaluatePhotos rangeOfString:@"|"];
                    if (!(seRange.location == NSNotFound)) {
                        seperatedStr = @"|";
                    }
                }
            }
            
        
            //判断有没晒单
            NSArray *commentPhotoImgUrlArr = [firstCommentModel.evaluatePhotos componentsSeparatedByString:seperatedStr];
            self.goodsCommentPhotoView.imgUrlArr = commentPhotoImgUrlArr;
            self.commentPhotoViewHeightConstraint.constant = 70;
            [self.view layoutIfNeeded];
        }
//        if (commentPhotoImgUrlArr.count >  0 ) {
//            self.goodsCommentPhotoView.imgUrlArr = commentPhotoImgUrlArr;
//            self.commentPhotoViewHeightConstraint.constant = 70;
//            [self.view layoutIfNeeded];
//        }
    
    }else{//没有评论
        [self.commentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(34);
        }];
        //设置高度优先级大于拉伸阻力优先级
        [self.commentView setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
        self.commentViewHeightConstraint.priority = UILayoutPriorityDefaultHigh;
        self.seeMoreCommentViewHeightConstraint.constant = 0;
        self.commentViewTitleLabel.text = @"暂无评价";
        self.commentFirstUserNameLabel.hidden = YES;
        self.commentFirstHeaderImgView.hidden = YES;
        self.firstCommentGoodsTypeLabel.hidden = YES;
        self.firstCommentLabel.hidden = YES;
        self.seeMoreCommentButton.hidden = YES;
        [self.view layoutIfNeeded];
    }
    
}//评论部分


#pragma mark - 猜您喜欢collectionView
- (void)_initGuessYouLikeCollectionView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 5, 10, 5);
    flowLayout.itemSize = CGSizeMake(156, 205);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.guessYouLikeCollectionView.collectionViewLayout = flowLayout;
    WEAK_SELF
    self.guessYouLikeCollectionView.clickItemCellBlock = ^(NSNumber *goodsID){
        KJGoodsDetailViewController *selfVC =[[KJGoodsDetailViewController alloc] init];
        selfVC.goodsID = goodsID;
        [weak_self.navigationController pushViewController:selfVC animated:YES];
    
    };
    
}


#pragma mark - 图文详情view
-(void)_loadPhotoTextView{
    
    _kjGoodDetailPhotoTextDetailShowView = BoundNibView(@"KJGoodDetailPhotoTextDetailView", KJGoodDetailPhotoTextDetailView);
    
    [self.gdScrollContentView addSubview:_kjGoodDetailPhotoTextDetailShowView];
    
    [_kjGoodDetailPhotoTextDetailShowView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.gdScrollContentView.mas_bottom);
        make.left.right.mas_equalTo(self.gdScrollContentView);
        make.height.mas_equalTo(kScreenHeight-NavBarStatusBarHeight-BottonBarHeight);
    }];
}

#pragma mark 添加真正的图文详情view
-(void)addTruePhotoTextView{
    if (!_kjGoodDetailPhotoTextDetailTrueView) {
        
        _kjGoodDetailPhotoTextDetailTrueView = BoundNibView(@"KJGoodDetailPhotoTextDetailView", KJGoodDetailPhotoTextDetailView);
        [self.view addSubview:_kjGoodDetailPhotoTextDetailTrueView];
        [_kjGoodDetailPhotoTextDetailTrueView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.right.mas_equalTo(self.view);
            make.height.mas_equalTo(kScreenHeight-NavBarStatusBarHeight-BottonBarHeight);
        }];
        //图文详情部分
        self.kjGoodDetailPhotoTextDetailTrueView.ptPhotoDetailWebUrlStr= self.goodsDetailModel.goodsDetailsMobile;
        self.kjGoodDetailPhotoTextDetailTrueView.ptPackageListWebUrlStr = self.goodsDetailModel.packDetails;
        
        WEAK_SELF
        __block CGFloat ableScrollHeight = _ableScrollHeight;
        _kjGoodDetailPhotoTextDetailTrueView.upBlock = ^(NSInteger selectedIndex){
            //拉上来的时候，，将真实的隐藏
            weak_self.kjGoodDetailPhotoTextDetailTrueView.hidden = YES;
            //把展示的view置为当前选择的webview
            weak_self.kjGoodDetailPhotoTextDetailShowView.currentIndex = selectedIndex;
            [weak_self.gdScrollView setContentOffset:CGPointMake(0, ableScrollHeight) animated:YES];
        };
        
    }else{
        
        _kjGoodDetailPhotoTextDetailTrueView.hidden = NO;
    }
}


#pragma mark - 加入购物车请求
-(void)_addShoppingCartRequest{
    
    ShopCartAddRequest *request = [[ShopCartAddRequest alloc] init:GetToken];
    request.api_goodId = self.goodsID;
    if (!self.selecdGoodsCationIdStr) {
        self.selecdGoodsCationIdStr = @"123";
    }
    request.api_gsp = self.selecdGoodsCationIdStr;
    request.api_count = _goodsBuyCount;

    NSLog(@"商品id %@,属性 %@ 数量 %ld",self.goodsID,self.selecdGoodsCationIdStr,_goodsBuyCount.longValue);
    
    WEAK_SELF
    [_vapmanager shopCartAdd:request success:^(AFHTTPRequestOperation *operation, ShopCartAddResponse *response) {
        
        if (response.errorCode.integerValue > 0) {
            if (self.hasGoodsCation) {
                [weak_self.addShoppingCarView endShowAfterSeconds:1.5];
            }
            [KJShoppingAlertView showAlertTitle:response.subMsg inContentView:self.view.window];
        }else{
            if (!self.hasGoodsCation) {//没有规格，购物车视图没有弹出来的
                if (_isImidiatelyBuy) {
                    [self goToShoppingCart];
                }else{
                    [KJShoppingAlertView showAlertTitle:@"添加购物车成功!" inContentView:self.view.window];
                }
            }else {//这部分是基于购物车视图弹出的，即有商品规格
                //如果是立即购买发起的请求，则进入购物车页面
                if (_isImidiatelyBuy) {
                    [weak_self.addShoppingCarView endShowAfterSeconds:0.1];
                    [self goToShoppingCart];
                }else{//加入购物车动画
                    [weak_self.addShoppingCarView endShowAfterSeconds:1.2];
                    if (!self.isShowingAddShoppingCartAnimation) {
                        [self performSelector:@selector(_beginShoppingCartAnimation) withObject:nil afterDelay:0.0];
                        //动画执行的时候，让下面button不可点，防止动画重复
                        self.addShopCartButton.userInteractionEnabled = NO;
                        self.isShowingAddShoppingCartAnimation = YES;
                    }
                }
            }
            //标志加入了购物车
            _isAddedCart = YES;
        
            //赋值购物车数量重置
            _shopCartCount = response.shopCartSize.integerValue;
            _shopCartView.shopCartNumber = _shopCartCount;
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [KJShoppingAlertView showAlertTitle:@"添加失败!" inContentView:self.view];
        _isAddedCart = NO;
    }];
}


#pragma mark - 处理有没有库存
-(BOOL)_hasGoodsInventory {
    //判断商品库存，有库存才能加入购物车
    if (_goodsDetailModel.goodsInventory.integerValue == 0) {
        NSString *alertStr = @"";
        if (_isImidiatelyBuy) {
            alertStr = @"商品库存不足，无法购买!";
        }else{
            alertStr = @"商品库存不足，无法加入购物车!";
        }
        
        if (_isSelectGoodsCation) {//如果是选择商品属性
            alertStr = @"商品库存不足，无法选择商品";
        }
        [KJShoppingAlertView showAlertTitle:alertStr inContentView:self.view];
        return NO;
    }
    
    return YES;
}


#pragma mark -加入购物车，选择商品的属性之后点击确认，根据属性ID字符串，找到价格
-(void)_findPriceBySelectedIdArr:(NSArray *)propertyIdArr{
    self.selectedGoodsPropertyLabel.text = self.addShoppingCarView.dataHander.selectedPropertyStr;
    self.selecdGoodsCationIdStr = self.addShoppingCarView.dataHander.selectedPropertyIdStr;
    self.selectGoodsCationLabel.text = @"已选";
    CGFloat squPrice = self.addShoppingCarView.dataHander.squPrice;
    if ((NSInteger)squPrice) {
        self.goodsPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",self.addShoppingCarView.dataHander.squPrice];
    }
}


#pragma mark - 弹出加入购物车视图做的一些初始化
-(void)_configureInfoBeforeAddingShoppingCart{
    
    if (!self.addShoppingCarView.dataHander ) {//说明第一次被赋值，此时里面的数据还没有处理
        AddShoppingCartViewDataInoutHander *dataHander = [[AddShoppingCartViewDataInoutHander alloc] initWithGoodsDetailModel:self.goodsDetailModel];
        self.addShoppingCarView.dataHander = dataHander;
    }
    [self.addShoppingCarView startShow];
}


#pragma mark - 分享
- (IBAction)goodsShareAction:(id)sender {
    UNLOGIN_HANDLE

    [self.shareview show];
}


-(JGShareView *)shareview {
    
    if (!_shareview) {
        _shareview = [JGShareView shareViewWithTitle:self.goodsDetailModel.goodsName content:self.goodsDetailModel.goodsName imgUrlStr:self.goodsDetailModel.goodsMainPhotoPath ulrStr:kGoodsShareUrlWithID(self.goodsDetailModel.GoodsDetailModelID) contentView:self.view shareImagePath:nil];
    }
    
    return _shareview;
}


-(void)_upShareView{

    WEAK_SELF
    //分享
    [UIView animateWithDuration:0.5 animations:^{
        
        _maskView.hidden = NO;
        [_shareView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.mas_equalTo(weak_self.view.mas_bottom).offset(0);
        }];
        
        [weak_self.view layoutIfNeeded];
    }];
}





#pragma mark - scrollView delegate
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    NSLog(@"will end drag content offset %.2f",scrollView.contentOffset.y);
    
    //    NSLog(@"contentHeight offset %.2f",scrollView.contentSize.height-scrollView.frame.size.height);
    if (!(int)_ableScrollHeight) {
        _ableScrollHeight = scrollView.contentSize.height-scrollView.frame.size.height;
    }
    //scrollScrollTopBottonOffset
    if (scrollView.contentOffset.y > _ableScrollHeight + OffetTrrigerScrollToDown) {
        //#warning 松手后它可能会往下滑动，，而我是想让他定在那里然后往上滑
        targetContentOffset->y = scrollView.contentOffset.y;
//        [scrollView setContentOffset:CGPointMake(0, _ableScrollHeight+PhotoTextViewHeight) animated:YES];
//        [self performSelector:@selector(addTruePhotoTextView) withObject:nil afterDelay:0.3];
        [self performSelector:@selector(_scrollUp) withObject:nil afterDelay:0.3];
        
    }
    
}

-(void)_scrollUp{

    [self.gdScrollView setContentOffset:CGPointMake(0, _ableScrollHeight+PhotoTextViewHeight) animated:YES];
    [self performSelector:@selector(addTruePhotoTextView) withObject:nil afterDelay:0.3];

}

#pragma mark - SDCycleScrollView delegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
}


#pragma mark - Goods Squ Change Notification
- (void)changeGoodsSquObserve:(NSNotification *)notiInfo {
    GoodsSquModel *selectSquModel = (GoodsSquModel *)notiInfo.object;
    
    //先判断外面有没积分兑换价，再判断里面
    if ([self.goodsDetailModel.hasExchangeIntegral integerValue]) {//有积分兑换价
        //判断选择的squ中有没积分兑换价
        if (selectSquModel.hasIntegralPrice) {//有
            self.integralExchangeLabel.hidden = NO;
            self.integralExchangeLabel.text = selectSquModel.integralAndIntegralPriceStr;
        }else{
            self.integralExchangeLabel.text = @"";
            self.integralExchangeLabel.hidden = YES;
        }
    }else{

    }
    
    if ([self.goodsDetailModel.hasMobilePrice integerValue]) {//有手机专享价外面
        //判断squ里面
        if (selectSquModel.hasMobilePrice) {//有squ手机专享价
            self.phoneSpecialShareImgView.hidden = NO;
        }else{
            self.phoneSpecialShareImgView.hidden = YES;
        }
    }
    
    //给商品属性label赋值
    self.goodsPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",    selectSquModel.actualPrice.floatValue];
    self.selectGoodsCationLabel.text = @"已选";
    self.selectedGoodsPropertyLabel.text = selectSquModel.selectGoodsSquStr;

}


#pragma mark ------------------------Action Method-----------------------------
#pragma mark - 加入购物车
- (IBAction)addShoppingCarAction:(id)sender {
    UNLOGIN_HANDLE
    _isImidiatelyBuy = NO;
    //判断商品有没库存
    if (![self _hasGoodsInventory]) {//没有库存，返回
        return;
    }
    
    self.hasGoodsCation = YES;
    if (!self.goodsDetailModel.cationList.count) {
        //无规格选择
        self.hasGoodsCation = NO;
        //直接购物车请求，不用弹出来，动画
        [self _addShoppingCartRequest];
        return;
    }
    
    
    
    //如果没有商品属性可选，那么不用弹出加入购物车视图，直接发送请求
    WEAK_SELF
    self.addShoppingCarView.makeSureBlock = ^(NSNumber *buyCount, NSArray *propertyIdArr,NSString *selectePropertyStr,CGFloat squPrice){
        if (weak_self.isShowingAddShoppingCartAnimation) {
            return ;
        }
        _goodsBuyCount = buyCount;
        weak_self.selectedGoodsCationIdStr = [propertyIdArr componentsJoinedByString:@","];
        [weak_self _findPriceBySelectedIdArr:propertyIdArr];
        //加入购物车请求
        [weak_self _addShoppingCartRequest];
    };
    self.addShoppingCarView.ispresentedBySelectedGoodsCation = NO;
    [self _configureInfoBeforeAddingShoppingCart];
    
}

#pragma mark - 选择商品的属性
- (IBAction)selectGoodsPropertyAction:(id)sender {
    UNLOGIN_HANDLE
    _isSelectGoodsCation = YES;
    //判断有没库存
    if (![self _hasGoodsInventory]) {//没库存
        return;
    }
    
    WEAK_SELF
    __block BOOL isAddedCart = _isAddedCart;
    self.addShoppingCarView.AddShopingCartOrBuyNowBlock = ^(NSNumber *buyCount, NSArray *propertyIdArr, BOOL isBuyNow){
        _goodsBuyCount = buyCount;
        weak_self.selectedGoodsCationIdStr = [propertyIdArr componentsJoinedByString:@","];
        [weak_self _findPriceBySelectedIdArr:propertyIdArr];
        if (isBuyNow) {//立即购买，进入购物车页面
#pragma mark - m
//            if (isAddedCart) {//如果已经加入了购物车
//                [weak_self goToShoppingCart];
//                [weak_self.addShoppingCarView endShowAfterSeconds:0.1];
//            }else{
//                _isImidiatelyBuy = YES;
//                [weak_self _addShoppingCartRequest];
//            }
            [weak_self _comToOrderConfirmPageWithGoodsID:weak_self.goodsID goodsCount:buyCount goodsGsp:[propertyIdArr componentsJoinedByString:@","]];
            [weak_self.addShoppingCarView endShowAfterSeconds:0.1];
        }else{//加入购物车
            //加入购物车请求
            [weak_self _addShoppingCartRequest];
        }
    };
    [self _configureInfoBeforeAddingShoppingCart];
    self.addShoppingCarView.ispresentedBySelectedGoodsCation = YES;
}

#pragma mark - 进入店铺
- (IBAction)commintoStore:(id)sender {
    
    WSJShopHomeViewController *goodsStoreVC = [[WSJShopHomeViewController alloc] init];
    goodsStoreVC.api_storeId = self.goodsDetailModel.goodsStoreId;
    [self.navigationController pushViewController:goodsStoreVC animated:YES];
}



#pragma mark - 返回
- (void)detailBack {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - 进入购物车
-(void)goToShoppingCart{
    UNLOGIN_HANDLE
    WSJShoppingCartViewController *shoppingCartVC = [[WSJShoppingCartViewController alloc] init];
    [self.navigationController pushViewController:shoppingCartVC animated:YES];
}


#pragma mark - 立即购买
- (IBAction)buyImidityliAction:(id)sender {
    UNLOGIN_HANDLE
    if (_isAddedCart) {//如果加入了购物车，进入确认订单页面
//        [self goToShoppingCart];
        [self _comToOrderConfirmPageWithGoodsID:self.goodsID goodsCount:_goodsBuyCount goodsGsp:self.selectedGoodsCationIdStr];
    }else{//否则弹出加入购物车视图
        //有属性时才弹出，否则直接请求加入购物车
        _isImidiatelyBuy = YES;
        //判断商品有没库存c
        if (![self _hasGoodsInventory]) {//没库存
            return;
        }
        self.hasGoodsCation = YES;
        if (!self.goodsDetailModel.cationList.count) {
            //无规格选择
            self.hasGoodsCation = NO;
            //直接购物车请求，不用弹出来，动画
#pragma mark - m
//            [self _addShoppingCartRequest];
            [self _comToOrderConfirmPageWithGoodsID:self.goodsID goodsCount:@1 goodsGsp:nil];
            return;
        }
        WEAK_SELF
        self.addShoppingCarView.makeSureBlock = ^(NSNumber *buyCount, NSArray *propertyIdArr,NSString *selectePropertyStr,CGFloat squPrice){
            [weak_self _findPriceBySelectedIdArr:propertyIdArr];
            _goodsBuyCount = buyCount;
            //加入购物车请求
#pragma mark - m
//            [weak_self _addShoppingCartRequest];
            [weak_self _comToOrderConfirmPageWithGoodsID:weak_self.goodsID goodsCount:buyCount goodsGsp:[propertyIdArr componentsJoinedByString:@","]];
            [weak_self.addShoppingCarView endShowAfterSeconds:0.1];
        };
        [self _configureInfoBeforeAddingShoppingCart];
        self.addShoppingCarView.ispresentedBySelectedGoodsCation = NO;
    }
}

-(void)_comToOrderConfirmPageWithGoodsID:(NSNumber *)goodsId goodsCount:(NSNumber *)goodsCount goodsGsp:(NSString *)goodsGsp
{
    OrderConfirmViewController *orderConfirmVC = [[OrderConfirmViewController alloc] init];
    orderConfirmVC.goodsId = goodsId;
    orderConfirmVC.goodsGsp = goodsGsp;
    orderConfirmVC.goodsCount = goodsCount;
    orderConfirmVC.isComeFromBuyNow = YES;
    [self.navigationController pushViewController:orderConfirmVC animated:YES];
}



#pragma mark - 查看更多评价
- (IBAction)seeMoreCommentAction:(id)sender {
    
    WSJEvaluateListViewController *moreCommentVC = [[WSJEvaluateListViewController alloc] init];
    moreCommentVC.goodsId = self.goodsID;
    [self.navigationController pushViewController:moreCommentVC animated:YES];
}


#pragma mark - 收藏
- (IBAction)collectionGoodsAction:(id)sender {
    UNLOGIN_HANDLE
    UIButton *favoriteButton = (UIButton *)sender;
    if (favoriteButton.selected) {
        //取消收藏请求
        [self _cancelCollectionRequest];
    }else{
        //收藏请求
        [self _goodsCollectionRequest];
    }    
}

#pragma mark - 取消收藏
-(void)_cancelCollectionRequest{
    
    

    SelfFavaDeleteRequest *request = [[SelfFavaDeleteRequest alloc] init:GetToken];
    request.api_id = self.goodsID;
    request.api_type =@"3";
    
    [_vapmanager selfFavaDelete:request success:^(AFHTTPRequestOperation *operation, SelfFavaDeleteResponse *response) {
        NSString *alertStr = @"";
        if (response.errorCode.integerValue > 0) {
            alertStr = @"取消收藏失败";
        }else{
            alertStr = @"取消收藏成功";
            if (self.favoriteButton.selected) {
                self.favoriteButton.selected = NO;
            }
        }
        [KJShoppingAlertView showAlertTitle:alertStr inContentView:self.view];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [KJShoppingAlertView showAlertTitle:@"取消收藏失败" inContentView:self.view];
    }];
}


#pragma mark - 收藏请求
-(void)_goodsCollectionRequest{
    UsersFavoritesRequest *request = [[UsersFavoritesRequest alloc] init:GetToken];
    request.api_fid = [self.goodsID stringValue];
    request.api_type = @"3";
    [_vapmanager usersFavorites:request success:^(AFHTTPRequestOperation *operation, UsersFavoritesResponse *response) {
        NSString *alertStr = @"";
        if (response.errorCode.integerValue > 0) {
            alertStr = @"添加收藏失败";
        }else{
            alertStr = @"添加收藏成功";
            if (!self.favoriteButton.selected) {
                self.favoriteButton.selected = YES;
            }
        }
        [KJShoppingAlertView showAlertTitle:alertStr inContentView:self.view];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [KJShoppingAlertView showAlertTitle:@"添加收藏失败" inContentView:self.view];
    }];
}


#pragma mark - 咨询
- (IBAction)consultAction:(id)sender {
    UNLOGIN_HANDLE
    GoodsConsultlistShowConstroller *consultVC = [[GoodsConsultlistShowConstroller alloc] init];
    [self.navigationController pushViewController:consultVC animated:YES];
    consultVC.consultGoodsID = self.goodsDetailModel.GoodsDetailModelID;
    consultVC.goodsName = self.goodsDetailModel.goodsName;
}


#pragma mark ------------------------ getter Method
-(KJAddShoppingCarView *)addShoppingCarView{
    
    if (!_addShoppingCarView) {
        _addShoppingCarView = [KJAddShoppingCarView showCartViewInContentView:self.view.window];
    }
    return _addShoppingCarView;
}


#pragma mark ------------------------ 加入购物车动画 ---------------------
-(void)_beginShoppingCartAnimation{
    
    //拿到购物车中商品的图片imgView,并算出它在window的位置
    //    CGRect shopCartImgViewFrameInWindow = [self.view.window convertRect:_addShoppingCarView.goodsImgView.frame fromview:_addShoppingCarView];
    
    CGRect shopCartImgViewFrameInWindow = [self.view.window convertRect:_addShoppingCarView.goodsImgView.frame fromView:_addShoppingCarView];//好像不行，这个方法
    CGPoint beginPoint = shopCartImgViewFrameInWindow.origin;
    beginPoint = CGPointMake(16, 207);
    
    NSLog(@"起点 x %.2f, y : %.2f",beginPoint.x,beginPoint.y);
    CGSize animateImgViewSize = shopCartImgViewFrameInWindow.size;
    //初始化动画layer
    if (!animateImgViewlayer) {
        
        animateImgViewlayer = [CALayer layer];
        [self.view.window.layer addSublayer:animateImgViewlayer];
        animateImgViewlayer.contentsGravity = kCAGravityResizeAspect;
        UIImage *animateImge = _addShoppingCarView.goodsImgView.image;
        animateImgViewlayer.contents = (__bridge id)animateImge.CGImage;
        animateImgViewlayer.position = CGPointMake(16+143/2, 207);
        animateImgViewlayer.bounds = CGRectMake(0, 0, animateImgViewSize.width, animateImgViewSize.height);
        
    }
    
    [self groupAnimationWithBeginPoint:beginPoint];
}

-(void)_initBezial{
    
    _addShopAnimateBezier = [UIBezierPath bezierPath];
    CGPoint beginPoint = CGPointMake(16, 207);
    [_addShopAnimateBezier moveToPoint:beginPoint];
    //结束x坐标，导航栏最右边购物车哪里
    CGFloat endX = kScreenWidth - 40;
    [_addShopAnimateBezier addQuadCurveToPoint:CGPointMake(endX,40) controlPoint:CGPointMake((endX-beginPoint.x)/2+beginPoint.x,(beginPoint.y-40)/2+40)];
}


-(void)groupAnimationWithBeginPoint:(CGPoint)beginPoint
{
    NSMutableArray *groupAnimationArr = [NSMutableArray arrayWithCapacity:0];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = _addShopAnimateBezier.CGPath;
    [groupAnimationArr addObject:animation];
    
    CABasicAnimation *trainAnimation = [CABasicAnimation animationWithKeyPath:@"transform.y"];
    trainAnimation.duration = 0.1;
    trainAnimation.toValue = @(beginPoint.y-50);
    [groupAnimationArr addObject:trainAnimation];
    
    for (float i=0.0; i<=1.0; i+=0.1) {
        CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        rotationAnimation.beginTime = i+0.2;
        rotationAnimation.duration = 0.2;
        rotationAnimation.fromValue = @((i * 10) * M_PI);
        rotationAnimation.toValue = @((i*10)*M_PI + M_PI);
        [groupAnimationArr addObject:rotationAnimation];
        
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.beginTime = i+0.2;
        scaleAnimation.fromValue = @(1 - i);
        scaleAnimation.duration = 0.1;
        scaleAnimation.toValue = @(1-i-0.1);
        [groupAnimationArr addObject:scaleAnimation];
    }
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = (NSArray *)groupAnimationArr;
    groups.duration = 1.0;
    groups.removedOnCompletion=NO;
    groups.fillMode=kCAFillModeForwards;
    groups.delegate = self;
    [animateImgViewlayer addAnimation:groups forKey:@"group"];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
    if (anim == [animateImgViewlayer animationForKey:@"group"]) {
        
        _isShowingAddShoppingCartAnimation = NO;
        [animateImgViewlayer removeFromSuperlayer];
        animateImgViewlayer = nil;
        _shopCartView.shopCartNumber = _shopCartCount;
        [KJShoppingAlertView showAlertTitle:@"添加购物车成功!" inContentView:self.view.window];
        //动画结束的时候，让下面button可点，
        self.addShopCartButton.userInteractionEnabled = YES;
    }
}


- (void)dealloc
{
    [kNotification removeObserver:self];
}












@end
