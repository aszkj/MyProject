//
//  GotoStoreExperienceView.m
//  jingGang
//
//  Created by 张康健 on 15/8/14.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "GotoStoreExperienceView.h"
#import "UIView+BlockGesture.h"
#import "GlobeObject.h"
#import "GotoStoreExperienceTableView.h"
#import "GotoStoreExperienceCollectionView.h"
#import "VApiManager.h"
#import "SDCycleScrollView.h"
#import "WSJShopCategoryViewController.h"
#import "ShoppingHomeController.h"
#import "mapObject.h"
#import "ServiceModel.h"
#import "RecommendStoreModel.h"
#import "AwareStoreModel.h"
#import "ServiceDetailController.h"
#import "WSJMerchantDetailViewController.h"
#import "WSJPromotionViewController.h"
#import "WSJKeySearchViewController.h"
#import "RecommentCodeDefine.h"
#import "AdRecommendModel.h"
#import "MJRefresh.h"
#import "JGScanQCodeViewController.h"
#import "JGSacnQRCodeNextController.h"

#define GotoStoreExperienceCellHeight 98
#define GotoStoreExperienceHeaderHeight 27
@interface GotoStoreExperienceView() <SDCycleScrollViewDelegate>{
    
    VApiManager *_vapManager;
    NSNumber    *_latitude; //精度
    NSNumber    *_longtitude; //纬度
    NSNumber    *_cityID;      //城市ID
    NSMutableArray *_adRecommendArr;
}
@property (weak, nonatomic) IBOutlet UIScrollView *gotoStoreScrollView;

//头部
@property (weak, nonatomic) IBOutlet SDCycleScrollView *headerScrollView;

//离我最近表高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nearlestTableHeightConstraint;
//促销推荐表高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *promoteSaleTableHeightConstraint;
//猜您喜欢表高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *guessYoulikeTableHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *gotoStoreTableViewHeightConstraint;

//促销推荐头view
@property (weak, nonatomic) IBOutlet UIView *promoteHeaderView;
//好店推荐头viewx
@property (weak, nonatomic) IBOutlet UIView *goodStoreHeaderView;
//离我最近头view
@property (weak, nonatomic) IBOutlet UIView *nearestHeaderView;


//促销推荐头部高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *promoteHeaderHeightConstraint;
//好店推荐头部高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *goodStoreRecommendHeaderHeightConstraint;
//离我最近头部高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nearestHeaderHeightConstraint;



//八大分类
@property (weak, nonatomic) IBOutlet GotoStoreExperienceCollectionView *gotoStoreCircleCollectionView;
@property (weak, nonatomic) IBOutlet GotoStoreExperienceTableView *promoteRecommendTableView;
@property (weak, nonatomic) IBOutlet GotoStoreExperienceTableView *goodStoreRecommendTableView;
@property (weak, nonatomic) IBOutlet GotoStoreExperienceTableView *nearestTableView;

@end

@implementation GotoStoreExperienceView

-(void)awakeFromNib{
    
    _vapManager = [[VApiManager alloc] init];
    
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    //初始化
    [self _init];
    
    //下拉刷新
    [self _addHeaderFresh];
    
    //请求数据
    [self _requestData];
    
    self.goodStoreHeaderView.backgroundColor = JGRandomColor;
    
}


#pragma mark ----------------------- private Method -----------------------
- (void)_init {
    
    //头部
    [self _initHeaderScrollView];
    
    //圈子 八大主营分类
    [self _initCircleCollectionView];
    
    //下面三张表
    [self _initThreeTalbe];
    self.backgroundColor = JGBaseColor;
    
}

