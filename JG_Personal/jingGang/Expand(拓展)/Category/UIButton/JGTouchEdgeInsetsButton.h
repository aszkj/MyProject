//
//  JGTouchEdgeInsetsButton.h
//  jingGang
//
//  Created by dengxf on 16/2/19.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JGTouchEdgeInsetsButton : UIButton

@property (nonatomic, assign) UIEdgeInsets touchEdgeInsets; // 扩展的点击区域 （负值为加大，正值减少）

@end
