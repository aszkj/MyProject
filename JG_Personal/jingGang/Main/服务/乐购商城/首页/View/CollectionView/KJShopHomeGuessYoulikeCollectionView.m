//
//  KJShopHomeGuessYoulikeCollectionView.m
//  jingGang
//
//  Created by 张康健 on 15/8/27.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "KJShopHomeGuessYoulikeCollectionView.h"

@implementation KJShopHomeGuessYoulikeCollectionView


static NSString *GuessyouLikeCollectionCellID= @"GuessyouLikeCollectionCellID";

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
    
    [self registerNib:[UINib nibWithNibName:@"SHKJGuessyouLikeCollectionCell" bundle:nil] forCellWithReuseIdentifier:GuessyouLikeCollectionCellID];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"guess count %ld",self.guessYoulikeArr.count);
    return self.guessYoulikeArr.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SHKJGuessyouLikeCollectionCell *cell = [self dequeueReusableCellWithReuseIdentifier:GuessyouLikeCollectionCellID forIndexPath:indexPath];
    cell.model = self.guessYoulikeArr[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
//    NSLog(@"did select cell");
    if (self.shopHomeGuessyouLikeBlock) {
        self.shopHomeGuessyouLikeBlock(self.guessYoulikeArr[indexPath.row]);
    }

    
}




@end
