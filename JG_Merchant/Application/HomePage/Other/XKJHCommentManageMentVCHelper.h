//
//  XKJHCommentManageMentVCHelper.h
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/8.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKJHCommentManageMentVCHelper : NSObject

-(id)initWithTableCount:(NSInteger)tableCount vcRootView:(UIView *)vcRootView;
//点击上面的topbar部分，做相应的处理，隐藏，自动刷新等
-(void)clickTopbarAtIndex:(NSInteger)clickedTopBarIndex;

//将第index个表的finishedAutoFresh置位，因为当进入另外一个控制器再返回时，可能会有更新的
-(void)resetTableFinishedAutoFreshAtIndex:(NSInteger)resetIndexTable;

@end
