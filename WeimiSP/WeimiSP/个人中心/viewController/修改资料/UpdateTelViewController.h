//
//  UpdateTelViewController.h
//  weimi
//
//  Created by thinker on 16/1/19.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UpdateTelBlock)(NSString *tel);

@interface UpdateTelViewController : UIViewController

@property (nonatomic, copy) UpdateTelBlock updateTelBlock;

@end
