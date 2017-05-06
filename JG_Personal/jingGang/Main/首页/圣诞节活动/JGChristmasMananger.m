//
//  JGChristmasMananger.m
//  jingGang
//
//  Created by dengxf on 15/12/18.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "JGChristmasMananger.h"
#import "VApiManager.h"
#import "GlobeObject.h"
#import "ActivityHotSaleApiBO+Extension.h"
#import "IntegralListBO+InitExtend.h"
#import "UserIntegral+InitExtend.h"

@interface JGChristmasMananger ()

@property (strong,nonatomic) VApiManager *netManager;

@end

static JGChristmasMananger *_manager = nil;

@implementation JGChristmasMananger

+ (instancetype)sharedInstanced {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_manager == nil) {
            _manager = [[JGChristmasMananger alloc] init];
        }
    });
    return _manager;
}

- (instancetype)init {
    if (self = [super init]) {
        self.netManager = [[VApiManager alloc] init];
    }
    return self;
}

- (void)queryActivityInformationSuccess:(void (^)(ActivityHotSaleApiBO *))success fail:(void (^)())fail{
    SalePromotionAdInfoRequest *request = [[SalePromotionAdInfoRequest alloc] init:nil];
    request.api_actCode = @"APP_SPRING_FESTIVAL";
    [self.netManager salePromotionAdInfo:request success:^(AFHTTPRequestOperation *operation, SalePromotionAdInfoResponse *response) {
        NSDictionary *dic = (NSDictionary *)response.activityHotSaleApiBO;
        if (success) {
            success ([[ActivityHotSaleApiBO alloc] initWithDict:dic]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        JGLog(@"fail");
    }]; 
}



- (void)queryIntegarlListWithPageSize:(NSNumber *)pageSize
                              pageNum:(NSNumber *)pageNum
                          minIntegral:(NSString *)minIntegral
                          maxIntegral:(NSString *)maxIntegral
                              findAll:(BOOL)findAll
                              Suceess:(void (^)(NSArray *integralBOList))success
                                 fail:(void (^)())fail
{
    IntegralListByCriteriaRequest *request = [[IntegralListByCriteriaRequest alloc] init:nil];
    request.api_pageNum = pageNum;
    request.api_pageSize = pageSize;
    request.api_maxIntegral = maxIntegral;
    request.api_minIntegral = minIntegral;
    if (findAll) {
        request.api_findAll = @1;
    }else {
        request.api_findAll = @0;
    }
    
    JGLog(@"分割线---------------------------------");
    JGLog(@"----查询商品\n页数:%@,个数:%@,最大积分:%@,最小积分:%@,是否查找全部:%d",pageNum,pageSize,maxIntegral,minIntegral,findAll);
    JGLog(@"分割线---------------------------------");
    
    [self.netManager integralListByCriteria:request success:^(AFHTTPRequestOperation *operation, IntegralListByCriteriaResponse *response) {
        
        NSArray *listArray = [NSArray arrayWithArray:response.integralList];
        NSMutableArray *mutableArray = [NSMutableArray array];
        
        for (NSDictionary *dic in listArray) {
            IntegralListBO *listBO = [[IntegralListBO alloc] initWithIntegralListDict:dic];
            [mutableArray addObject:listBO];
        }
        if (success) {
            success([mutableArray copy]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        JGLog(@"%@",error.domain);
        if (fail) {
            fail();
        }
        
    }];
}

/**
 *  不带token请求用户信息
 */
- (void)queryUserIntegaralInfoSuccess:(void (^)(UserIntegral *))success fail:(void (^)(void))fail {
    UsersIntegralGetRequest *request = [[UsersIntegralGetRequest alloc] init:GetToken];
    [self.netManager usersIntegralGet:request success:^(AFHTTPRequestOperation *operation, UsersIntegralGetResponse *response) {
        //  用户已登录,且token未失效 返回积分信息
        if (success) {
            if (response.integral) {
                NSDictionary *integral =(NSDictionary *) response.integral;
                success([[UserIntegral alloc] initWithDict:integral]);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 返回失败

        if (fail) {
            fail();
        }
    }];

}

/**
 *  带token请求用户积分
 */
- (void)queryUserIntegaralInfoWithTokenSuccess:(void (^)())success fail:(void (^)())fail {
    UsersIntegralGetByUidRequest *request = [[UsersIntegralGetByUidRequest alloc] init:GetToken];
    [self.netManager usersIntegralGetByUid:request success:^(AFHTTPRequestOperation *operation, UsersIntegralGetByUidResponse *response) {

        if (success) {
            success();
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fail) {
            fail();
        }
    }];
}
@end
