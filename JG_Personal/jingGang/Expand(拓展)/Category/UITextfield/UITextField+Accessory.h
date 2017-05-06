//
//  UITextField+Accessory.h
//  XF_Client
//
//  Created by You Tu on 15/1/17.
//  Copyright (c) 2015年 XF_. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XF_Keyboard.h"

// 点击done或search按钮block
typedef void(^XF_DoneButtonPressedBlock)();

@interface UITextField (Accessory) <XF_KeyboardDelegate>

@property (nonatomic, copy) XF_DoneButtonPressedBlock doneBtnPressedBlock;

- (void)showAccessory;  // 键盘上显示完成按钮 resign first responder
- (void)showSearch;     // 键盘上显示搜索按钮 resign first responder

@end
