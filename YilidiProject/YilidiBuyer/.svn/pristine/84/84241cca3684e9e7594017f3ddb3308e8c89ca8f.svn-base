//
//  DLHomeHeaderView.m
//  YilidiBuyer
//
//  Created by yld on 16/4/16.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLHomeHeaderView.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "MyCommonCollectionView.h"
#import "DLHomeSpecialItemCollectionViewCell.h"
#import "DLHomeSpecialItemModel.h"
#import "ProjectRelativeMaco.h"
#import "DLHomeNewDistributeFoodModel.h"
#import "DLHomeRecommondFoodModel.h"
#import "DLHomeHeaderLoopModel.h"
#import "SUIUtils.h"
#import "GlobleConst.h"
#import "UIImageView+sd_SetImg.h"
#import "DLHomeGoodsModel.h"
#import "ProjectRelativeMaco.h"
#import "NSArray+subArrToIndex.h"
#import "TimerLoopView.h"
#import "ProjectRelativeDefineNotification.h"
#import "UIButton+Block.h"
#import "ProjectRelativeKey.h"

@interface DLHomeHeaderView()

@property (weak, nonatomic) IBOutlet SDCycleScrollView *headerCycleView;
@property (weak, nonatomic) IBOutlet MyCommonCollectionView *specialItemCollectionView;
@property (weak, nonatomic) IBOutlet MyCommonCollectionView *recommonFoodCollectionView;
@property (weak, nonatomic) IBOutlet MyCommonCollectionView *willOnMarkFoodCollectionView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *recommonCollectionViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *willOnMarkFoodCollectionViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *discountSectionHeaderHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hotSaleSectionHeaderHeightConstriant;
@property (weak, nonatomic) IBOutlet UIView *hotSaleSectionHeaderView;
@property (weak, nonatomic) IBOutlet UIView *disCountSectionHeaderView;
@property (weak, nonatomic) IBOutlet TimerLoopView *adTextLoopView;

@property (nonatomic,copy)NSArray *imgUrlArr;

@end

@implementation DLHomeHeaderView

- (void)awakeFromNib {
    
    [self _init];
    

}

#pragma mark -------------------Init Method----------------------
-(void)_init {
    
    [self _initHeaderScrollView];
    
    [self _initSpecialItemView];
    
    [self _initRecommondFoodView];
    
    [self _initWillOnMarkFoodView];
    
    [self _initTextAdView];
    
    [self initHeaderHeight];
}

#pragma mark - 头部
-(void)_initHeaderScrollView {
    self.headerCycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.headerCycleView.currentPageDotColor = [UIColor redColor];
}

#pragma mark - 文字广告
- (void)_initTextAdView {
    LoopObj *loopObj1 = [[LoopObj alloc] init];
    loopObj1.titleName = @"发生牛奶暴走事件请问官方如何处理";
    LoopObj *loopObj2 = [[LoopObj alloc] init];
    loopObj2.titleName = @"查询用户信息该如何查询";
    NSArray *adArr = @[loopObj1,loopObj2];
    self.adTextLoopView.titleColor = UIColorFromRGB(0xA7A7A7);
    self.adTextLoopView.itemarray = adArr;
}


#pragma mark - 专区
- (void)_initSpecialItemView {

    [self.specialItemCollectionView configureCollectionCellNibName:@"DLHomeSpecialItemCollectionViewCell" configureCollectionCellData:^(id collectionModel, UICollectionViewCell *collectionCell) {
        DLHomeSpecialItemModel *model = (DLHomeSpecialItemModel *)collectionModel;
        DLHomeSpecialItemCollectionViewCell *cell = (DLHomeSpecialItemCollectionViewCell *)collectionCell;
        [cell.itemIconButton setBackgroundImage:IMAGE(model.iconName) forState:UIControlStateNormal];
        cell.titleLabel.text = model.title;
        
    } clickCell:^(id collectionModel, UICollectionViewCell *collectionCell, NSIndexPath *clickIndexPath) {
       NSLog(@"%ld",clickIndexPath.row);
    }];
    self.specialItemCollectionView.commonFlowLayout.itemSize = CGSizeMake(kScreenWidth / 4.0, 75);
    self.specialItemCollectionView.commonFlowLayout.sectionInset = MakeUIEdgeInset(0, 0, 0, 0);
    self.specialItemCollectionView.commonFlowLayout.minimumInteritemSpacing = 0;
    self.specialItemCollectionView.commonFlowLayout.minimumLineSpacing = 0;
    self.specialItemCollectionView.commonFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    DLHomeSpecialItemModel *model1 = [[DLHomeSpecialItemModel alloc] init];
    model1.iconName = @"home_icon_01";
    model1.title = @"秒杀";
    
    DLHomeSpecialItemModel *model2 = [[DLHomeSpecialItemModel alloc] init];
    model2.iconName = @"home_icon_02";
    model2.title = @"红包";

    DLHomeSpecialItemModel *model3 = [[DLHomeSpecialItemModel alloc] init];
    model3.iconName = @"home_icon_03";
    model3.title = @"新品";

    DLHomeSpecialItemModel *model4 = [[DLHomeSpecialItemModel alloc] init];
    model4.iconName = @"home_icon_04";
    model4.title = @"特价";
    
    NSArray *arr = @[model1,model2,model3,model4];
    self.specialItemCollectionView.datas = arr;
    [self.specialItemCollectionView reloadData];

}

