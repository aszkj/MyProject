//
//  DLHomeHeaderView.m
//  YilidiBuyer
//
//  Created by yld on 16/4/16.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLHomeHeaderView.h"
#import "MyCommonCollectionView.h"
#import "DLHomeSpecialItemCollectionViewCell.h"
#import "DLHomeSpecialItemModel.h"
#import "ProjectRelativeMaco.h"
#import "DLHomeHeaderLoopModel.h"
#import "SUIUtils.h"
#import "GlobleConst.h"
#import "DLHomeGoodsModel.h"
#import "ProjectRelativeMaco.h"
#import "NSArray+subArrToIndex.h"
#import "TimerLoopView.h"
#import "ProjectRelativeDefineNotification.h"
#import "UIButton+Block.h"
#import "ProjectRelativeKey.h"
#import "DLHomeTopView.h"
#import "DataManager+linkDataHandle.h"
#import "NSArray+extend.h"
#import "MyCommonCollectionView.h"
#import <Masonry/Masonry.h>
#import "DLSpecialSubjectModel.h"
#import "DLHomeSpecialSubjectCell.h"
#import "SeckillActivityManager.h"
#import "CountDownView.h"
#import "ProjectRelativeKey.h"
#import "UIView+BlockGesture.h"
#import <SDWebImage/UIButton+WebCache.h>


@interface DLHomeHeaderView()<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet MyCommonCollectionView *specialItemCollectionView;
@property (weak, nonatomic) IBOutlet UIView *headerTopView;
@property (nonatomic,copy)NSArray *imgUrlArr;
@property (nonatomic, strong)DLHomeTopView *homeTopView;
@property (weak, nonatomic) IBOutlet MyCommonCollectionView *specialSubjectCollectionView;
@property (nonatomic, copy)NSArray *headerAdArr;
@property (nonatomic, strong)SeckillActivityManager *seckillActivityManager;
@property (weak, nonatomic) IBOutlet  CountDownView*seckillActivityCountDownView;
@property (weak, nonatomic) IBOutlet UIImageView *firstSpecialSubjectImgView;
@property (weak, nonatomic) IBOutlet UIImageView *secondSpecialSubjectImgView;
@property (weak, nonatomic) IBOutlet UIImageView *seckillActivityImgView;
@property (weak, nonatomic) IBOutlet UIImageView *holidayAdImgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpecialSubjectPartHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *seckillActivityViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *seckillActivityHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *specialSubjectSecondPartHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *holidayAdViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *specialPartToHolidayTopEdgeConstraint;

@end

@implementation DLHomeHeaderView

- (void)awakeFromNib {
    
    [self _init];
    
//    [self _loadTopBarView];
}


#pragma mark -------------------Init Method----------------------
-(void)_init {
    
    [self _initHeaderScrollView];
    
    [self _initHolidayAdView];
    
    [self _initSpecialItemView];
    
    [self _initSeckillActivity];
    
    [self _initSpecialSubjectPartView];
}

- (void)_loadTopBarView {
    [self.headerTopView addSubview:self.homeTopView];
    [self.homeTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerTopView);
        make.left.right.mas_equalTo(self.headerTopView);
        make.height.mas_equalTo(64);
    }];
}

- (void)_initSeckillActivity {
    self.seckillActivityManager = [[SeckillActivityManager alloc] init];
    WEAK_SELF
    self.seckillActivityManager.crazySaleActivityCountDonwBlock = ^(long long leftCount){
        weak_self.seckillActivityCountDownView.countDownNumber = (NSInteger)leftCount;
        if (leftCount%3==0) {
            [weak_self _confiureSeckillAdImgViewWithCountDownNumber:leftCount/3];
        }
    };
    const CGFloat seckillViewWidthInIphone6Screen = 144;
    self.seckillActivityViewWidthConstraint.constant = ADAPT_SCREEN_WIDTH(seckillViewWidthInIphone6Screen);
    self.seckillActivityHeightConstraint.constant = KSeckillPartViewHeight;

}

- (void)requestSeckillActivityCrazyStratchInfo {

    [self.seckillActivityManager requestHomeSeckillActivityInfo];

}


#pragma mark - 头部
-(void)_initHeaderScrollView {
    
    self.headerCycleView.currentPageDotColor = [UIColor redColor];
    self.headerCycleView.backgroundColor = [UIColor whiteColor];
    self.headerCycleView.delegate = self;
}

#pragma mark - 节假日
- (void)_initHolidayAdView {
    self.holidayAdImgView.userInteractionEnabled = YES;
    WEAK_SELF
    [self.holidayAdImgView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        DLHomeHeaderLoopModel *firstHolidayAdModel = self.headerHolidayAdArr[0];
        [weak_self _dealClickClassAdAndMoreUIWithLinkCode:firstHolidayAdModel.linkData linkTypeNumber:firstHolidayAdModel.linkTypeNumber];

    }];
}

