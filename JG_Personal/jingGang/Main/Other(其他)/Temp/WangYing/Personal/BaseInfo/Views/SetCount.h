//
//  SetCount.h
//  jingGang
//
//  Created by wangying on 15/5/30.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCount : UIView
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)UIScrollView *scroll_base;
@property(nonatomic,strong)UIScrollView *scroll_other;
//@property(nonatomic,strong)NSString *newPass;
//@property(nonatomic,strong)NSString *oldPass;
//@property(nonatomic,strong)NSString *surePass;
-(void)creatUI;
@end
