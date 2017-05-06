//
//  DLBrandView.h
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/12/12.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MyCommonCollectionView.h"
@class DLClassificationVC;
@class DLGoodsSearchVC;
@interface DLBrandView : UIView
@property (nonatomic,weak)DLGoodsSearchVC *searchVC;
@property (nonatomic,strong)NSString *showType;
@property (nonatomic,strong)NSString *keyWords;
@property (strong, nonatomic) IBOutlet MyCommonCollectionView *brandCollectionView;

- (void)requestHotBrandDataConfigure;

@end