#pragma mark - 专区
- (void)_initSpecialItemView {
    
    
    [self.specialItemCollectionView configureCollectionCellNibName:@"DLHomeSpecialItemCollectionViewCell" configureCollectionCellData:^(UICollectionView *collectionView,id collectionModel, UICollectionViewCell *collectionCell) {
        DLHomeSpecialItemModel *model = (DLHomeSpecialItemModel *)collectionModel;
        DLHomeSpecialItemCollectionViewCell *cell = (DLHomeSpecialItemCollectionViewCell *)collectionCell;
        [cell.itemIconButton sd_setBackgroundImageWithURL:[NSURL URLWithString:model.iconImgUrl] forState:UIControlStateNormal placeholderImage:IMAGE(model.iconName)];
        cell.titleLabel.text = model.title;
        
    } clickCell:^(UICollectionView *collectionView,id collectionModel, UICollectionViewCell *collectionCell, NSIndexPath *clickIndexPath) {
        NSInteger goodsTypeNumber = 0;
        if (clickIndexPath.row == 0) {
            [kNotification postNotificationName:KNotificationToH5Page object:defineOneKeyValueDic(kLinkDataKeyH5Page, H5PAGETYPE_UPGRADE_VIP) userInfo:nil];
        }else if (clickIndexPath.row == 1) {
//            [Util ShowAlertWithOnlyMessage:@"活动暂未开启，敬请期待！"];
            [kNotification postNotificationName:KNotificationLookRedPacketPage object:nil userInfo:nil];

        }else if (clickIndexPath.row == 2){
            goodsTypeNumber = kGoodsTypeNumberSpecialPrice;
            [kNotification postNotificationName:KNotificationLookDifferentGoodsTypeData object:@(goodsTypeNumber) userInfo:nil];
        }else {
            [kNotification postNotificationName:KNotificationLookGoodsClassPage object:defineOneKeyValueDic(kLinkDataKeyGoodsClass, TOP_CLASS_CODE) userInfo:nil];
        }
    }];
    self.specialItemCollectionView.commonFlowLayout.itemSize = CGSizeMake(kScreenWidth / 4.0, 87);
    self.specialItemCollectionView.commonFlowLayout.sectionInset = MakeUIEdgeInset(0, 0, 0, 0);
    self.specialItemCollectionView.commonFlowLayout.minimumInteritemSpacing = 0;
    self.specialItemCollectionView.commonFlowLayout.minimumLineSpacing = 0;
    self.specialItemCollectionView.commonFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    DLHomeSpecialItemModel *model1 = [[DLHomeSpecialItemModel alloc] init];
    model1.iconName = @"升级VIP";
    model1.title = @"升级VIP";
    model1.iconImgUrl = jFormat(@"%@%@%@",ImgServerDomain,kUrl_HomeIcon,@"grid01.png");
  
    
    DLHomeSpecialItemModel *model2 = [[DLHomeSpecialItemModel alloc] init];
    model2.iconName = @"抢红包";
    model2.title = @"抢红包";
    model2.iconImgUrl = jFormat(@"%@%@%@",ImgServerDomain,kUrl_HomeIcon,@"grid02.png");

    DLHomeSpecialItemModel *model3 = [[DLHomeSpecialItemModel alloc] init];
    model3.iconName = @"每周推荐";
    model3.title = @"每周推荐";
    model3.iconImgUrl = jFormat(@"%@%@%@",ImgServerDomain,kUrl_HomeIcon,@"grid03.png");

    DLHomeSpecialItemModel *model4 = [[DLHomeSpecialItemModel alloc] init];
    model4.iconName = @"全部分类";
    model4.title = @"全部分类";
    model4.iconImgUrl = jFormat(@"%@%@%@",ImgServerDomain,kUrl_HomeIcon,@"grid04.png");

    
    NSArray *arr = @[model1,model2,model3,model4];
    self.specialItemCollectionView.dataLogicModule.currentDataModelArr = [arr mutableCopy];
    [self.specialItemCollectionView reloadData];

}

