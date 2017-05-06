//
//  MerchantPosterVCHelper.m
//  Merchants_JingGang
//
//  Created by 张康健 on 15/11/7.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "MerchantPosterVCHelper.h"
#import "MerchantPosterTableView.h"

@implementation MerchantPosterVCHelper

-(void)requestData{
    
    UsersNoticeRequest *request = [[UsersNoticeRequest alloc] init:GetToken];
    request.api_pageSize = @(self.currentFreshTableView.dataLogicModule.requestPageSize);
    request.api_pageNum = @(self.currentFreshTableView.dataLogicModule.requestFromPage);
    NSString *requestTypeStr = [self getRequestTypeWithTalbleTag:self.currentFreshTableView.tag];
    request.api_type = @(requestTypeStr.integerValue);

    [self.vapManager usersNotice:request success:^(AFHTTPRequestOperation *operation, UsersNoticeResponse *response) {
        
        NSArray *arr = nil;
        if (!request.api_type.integerValue) {//运营商公告
            arr =  [OpNotices JGObjectArrWihtKeyValuesArr:response.opNoticesBOs];
        }else {
            arr = [ArticleBO JGObjectArrWihtKeyValuesArr:response.articleList];
        }
        [self configureTableAfterRequestData:arr];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        

    }];
    
}

-(NSString *)getRequestTypeWithTalbleTag:(NSInteger)tag {
    
    NSString *requestTypeStr = nil;
    switch (tag) {
        case 0:
            requestTypeStr = @"0";//营运商公告
            break;
        case 1:
            requestTypeStr = @"1";//平台公告
            break;
        default:
            break;
    }
    return requestTypeStr;
}


-(void)loadTableInView:(UIView *)vcRootView tableCount:(NSInteger)tableCount {
    
    for (int i=0; i<tableCount; i++) {
        MerchantPosterTableView *tableView = [[MerchantPosterTableView alloc] initWithFrame:CGRectMake(kTopBarTypeTableX, 50, kTopBarTypeTableWidth,kTopBarTypeTableHeight) style:UITableViewStylePlain];
        tableView.posterType = (i == 0) ? PoserOperater_Send : PosterPlat_Send;
        //配置每张表
        [self setTableAttributeAtIndex:i forTableView:tableView];
        tableView.allowsSelection = YES;
        [vcRootView addSubview:tableView];
        [self.contentTableArr addObject:tableView];
    }
}




@end
