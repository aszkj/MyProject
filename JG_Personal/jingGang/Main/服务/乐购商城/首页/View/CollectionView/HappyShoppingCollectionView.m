//
//  HappyShoppingCollectionView.m
//  jingGang
//
//  Created by 张康健 on 15/11/21.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "HappyShoppingCollectionView.h"
#import "HappyShoppingSecondSectionHeaderView.h"
#import "HasyouLikeCollecionCell.h"
#import "AdRecommendModel.h"
#import "UIImageView+WebCache.h"
#import "GlobeObject.h"
#import "SHKJGuessyouLikeCollectionCell.h"

@interface HappyShoppingCollectionView(){

    NSDictionary *_sectionHeaderDataDic;

}

@end

@implementation HappyShoppingCollectionView

static NSString *HappyShoppingFirstSectionHeaderID = @"HappyShoppingFirstSectionHeaderID";
static NSString *HasyouLikeCollecionCellID = @"HasyouLikeCollecionCellID";
static NSString *GuessyouLikeCollectionCellID= @"GuessyouLikeCollectionCellID";
static NSString *HappyShoppingSecondSectionHeaderID = @"HappyShoppingSecondSectionHeaderID";

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self _init];
    }
    return self;
}


-(void)_init{
    
    self.dataSource = self;
    self.delegate = self;
    _sectionHeaderDataDic = @{kPerfictGoodsRecommendKey:@{@"firstImgName":@"has_you_like",@"itemName":@"精品推荐",@"secondImgName":@"youKown",@"itemColor":COMMONTOPICCOLOR},
                              kHasYoulikeGoodsKey:@{@"firstImgName":@"KEAIDE",@"itemName":@"有您喜欢",@"secondImgName":@"新发现---Assistor.png",@"itemColor":COMMONTOPICCOLOR}};
    


//    self.dataDic = [NSMutableDictionary dictionaryWithCapacity:0];
    self.dataDic = [NSMutableDictionary dictionaryWithDictionary:@{kPerfictGoodsRecommendKey:@[],kHasYoulikeGoodsKey:@[]}];
//    NSArray *deafaultArr = [NSArray array];
//    [self.dataDic setObject:deafaultArr forKey:kHeaderKey];
    [self registerNib:[UINib nibWithNibName:@"HappyShoppingFirstSectionHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HappyShoppingFirstSectionHeaderID];
    
    [self registerNib:[UINib nibWithNibName:@"HasyouLikeCollecionCell" bundle:nil] forCellWithReuseIdentifier:HasyouLikeCollecionCellID];
    [self registerNib:[UINib nibWithNibName:@"SHKJGuessyouLikeCollectionCell" bundle:nil] forCellWithReuseIdentifier:GuessyouLikeCollectionCellID];
    
    [self registerNib:[UINib nibWithNibName:@"HappyShoppingSecondSectionHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HappyShoppingSecondSectionHeaderID];
    
}

- (void)backtoTop {

    [UIView animateWithDuration:0.37 animations:^{

        [self setContentOffset:CGPointMake(0, 0)];

    }];
}

#pragma mark ----------------------- data source -----------------------
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.dataDic.allKeys.count + 1 ;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else{
        NSString *key = self.dataDic.allKeys[section-1];
        NSArray *arr = self.dataDic[key];
        return arr.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section >=1 ) {
        NSString *key = self.dataDic.allKeys[indexPath.section-1];
        NSArray *arr = self.dataDic[key];
        if ([key isEqualToString:kPerfictGoodsRecommendKey]) {//精选商品对应的数据源key
            HasyouLikeCollecionCell *cell = [self dequeueReusableCellWithReuseIdentifier:HasyouLikeCollecionCellID forIndexPath:indexPath];
            AdRecommendModel *model = arr[indexPath.row];
            NSString *newStr = TwiceImgUrlStr(model.adImgPath, KRecommendImgWith, KRecommendImgWith);
            [cell.hasYouLikeImgView sd_setImageWithURL:[NSURL URLWithString:newStr]];
            NSInteger hasMobilePrice = [model.hasMobilePrice integerValue];
            if (hasMobilePrice == 0) {
                cell.labelPrice.text = [NSString stringWithFormat:@"¥%.2f",[model.goodsCurrentPrice floatValue]];
            }else{
                cell.labelPrice.text = [NSString stringWithFormat:@"¥%.2f",[model.goodsMobilePrice floatValue]];
            }
            cell.labelGoodsName.text = [NSString stringWithFormat:@"%@",model.goodsName];
            
            return cell;
        }else if ([key isEqualToString:kHasYoulikeGoodsKey]){//有您喜欢对应的key
            SHKJGuessyouLikeCollectionCell *cell = [self dequeueReusableCellWithReuseIdentifier:GuessyouLikeCollectionCellID forIndexPath:indexPath];
            cell.model = arr[indexPath.row];
            return cell;
        }

    }
    
    
    return nil;
}

#pragma mark ----------------------- header reuse Method -----------------------
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath

{
    
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader){
        if (indexPath.section == 0) {
            HappyShoppingFirstSectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HappyShoppingFirstSectionHeaderID forIndexPath:indexPath];
            reusableview = headerView;
            self.headerView = headerView;
        }else{
        
            HappyShoppingSecondSectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HappyShoppingSecondSectionHeaderID forIndexPath:indexPath];
            NSString *key = self.dataDic.allKeys[indexPath.section-1];
            NSDictionary *dic = _sectionHeaderDataDic[key];
            UIImage *image = [UIImage imageNamed:dic[@"firstImgName"]];
            headerView.sectionIconImgView.image = image;
            if (image.size.width == 0 ||image.size.height ) {
                
            }else {
                headerView.secionIconHeightConstraint.constant = 20 * (image.size.height/image.size.width);
            }
            headerView.sectionTitlLabel.text = dic[@"itemName"];
            headerView.sectionTitlLabel.textColor = dic[@"itemColor"];
            headerView.sectionIconTwoImgView.image = [UIImage imageNamed:dic[@"secondImgName"]];
          
            
            reusableview = headerView;
        }
    }
    
      return reusableview;
}


#pragma mark ----------------------- 布局的 -----------------------
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return  CGSizeMake(375, 407 + kScreenWidth/5 + kScreenWidth/2);
    }

    return CGSizeMake(375, 33);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {//精选商品cell
        return CGSizeMake(kScreenWidth / 2, KRecommendGoodsCellHeight + 20);
    }else if (indexPath.section == 2){//有您喜欢cell
        return CGSizeMake(kScreenWidth / 2, kCareChoosenGoodsCellHeight);
    }else{
        return CGSizeZero;
    }
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
        return UIEdgeInsetsMake(0, 0, 0, 0);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"did select cell");
    
    NSString *key = self.dataDic.allKeys[indexPath.section-1];
    NSArray *arr = self.dataDic[key];
    NSNumber *clickID = nil;
    if (indexPath.section == 1) {//精品推荐点击
        AdRecommendModel *model = arr[indexPath.row];
        clickID = @(model.itemId.integerValue);
    }else if (indexPath.section == 2){//有您喜欢点击
        GoodsDetailModel *model = arr[indexPath.row];
        clickID = model.GoodsDetailModelID;
    }
    if (self.clickItemBlcok) {
        self.clickItemBlcok(clickID,indexPath);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [kNotification postNotificationName:@"kCollectionViewContentOffset" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:self.contentOffset.y],@"contentOffsetY", nil]];
}






@end
