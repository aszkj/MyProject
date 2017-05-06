//
//  DLCordovaH5VC+shareModule.h
//  YilidiBuyer
//
//  Created by mm on 16/12/20.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLCordovaH5VC.h"
#import <MessageUI/MessageUI.h>

@interface DLCordovaH5VC (shareModule)<MFMessageComposeViewControllerDelegate>

- (void)initShareModule;

- (void)initSharePlugin;

@end
