//
//  JDBKeyboard.h
//  JDBClient
//
//  Created by You Tu on 15/1/17.
//  Copyright (c) 2015年 JDB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol XF_KeyboardDelegate <NSObject>

@optional
- (void)nextClicked:(NSUInteger)sender;
- (void)previousClicked:(NSUInteger)sender;

@required
- (void)doneBtnTapped;

@end

@interface XF_Keyboard : NSObject // Keyboard input accesscory view 配置对象

@property (nonatomic, strong) UIColor *navBarColor;
@property (nonatomic, strong) UIColor *fontColor;
@property (nonatomic, strong) id<XF_KeyboardDelegate> delegate;
@property (nonatomic) NSUInteger currentSelectedTextboxIndex;

- (UIToolbar *)getToolbarWithDonePrevious:(BOOL)previousEnabled next:(BOOL)nextEnabled;
- (UIToolbar *)getToolbarWithPrevious:(BOOL)previousEnabled next:(BOOL)nextEnabled;
- (UIToolbar *)getToolbarWithUIBarButtonSystemItem:(UIBarButtonSystemItem)item;

@end