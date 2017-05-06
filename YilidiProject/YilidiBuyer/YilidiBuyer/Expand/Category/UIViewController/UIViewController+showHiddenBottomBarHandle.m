//
//  UIViewController+showHiddenBottomBarHandle.m
//  YilidiBuyer
//
//  Created by mm on 16/12/1.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "UIViewController+showHiddenBottomBarHandle.h"
#import "ProjectRelativeMaco.h"
#import "DLMainTabBarController.h"


@implementation UIViewController (showHiddenBottomBarHandle)

- (void)showHiddenBottomBarHandle {
    UIViewController *rootVC = rootController;
    /*这里为什么要采取这种方式，隐藏tabbar，由于应用的tabbaritem有几处动画用系统的tabbaritem很难实现，所以本应用的tabbar是自定义的一个视图（不是继承的tabbaritem的自定义方式，无法实现动画），所以push，pop的情况下，采用如下方式隐藏展现底部tabbar,没有采用hiddenWhenPushed（有弊端，如果采用poptovc:方法他是检测不到的，而且当时因为这个，返回到首页出现了一个比较大的bug，首页底部四个按钮全都失去焦点）*/
    if ([rootVC isMemberOfClass:[DLMainTabBarController class]]) {
        DLMainTabBarController *mainVC = (DLMainTabBarController *)rootController;
        if (self.navigationController.viewControllers.count >= 2) {
            [mainVC hiddenBottomView];
        }else {
            [mainVC showBottomView];
        }
    }

}

@end
