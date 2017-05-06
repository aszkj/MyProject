//
//  DLClassificationZoneVC.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/8/9.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLClassificationZoneVC.h"
#import "MyCommonCollectionView.h"
#import "DLGoodsAllshowCell.h"
#import "DLHomeGoodsModel.h"
#import "GlobleConst.h"
#import "GoodsModel.h"
#import "ProjectRelativeKey.h"
#import "DLHomeGoodsVerticalCell.h"
#import "CommunityDataManager.h"
#import "ShopCartView.h"
#import "ProjectRelativeDefineNotification.h"
#import "DLAnimatePerformer.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "DLShopCarVC.h"
#import "UIViewController+unLoginHandle.h"
#import "DLPartitionHeaderView.h"
#import "DataManager+linkDataHandle.h"
#import "UIImageView+sd_SetImg.h"
#import "DLGoodsdetailVC.h"
#import "UIImageView+WebCache.h"
#import "DLAnimatePerformer+business.h"

@interface DLClassificationZoneVC ()<UIScrollViewDelegate>



@property (strong, nonatomic) IBOutlet MyCommonCollectionView *classificationCollection;
@property (strong, nonatomic) IBOutlet ShopCartView *shopCartView;
@property (nonatomic, assign)NSInteger searchedGoodsCount;
@property (nonatomic,strong)NSString *zoneCode;
@property (nonatomic,strong)NSString *heardImage;
@property (nonatomic,strong)NSString *zoneImage;
@property (nonatomic,strong)NSString *zoneColor;


@property (nonatomic,strong)UIImageView *imageSubView;
@property (nonatomic,strong)UIImageView *image;
@property (nonatomic,assign) CGFloat  headSize;
@property (nonatomic,assign) CGFloat  zoneSize;
@end

@implementation DLClassificationZoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    [self showHubWithDefaultStatus];
    
   
    
}



-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
     [self.navigationController setNavigationBarHidden:YES animated:animated];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
     [self.navigationController setNavigationBarHidden:NO animated:animated];
    
}


#pragma mark ------------------------Init---------------------------------
-(void)_init {
    
//    NSDictionary *dic =  [[DataManager  sharedManager]transferToDicWithLinkCodeStr:self.keyWords linkTypeNumber:nil];
    
    self.zoneCode = self.infoDic[kLinkDataKeySpecialSubject];
    
    
    [self requestGoodsData];
    [self _initGoodsSearchResultCollectionView];
    
}


-(void)_initGoodsSearchResultCollectionView {
    
    WEAK_SELF
    self.classificationCollection.noDataLogicModule.nodataAlertTitle = @"抱歉，没有相关商品";
    [self.classificationCollection configureCollectionCellNibName:@"DLHomeGoodsVerticalCell" configureCollectionCellData:^(UICollectionView *collectionView, id collectionModel, UICollectionViewCell *collectionCell,NSIndexPath *clickIndexPath) {
        GoodsModel *model = (GoodsModel *)collectionModel;
        DLHomeGoodsVerticalCell *searchGoodsCell = (DLHomeGoodsVerticalCell *)collectionCell;
        [searchGoodsCell setCellModel:model];
        MyCommonCollectionView *collectionview = (MyCommonCollectionView *)collectionView;
        searchGoodsCell.imgHeightConstraint.constant = collectionview.cellCalculateModel.cellImgHeight;
        searchGoodsCell.imgWidthConstraint.constant = collectionview.cellCalculateModel.cellImgWidth;
        WEAK_OBJ(searchGoodsCell)
        searchGoodsCell.goodsCountChangeView.countChangedBlk = ^(NSInteger nowCount,BOOL isAdd){
            [DLAnimatePerformer excuteAddShopCartAnimationUsingAnimateImageView:weak_searchGoodsCell.goodsImgView contentListView:weak_self.classificationCollection shopCartViewPoint:ListPageShopCartIconPoint isAddShopCart:isAdd];

        };
        
    } clickCell:^(UICollectionView *collectionView, id collectionModel, UICollectionViewCell *collectionCell, NSIndexPath *clickIndexPath) {
        GoodsModel *model = (GoodsModel *)collectionModel;
        [weak_self _enterGoodsDetailWithGoodsId:model.goodsId];
    }];
    
    
    self.classificationCollection.listenCollectionScrollOffsetBlock = ^(CGFloat offset){
        UIColor *barColor=[UIColor whiteColor];
       
        
        weak_self.bgView.backgroundColor=[barColor colorWithAlphaComponent:offset / 200];
        weak_self.bgView.hidden = offset > 30;
        weak_self.bgView.hidden = offset < 30;
        weak_self.backButton.hidden = offset > 30;
        
    };
    
    
    self.classificationCollection.commonFlowLayout.minimumInteritemSpacing = 5;
    self.classificationCollection.commonFlowLayout.minimumLineSpacing = 5;
    self.classificationCollection.commonFlowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    CellCalculateNeedModel *cellCaculateNeedModel = [[CellCalculateNeedModel alloc] initWithHorizontalDisplayCount:2 horizontalDisplayAreaWidth:kScreenWidth cellImgToSideEdge:8 cellImgWidthToHeightScale:0.9 cellOterPartHeightBesideImg:97 edgeBetweenCellAndCell:5 edgeBetweenCellAndSide:5];
    CellCalculateModel *cellCaculateModel = [[CellCalculateModel alloc] initWithCalculateNeedModel:cellCaculateNeedModel];
    self.classificationCollection.cellCalculateModel = cellCaculateModel;
    self.classificationCollection.commonFlowLayout.itemSize = CGSizeMake(cellCaculateModel.cellWidth, cellCaculateModel.cellHeight);
    
    
}

