//
//  utility.m
//  jingGang
//
//  Created by wangying on 15/6/15.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "utility.h"
#import "VApiManager.h"
#import "userDefaultManager.h"
#import "FollwerContent.h"

@implementation utility
+(void)FaviousRequest:(NSString *)circle typte:(NSString *)type

{
    VApiManager * _VApManager = [[VApiManager alloc]init];
    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
    
    UsersFavoritesRequest *usersFavorites = [[UsersFavoritesRequest alloc] init:accessToken];
    
    usersFavorites.api_fid = circle;
    usersFavorites.api_type = type;
    [_VApManager usersFavorites:usersFavorites success:^(AFHTTPRequestOperation *operation, UsersFavoritesResponse *response) {
        
        NSLog(@"收藏成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
    }];
}
+(void)CancleFaviousRequest:(NSString *)circle
{
    
   VApiManager *_VApManager = [[VApiManager alloc]init];
    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
    
    UsersFavoritesCancleRequest *usersFavoritesCancleRequest = [[UsersFavoritesCancleRequest alloc] init:accessToken];
    
    usersFavoritesCancleRequest.api_fid = circle;
    [_VApManager usersFavoritesCancle:usersFavoritesCancleRequest success:^(AFHTTPRequestOperation *operation, UsersFavoritesCancleResponse *response) {
        NSLog(@"取消收藏成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}
+(void)ZanRequest:(NSString *)circle
{
    
    VApiManager *_VApManager = [[VApiManager alloc]init];
    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
    
    UsersPraiseRequest *usersPraiseRequest = [[UsersPraiseRequest alloc] init:accessToken];
    
    usersPraiseRequest.api_fid = circle;
    
    NSLog(@" ---------circle%@",circle);
    [_VApManager usersPraise:usersPraiseRequest success:^(AFHTTPRequestOperation *operation, UsersPraiseResponse *response) {
        NSLog(@"---点赞成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"---%@",error);
    }];
}
+(void)CancleZan:(NSString *)circle
{
   VApiManager  *_VApManager = [[VApiManager alloc]init];
    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
    
    UsersCanclePraiseRequest *usersCanclePraiseRequest = [[UsersCanclePraiseRequest alloc] init:accessToken];
    
    usersCanclePraiseRequest.api_fid = circle;
    [_VApManager usersCanclePraise:usersCanclePraiseRequest success:^(AFHTTPRequestOperation *operation, UsersCanclePraiseResponse *response) {
        NSLog(@"取消点赞成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"取消点赞失败");
    }];
}
+(id)FollowRequest:(NSString *)num
{
    
    FollwerContent *follow = [[FollwerContent alloc]init];
    NSNumber *nubm = [NSNumber numberWithInt:[num intValue]];
    
    follow.num = nubm;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:follow];
    RELEASE(follow);
    return AUTO_RELEASE(nav);
    //[self.navigationController pushViewController:follow animated:YES];
   // [self presentViewController:nav animated:YES completion:nil];
}

@end
