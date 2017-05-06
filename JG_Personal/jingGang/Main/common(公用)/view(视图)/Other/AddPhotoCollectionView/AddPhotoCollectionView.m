//
//  AddPhotoCollectionView.m
//  jingGang
//
//  Created by 张康健 on 15/9/14.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "AddPhotoCollectionView.h"
#import "AddPhotoCellectionViewCell.h"
#import "GlobeObject.h"
#import "UIButton+Block.h"


@implementation AddPhotoCollectionView

static NSString *AddPhotoCellectionViewCellID = @"AddPhotoCellectionViewCellID";

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self _init];
    }
    return self;
}

-(void)setDefaultLayout {

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(ItemSize, ItemSize);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumLineSpacing = ( kScreenWidth - 60 - 3*70 ) / 2;
    self.collectionViewLayout = layout;

}

-(void)_init{
    
    self.dataSource = self;
    self.delegate = self;
    [self registerNib:[UINib nibWithNibName:@"AddPhotoCellectionViewCell" bundle:nil] forCellWithReuseIdentifier:AddPhotoCellectionViewCellID];
    _photoArr = [NSMutableArray arrayWithCapacity:0];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoArr.count;
//    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AddPhotoCellectionViewCell *cell = [self dequeueReusableCellWithReuseIdentifier:AddPhotoCellectionViewCellID forIndexPath:indexPath];
    cell.photoDataModel = self.photoArr[indexPath.row];
    cell.deleteButton.tag = indexPath.row;
    WEAK_SELF
    [cell.deleteButton addActionHandler:^(NSInteger tag) {
        if (weak_self.deletePhotoBlock) {
            weak_self.deletePhotoBlock(tag);
        }
    }];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"did select cell");
}





@end