- (void)_addHeaderFresh {
    
    [self.gotoStoreScrollView addHeaderWithCallback:^{
        [self _requestData];
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


#pragma mark - 圈子
-(void)_initCircleCollectionView{
    
    UICollectionViewFlowLayout *flowLayoutCircle = [[UICollectionViewFlowLayout alloc] init];
    flowLayoutCircle.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayoutCircle.minimumLineSpacing = 0;
    flowLayoutCircle.minimumInteritemSpacing = 0;
    flowLayoutCircle.itemSize = CGSizeMake(CGRectGetWidth(self.frame)/4, 73);
    flowLayoutCircle.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.gotoStoreCircleCollectionView.collectionViewLayout = flowLayoutCircle;
    WEAK_SELF
    self.gotoStoreCircleCollectionView.clickCircleItemBlock = ^(NSNumber *itemNumber){

        NSLog(@"item number %@",itemNumber);
        WSJShopCategoryViewController *shopCategoryVC = [[WSJShopCategoryViewController alloc] initWithNibName:@"WSJShopCategoryViewController" bundle:nil];
        shopCategoryVC.api_classId = itemNumber;
        shopCategoryVC.shopType = O2OType;
        shopCategoryVC.hidesBottomBarWhenPushed = YES;
        [weak_self.shoppingHomeVC.navigationController pushViewController:shopCategoryVC animated:YES];
    };
}

#pragma mark - 下面三个表，促销推荐、好店推荐、离我最近
- (void)_initThreeTalbe {
    
    self.promoteRecommendTableView.gotoStoreTableType = PromoteRecommendTableType;
    self.goodStoreRecommendTableView.gotoStoreTableType = GoodStoreRecommendTableType;
    self.nearestTableView.gotoStoreTableType = NearestTableType;
    
    WEAK_SELF;
    //促销推荐
    self.promoteRecommendTableView.clickItemBlock = ^(NSNumber *itemID){
        
        //促销推荐服务
        [weak_self _cominToServiceDetailWithServiceID:itemID];
        
    };
    //好店推荐
    self.goodStoreRecommendTableView.clickItemBlock = ^(NSNumber *itemID){

        [weak_self _cominToStoreDetailWithStoreId:itemID];
    };
    
    //离我最近
    self.nearestTableView.clickItemBlock = ^(NSNumber *itemID){
        
        //离我最近服务
        [weak_self _cominToServiceDetailWithServiceID:itemID];
    
    };
    
}

#pragma mark - 进入服务详情
-(void)_cominToServiceDetailWithServiceID:(NSNumber *)serviceID {
    ServiceDetailController *serviceDetailVC = [[ServiceDetailController alloc] init];
    serviceDetailVC.serviceID = serviceID;
    serviceDetailVC.hidesBottomBarWhenPushed = YES;
    serviceDetailVC.hidesBottomBarWhenPushed = YES;
    [self.shoppingHomeVC.navigationController pushViewController:serviceDetailVC animated:YES];
}
/**
 *  扫描二维码按钮
 */
- (IBAction)scanQRcodeButtonClick:(id)sender {
    WEAK_SELF
    JGScanQCodeViewController *scanQRCodeVc = [[JGScanQCodeViewController alloc]initWithCodeSuccess:^(NSString *string) {
        
        JGSacnQRCodeNextController *sacnQRCodeNextVC = [[JGSacnQRCodeNextController alloc]init];
        sacnQRCodeNextVC.strScanQRCodeUrl = string;
        [weak_self.shoppingHomeVC.navigationController pushViewController:sacnQRCodeNextVC animated:YES];
    } fail:^{
        
    }];
    [self.shoppingHomeVC.navigationController pushViewController:scanQRCodeVc animated:YES];
}

#pragma mark - 进入店铺详情
-(void)_cominToStoreDetailWithStoreId:(NSNumber *)storeID {
    WSJMerchantDetailViewController *goodStoreVC = [[WSJMerchantDetailViewController alloc] init];
    goodStoreVC.api_classId = storeID;
    goodStoreVC.hidesBottomBarWhenPushed = YES;
    [self.shoppingHomeVC.navigationController pushViewController:goodStoreVC animated:YES];
}

-(void)_dealWithHeaderView:(UIView *)headerView headerHeightConstraingt:(NSLayoutConstraint *)headerHeightConstraint itemCount:(NSInteger)itemCount
{
    headerHeightConstraint.constant = itemCount > 0 ? GotoStoreExperienceHeaderHeight : 1;
    headerView.hidden = itemCount > 0 ? NO : YES;
}


#pragma mark ----------------------- RequestData Method -----------------------
- (void)_requestData {
    
    //请求八大分类
    [self _requestMerchantEightClassData];
    
    _latitude = [[mapObject sharedMap] baiduLatitude];
    _longtitude = [[mapObject sharedMap] baiduLongitude];
    _cityID = [[mapObject sharedMap] baiduCityID];

    NSLog(@"精度 %@ 维度 %@，城市ID %@",_latitude,_longtitude,_cityID);
    //顺序请求，减少线程并发数
    //请求头部服务推荐
    [self _requestHeaderRecommendData];
    
    //请求促销推荐
//    [self _promoteSalesRecommed];
    
    //请求好店推荐
//    [self _goodStoreRecommendRequest];
    
    //请求离我最近
//    [self _requestAwayNearlestMe];
    
}

#pragma mark - 八大分类
- (void)_requestHeaderRecommendData {
    
    SnsRecommendListRequest *request = [[SnsRecommendListRequest alloc] init:GetToken];
    request.api_posCode = ServiceHomeRecommendCode;
    request.api_cityId = _cityID;
    
    [_vapManager snsRecommendList:request success:^(AFHTTPRequestOperation *operation, SnsRecommendListResponse *response) {
        
        NSLog(@"服务首页广告推荐位 response %@",response);
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
        
        //刷新头部
        self.headerScrollView.imageURLStringsGroup = (NSArray *)headImgUrlArr;
        
        //请求促销推荐
        [self _promoteSalesRecommed];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //请求促销推荐
        [self _promoteSalesRecommed];
    }];
}

-(void)_requestMerchantEightClassData {
   
   GroupGroupClassListRequest *request = [[GroupGroupClassListRequest alloc] init:GetToken];
   request.api_ret = @1;
   
    [_vapManager groupGroupClassList:request success:^(AFHTTPRequestOperation *operation, GroupGroupClassListResponse *response) {
//       NSLog(@"主营类目response %@",response);
       NSInteger itemCount = response.groupClassList.count;
       if (itemCount >= 8) {
           itemCount = 8;
       }
       NSMutableArray *arr = [NSMutableArray arrayWithCapacity:itemCount];
       for (int i=0; i<itemCount; i++) {
           NSDictionary *dic = response.groupClassList[i];
           [arr addObject:dic];
       }
       self.gotoStoreCircleCollectionView.gotoStoreCircleDataArr = (NSArray *)arr;
       [self.gotoStoreCircleCollectionView reloadData];
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];

}

#pragma mark - 促销推荐
- (void)_promoteSalesRecommed {
        PersonalPromotionGoodsListRequest *request = [[PersonalPromotionGoodsListRequest alloc] init:GetToken];
        request.api_cityId = _cityID;
        request.api_pageNum = @1;
        request.api_pageSize = @10;
        request.api_storeLat = _latitude;
        request.api_storeLon = _longtitude;

        [_vapManager personalPromotionGoodsList:request success:^(AFHTTPRequestOperation *operation, PersonalPromotionGoodsListResponse *response) {
            JGLog(@"促销推荐 response %@",response);
            NSInteger itemCount = response.groupGoodsBOs.count;
            if (itemCount >= 2) {
                itemCount = 2;
            }
            
            self.promoteSaleTableHeightConstraint.constant = itemCount * GotoStoreExperienceCellHeight;
            [self _dealWithHeaderView:self.promoteHeaderView headerHeightConstraingt:self.promoteHeaderHeightConstraint itemCount:itemCount];
            
            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:itemCount];

            for (int i=0; i<itemCount; i++) {
                
                NSDictionary *dic = response.groupGoodsBOs[i];
                ServiceModel *model = [[ServiceModel alloc] initWithJSONDic:dic];
                [arr addObject:model];
            }
            self.promoteRecommendTableView.dataArr = (NSArray *)arr;
            [self.promoteRecommendTableView reloadData];
            
            //请求好店推荐
            [self _goodStoreRecommendRequest];

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //请求好店推荐
            [self _goodStoreRecommendRequest];
            
        }];
}

#pragma mark - 好店推荐
-(void)_goodStoreRecommendRequest {
        PersonalRecommStoreListRequest *request = [[PersonalRecommStoreListRequest alloc] init:GetToken];
        request.api_areaId = _cityID;
        request.api_pageNum = @1;
        request.api_pageSize = @10;
        request.api_storeLat = _latitude;
        request.api_storeLon = _longtitude;
        [_vapManager personalRecommStoreList:request success:^(AFHTTPRequestOperation *operation, PersonalRecommStoreListResponse *response) {
            NSInteger itemCount = response.recommStoreInfo.count;
            self.gotoStoreTableViewHeightConstraint.constant = itemCount * GotoStoreExperienceCellHeight;
            [self _dealWithHeaderView:self.goodStoreHeaderView headerHeightConstraingt:self.goodStoreRecommendHeaderHeightConstraint itemCount:itemCount];
            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:itemCount];
            for (int i=0; i<itemCount; i++) {
                NSDictionary *dic = response.recommStoreInfo[i];
                RecommendStoreModel *model = [[RecommendStoreModel alloc] initWithJSONDic:dic];
                [arr addObject:model];
            }
            
            self.goodStoreRecommendTableView.dataArr = (NSArray *)arr;
            [self.goodStoreRecommendTableView reloadData];
            
            //请求离我最近
            [self _requestAwayNearlestMe];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            //请求离我最近
            [self _requestAwayNearlestMe];
        }];
}

#pragma mark - 离我最近
-(void)_requestAwayNearlestMe {
        PersonalAwayStoreListRequest *request = [[PersonalAwayStoreListRequest alloc] init:GetToken];
        request.api_areaId = _cityID;
        request.api_pageNum = @1;
        request.api_pageSize = @10;
        request.api_storeLat = _latitude;
        request.api_storeLon = _longtitude;
        [_vapManager personalAwayStoreList:request success:^(AFHTTPRequestOperation *operation, PersonalAwayStoreListResponse *response) {
            JGLog(@"离我最近--response %@",response);
            NSInteger itemCount = response.awayStoreList.count;
            self.nearlestTableHeightConstraint.constant = itemCount * GotoStoreExperienceCellHeight;
            [self _dealWithHeaderView:self.nearestHeaderView headerHeightConstraingt:self.nearestHeaderHeightConstraint itemCount:itemCount];
            
            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:itemCount];
            for (int i=0; i<itemCount; i++) {
                NSDictionary *dic = response.awayStoreList[i];
                AwareStoreModel *model = [[AwareStoreModel alloc] initWithJSONDic:dic];
                [arr addObject:model];
            }
            
            self.nearestTableView.dataArr = (NSArray *)arr;
            [self.nearestTableView reloadData];
            
            [self.gotoStoreScrollView headerEndRefreshing];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

            [Util ShowAlertWithOnlyMessage:error.localizedDescription];
             self.nearlestTableHeightConstraint.constant = 0;
            [self _dealWithHeaderView:self.nearestHeaderView headerHeightConstraingt:self.nearestHeaderHeightConstraint itemCount:0];
        }];
}




#pragma mark ----------------------- delegate Method -----------------------
#pragma mark - 头部SDCycleScrollView Delegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    AdRecommendModel *model = _adRecommendArr[index];

    NSLog(@"广告类型 %@",model.adType);
    
    if (model.itemId) {
        NSNumber *detailID = @(model.itemId.integerValue);
        if (model.adType.integerValue == 5) {//商户详情
            [self _cominToStoreDetailWithStoreId:detailID];
        }else{
            //服务详情
            [self _cominToServiceDetailWithServiceID:detailID];
        }
    }
}


#pragma mark ----------------------- Action Method -----------------------
- (IBAction)promoteSaleMoreAction:(id)sender {
    
    WSJPromotionViewController *promoteSaleVC = [[WSJPromotionViewController alloc] init];
    promoteSaleVC.hidesBottomBarWhenPushed = YES;
    [self.shoppingHomeVC.navigationController pushViewController:promoteSaleVC animated:YES];
    
}

- (IBAction)comintoSearchPageAction:(id)sender {
    
    WSJKeySearchViewController *shopSearchVC = [[WSJKeySearchViewController alloc] init];
    shopSearchVC.shopType = searchO2Oype;
    shopSearchVC.hidesBottomBarWhenPushed = YES;
    self.shoppingHomeVC.selectCityView.hidden = YES;
    [self.shoppingHomeVC.navigationController pushViewController:shopSearchVC animated:YES];
}


@end
