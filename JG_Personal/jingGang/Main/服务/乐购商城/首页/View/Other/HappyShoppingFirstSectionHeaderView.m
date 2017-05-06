//
//  HappyShoppingFirstSectionHeaderView.m
//  jingGang
//
//  Created by 张康健 on 15/11/21.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "HappyShoppingFirstSectionHeaderView.h"
#import "IntegralShopHomeController.h"
#import "UIView+firstResponseController.h"
#import "WSJShopCategoryViewController.h"
#import "UIView+BlockGesture.h"
#import "KJGoodsDetailViewController.h"
#import "VApiManager.h"
#import "UIImageView+WebCache.h"
#import "GlobeObject.h"
#import "AdRecommendModel.h"
#import "RecommentCodeDefine.h"
#import "WSJKeySearchViewController.h"
#import "IntegralNewHomeController.h"
//#import "JGScanQCodeViewController.h"
//#import "JGSacnQRCodeNextController.h"
@interface HappyShoppingFirstSectionHeaderView()<SDCycleScrollViewDelegate>{

    VApiManager     *_vapManager;
    NSMutableArray  *_adRecommendArr;

}

@end

@implementation HappyShoppingFirstSectionHeaderView

- (void)awakeFromNib {
    
    _vapManager = [[VApiManager alloc] init];
    
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    [self _init];
}


#pragma mark -------- init Method
-(void)_init{
    
    //头部
    [self _initHeaderScrollView];
    //圈子
    [self _initCircleCollectionView];
    //初始化积分商城入口广告
    [self _initIntegralAd];
    //橱窗一级
    [self _initShowCaseFirstLevelCollectionView];
    //橱窗二级
    [self _initShowCaseSecondLevelCollectionView];
    
}

- (void)headerRequestData {
    
    //请求头部广告推荐位
    [self _requestHeaderDataWithAdCode:ShoppingHomeRecommendCode];
    
    //请求积分广告
    [self _requestIntegralGoodsImgWithCode:IntegralShopImgCode];
    
    //请求商品一级分类
    [self _requestGoodsClassfy];
    
    //请求橱窗
    [self _requestGoodsShowcaseData];
}
/**
 *  扫描按钮
 */
//- (IBAction)scanQRcodeButtonClick:(id)sender {
//    
//    WEAK_SELF
//    JGScanQCodeViewController *scanQRCodeVc = [[JGScanQCodeViewController alloc]initWithCodeSuccess:^(NSString *string) {
//
//        JGSacnQRCodeNextController *sacnQRCodeNextVC = [[JGSacnQRCodeNextController alloc]init];
//        sacnQRCodeNextVC.strScanQRCodeUrl = string;
//        [weak_self.firstResponseController.navigationController pushViewController:sacnQRCodeNextVC animated:YES];
//    } fail:^{
//        
//    }];
//    [self.firstResponseController.navigationController pushViewController:scanQRCodeVc animated:YES];
//}


#pragma mark - 头部广告推荐位
-(void)_requestHeaderDataWithAdCode:(NSString *)adCode{
    
    SnsRecommendListRequest *request = [[SnsRecommendListRequest alloc] init:GetToken];
    request.api_posCode = adCode;
    [_vapManager snsRecommendList:request success:^(AFHTTPRequestOperation *operation, SnsRecommendListResponse *response) {
        
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

        ;
        //
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //请求商品一级分类
        [self _requestGoodsClassfy];
    }];
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



#pragma mark - 头部
-(void)_initHeaderScrollView{
    
    _headerScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _headerScrollView.delegate = self;
    _headerScrollView.backgroundColor = [UIColor whiteColor];
    _headerScrollView.autoScrollTimeInterval = 5.0f;
    // 自定义分页控件小圆标颜色
    _headerScrollView.dotColor = [UIColor greenColor];
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
    self.showCaseSecondLevelCollectionView.currentSecondCasePageBlock = ^(NSInteger currentPage){
        weak_self.secondGoodsPageControl.currentPage = currentPage;

    };
}

#pragma mark - 圈子
-(void)_initCircleCollectionView{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.frame)/4, 73);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.shCircleCollectionViiew.collectionViewType = CirCleCollectionViewType;
    self.shCircleCollectionViiew.collectionViewLayout = flowLayout;
    WEAK_SELF
    self.shCircleCollectionViiew.circleClickBlock = ^(NSNumber *circleID){
        
        WSJShopCategoryViewController *shopCategoryVC = [[WSJShopCategoryViewController alloc] initWithNibName:@"WSJShopCategoryViewController" bundle:nil];
        shopCategoryVC.api_classId = circleID;
        shopCategoryVC.hidesBottomBarWhenPushed = YES;
        [weak_self.firstResponseController.navigationController pushViewController:shopCategoryVC animated:YES];
    };
}


#pragma mark - 积分商城入口广告
- (void)_initIntegralAd {
    
    self.integralAdImgView.userInteractionEnabled = YES;
    [self.integralAdImgView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
        NSLog(@"表头的第一响应者%@",self.firstResponseController.navigationController);
        IntegralNewHomeController *integralShopHomeController = [[IntegralNewHomeController alloc] init];
        integralShopHomeController.hidesBottomBarWhenPushed = YES;
        [self.firstResponseController.navigationController pushViewController:integralShopHomeController animated:YES];
        
    }];
    
}

#pragma mark - 设置橱窗一级二级collectionFlowlayout
-(void)setFlowLayout:(UICollectionViewFlowLayout *)flowLayout withCollectionType:(ShowCaseCollectionViewType)collectionType
{

    if (collectionType == FirstLevelCollectionViewType) {
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
//        flowLayout.itemSize = CGSizeMake(103, 27);
        flowLayout.minimumInteritemSpacing = 0;
    }else{
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 5, 10, 5);
        flowLayout.minimumLineSpacing = 5 ;
//        flowLayout.itemSize = CGSizeMake((CGRectGetWidth(self.frame)-5*4)/3, 112);
        
    }
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
}

#pragma mark - 进入搜索页
- (IBAction)comminToSearchPageAction:(id)sender {
    
    WSJKeySearchViewController *shopSearchVC = [[WSJKeySearchViewController alloc] init];
    shopSearchVC.shopType = searchShopType;
    shopSearchVC.hidesBottomBarWhenPushed = YES;
    [self.firstResponseController.navigationController pushViewController:shopSearchVC animated:YES];
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


#pragma mark - 进入商品详情页
-(void)_comintoGoodsdetalPageWithGoodsId:(NSNumber *)goodsID {
    KJGoodsDetailViewController *goodsDetailVC = [[KJGoodsDetailViewController alloc] init];
    goodsDetailVC.goodsID = goodsID;
    goodsDetailVC.hidesBottomBarWhenPushed = YES;
    [self.firstResponseController.navigationController pushViewController:goodsDetailVC animated:YES];
}






@end
