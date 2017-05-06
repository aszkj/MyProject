//
//  UITextField+Accessory.m
//  JDBClient
//
//  Created by You Tu on 15/1/17.
//  Copyright (c) 2015年 JDB. All rights reserved.
//

#import "UITextField+Accessory.h"
#import "XF_Keyboard.h"
#import "objc/runtime.h"

static char kAccessoryKey;

@implementation UITextField (Accessory)

- (void)showAccessory
{
    if (!objc_getAssociatedObject(self, &kAccessoryKey)) {
        XF_Keyboard *keyboard = [[XF_Keyboard alloc] init];
        keyboard.delegate = self;
        self.inputAccessoryView = [keyboard getToolbarWithUIBarButtonSystemItem:UIBarButtonSystemItemDone];
        objc_setAssociatedObject(self, &kAccessoryKey, keyboard, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)showSearch
{
    if (!objc_getAssociatedObject(self, &kAccessoryKey)) {
        XF_Keyboard *keyboard = [[XF_Keyboard alloc] init];
        keyboard.delegate = self;
        self.inputAccessoryView = [keyboard getToolbarWithUIBarButtonSystemItem:UIBarButtonSystemItemSearch];
        objc_setAssociatedObject(self, &kAccessoryKey, keyboard, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)setDoneBtnPressedBlock:(XF_DoneButtonPressedBlock)doneBtnPressedBlock
{
    objc_setAssociatedObject(self, @selector(doneBtnPressedBlock), doneBtnPressedBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (XF_DoneButtonPressedBlock)doneBtnPressedBlock
{
    return objc_getAssociatedObject(self, @selector(doneBtnPressedBlock));
}

- (void)doneBtnTapped
{
    [self resignFirstResponder];
    if (self.doneBtnPressedBlock) {
        self.doneBtnPressedBlock();
    }
}

@end
