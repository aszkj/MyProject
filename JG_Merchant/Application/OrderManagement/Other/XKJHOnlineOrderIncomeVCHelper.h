//
//  XKJHOnlineOrderIncomeVCHelper.h
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/5.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XKJHOnlineOrderIncomeVCHelper : NSObject

-(id)initWithTableCount:(NSInteger)tableCount vcRootView:(UIView *)vcRootView;
//点击上面的topbar部分，做相应的处理，隐藏，自动刷新等
-(void)clickTopbarAtIndex:(NSInteger)clickedTopBarIndex;

@end