#pragma mark - 专题区
-(void)_initSpecialSbjectCollectionView {
    
    WEAK_SELF
    [self.specialSubjectCollectionView configureCollectionCellNibName:@"DLHomeSpecialSubjectCell" configureCollectionCellData:^(UICollectionView *collectionView,id collectionModel, UICollectionViewCell *collectionCell) {
        DLHomeSpecialSubjectCell *cell = (DLHomeSpecialSubjectCell *)collectionCell;
        DLHomeHeaderLoopModel *model = (DLHomeHeaderLoopModel *)collectionModel;
        [cell.specialSubjectImgView sd_SetImgWithUrlStr:model.imgUrl placeHolderImgName:nil];
    } clickCell:^(UICollectionView *collectionView,id collectionModel, UICollectionViewCell *collectionCell, NSIndexPath *clickIndexPath) {
        DLHomeHeaderLoopModel *specialSubjectModel = (DLHomeHeaderLoopModel *)collectionModel;
        [weak_self _dealClickClassAdAndMoreUIWithLinkCode:specialSubjectModel.linkData linkTypeNumber:specialSubjectModel.linkTypeNumber];
    }];
    
    self.specialSubjectCollectionView.commonFlowLayout.itemSize = CGSizeMake(kScreenWidth/2, kSpecaiSubjectSecondlPartHeight);
    self.specialItemCollectionView.commonFlowLayout.minimumInteritemSpacing = 1;
    self.specialItemCollectionView.commonFlowLayout.minimumLineSpacing = 1;
    self.specialSubjectCollectionView.commonFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
}

- (void)_initSpecialSubjectPartView {
    self.firstSpecialSubjectImgView.userInteractionEnabled = YES;
    WEAK_SELF
    [self.firstSpecialSubjectImgView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        if (self.headerSpecialSubjectAdArr.count > 0) {
            DLHomeHeaderLoopModel *firstSpecialSubjectModel = self.headerSpecialSubjectAdArr[0];
            [weak_self _dealClickClassAdAndMoreUIWithLinkCode:firstSpecialSubjectModel.linkData linkTypeNumber:firstSpecialSubjectModel.linkTypeNumber];
        }

    }];
    
    self.secondSpecialSubjectImgView.userInteractionEnabled = YES;
    [self.secondSpecialSubjectImgView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        if (self.headerSpecialSubjectAdArr.count > 1) {
            DLHomeHeaderLoopModel *secondSpecialSubjectModel = self.headerSpecialSubjectAdArr[1];
            [weak_self _dealClickClassAdAndMoreUIWithLinkCode:secondSpecialSubjectModel.linkData linkTypeNumber:secondSpecialSubjectModel.linkTypeNumber];
        }

    }];
    
    [self _initSpecialSbjectCollectionView];

}

- (void)_configureSpecialSubjectPartData {
    if (self.headerSpecialSubjectAdArr.count > 0) {
        DLHomeHeaderLoopModel *firstSpecialSubjectAdModel = self.headerSpecialSubjectAdArr.firstObject;
        [self.firstSpecialSubjectImgView sd_SetImgWithUrlStr:firstSpecialSubjectAdModel.imgUrl placeHolderImgName:nil];
    }
    
    if (self.headerSpecialSubjectAdArr.count > 1) {
        DLHomeHeaderLoopModel *secondSpecialSubjectAdModel = self.headerSpecialSubjectAdArr[1];
        [self.secondSpecialSubjectImgView sd_SetImgWithUrlStr:secondSpecialSubjectAdModel.imgUrl placeHolderImgName:nil];
    }

    if (self.headerSpecialSubjectAdArr.count > 2) {
        self.specialSubjectCollectionView.dataLogicModule.currentDataModelArr = [[_headerSpecialSubjectAdArr subarrayWithRange:NSMakeRange(2, self.headerSpecialSubjectAdArr.count-2)] mutableCopy];
        [self.specialSubjectCollectionView reloadData];
        self.specialSubjectSecondPartHeightConstraint.constant = kSpecaiSubjectSecondlPartHeight;
    }else {
        self.bottomSpecialSubjectPartHeightConstraint.constant = 0;

    }
}

- (void)_configureSeckillAdData {
    
    if (self.headerSeckillAdArr.count > 0) {
        DLHomeHeaderLoopModel *firstSeckillAdModel = self.headerSeckillAdArr.firstObject;
        [self.seckillActivityImgView sd_SetImgWithUrlStr:firstSeckillAdModel.imgUrl placeHolderImgName:nil];
    }
}

- (void)_confiureSeckillAdImgViewWithCountDownNumber:(long long)leftCount {
    if (!self.headerSeckillAdArr.count) {
        return;
    }
    NSInteger adImgIndex = leftCount % self.headerSeckillAdArr.count;
    DLHomeHeaderLoopModel *seckillAdModel = self.headerSeckillAdArr[adImgIndex];
    [self.seckillActivityImgView sd_setImageWithURL:[NSURL URLWithString:seckillAdModel.imgUrl] placeholderImage:nil];
    WEAK_SELF
    self.seckillActivityImgView.userInteractionEnabled = YES;
    [self.seckillActivityImgView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        if (self.headerSeckillAdArr.count >= 1) {
            [weak_self _dealClickClassAdAndMoreUIWithLinkCode:seckillAdModel.linkData linkTypeNumber:seckillAdModel.linkTypeNumber];
        }
    }];

}


