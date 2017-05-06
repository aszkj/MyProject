//
//  UpdateNicknameViewController.h
//  weimi
//
//  Created by thinker on 16/1/19.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UpdateNickeNameBlock)(NSString *name);

@interface UpdateNicknameViewController : UIViewController

@property (nonatomic, strong) UITextField *userNicknameTextField;

@property (nonatomic, copy) UpdateNickeNameBlock updateNickeNameBlock;

@end
