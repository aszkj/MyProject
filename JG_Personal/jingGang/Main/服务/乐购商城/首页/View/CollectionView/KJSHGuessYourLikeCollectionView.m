//
//  KJSHGuessYourLikeCollectionView.m
//  商品详情页collectionView测试
//
//  Created by 张康健 on 15/8/14.
//  Copyright (c) 2015年 com.organazation. All rights reserved.
//

#import "KJSHGuessYourLikeCollectionView.h"
#import "ShoppingCircleCellectionCell.h"
//#import "KJGuessyouLikeCollectionCell.h"
#import "SHKJGuessyouLikeCollectionCell.h"
#import "HasyouLikeCollecionCell.h"
#import "AdRecommendModel.h"
#import "GlobeObject.h"
#import "UIImageView+WebCache.h"
@implementation KJSHGuessYourLikeCollectionView

static NSString *guessYouLikeCollectionCellID = @"guessYouLikeCollectionCellID";
static NSString *ShoppingCircleCellectionCellID = @"ShoppingCircleCellectionCellID";
static NSString *HasyouLikeCollecionCellID = @"HasyouLikeCollecionCellID";

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
    
}

-(void)setCollectionViewType:(ShoppingMainCollectionViewType)collectionViewType{
    
    _collectionViewType = collectionViewType;
    
    if (_collectionViewType == GuessYoulikeCollectionViewType || _collectionViewType == HasYourLikeCollectionViewType) {//猜您喜欢，有你喜欢

        if (_collectionViewType == GuessYoulikeCollectionViewType) {
            [self registerNib:[UINib nibWithNibName:@"SHKJGuessyouLikeCollectionCell" bundle:nil] forCellWithReuseIdentifier:guessYouLikeCollectionCellID];
        }else{
            [self registerNib:[UINib nibWithNibName:@"HasyouLikeCollecionCell" bundle:nil] forCellWithReuseIdentifier:HasyouLikeCollecionCellID];
        }
        
    }else{//圈子对应的collectionView
        [self registerNib:[UINib nibWithNibName:@"ShoppingCircleCellectionCell" bundle:nil] forCellWithReuseIdentifier:ShoppingCircleCellectionCellID];
        
    }
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_collectionViewType == GuessYoulikeCollectionViewType) {
        return self.guessYouLikeDataArr.count;
    }else if (_collectionViewType == HasYourLikeCollectionViewType){
        return 4;
    }else{
        return self.circleDataArr.count;
    }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_collectionViewType == GuessYoulikeCollectionViewType || _collectionViewType == HasYourLikeCollectionViewType) {
        
        if (_collectionViewType == GuessYoulikeCollectionViewType) {
            SHKJGuessyouLikeCollectionCell *cell = [self dequeueReusableCellWithReuseIdentifier:guessYouLikeCollectionCellID forIndexPath:indexPath];
            //猜您喜欢模型赋值
            cell.model = self.guessYouLikeDataArr[indexPath.row];
            return cell;
        }else{//有您喜欢模型赋值
            HasyouLikeCollecionCell *cell = [self dequeueReusableCellWithReuseIdentifier:HasyouLikeCollecionCellID forIndexPath:indexPath];
            AdRecommendModel *model = self.hasYouLikeDataArr[indexPath.row];
#pragma mark - 2*2
            NSString *newStr = TwiceImgUrlStr(model.adImgPath, 136, 185);
            [cell.hasYouLikeImgView sd_setImageWithURL:[NSURL URLWithString:newStr]];
            return cell;
        }
        
    }else{//圈子
        
        ShoppingCircleCellectionCell *cell = [self dequeueReusableCellWithReuseIdentifier:ShoppingCircleCellectionCellID forIndexPath:indexPath];
        NSDictionary *dic = self.circleDataArr[indexPath.row];
        NSString *imgName = [NSString stringWithFormat:@"%02ld",indexPath.row+1];
//        [cell.circleButton setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        [cell.shopCircleImgView sd_setImageWithURL:[NSURL URLWithString:dic[@"mobileIcon"]] placeholderImage:nil];
        cell.circleTitleLabel.text = dic[@"className"];
        return cell;
    }
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.collectionViewType == CirCleCollectionViewType) {
        if (self.circleClickBlock) {
            self.circleClickBlock(self.circleDataArr[indexPath.row][@"id"]);
        }
    }else{
        
        if (self.collectionViewType == GuessYoulikeCollectionViewType) {//猜您喜欢
            if (self.guessyouLikeClickBlock) {
                self.guessyouLikeClickBlock(self.guessYouLikeDataArr[indexPath.row]);
            }
        }else{//有您喜欢
            if (self.hasyouLikeClickBlock) {
                self.hasyouLikeClickBlock(self.hasYouLikeDataArr[indexPath.row]);
            }
        
        }
    
    }
    
}

@end
