//
//  AppDelegate+JGActivity.m
//  jingGang
//
//  Created by dengxf on 16/2/17.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import "AppDelegate+JGActivity.h"
#import "JGActivityHelper.h"

@implementation AppDelegate (JGActivity)

- (void)loadActivity {
    [JGActivityHelper queryActivityWithActivityCode:@"APP_SPRING_FESTIVAL" progressing:^{
        
    } beyondTime:^{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PostActivityKey" object:@1];
    } error:^(NSError *error) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PostActivityKey" object:@1];
    } notiBlock:^{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PostActivityKey" object:@0];
    }];
}

- (void)queryUserDidCheck {
    
    
    //已经安装，但是版本号不相符,如果版本号不相符则等待引导页加载结束后再签到
    [JGActivityHelper queryUserDidCheckInPopView:^(UserSign *userSign) {
        // 用户没签到弹窗
        //        JGLog(@"用户当前签到状况: 没签到！");
        //        JGLog(@"userSign:%@",userSign);
    } notPop:^{
        // 用户已签到，或网络错误不弹窗
        //        JGLog(@"用户当前签到状况: 没签到！");
        }];

}

@end
