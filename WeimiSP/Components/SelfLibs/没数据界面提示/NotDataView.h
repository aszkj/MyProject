//
//  NotDataView.h
//  WeimiSP
//
//  Created by thinker on 16/3/8.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^RequestDataBlock)(void);

@interface NotDataView : UIView

@property (nonatomic, copy) RequestDataBlock requestDataBlock;

@end
