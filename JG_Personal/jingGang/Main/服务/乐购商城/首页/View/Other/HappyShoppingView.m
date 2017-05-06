//
//  HappyShoppingView.m
//  jingGang
//
//  Created by 张康健 on 15/8/13.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "HappyShoppingView.h"
#import "ShoppingHomeController.h"
#import "VApiManager.h"
#import "GoodsDetailModel.h"
#import "GlobeObject.h"
#import "WSJShopCategoryViewController.h"
#import "KJGoodsDetailViewController.h"
#import "WSJKeySearchViewController.h"
#import "NSDate+Utilities.h"
#import "RecommentCodeDefine.h"
#import "AdRecommendModel.h"
#import "IntegralShopHomeController.h"
#import "UIView+BlockGesture.h"
#import "UIImageView+WebCache.h"
#import "TMCache.h"
#import "MJRefresh.h"

#define GuessYouLikeCellHeight 205
#define HaveYouLikeCellHeight 160


@interface HappyShoppingView()<SDCycleScrollViewDelegate>{
    
    VApiManager     *_vapManager;
    NSMutableArray  *_adRecommendArr; //广告位数组
    NSInteger haveLikeCount;
    TMCache         *_hasYoulikeCache;//有您喜欢缓存
    NSInteger       _requestFromPage;
}
@property (weak, nonatomic) IBOutlet UIScrollView *happyScrollView;

@property (weak, nonatomic) IBOutlet UIImageView *integralAdImgView;

@property (weak, nonatomic) IBOutlet UIImageView *searchImgView;

@property (weak, nonatomic) IBOutlet UIView *hasYouLikeHeaderView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hasYouLikeHeaderHeightConstrait;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerHeightConstraint;
@property (weak, nonatomic) IBOutlet UIPageControl *secondGoodsPageControl;

//有您喜欢高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hasYouLikeHeightConstriant;
//精品推荐height
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *goodsRecommendCollectionHeight;

@end

@implementation HappyShoppingView

-(void)awakeFromNib{

    [super awakeFromNib];
    _requestFromPage = 1;
    _vapManager = [[VApiManager alloc] init];
    _hasYoulikeCache = [TMCache sharedCache];
    self.headerHeightConstraint.constant = kScreenWidth / 2;
}



-(void)layoutSubviews{

    [super layoutSubviews];
    
    [self _addHeaderFresh];
    
    [self _init];
    
    [self _requestData];
    
}




#pragma mark ----------------------- private Method -----------------------
- (void)_addHeaderFresh {
    
    [self.happyScrollView addHeaderWithCallback:^{
        _requestFromPage = 1;
        [self _requestData];
    }];
    [self.happyScrollView addFooterWithCallback:^{
        [self _requestGuessYouLikeData];
    }];
}


#pragma mark -------- NetWork Request Method
- (void)_requestData {
    
    //请求头部广告推荐位
    [self _requestHeaderDataWithAdCode:ShoppingHomeRecommendCode];
    
    //请求精品推荐
    [self _requestHeaderDataWithAdCode:ShoppingHomeHasYourLikeCode];
    
    //请求积分广告
    [self _requestIntegralGoodsImgWithCode:IntegralShopImgCode];
    
    //请求商品一级分类
    [self _requestGoodsClassfy];
    
    //请求橱窗
    [self _requestGoodsShowcaseData];
    
    //请求猜您喜欢数据
    [self _requestGuessYouLikeData];
}