- (void)_isHeaderView{

    
    self.classificationCollection.commonFlowLayout.headerReferenceSize =
    CGSizeMake(kScreenWidth, kScreenWidth/self.headSize+kScreenWidth/self.zoneSize);
    
        WEAK_SELF
        [self.classificationCollection configureFirstSectioHeaderNibName:@"DLPartitionHeaderView" configureFirstSectionHeaderBlock:^(UICollectionView *collectionView, id collectionModel, UICollectionReusableView *firstSectionHeaderView) {
            
           DLPartitionHeaderView *header  = (DLPartitionHeaderView*)firstSectionHeaderView;
            header.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth/self.headSize+kScreenWidth/self.zoneSize);
            header.headViewBg.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth/self.headSize+kScreenWidth/self.zoneSize);
            header.headerImage.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth/self.headSize);
            header.zoneimage.frame = CGRectMake(0, header.headerImage.frame.size.height, kScreenWidth, kScreenWidth/self.zoneSize);
            
            [header.headerImage sd_SetImgWithUrlStr:weak_self.heardImage placeHolderImgName:nil];
            [header.zoneimage sd_SetImgWithUrlStr:weak_self.zoneImage placeHolderImgName:nil];
            header.backgroundColor = [weak_self colorWithHexString:weak_self.zoneColor];
            header.headViewBg.backgroundColor = [weak_self colorWithHexString:weak_self.zoneColor];;
            NSLog(@"head1=%@",NSStringFromCGRect(header.frame));
            NSLog(@"head2=%@",NSStringFromCGRect(header.headViewBg.frame));
            NSLog(@"headimage=%@",NSStringFromCGRect(header.headerImage.frame));
            NSLog(@"zoneimage=%@",NSStringFromCGRect(header.zoneimage.frame));
            
        }];
    


}


#pragma mark ------------------------Private-------------------------

#pragma mark ------------------------Api----------------------------------
- (void)requestGoodsData {
    //这两个imageview是为了计算拿到后台给的url图片的尺寸
    self.image = [[UIImageView alloc]init];
    self.imageSubView = [[UIImageView alloc]init];
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionaryWithCapacity:0];
    [requestParam setObject:self.zoneCode forKey:@"typeCode"];
    [requestParam setObject:kCommunityStoreId forKey:KStoreIdKey];
    WEAK_SELF
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:kUrl_GetClassZoneProducts block:^(NSDictionary *resultDic, NSError *error) {
//        [weak_self dissmiss];
        
        weak_self.zoneColor = resultDic[EntityKey][@"baseColor"];
        
        if (resultDic[EntityKey][@"themeImageUrl"]!=nil&&resultDic[EntityKey][@"sloganImageUrl"]!=nil) {
            weak_self.heardImage = resultDic[EntityKey][@"themeImageUrl"];
            weak_self.zoneImage = resultDic[EntityKey][@"sloganImageUrl"];
            
            [weak_self.imageSubView sd_setImageWithURL:[NSURL URLWithString:weak_self.heardImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [weak_self dissmiss];
                CGSize size = image.size;
                weak_self.headSize = size.width/size.height;
                NSLog(@"headSize:%f",weak_self.headSize);
                [weak_self.image sd_setImageWithURL:[NSURL URLWithString:weak_self.zoneImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    CGSize  size= image.size;
                    weak_self.zoneSize = size.width/size.height;
                    NSLog(@"size:%f",weak_self.zoneSize);
                    NSArray *resultArr = resultDic[EntityKey][@"saleProducts"];
                    NSArray *transferedArr = [GoodsModel objectGoodsModelWithGoodsArr:resultArr];
                    [weak_self.classificationCollection configureCollectionAfterRequestPagingData:transferedArr];

                    [weak_self _isHeaderView];
                    
                }];

            }];

           
        }else {
            [weak_self dissmiss];
            NSArray *resultArr = resultDic[EntityKey][@"saleProducts"];
            NSArray *transferedArr = [GoodsModel objectGoodsModelWithGoodsArr:resultArr];
            [weak_self.classificationCollection configureCollectionAfterRequestPagingData:transferedArr];
    
        }
        
        if (resultDic[EntityKey][@"themeName"]!=nil) {
            weak_self.titleLabel.text = resultDic[EntityKey][@"themeName"];
        }else{
            weak_self.titleLabel.text = @"一里递";
        }
        
       
        
        
    }];
}


#pragma mark ------------------------Page Navigate---------------------------
- (void)_enterGoodsDetailWithGoodsId:(NSString *)goodsId {
    DLGoodsdetailVC *goodsDetailVC = [[DLGoodsdetailVC alloc] init];
    goodsDetailVC.goodsId = goodsId;
    [self navigatePushViewController:goodsDetailVC animate:YES];
}


#pragma mark ------------------------View Event---------------------------
- (IBAction)backPageClick:(id)sender {
    [self goBack];
}

- (IBAction)backButtonClick:(id)sender {
    [self goBack];
}


#pragma mark ------------------------Delegate-----------------------------



#pragma mark ------------------------Notification-------------------------

#pragma mark -------------------Setter/Getter Method----------------------
- (void)setZoneColor:(NSString *)zoneColor {
    
    _zoneColor = zoneColor;
    if (!isEmpty(_zoneColor)) {
    
    self.classificationCollection.backgroundColor = [self colorWithHexString:_zoneColor];
    }
}



- (UIColor *)colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    

    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}



@end
