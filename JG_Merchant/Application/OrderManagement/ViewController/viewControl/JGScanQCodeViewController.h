//
//  JGScanQCodeViewController.h
//  Merchants_JingGang
//
//  Created by dengxf on 15/12/25.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JGScanQCodeViewController : UIViewController

- (instancetype)initWithCodeSuccess:(void(^)(NSString *string))codeBlock fail:(void(^)())fail;

@end
