//
//  MERMenusViewModel.m
//  jingGang
//
//  Created by ray on 15/10/23.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "MERMenusViewModel.h"

@interface MERMenusViewModel ()

@property (nonatomic) NSArray *resultGroupArray;
@property (nonatomic) NSArray *resultItemBOArray;

@end

@implementation MERMenusViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.classArray = [NSArray array];
        self.detailArray = [NSArray array];
    }
    return self;
}

- (void)setResultGroupArray:(NSArray *)resultGroupArray {
    _resultGroupArray = resultGroupArray;
    NSMutableArray *mainArray = [NSMutableArray array];
    [resultGroupArray enumerateObjectsUsingBlock:^(ResultGroup *obj, NSUInteger idx, BOOL * stop) {
        [mainArray addObject:obj.groupName];
    }];
    self.classArray = mainArray.copy;
}

- (void)setResultItemBOArray:(NSArray *)resultItemBOArray {
    _resultItemBOArray = resultItemBOArray;
    NSMutableArray *detailArray = [NSMutableArray array];
    [resultItemBOArray enumerateObjectsUsingBlock:^(ResultItem *obj, NSUInteger idx, BOOL * stop)
    {
        [detailArray addObject:obj.itemName];
    }];
    self.detailArray = detailArray.copy;
}

- (void)getClassArrayRequest {
    [self getReportResultClassList:nil];
}

- (void)getDetailArrayAtIndex:(NSInteger)index {
    ResultGroup *resultGroup = self.resultGroupArray[index];
    [self getReportResultClassList:resultGroup.apiId];
}

- (void)getReportResultClassList:(NSNumber *)classId {
    self.isExcuting = YES;
    ReportResultClassListRequest *request = ({
        ReportResultClassListRequest *classListRequest= [[ReportResultClassListRequest alloc] init:GetToken];
        classListRequest.api_id = classId;
        classListRequest;
    });
    [self.client.vapiManager reportResultClassList:request success:^(AFHTTPRequestOperation *operation, ReportResultClassListResponse *response) {
        self.isExcuting = NO;
        if (classId) {
            [ResultItem setupReplacedKeyFromPropertyName:^NSDictionary *{
                return @{
                         @"apiId" : @"id"
                         };
            }];
            if (classId.integerValue == -1) {
                self.resultItemBOArray = [ResultItem objectArrayWithKeyValuesArray:response.usingResultItemBOs];
            } else {
                self.resultItemBOArray = [ResultItem objectArrayWithKeyValuesArray:response.resultItemBOs];
            }
        } else {
            [ResultGroup setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"apiId" : @"id"
            };
            }];
            self.resultGroupArray = [ResultGroup objectArrayWithKeyValuesArray:response.resultGroupBOs];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.isExcuting = NO;
        self.error = error;
    }];
   
}

- (NSArray *)debugArray {
    
    NSDictionary *dic1 = @{@"itemName":[NSString stringWithFormat:@"%f",drand48()]};
    NSDictionary *dic2 = @{@"itemName":@"123"};
    NSDictionary *dic3 = @{@"itemName":@"12345"};
    return @[dic1,dic2,dic3];
}

@end
