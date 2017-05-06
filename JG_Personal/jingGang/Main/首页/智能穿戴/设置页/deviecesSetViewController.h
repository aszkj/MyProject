//
//  deviecesSetViewController.h
//  jingGang
//
//  Created by yi jiehuang on 15/6/5.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^IsPopBlock)(void);

@interface deviecesSetViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

//标志pop返回block
@property (nonatomic, copy)IsPopBlock isPopBlock;
@end
