//
//  GotoStoreExperienceCollectionView.m
//  jingGang
//
//  Created by 张康健 on 15/9/21.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "GotoStoreExperienceCollectionView.h"
#import "ShoppingCircleCellectionCell.h"
#import "UIImageView+WebCache.h"
@implementation GotoStoreExperienceCollectionView

static NSString *GotoStoreCircleCellectionCellID = @"GotoStoreCircleCellectionCellID";

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self _init];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self _init];
    }
    return self;
}


-(void)_init{
    
    _isCircle = NO;
    self.dataSource = self;
    self.delegate = self;
    [self registerNib:[UINib nibWithNibName:@"ShoppingCircleCellectionCell" bundle:nil] forCellWithReuseIdentifier:GotoStoreCircleCellectionCellID];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.gotoStoreCircleDataArr.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShoppingCircleCellectionCell *cell = [self dequeueReusableCellWithReuseIdentifier:GotoStoreCircleCellectionCellID forIndexPath:indexPath];
    NSDictionary *dic = self.gotoStoreCircleDataArr[indexPath.row];
    cell.circleTitleLabel.text = dic[@"gcName"];
    NSString *itemImgUrlStr = dic[@"mobileIcon"];
    if (itemImgUrlStr) {
        if (self.isCircle) {//如果是圈子
            cell.shopCircleImgView.image = [UIImage imageNamed:itemImgUrlStr];
        }else{
            [cell.shopCircleImgView sd_setImageWithURL:[NSURL URLWithString:itemImgUrlStr] placeholderImage:nil];
        }
    }
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.clickCircleItemBlock) {
        if (self.isCircle) {//圈子点击，
            self.clickCircleItemBlock(@(indexPath.row));
        }else {
            NSDictionary *dic = self.gotoStoreCircleDataArr[indexPath.row];
            self.clickCircleItemBlock(dic[@"id"]);
        }
    }

}





@end
