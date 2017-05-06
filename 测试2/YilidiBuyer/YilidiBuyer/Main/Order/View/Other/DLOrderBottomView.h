//
//  DLOrderBottomView.h
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/7/13.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CancelBlock)(void);
typedef void(^PlayBlock)(void);
@interface DLOrderBottomView : UIView
@property (nonatomic,strong)CancelBlock cancelBlock;
@property (nonatomic,strong)PlayBlock playBlock;
@end
