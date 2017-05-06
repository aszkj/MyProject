//
//  eyechartViewController.h
//  jingGang
//
//  Created by thinker on 15/7/20.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface menuViewController : UIViewController

@property (nonatomic,strong) NSString * titleText;//设置导航条的标题
@property (nonatomic,strong) NSArray *menuContentArray;//菜单选项内容（数据内容是菜单NSString）
@property (nonatomic,strong) NSArray *contentView;//每个菜单的内容（数据内容是UIView、UIViewController子类的类名）

@property (nonatomic, assign) NSInteger pageView; //初始化时在哪个界面


@end
