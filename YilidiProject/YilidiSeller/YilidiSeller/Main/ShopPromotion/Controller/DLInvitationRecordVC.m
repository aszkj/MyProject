//
//  DLInvitationRecordVC.m
//  YilidiSeller
//
//  Created by yld on 16/6/3.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLInvitationRecordVC.h"
#import "DLInvitationCell.h"
#import "MycommonTableView.h"
#import "DLInvitationModel.h"
#import "AFNHttpRequestOPManager+DLUnNomalApi.h"
#import "DLRequestUrl.h"
#import "GlobleConst.h"
@interface DLInvitationRecordVC ()
@property (weak, nonatomic) IBOutlet MycommonTableView *invitationTableView;
@property (strong, nonatomic) IBOutlet UILabel *userCount;
@property (strong, nonatomic) IBOutlet UILabel *vipCount;


@property (nonatomic,strong)NSArray *array;
@end

@implementation DLInvitationRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _requestData];
    [self _requestStatistical];
    [self _initTableView];
      self.pageTitle =@"邀请记录";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ------------------------Init---------------------------------
- (void)_initTableView {
   
    [self.invitationTableView configurecellNibName:@"DLInvitationCell" configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell) {
        DLInvitationModel *model = (DLInvitationModel *)cellModel;
        DLInvitationCell *viewCell = (DLInvitationCell *)cell;
        [viewCell setModel:model];
       
        
    }];
    
    WEAK_SELF
    [self.invitationTableView headerRreshRequestBlock:^{
        [weak_self  _requestData];
    }];
    
    [self.invitationTableView footerRreshRequestBlock:^{
        [weak_self _requestData];
    }];

    
   

}
#pragma mark ------------------------Private-------------------------


#pragma mark ------------------------Api----------------------------------
- (void)_requestData{
    NSDictionary *dic = @{kRequestPageNumKey:@(self.invitationTableView.dataLogicModule.requestFromPage),kRequestPageSizeKey:@(kRequestDefaultPageSize)};
    NSLog(@"DIC%@",dic);
    [AFNHttpRequestOPManager postWithParameters:dic subUrl:kUrl_InvitationRecord block:^(NSDictionary *resultDic, NSError *error) {
        NSLog(@"%@",resultDic);
        _array = [DLInvitationModel objectWithInvitationModelArray:resultDic[EntityKey][@"list"]];
         
        [self.invitationTableView configureTableAfterRequestPagingData:_array];
        [self.invitationTableView reloadData];
    }];
   
    
}

- (void)_requestStatistical{
    
    [AFNHttpRequestOPManager postWithParameters:nil subUrl:kUrl_InvitationStatistical block:^(NSDictionary *resultDic, NSError *error) {
        
        self.userCount.text = [NSString stringWithFormat:@"已成功邀请%@人注册，",[resultDic[EntityKey][@"inviteCount"]stringValue]];
        self.vipCount.text = [resultDic[EntityKey][@"vipUserCount"]stringValue];
    }];

}

#pragma mark ------------------------Page Navigate---------------------------


#pragma mark ------------------------View Event---------------------------

#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------



@end
