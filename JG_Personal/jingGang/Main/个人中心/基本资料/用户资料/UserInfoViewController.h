//
//  UserInfoViewController.h
//  jingGang
//
//  Created by ray on 15/11/24.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "XK_ViewController.h"


@protocol UserInfoViewControllerDelegate <NSObject>

- (void)nofiticationPopUserInfoView;

@end


@interface UserInfoViewController : XK_ViewController

@property (nonatomic,assign) id<UserInfoViewControllerDelegate>delegate;

- (void)changeAction;

@end