#pragma mark - 头部广告推荐位
-(void)_requestHeaderDataWithAdCode:(NSString *)adCode{
    
    SnsRecommendListRequest *request = [[SnsRecommendListRequest alloc] init:GetToken];
    request.api_posCode = adCode;
    [_vapManager snsRecommendList:request success:^(AFHTTPRequestOperation *operation, SnsRecommendListResponse *response) {
//        NSLog(@"recommend %@",operation.responseObject);
        if ([adCode isEqualToString:ShoppingHomeHasYourLikeCode]) {//有您喜欢
                NSMutableArray *_hasYouLikeArr = [NSMutableArray arrayWithCapacity:response.advList.count];
            NSLog(@"有您细化个数 %ld",response.advList.count);
            if (response.advList.count == 0) {
                self.hasYouLikeHeaderView.hidden = YES;
                self.haveYouLikeCollectionView.hidden = YES;
                self.hasYouLikeHeaderHeightConstrait.constant = 1;
                self.goodsRecommendCollectionHeight.constant = 1;
            }
            else{
                //设置有您喜欢高度
                  haveLikeCount = response.advList.count;
                  NSInteger heighN = haveLikeCount % 2 ? (haveLikeCount / 2 + 1) : haveLikeCount / 2;
                  self.goodsRecommendCollectionHeight.constant = heighN * KRecommendGoodsCellHeight;
            }
            NSInteger itemCount = response.advList.count;
//            if (response.advList.count >= 2) {
                for (int i=0; i<itemCount; i++) {
                    NSDictionary *dic = response.advList[i];
                    AdRecommendModel *model = [[AdRecommendModel alloc] initWithJSONDic:dic];
                    [_hasYouLikeArr addObject:model];
                }
//            }
            self.haveYouLikeCollectionView.hasYouLikeDataArr = (NSArray *)_hasYouLikeArr;
            [self.haveYouLikeCollectionView reloadData];
            
            //请求商品一级分类
//            [self _requestGoodsClassfy];

        }else{
#pragma mark ---  顶部轮播图请求 ----
            
            //头部模型数组
            _adRecommendArr = [NSMutableArray arrayWithCapacity:response.advList.count];
            //头部图片数组
            NSMutableArray *headImgUrlArr = [NSMutableArray arrayWithCapacity:response.advList.count];
            for (NSDictionary *dic in response.advList) {
                AdRecommendModel *model = [[AdRecommendModel alloc] initWithJSONDic:dic];
                [_adRecommendArr addObject:model];
                
                NSString *urlStr = TwiceImgUrlStr(model.adImgPath, CGRectGetWidth(self.headerScrollView.frame), CGRectGetHeight(self.headerScrollView.frame));
                [headImgUrlArr addObject:urlStr];
            }
            
            NSLog(@"头部图片 %@",headImgUrlArr);
            //刷新头部
            self.headerScrollView.imageURLStringsGroup = (NSArray *)headImgUrlArr;
        }
        ;
//
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //请求商品一级分类
        [self _requestGoodsClassfy];
    }];
}

-(void)setHasYoulikeHeightWithCount{

    CGFloat  guessYouheight = haveLikeCount / 2 * GuessYouLikeCellHeight;
    self.hasYouLikeHeightConstriant.constant = guessYouheight;
}


#pragma mark - 商品一级分类
-(void)_requestGoodsClassfy{
    GoodsClassListRequest *request = [[GoodsClassListRequest alloc] init:GetToken];
    request.api_classNum = @1;
    [_vapManager goodsClassList:request success:^(AFHTTPRequestOperation *operation, GoodsClassListResponse *response) {
        
        NSInteger itemCount = response.goodsClassList.count;
        NSLog(@"goods class %@",response);
        if (response.goodsClassList.count > 8 ) {
            itemCount = 8;
        }
        NSMutableArray *goodsClassArr = [NSMutableArray arrayWithCapacity:0];
        for (int i=0; i<itemCount; i++) {
            NSDictionary *dic = response.goodsClassList[i];
            [goodsClassArr addObject:dic];
        }
    
        self.shCircleCollectionViiew.circleDataArr = (NSArray *)goodsClassArr;
        [self.shCircleCollectionViiew reloadData];
        
        //请求橱窗
//        [self _requestGoodsShowcaseData];
        

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //请求橱窗
        [self _requestGoodsShowcaseData];
    }];


}


