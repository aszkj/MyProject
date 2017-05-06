//
//  ChangeLoginViewController.h
//  jingGang
//
//  Created by ray on 15/11/24.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "XK_ViewController.h"

@protocol ChangeLoginViewControllerDelegate <NSObject>

- (void)nofiticationPopChangeLoginView;

@end


@interface ChangeLoginViewController : XK_ViewController

@property (nonatomic,assign) id<ChangeLoginViewControllerDelegate>delegate;



@end
