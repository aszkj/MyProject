//
//  OptionViewController.h
//  jingGang
//
//  Created by thinker on 15/8/4.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OptionViewController : UIViewController

typedef void(^CancelWatchBlock)();
typedef void(^AddShoppingCart)(void);
typedef void(^EnterShoppingCart)(void);

@property (copy) CancelWatchBlock cancelBlock;
@property (copy) AddShoppingCart addShoppingBlock;
@property (copy) EnterShoppingCart buyCurrentBlock;

@property (nonatomic) BOOL isServerView;

@end