#pragma mark - 请求积分商城入口处推荐位图片
-(void)_requestIntegralGoodsImgWithCode:(NSString *)adCode{
        
        SnsRecommendListRequest *request = [[SnsRecommendListRequest alloc] init:GetToken];
        request.api_posCode = adCode;
        [_vapManager snsRecommendList:request success:^(AFHTTPRequestOperation *operation, SnsRecommendListResponse *response) {
            if (response.errorCode.integerValue == 2) {
                [Util enterLoginPage];
                return;
            }
            NSLog(@"积分商城首页入口图片 %@",response);
            if (response.advList.count) {
                NSDictionary *dic = response.advList[0];
                  NSString *urlStr = TwiceImgUrlStr(dic[@"adImgPath"], CGRectGetWidth(self.integralAdImgView.frame), CGRectGetHeight(self.integralAdImgView.frame));
                [self.integralAdImgView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [Util ShowAlertWithOnlyMessage:error.localizedDescription];
            
        }];
    
}
 
    



#pragma mark - 橱窗列表
-(void)_requestGoodsShowcaseData{
   
    CaseListRequest *request = [[CaseListRequest alloc] init:GetToken];
    request.api_pageNum = @1;
    request.api_pageSize = @20;
    [_vapManager caseList:request success:^(AFHTTPRequestOperation *operation, CaseListResponse *response) {
        NSLog(@"%@",response);
        self.showCasefirstLevelCollectionView.showCaseData = response.goodsCaseList;
        [self.showCasefirstLevelCollectionView reloadData];
        
        if (response.goodsCaseList.count > 0) {
            //取出第一个橱窗ID
            NSNumber *firstShowCaseID = response.goodsCaseList[0][@"id"];
            [self _requestGoodsShowcaseGoodsDataWithCaseID:firstShowCaseID];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
   
}

#pragma mark - 商品橱窗下商品列表
-(void)_requestGoodsShowcaseGoodsDataWithCaseID:(NSNumber *)caseID{
    
    GoodsCaseListRequest *request = [[GoodsCaseListRequest alloc] init:GetToken];
    request.api_id = caseID;
    
    [_vapManager goodsCaseList:request success:^(AFHTTPRequestOperation *operation, GoodsCaseListResponse *response) {
        NSLog(@"good  list response %@",response);
        NSMutableArray *caseGoodsArr = [NSMutableArray arrayWithCapacity:response.goodsList.count];
        for (NSDictionary *dic in response.goodsList) {
            GoodsDetailModel *model = [[GoodsDetailModel alloc] initWithJSONDic:dic];
            [caseGoodsArr addObject:model];
//            NSLog(@"imgUrl - %@",model.goodsMainPhotoPath);
        }
        self.showCaseSecondLevelCollectionView.showCaseGoodsData = (NSArray *)caseGoodsArr;
        [self.showCaseSecondLevelCollectionView reloadData];
        ;
        
        //请求下来之后橱窗二级pageControl初始化
        self.secondGoodsPageControl.numberOfPages = caseGoodsArr.count / 3;
        
        //请求猜您喜欢数据
//        [self _requestGuessYouLikeData];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //请求猜您喜欢数据
//        [self _requestGuessYouLikeData];
        
    }];
}


#pragma mark - 猜您喜欢列表
-(void)_requestGuessYouLikeData{
    
    LikeYouGoodsListRequest *reqeust = [[LikeYouGoodsListRequest alloc] init:GetToken];
//    NSArray *guessYourLikeIdArr = [_hasYoulikeCache objectForKey:KHasYoulikeCacheKey];
//    if (guessYourLikeIdArr.count > 0) {//说明有
//        NSString *guessYoulikeIdStr = [guessYourLikeIdArr componentsJoinedByString:@","];
//        reqeust.api_likeIds = guessYoulikeIdStr;
//    }
    reqeust.api_pageNum = @(_requestFromPage);
    reqeust.api_pageSize = @4;
    
    [_vapManager likeYouGoodsList:reqeust success:^(AFHTTPRequestOperation *operation, LikeYouGoodsListResponse *response) {
        
        NSInteger itemCount = response.youLikelist.count;
        NSMutableArray *guessYouLikeArr = [NSMutableArray arrayWithCapacity:itemCount];
        for (int i=0; i<itemCount; i++) {
            NSDictionary *dic = response.youLikelist[i];
            GoodsDetailModel *model = [[GoodsDetailModel alloc] initWithJSONDic:dic];
            [guessYouLikeArr addObject:model];
        }
        
        if (_requestFromPage == 1) {//下拉刷新
            [self.happyScrollView headerEndRefreshing];
            self.guessYouLikeCollecionView.guessYoulikeArr = guessYouLikeArr;
        }else {//上拉加载更多
            [self.happyScrollView footerEndRefreshing];
            [self.guessYouLikeCollecionView.guessYoulikeArr addObjectsFromArray:(NSArray *)guessYouLikeArr];
        }
        
        if (itemCount) {
            _requestFromPage ++;
        }
        
        itemCount = self.guessYouLikeCollecionView.guessYoulikeArr.count;
        NSInteger heighN = itemCount % 2 ? (itemCount / 2 + 1) : itemCount / 2;
        self.hasYouLikeHeightConstriant.constant = heighN * kCareChoosenGoodsCellHeight;
        [self.guessYouLikeCollecionView reloadData];
        ;
       
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
}


#pragma mark -------- init Method
-(void)_init{
    
    //头部
    [self _initHeaderScrollView];
    //圈子
    [self _initCircleCollectionView];
//    //初始化积分商城入口广告
    [self _initIntegralAd];
    //猜您，有您喜欢
    [self _initYouLikeCollectionView];
    //橱窗一级
    [self _initShowCaseFirstLevelCollectionView];
    //橱窗二级
    [self _initShowCaseSecondLevelCollectionView];
    
}

#pragma mark - 头部
-(void)_initHeaderScrollView{

    _headerScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _headerScrollView.delegate = self;
    _headerScrollView.backgroundColor = [UIColor whiteColor];
    _headerScrollView.autoScrollTimeInterval = 5.0f;
    // 自定义分页控件小圆标颜色
    _headerScrollView.dotColor = [UIColor whiteColor];
}


#pragma mark - 橱窗一级
-(void)_initShowCaseFirstLevelCollectionView{
    UICollectionViewFlowLayout *flowLayoutFirstLevel = [[UICollectionViewFlowLayout alloc] init];
    [self setFlowLayout:flowLayoutFirstLevel withCollectionType:FirstLevelCollectionViewType];
    self.showCasefirstLevelCollectionView.collectionViewType = FirstLevelCollectionViewType;
    self.showCasefirstLevelCollectionView.collectionViewLayout = flowLayoutFirstLevel;
    WEAK_SELF
    //点击block
    self.showCasefirstLevelCollectionView.clickCaseCellBlock = ^(NSDictionary *caseDic){
        //刷新橱窗商品列表
        [weak_self _requestGoodsShowcaseGoodsDataWithCaseID:caseDic[@"id"]];
    };
}

#pragma mark - 橱窗二级
-(void)_initShowCaseSecondLevelCollectionView{
    UICollectionViewFlowLayout *flowLayoutSecondLevel = [[UICollectionViewFlowLayout alloc] init];
    [self setFlowLayout:flowLayoutSecondLevel withCollectionType:SecondLevelCollectionViewType];
    self.showCaseSecondLevelCollectionView.collectionViewType = SecondLevelCollectionViewType;
    WEAK_SELF
    self.showCaseSecondLevelCollectionView.collectionViewLayout = flowLayoutSecondLevel;
    self.showCaseSecondLevelCollectionView.clickCaseGoodsCellBlock = ^(GoodsDetailModel *model){
        [weak_self _comintoGoodsdetalPageWithGoodsId:model.GoodsDetailModelID];
    };
    weak_self;
    self.showCaseSecondLevelCollectionView.currentSecondCasePageBlock = ^(NSInteger currentPage){
//        [UIView animateWithDuration:0.0 animations:^{
            weak_self.secondGoodsPageControl.currentPage = currentPage;
//        }];
    };
}

#pragma mark - 圈子
-(void)_initCircleCollectionView{
    
    UICollectionViewFlowLayout *flowLayoutCircle = [[UICollectionViewFlowLayout alloc] init];
//    [self setFlowLayout:flowLayoutCircle isCircle:YES];
    [self setFlowLayout:flowLayoutCircle withCollecionType:CirCleCollectionViewType];

    self.shCircleCollectionViiew.collectionViewType = CirCleCollectionViewType;
    self.shCircleCollectionViiew.collectionViewLayout = flowLayoutCircle;
    WEAK_SELF
    self.shCircleCollectionViiew.circleClickBlock = ^(NSNumber *circleID){
    
        WSJShopCategoryViewController *shopCategoryVC = [[WSJShopCategoryViewController alloc] initWithNibName:@"WSJShopCategoryViewController" bundle:nil];
        shopCategoryVC.api_classId = circleID;
        shopCategoryVC.hidesBottomBarWhenPushed = YES;
        [weak_self.shoppingHomeController.navigationController pushViewController:shopCategoryVC animated:YES];
    };
}


#pragma mark - 积分商城入口广告
- (void)_initIntegralAd {
    
    self.integralAdImgView.userInteractionEnabled = YES;
    [self.integralAdImgView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        IntegralShopHomeController *integralShopHomeController = [[IntegralShopHomeController alloc] init];
        integralShopHomeController.hidesBottomBarWhenPushed = YES;
        [self.shoppingHomeController.navigationController pushViewController:integralShopHomeController animated:YES];
        
    }];
    
}


#pragma mark - 猜您喜欢，有您喜欢
-(void)_initYouLikeCollectionView{
    
    UICollectionViewFlowLayout *flowLayoutLike = [[UICollectionViewFlowLayout alloc] init];
    [self setFlowLayout:flowLayoutLike withCollecionType:GuessYoulikeCollectionViewType];
    self.guessYouLikeCollecionView.collectionViewLayout = flowLayoutLike;
#warning 这里谨记--千万不要把同一个flow给两个collection，这样它就会指向第二个，尽管这两个collection的布局一模一样，，这样会导致他们的代理方法不走
    UICollectionViewFlowLayout *flowLayoutHaveYouLike = [[UICollectionViewFlowLayout alloc] init];
    [self setFlowLayout:flowLayoutHaveYouLike withCollecionType:HasYourLikeCollectionViewType];
    self.haveYouLikeCollectionView.collectionViewLayout = flowLayoutHaveYouLike;

    //点击回调
    WEAK_SELF
    self.guessYouLikeCollecionView.shopHomeGuessyouLikeBlock = ^(GoodsDetailModel *model){
        [weak_self _comintoGoodsdetalPageWithGoodsId:model.GoodsDetailModelID];
    };
#pragma mark - 去掉有您喜欢的
    self.haveYouLikeCollectionView.haveyouLikeClickBlock = ^(AdRecommendModel *model){
        
                NSNumber *goodsID = @(model.itemId.integerValue);
                [weak_self _comintoGoodsdetalPageWithGoodsId:goodsID];
    };
    
}

#pragma mark - 进入搜索页
- (IBAction)comminToSearchPageAction:(id)sender {
    
    WSJKeySearchViewController *shopSearchVC = [[WSJKeySearchViewController alloc] init];
    shopSearchVC.shopType = searchShopType;
    shopSearchVC.hidesBottomBarWhenPushed = YES;
    [self.shoppingHomeController.navigationController pushViewController:shopSearchVC animated:YES];
}


#pragma mark - 进入商品详情页
-(void)_comintoGoodsdetalPageWithGoodsId:(NSNumber *)goodsID {
    KJGoodsDetailViewController *goodsDetailVC = [[KJGoodsDetailViewController alloc] init];
    goodsDetailVC.goodsID = goodsID;
    goodsDetailVC.hidesBottomBarWhenPushed = YES;
    [self.shoppingHomeController.navigationController pushViewController:goodsDetailVC animated:YES];
}


#pragma mark - 设置圈子，猜您，有您喜欢collectionFlowlayout
-(void)setFlowLayout:(UICollectionViewFlowLayout *)flowLayout isCircle:(BOOL)isCircle{
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    if (isCircle) {
        flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.frame)/4, 73);
    }else{
        flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.frame)/2, 410/2);
    }
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
}

-(void)setFlowLayout:(UICollectionViewFlowLayout *)flowLayout withCollecionType:(ShoppingMainCollectionViewType)collectionType{
    
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    if (collectionType == CirCleCollectionViewType) {
        flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.frame)/4, 73);
    }else if(collectionType == GuessYoulikeCollectionViewType){//猜您喜欢
        flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.frame)/2, kCareChoosenGoodsCellHeight);
    }else{//有您喜欢
        flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.frame)/2, KRecommendGoodsCellHeight);
    }
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
}



#pragma mark - 设置橱窗一级二级collectionFlowlayout
-(void)setFlowLayout:(UICollectionViewFlowLayout *)flowLayout withCollectionType:(ShowCaseCollectionViewType)collectionType
{
    flowLayout.minimumLineSpacing = 5 ;
    if (collectionType == FirstLevelCollectionViewType) {
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        flowLayout.itemSize = CGSizeMake(103, 27);
    }else{
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 5, 10, 5);
        flowLayout.itemSize = CGSizeMake((CGRectGetWidth(self.frame)-5*4)/3, 112);
        
    }
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
}

#pragma mark - 头部SDCycleScrollView delegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    AdRecommendModel *model = _adRecommendArr[index];
    if (model.itemId) {
        NSNumber *goodsID = @(model.itemId.integerValue);
        [self _comintoGoodsdetalPageWithGoodsId:goodsID];
    }
    
}





@end
