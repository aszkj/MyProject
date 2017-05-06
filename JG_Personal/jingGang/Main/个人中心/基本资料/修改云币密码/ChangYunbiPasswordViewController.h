//
//  ChangYunbiPasswordViewController.h
//  Merchants_JingGang
//
//  Created by ray on 15/9/28.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "XK_ViewController.h"

typedef void(^ChangeYunbiPasswdSuccess)(void);

@protocol ChangYunbiPasswordViewControllerDelegate <NSObject>

- (void)nofiticationPopChangYunbiPasswordView;

@end

@interface ChangYunbiPasswordViewController : XK_ViewController

- (void)changeAction;

@property (nonatomic, copy)ChangeYunbiPasswdSuccess changeYunbiPasswdSuccess;

@property (nonatomic,assign) id<ChangYunbiPasswordViewControllerDelegate>delegate;

@property (nonatomic,assign)BOOL isComfromPayPage;

@end
