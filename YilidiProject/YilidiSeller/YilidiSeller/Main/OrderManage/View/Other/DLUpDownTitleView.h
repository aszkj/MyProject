//
//  DLTabbarItemView.h
//  YilidiBuyer
//
//  Created by yld on 16/4/18.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLUpDownTitleView : UIView

@property (nonatomic,strong)UIButton *upButton;

@property (nonatomic,strong)UIButton *downButton;

@property (nonatomic,strong)UIColor *defaultTitleColor;

@property (nonatomic,strong)UIColor *selectedTitleColor;

@property (nonatomic,strong)UIColor *defaultBackGroundColor;

@property (nonatomic,strong)UIColor *selectedBackGroundColor;

@property (nonatomic,strong)UIColor *verticalLineBgColor;

@property (nonatomic,strong)UIFont *titleFont;

@property (nonatomic,assign)BOOL canTouched;

@property (nonatomic,copy)NSString *upTitle;

@property (nonatomic,copy)NSString *downTitle;

@property (nonatomic,assign)BOOL selected;

@property (nonatomic,assign)BOOL needVerticalSeperatedLine;



@end
