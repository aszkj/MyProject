//
//  HappyShoppingNewView.m
//  jingGang
//
//  Created by 张康健 on 15/11/21.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "HappyShoppingNewView.h"
#import "HappyShoppingCollectionView.h"
#import "GlobeObject.h"
#import "VApiManager.h"
#import "RecommentCodeDefine.h"
#import "AdRecommendModel.h"
#import "TMCache.h"
#import "MJRefresh.h"
#import "GoodsDetailModel.h"
#import "KJGoodsDetailViewController.h"
#import "UIView+firstResponseController.h"
#import "IntegralShopHomeController.h"
@interface HappyShoppingNewView (){

    VApiManager *_vapManager;
    TMCache     *_hasYoulikeCache;
    NSInteger  _requestFromPage;
    BOOL       _isLoadData;
    

}

@property (weak, nonatomic) IBOutlet HappyShoppingCollectionView *happyShoppingCollectionView;

@end

@implementation HappyShoppingNewView


-(void)awakeFromNib {
    
    [self _init];


}

- (void)_init {
    
    _isLoadData = NO;
    _requestFromPage = 1;
    _vapManager = [[VApiManager alloc] init];
    _hasYoulikeCache = [TMCache sharedCache];
    CGFloat kgap = 0;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = kgap;
    layout.minimumInteritemSpacing = kgap;
    self.happyShoppingCollectionView.collectionViewLayout = layout;
    
    [self _addHeaderFresh];
    
    WEAK_SELF;
    self.happyShoppingCollectionView.clickItemBlcok = ^(NSNumber *ID,NSIndexPath *indexPath){
        
         NSLog(@"表的第一响应者%@",self.firstResponseController.navigationController);
        KJGoodsDetailViewController *goodsDetailVC = [[KJGoodsDetailViewController alloc] init];
        goodsDetailVC.goodsID = ID;
        [weak_self.firstResponseController.navigationController pushViewController:goodsDetailVC animated:YES];
    };

}

- (void)scrollTop {
    [self.happyShoppingCollectionView backtoTop];
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    //这里为什么要采用这种方式调用，，因为这种方式是等这个方法走完才会调用具体方法，那么为什么要等这个方法走完呢，，因为这个方法是布局子视图的，，只有这个方法走完子视图才布局完成，所以self.happyShoppingCollectionView.headerView才不为空，才能调用，，如果你直接掉的话，它是空的，因为子视图还没有布局完成
    if (_isLoadData) {
        if (iOS7) {
            return;
        }
    }
    [self performSelector:@selector(_requestHeaderData) withObject:nil afterDelay:0.0];
    [self _requestTableData];
    _isLoadData = YES;
    
    
}

- (void)_addHeaderFresh {
    
    [self.happyShoppingCollectionView addHeaderWithCallback:^{
        _requestFromPage = 1;
        [self _requestHeaderData];
        [self _requestTableData];
    }];
    
    [self.happyShoppingCollectionView addFooterWithCallback:^{
        [self _requestGuessYouLikeData];
    }];
}




-(void)_requestHeaderData{

    [self.happyShoppingCollectionView.headerView headerRequestData];
    
}

- (void)_requestTableData {
    //请求精品推荐
    [self _requestHeaderDataWithAdCode:ShoppingHomeHasYourLikeCode];

//    [self _requestGuessYouLikeData];
    
}



-(void)_requestHeaderDataWithAdCode:(NSString *)adCode{
    
    SnsRecommendListRequest *request = [[SnsRecommendListRequest alloc] init:GetToken];
    request.api_posCode = adCode;
    [_vapManager snsRecommendList:request success:^(AFHTTPRequestOperation *operation, SnsRecommendListResponse *response) {

            NSMutableArray *_hasYouLikeArr = [NSMutableArray arrayWithCapacity:response.advList.count];
//            NSLog(@"有您细化个数 %ld",response.advList.count);
            NSInteger itemCount = response.advList.count;
            for (int i=0; i<itemCount; i++) {
                NSDictionary *dic = response.advList[i];
                AdRecommendModel *model = [[AdRecommendModel alloc] initWithJSONDic:dic];
                [_hasYouLikeArr addObject:model];
            }
            [self.happyShoppingCollectionView.dataDic setObject:(NSArray *)_hasYouLikeArr forKey:kPerfictGoodsRecommendKey];
//            [self.happyShoppingCollectionView reloadData];
        
            [self _requestGuessYouLikeData];

      
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     
    }];
}

#pragma mark - 猜您喜欢列表
-(void)_requestGuessYouLikeData{
    
    LikeYouGoodsListRequest *reqeust = [[LikeYouGoodsListRequest alloc] init:GetToken];
    NSArray *guessYourLikeIdArr = [_hasYoulikeCache objectForKey:KHasYoulikeCacheKey];
    //    if (guessYourLikeIdArr.count > 0) {//说明有
    //        NSString *guessYoulikeIdStr = [guessYourLikeIdArr componentsJoinedByString:@","];
    //        reqeust.api_likeIds = guessYoulikeIdStr;
    //    }
    reqeust.api_pageNum = @(_requestFromPage);
    reqeust.api_pageSize = @4;
    
    [_vapManager likeYouGoodsList:reqeust success:^(AFHTTPRequestOperation *operation, LikeYouGoodsListResponse *response) {
        NSLog(@"有您喜欢 %@",response);
        NSInteger itemCount = response.youLikelist.count;
        NSMutableArray *guessYouLikeArr = [NSMutableArray arrayWithCapacity:itemCount];
        for (int i=0; i<itemCount; i++) {
            NSDictionary *dic = response.youLikelist[i];
            GoodsDetailModel *model = [[GoodsDetailModel alloc] initWithJSONDic:dic];
            [guessYouLikeArr addObject:model];
        }
        
        if (_requestFromPage == 1) {//下拉刷新
            [self.happyShoppingCollectionView headerEndRefreshing];
            [self.happyShoppingCollectionView.dataDic setObject:guessYouLikeArr forKey:kHasYoulikeGoodsKey];
        }else {//上拉加载更多
            [self.happyShoppingCollectionView footerEndRefreshing];
            NSMutableArray *arr = [[self.happyShoppingCollectionView.dataDic objectForKey:kHasYoulikeGoodsKey] mutableCopy];
            [arr addObjectsFromArray:guessYouLikeArr];
            [self.happyShoppingCollectionView.dataDic setObject:(NSArray *)arr forKey:kHasYoulikeGoodsKey];
        }
        
        if (itemCount) {
            _requestFromPage ++;
            [self.happyShoppingCollectionView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
}








@end
