//
//  TLActionSheet.h
//  jingGang
//
//  Created by thinker on 15/8/17.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TLActionSheetButtonType) {
    TLActionSheetButtonTypeDefault = 0,
    TLActionSheetButtonTypeDisabled,
    TLActionSheetButtonTypeDestructive
};

@class TLActionSheet;
typedef void(^TLActionSheetHandler)(TLActionSheet *actionSheet);


@interface TLActionSheet : UIView

@property (nonatomic) NSTimeInterval animationDuration UI_APPEARANCE_SELECTOR;

- (id)initWithTitle:(NSString *)title;

- (void)addButtonWithTitle:(NSString *)title image:(UIImage *)image type:(TLActionSheetButtonType)type handler:(TLActionSheetHandler)handler;
- (void)showInView:(UIView *)superView;

@end
