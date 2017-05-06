//
//  AddPhotoCollectionView.h
//  jingGang
//
//  Created by 张康健 on 15/9/14.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ItemSize 70

typedef void(^DeletePhotoBlock)(NSInteger index);
@interface AddPhotoCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, copy)DeletePhotoBlock deletePhotoBlock;

@property (nonatomic, strong)NSMutableArray *photoArr;

@property (nonatomic, assign)BOOL isAddedPhoto;

//设置默认的layout，调用的话，就设置默认的layout,不调用，用户自己设置layout
-(void)setDefaultLayout;

@end
