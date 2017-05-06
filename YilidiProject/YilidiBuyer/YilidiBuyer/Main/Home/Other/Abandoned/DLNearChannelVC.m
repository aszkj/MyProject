//
//  DLNearChannelVC.m
//  YilidiBuyer
//
//  Created by yld on 16/5/9.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLNearChannelVC.h"
#import "DLNearChannelCell.h"
#import "DLNearChannelModel.h"
#import "ProjectRelativeMaco.h"
#import "DLShopCartCell.h"
#import "MycommonTableView.h"
#import "DLNearChannelModel.h"
#import "DLDataLoaderGifHub.h"
static NSString *ChannelIdentifier = @"ChannelIdentifier";
@interface DLNearChannelVC ()

@property (weak, nonatomic) IBOutlet MycommonTableView *nearChannelTabbleView;
@property (nonatomic,strong) NSArray *responseDataArr;


@end

@implementation DLNearChannelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ------------------------Init---------------------------------

-(void)_init {
     self.pageTitle = @"附近社区超市";
    [self _requetData];
    [self _initgoodsAllTableView];
    [self _initgoodsAllContionView];
    
}


-(void)_initgoodsAllTableView {
    
  
    self.nearChannelTabbleView.cellHeight = 80.0f;
    self.nearChannelTabbleView.separatorStyle=UITableViewCellSeparatorStyleNone;
   
    _responseDataArr = @[
                         @{@"data":@{@"selltype":@"2",
                                     @"selltypeName":@"快餐",@"shopId":@8,@"shopName":@"前进便利店", @"shopImgUrl":@"http://183.2.185.81:9401/5/39a86f269a",@"shopKey":@"1bqjc8fk6fv6o81tp2tivjygr"}},@{@"data":@{@"selltype":@"2",                                                                                                                                                   @"selltypeName":@"快餐",@"shopId":@8,@"shopName":@"前进便利店", @"shopImgUrl":@"http://183.2.185.81:9401/5/39a86f269a",@"shopKey":@"1bqjc8fk6fv6o81tp2tivjygr"}}];
    
    
    [self.nearChannelTabbleView configurecellNibName:@"DLNearChannelCell" cellDataSource:_responseDataArr configurecellData:^(UITableView *tableView,id cellModel, UITableViewCell *cell) {
        DLNearChannelCell *nearCell = (DLNearChannelCell *)cell;
        
        DLNearChannelModel *model =[[DLNearChannelModel alloc] initWithDefaultDataDic:@{@"selltype":@"2",
                                                             @"selltypeName":@"快餐",@"shopId":@8,@"shopName":@"前进便利店", @"shopImgUrl":@"http://183.2.185.81:9401/5/39a86f269a",@"shopKey":@"1bqjc8fk6fv6o81tp2tivjygr"}];
        
        [nearCell setDLNearChannelCell:model];
 
        
    } clickCell:^(UITableView *tableView,id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
       
        JLog(@"%@",cellModel[@"data"][@"shopImgUrl"]);
        

    }];
}


-(void)_initgoodsAllContionView {

    

}

#pragma mark ------------------------Private-------------------------
- (void)_requetData {
   
    [DLDataLoaderGifHub showInContainerView:self.view];
    NSDictionary *classGoodsParam  = @{@"lng":@(22.551214),@"lat":@(113.948044)};
    WEAK_SELF
    [AFNHttpRequestOPManager getInfoWithSubUrl:kUrl_GetNeartyDefaultShop parameters:classGoodsParam block:^(id result, NSError *error) {
        [DLDataLoaderGifHub dissmiss];
        weak_self.responseDataArr= result;
        JLog(@"result%@",result);
        weak_self.responseDataArr =@[
                                     @{@"data":@{@"selltype":@"2",
                                                 @"selltypeName":@"快餐",@"shopId":@8,@"shopName":@"前进便利店", @"shopImgUrl":@"http://183.2.185.81:9401/5/39a86f269a",@"shopKey":@"1bqjc8fk6fv6o81tp2tivjygr"},@"code":@"1001",@"msg":@"执行成功"}];
       
        JLog(@"arr%@",weak_self.responseDataArr);

    }];

    
    
}

#pragma mark ------------------------Api----------------------------------

#pragma mark ------------------------Page Navigate---------------------------

#pragma mark ------------------------View Event---------------------------

#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------

#pragma mark ------------------------Init---------------------------------


@end
