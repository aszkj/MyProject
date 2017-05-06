//
//  DLTabbarItemView.h
//  YilidiBuyer
//
//  Created by yld on 16/4/18.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLTabbarItemView : UIView

@property (nonatomic,strong)UIButton *itemIconButton;

@property (nonatomic,strong)UIButton *itemTitleButton;

@property (nonatomic,copy)NSString *iconImgName;

@property (nonatomic,copy)NSString *selectedIconImgName;

@property (nonatomic,copy)NSString *title;

@property (nonatomic,assign)BOOL selected;

@end
