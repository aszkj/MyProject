//
//  DLBrandHeadView.h
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/12/12.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLBrandHeadView : UICollectionReusableView

@property (nonatomic,strong)void(^headBlock)(void);
@end
