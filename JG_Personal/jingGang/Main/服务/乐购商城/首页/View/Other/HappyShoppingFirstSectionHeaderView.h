//
//  HappyShoppingFirstSectionHeaderView.h
//  jingGang
//
//  Created by 张康健 on 15/11/21.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//



//@protocol HappyShoppingFirstSectionHeaderView <NSObject>
//
//- (void)happyShoppingFirstSectionHeaderViewScanQRCode
//
//@end

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "KJSHGuessYourLikeCollectionView.h"
#import "ShowCaseCollectionView.h"



@interface HappyShoppingFirstSectionHeaderView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet SDCycleScrollView *headerScrollView;
@property (weak, nonatomic) IBOutlet KJSHGuessYourLikeCollectionView *shCircleCollectionViiew;
@property (weak, nonatomic) IBOutlet UIImageView *integralAdImgView;
@property (weak, nonatomic) IBOutlet ShowCaseCollectionView *showCasefirstLevelCollectionView;
@property (weak, nonatomic) IBOutlet ShowCaseCollectionView *showCaseSecondLevelCollectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *secondGoodsPageControl;

-(void)headerRequestData;



@end