#pragma mark -------------------Action Method----------------------
- (IBAction)clickToSeckillPageAction:(id)sender {
    [kNotification postNotificationName:KNotificationComeToSeckillActivityPage object:nil];
}

#pragma mark -------------------Setter/Getter Method----------------------
- (DLHomeTopView *)homeTopView {
    
    if (!_homeTopView) {
        _homeTopView = BoundNibView(@"DLHomeTopView", DLHomeTopView);
        _homeTopView.selectdShopBlock = ^{
            [kNotification postNotificationName:KNotificationSelecteNearbyShops object:nil];
        };
        
        _homeTopView.beginSearchBlock = ^{
            [kNotification postNotificationName:KNotificationComeToSearchPage object:nil];
        };
    }
    return _homeTopView;
}

- (void)setHeaderHolidayAdArr:(NSArray *)headerHolidayAdArr {
    _headerHolidayAdArr = headerHolidayAdArr;
    if (headerHolidayAdArr.count) {
        _headerHolidayAdArr = [headerHolidayAdArr transferDicArrToModelArrWithModelClass:[DLHomeHeaderLoopModel class]];
        self.holidayAdViewHeightConstraint.constant = kHolidayAdPartHeight;
        self.specialPartToHolidayTopEdgeConstraint.constant = 0;
        DLHomeHeaderLoopModel *firstHolidayAdModel = _headerHolidayAdArr.firstObject;
        [self.holidayAdImgView sd_SetImgWithUrlStr:firstHolidayAdModel.imgUrl placeHolderImgName:nil];
    }else {
        self.holidayAdViewHeightConstraint.constant = 0;
        self.specialPartToHolidayTopEdgeConstraint.constant = 0;

    }
}

- (void)setHeaderLoopArr:(NSArray *)headerLoopArr {
    
    _headerLoopArr = headerLoopArr;
    if (isEmpty(headerLoopArr)) {
        return;
    }
    NSArray *transferedArr = [headerLoopArr transferDicArrToModelArrWithModelClass:[DLHomeHeaderLoopModel class]];
    self.headerAdArr = transferedArr;
    self.imgUrlArr = (NSArray *)[transferedArr sui_map:^NSString* (DLHomeHeaderLoopModel* obj, NSUInteger index) {
        return obj.imgUrl;
    }];
    self.headerCycleView.imageURLStringsGroup = self.imgUrlArr;
}

- (void)setHeaderSpecialSubjectAdArr:(NSArray *)headerSpecialSubjectAdArr {
    _headerSpecialSubjectAdArr = [headerSpecialSubjectAdArr transferDicArrToModelArrWithModelClass:[DLHomeHeaderLoopModel class]];
    [self _configureSpecialSubjectPartData];
}

- (void)setHeaderSeckillAdArr:(NSArray *)headerSeckillAdArr {
    _headerSeckillAdArr = [headerSeckillAdArr transferDicArrToModelArrWithModelClass:[DLHomeHeaderLoopModel class]];;
    [self _configureSeckillAdData];
}


#pragma mark -------------------Private Method----------------------
- (void)_notifyEnerPerfectGoodsPageWithPerfectGoodsNumber:(NSInteger)perfectGoodsNumber {
    [kNotification postNotificationName:KNotificationToH5Page object:@(perfectGoodsNumber)];
}


- (void)_dealClickClassAdAndMoreUIWithLinkCode:(NSString *)linkCode linkTypeNumber:(NSNumber *)linkTypeNumber{
    NSDictionary *linkInfo = [[DataManager sharedManager] transferToDicWithLinkCodeStr:linkCode linkTypeNumber:linkTypeNumber];
    NSString *linkNotificationName = [[DataManager sharedManager] transferTolinkNotificationNameWithlinkTypeNumber:linkTypeNumber linkDataDic:linkInfo];
    if (isEmpty(linkNotificationName)) {
        return;
    }
    [kNotification postNotificationName:linkNotificationName object:linkInfo];
}


#pragma mark -------------------Delegate Method----------------------
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    DLHomeHeaderLoopModel *clickHeaderModel = self.headerAdArr[index];
    [self _dealClickClassAdAndMoreUIWithLinkCode:clickHeaderModel.linkData linkTypeNumber:clickHeaderModel.linkTypeNumber];
}


@end