#pragma mark - 推荐
- (void)_initRecommondFoodView {
    
    self.recommonCollectionViewHeight.constant = kRecommondFruitCellHeight ;
    [self.recommonFoodCollectionView configureCollectionCellNibName:@"DLHomeRecommendCollectionViewCell" configureCollectionCellData:^(id collectionModel, UICollectionViewCell *collectionCell) {
        DLHomeGoodsModel *model = (DLHomeGoodsModel *)collectionModel;
        DLHomeRecommendCollectionViewCell *cell = (DLHomeRecommendCollectionViewCell *)collectionCell;
        [cell.recommonFruitImgView sd_SetImgWithUrlStr:model.imgUrl placeHolderImgName:nil];
        cell.recommondFruitOriginalPriceLabel.text = kPriceFloatValueToRMB(model.oldPrice.doubleValue);
        cell.recommonFruitTitleLabel.text = model.goodsName;
        cell.recommondFruitNowPriceLabel.text = kPriceFloatValueToRMB(model.goodsPrice.doubleValue);
        
        [cell.addShopCartClickButton addActionHandler:^(NSInteger tag) {
            NSDictionary *postDic = @{kaddShopCartGoodsModelKey:model,
                                      kwillAnimateGoodsViewKey:cell.recommonFruitImgView};
            [kNotification postNotificationName:KNotificationShopCartGoodsChange object:nil userInfo:postDic];
        }];
        
    } clickCell:^(id collectionModel, UICollectionViewCell *collectionCell, NSIndexPath *clickIndexPath) {
        

    }];
    
    
    self.recommonFoodCollectionView.commonFlowLayout.itemSize = CGSizeMake(kScreenWidth / 3.0, kRecommondFruitCellHeight);
    self.recommonFoodCollectionView.commonFlowLayout.sectionInset = MakeUIEdgeInset(0, 0, 0, 0);
    self.recommonFoodCollectionView.commonFlowLayout.minimumInteritemSpacing = 0;
    self.recommonFoodCollectionView.commonFlowLayout.minimumLineSpacing = 0;
    self.recommonFoodCollectionView.commonFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

#pragma mark - 新品，要上市的
- (void)_initWillOnMarkFoodView {
    
    self.willOnMarkFoodCollectionViewHeightConstraint.constant = kHomeWillOnMarkCellHeight*2;
    [self.willOnMarkFoodCollectionView configureCollectionCellNibName:@"DLNewDistributeFoodCollectionViewCell" configureCollectionCellData:^(id collectionModel, UICollectionViewCell *collectionCell) {
        DLHomeGoodsModel *model = (DLHomeGoodsModel *)collectionModel;
        DLNewDistributeFoodCollectionViewCell *cell = (DLNewDistributeFoodCollectionViewCell *)collectionCell;
        cell.salesNumberPerMonthLabel.text = [NSString stringWithFormat:@"月销量%lld",model.salesVolume];
        cell.foodOriginalPriceLabel.text = kPriceFloatValueToRMB(model.oldPrice.doubleValue);
        cell.willOnMarketFoodLabel.text = model.goodsName;
        cell.foodPriceLabel.attributedText = [Util toAttributeRMBfOfValue:model.goodsPrice.doubleValue RMBTextFont:kSystemFontSize(12) zhengshuPartFont:kSystemFontSize(14) pointPartFont:kSystemFontSize(12)];
        [cell.foodImgView sd_SetImgWithUrlStr:model.imgUrl placeHolderImgName:nil];
        
        [cell.addShopCartClickButton addActionHandler:^(NSInteger tag) {
            NSDictionary *postDic = @{kaddShopCartGoodsModelKey:model,
                                      kwillAnimateGoodsViewKey:cell.foodImgView};
            [kNotification postNotificationName:KNotificationShopCartGoodsChange object:nil userInfo:postDic];
        }];

        
    } clickCell:^(id collectionModel, UICollectionViewCell *collectionCell, NSIndexPath *clickIndexPath) {
        
    }];
  
    self.willOnMarkFoodCollectionView.commonFlowLayout.itemSize = CGSizeMake(kScreenWidth, kHomeWillOnMarkCellHeight);
    self.willOnMarkFoodCollectionView.commonFlowLayout.sectionInset = MakeUIEdgeInset(0, 0, 0, 0);
    self.willOnMarkFoodCollectionView.commonFlowLayout.minimumInteritemSpacing = 0;
    self.willOnMarkFoodCollectionView.commonFlowLayout.minimumLineSpacing = 0;
    self.willOnMarkFoodCollectionView.commonFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}


#pragma mark -------------------Setter Method----------------------

-(void)setDiscoutArr:(NSArray *)discoutArr {
    
    _discoutArr = discoutArr;
    _discoutArr = [_discoutArr subArrayToIndex:3];
    self.homeFirstSectionHeaderHeight += [self _disCoutViewDisplayOrHideConfigureWithDataCount:_discoutArr.count];
    NSArray *transferedArr = [DLHomeGoodsModel objectArrayWithKeyValuesArray:_discoutArr];
    self.recommonFoodCollectionView.datas = transferedArr;
    [self.recommonFoodCollectionView reloadData];
}

- (void)setHoteSaleArr:(NSArray *)hoteSaleArr {

    _hoteSaleArr = hoteSaleArr;
    _hoteSaleArr = [_hoteSaleArr subArrayToIndex:2];
    self.homeFirstSectionHeaderHeight += [self _hotSaleViewDisplayOrHideConfigureWithDataCount:_hoteSaleArr.count];
    
    NSArray *transferedArr = [DLHomeGoodsModel objectArrayWithKeyValuesArray:_hoteSaleArr];
    self.willOnMarkFoodCollectionView.datas = transferedArr;
    [self.willOnMarkFoodCollectionView reloadData];
}

- (void)initHeaderHeight {

    self.homeFirstSectionHeaderHeight = kDlhomeHeaderFixedHeight + kDLhomeHeaderCycleViewHeight;

}

- (void)setHeaderLoopArr:(NSArray *)headerLoopArr {
    
    _headerLoopArr = headerLoopArr;
    NSArray *transferedArr = [DLHomeHeaderLoopModel DLObjectArrWihtKeyValuesArr:_headerLoopArr];
    self.imgUrlArr = (NSArray *)[transferedArr sui_map:^NSString* (DLHomeHeaderLoopModel* obj, NSUInteger index) {
        return obj.imgUrl;
    }];
    
    self.headerCycleView.imageURLStringsGroup = self.imgUrlArr;

}



#pragma mark -------------------Api Method----------------------

- (CGFloat )_hotSaleViewDisplayOrHideConfigureWithDataCount:(NSInteger)dataCount {
    
    BOOL isDisplay = dataCount > 0;
    CGFloat hotSalPartHeight = 0.0;
    self.hotSaleSectionHeaderView.hidden = self.willOnMarkFoodCollectionView.hidden = !isDisplay;
    self.hotSaleSectionHeaderHeightConstriant.constant = isDisplay ? kDiscountHotsaleSectionHeaderHeight : 1;
    self.willOnMarkFoodCollectionViewHeightConstraint.constant = isDisplay ? kHomeWillOnMarkCellHeight * dataCount : 1;
    hotSalPartHeight = self.hotSaleSectionHeaderHeightConstriant.constant + self.willOnMarkFoodCollectionViewHeightConstraint.constant;
    //返回高度
    return hotSalPartHeight;
    
}

- (CGFloat)_disCoutViewDisplayOrHideConfigureWithDataCount:(NSInteger)dataCount {
    
    BOOL isDisplay = dataCount > 0;
    CGFloat discountPartHeight = 0.0;

    self.disCountSectionHeaderView.hidden = self.recommonFoodCollectionView.hidden = !isDisplay;
    self.discountSectionHeaderHeightConstraint.constant = isDisplay ? kDiscountHotsaleSectionHeaderHeight : 1;
    self.recommonCollectionViewHeight.constant = isDisplay ? kRecommondFruitCellHeight : 1;
    discountPartHeight = self.discountSectionHeaderHeightConstraint.constant + self.recommonCollectionViewHeight.constant;
    //返回高度
    return discountPartHeight;

}




@end
