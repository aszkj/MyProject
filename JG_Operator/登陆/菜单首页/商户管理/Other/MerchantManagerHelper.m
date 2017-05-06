//
//  MerchantManagerHelper.m
//  Operator_JingGang
//
//  Created by 张康健 on 15/9/19.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "MerchantManagerHelper.h"
#import "MerchantManageTableView.h"


@implementation MerchantManagerHelper

-(void)requestData{
    
    OperatorBusinessManagementListRequest *request = [[OperatorBusinessManagementListRequest alloc] init:GetToken];

    DDLogVerbose(@"token %@",GetToken);
    
    NSNumber *merchantTypeNum;
    if (self.merchantType == LishuMerchantType) {//隶属
        merchantTypeNum = @0;
    }else {
        merchantTypeNum = @1;
    }
    request.api_isBeLong = merchantTypeNum;
    request.api_pageSize = @(self.currentFreshTableView.dataLogicModule.requestPageSize);
    request.api_pageNum = @(self.currentFreshTableView.dataLogicModule.requestFromPage);
    NSString *requestTypeStr = [self getRequestTypeWithTalbleTag:self.currentFreshTableView.tag];
    if (requestTypeStr) {
        request.api_timeType = @(requestTypeStr.integerValue);
    }
    
    [self.vapManager operatorBusinessManagementList:request success:^(AFHTTPRequestOperation *operation, OperatorBusinessManagementListResponse *response) {

       NSLog(@"商户response  %@",response);
       
       [self configureTableAfterRequestData:[OperatorManagement JGObjectArrWihtKeyValuesArr:response.operatorRebateList]];
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
}

-(NSString *)getRequestTypeWithTalbleTag:(NSInteger)tag {
    
    NSString *requestTypeStr = nil;
    switch (tag) {
        case 0:
            requestTypeStr = nil;//全部统计
            break;
        case 1:
            requestTypeStr = @"1";//周统计
            break;
        case 2:
            requestTypeStr = @"2";//月统计
            break;
        case 3:
            requestTypeStr = @"3";//季统计
            break;
        case 4:
            requestTypeStr = @"4";//年统计
            break;
        default:
            break;
    }
    return requestTypeStr;
}


-(void)loadTableInView:(UIView *)vcRootView tableCount:(NSInteger)tableCount {

    for (int i=0; i<tableCount; i++) {
        MerchantManageTableView *tableView = [[MerchantManageTableView alloc] initWithFrame:CGRectMake(kTopBarTypeTableX, kTopBarTypeTableY, kTopBarTypeTableWidth,kTopBarTypeTableHeight) style:UITableViewStylePlain];
        //配置每张表
        [self setTableAttributeAtIndex:i forTableView:tableView];
        [vcRootView addSubview:tableView];
        [self.contentTableArr addObject:tableView];
    }
}




@end
