//
//  NewUpdateNickNameController.h
//  weimi
//
//  Created by 张康健 on 16/2/19.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^UpdateNickeNameBlock)(NSString *name);
@interface NewUpdateNickNameController : UIViewController

@property (nonatomic, copy)NSString *nickName;
@property (nonatomic, copy) UpdateNickeNameBlock updateNickeNameBlock;
@end
