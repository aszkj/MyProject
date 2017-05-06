//
//  advertManager.m
//  jingGang
//
//  Created by yi jiehuang on 15/6/13.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "advertManager.h"
#import "PublicInfo.h"
#import "userDefaultManager.h"

@implementation advertManager
@synthesize delegate = m_delegate;

- (id)init
{
    self = [super init];
    if (self) {
        m_delegate = nil;
    }
    return self;
}

- (void)dealloc
{


}


- (void) startRequestWithkeyStr:(NSString *) keyStr withDelegate:(id) delegate
{
    m_delegate = delegate;
    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
    if (![accessToken length]) {
        if (nil != m_delegate && [m_delegate respondsToSelector:@selector(DidFinishLoadingWithArray:WithKeyStr:)])
        {
            [m_delegate DidFailWithError:nil];
        }
        return ;
    }
    _vapManager = [[VApiManager alloc]init];

    SnsRecommendListRequest *SnsRecommendList = [[SnsRecommendListRequest alloc] init:accessToken];
    SnsRecommendList.api_posCode = keyStr;
    NSMutableArray * array = [[NSMutableArray alloc]init];
    [_vapManager snsRecommendList:SnsRecommendList success:^(AFHTTPRequestOperation *operation, SnsRecommendListResponse *response) {
        
        [NSObject fliterResponse:response withBlock:^(int event, id responseObject) {
            
            NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"-- guanggao -----%@",dict);
            NSArray * img_arr = [dict objectForKey:@"advList"];
            for (int i =0 ; i < img_arr.count; i++) {
                NSDictionary * dic = [img_arr objectAtIndex:i];
                NSString * typeStr = [dic objectForKey:@"adType"];
                if ([typeStr intValue] == 1) {
                    NSLog(@"咨询类");//如果是咨询类就保存标题和内容
                    NSString * title_str = [dic objectForKey:@"adTitle"];
                    NSString * dis_str = [dic objectForKey:@"adText"];
                    NSMutableDictionary * title_dic = [[NSMutableDictionary alloc]init];
#warning 不知原因崩溃
                    if (title_str != nil) {
                        
                        //                    [title_dic setValue:title_str forKey:@"title_str"];
                    }
                    if (dis_str != nil) {
                        
                        //                    [title_dic setValue:dis_str forKey:@"dis_str"];
                    }
                    [array addObject:title_dic];
                }else{
                    if ([dic objectForKey:@"adUrl"]) {
//                        NSString  * img_path = [dic objectForKey:@"adImgPath"];//图片
//                        NSString  * img_url = [dic objectForKey:@"adUrl"];//图片链接
                        NSDictionary * img_dic = [[NSDictionary alloc]init];
                        [array addObject:img_dic];
                    }
                }
            }
            
            NSLog( @"(%@)广告dict---->%@, img_arr.count = %ld",keyStr,dict,(long)array.count);
            if (nil != m_delegate && [m_delegate respondsToSelector:@selector(DidFinishLoadingWithArray:WithKeyStr:)])
            {
                [m_delegate DidFinishLoadingWithArray:array WithKeyStr:keyStr];
            }
            
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败, %@",error);
        if (nil != m_delegate && [m_delegate respondsToSelector:@selector(DidFailWithError:)])
        {
            [m_delegate DidFailWithError:error];
        }
    }];

}

@end
