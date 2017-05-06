//
//  ComplainDetailController.m
//  Operator_JingGang
//
//  Created by dengxf on 15/10/28.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "ComplainDetailController.h"
#import "ComplainProgressCell.h"
#import "OrderDetailCell.h"
#import "MerchantInfoCell.h"
#import "BuyerInfoCell.h"
#import "ComplainDetailCell.h"
#import "ComplainServiceCell.h"
#import "ComplainResultCell.h"
#import "ViewPhotoController.h"
#import "ComplainDetailModel.h"
@interface ComplainDetailController ()<UITableViewDelegate,UITableViewDataSource,ComplainResultCellDelegate>

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSMutableArray *dataArray;
/**
 *  详情数据模型
 */
@property (strong,nonatomic) ComplainDetailModel *model;



@end

@implementation ComplainDetailController

// 新投诉列表
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = VCBackgroundColor;
        // 初始化tableView列表
        _tableView.x = 0;
        _tableView.y = 0;
        _tableView.width = kScreenWidth;
        _tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
        _tableView.height = kScreenHeight - 64;
        _tableView.contentOffset = CGPointMake(0, -10);
        
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self netWorkRequestDetail];
    [self setupContent];
    [self.view addSubview:self.tableView];
}


- (void)netWorkRequestDetail
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    VApiManager *netManaget = [[VApiManager alloc]init];
    ComplaintsUsersDetailsRequest *request = [[ComplaintsUsersDetailsRequest alloc]init:GetToken];
    request.api_id = [NSNumber numberWithInteger:[self.apiID integerValue]];
    WEAK_SELF
    [netManaget complaintsUsersDetails:request success:^(AFHTTPRequestOperation *operation, ComplaintsUsersDetailsResponse *response) {
        JGLog(@"%@",response);
        
        weak_self.model = [ComplainDetailModel objectWithKeyValues:response.groupComplaintsBO];
        
        [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
        
        
        [weak_self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
    }];
}



- (void)setupContent {
    self.title = @"服务投诉详情细页";

    // 初始化数据源
    NSArray *dataArray = @[@"投诉进度",@"订单详情",@"商户信息",@"买家信息",@"投诉详情",@"投诉服务",@"处理结果"];
    [self.dataArray addObjectsFromArray:dataArray];
    
    
}



#pragma mark 提交处理结果的cell  delegat
- (void)commitTextViewTextForVC:(NSString *)str
{
    WEAK_SELF
    VApiManager *netManager = [[VApiManager alloc]init];
    ComplaintsHandlerRequest *requeset = [[ComplaintsHandlerRequest alloc]init:GetToken];
    requeset.api_id = [NSNumber numberWithInteger:[self.apiID integerValue]];
    requeset.api_result = str;
    [netManager complaintsHandler:requeset success:^(AFHTTPRequestOperation *operation, ComplaintsHandlerResponse *response) {
        //提交成功后返回上一页面同时通知投诉列表页面刷新数据
        if ([self.delegate respondsToSelector:@selector(nofitiCationComplainMainListRefreshData)]) {
            return [self.delegate nofitiCationComplainMainListRefreshData];
        }
        [self netWorkRequestDetail];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark -- tableviewDelegate -- 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 85.0;
            break;
        case 1:
            return 144.0f;
            break;
        case 2:
            return 118;
            break;
        case 3:
            return 65;
            break;
        case 4:
            return 144;
            break;
        case 5:
            return 367;
            break;
        case 6:
            if ([self.model.status isEqualToString:@"1"]) {
                return 208;
            }else{
                return 108;
            }
            
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WEAK_SELF
    switch (indexPath.section) {
        case 0:
        {
            /**
             *  投诉进度cell
             */
            static NSString *identifierId = @"ComplainProgressCell";
            ComplainProgressCell *cell   = [tableView dequeueReusableCellWithIdentifier:identifierId];
            if (!cell) {
                cell = [[ComplainProgressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierId];
            }
            //订单状态
            cell.model = self.model;
            return cell;
            
        }
            break;
        case 1:
        {
            /**
             *  订单详情cell
             */
            static NSString *identifierId = @"OrderDetailCell";
            OrderDetailCell *cell   = [tableView dequeueReusableCellWithIdentifier:identifierId];
            if (!cell) {
                cell = [[OrderDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierId];
            }
            cell.model = self.model;
   
            
            return cell;
            
        }
            break;
        case 2:
        {
            /**
             *  商户信息
             */
            static NSString *identifierId = @"MerchantInfoCell";
            MerchantInfoCell *cell   = [tableView dequeueReusableCellWithIdentifier:identifierId];
            if (!cell) {
                cell = [[MerchantInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierId];
            }
            cell.model = self.model;
            return cell;
            
        }
            break;
        case 3:
        {
            /**
             *  买家信息
             */
            static NSString *identifierId = @"BuyerInfoCell";
            BuyerInfoCell *cell   = [tableView dequeueReusableCellWithIdentifier:identifierId];
            if (!cell) {
                cell = [[BuyerInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierId];
            }
            cell.model = self.model;
            return cell;
            
        }
            break;
        case 4:
        {
            /**
             *  投诉详情信息
             */
            static NSString *identifierId = @"ComplainDetailCell";
            ComplainDetailCell *cell   = [tableView dequeueReusableCellWithIdentifier:identifierId];
            if (!cell) {
                cell = [[ComplainDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierId];
            }
            
            cell.model = self.model;
            
            //查看图片
    
            cell.viewPhotoBlock = ^(){
                if (weak_self.model.fromAccArry.count == 0) {
                    [MBProgressHUD showSuccess:@"投诉方没有上传证据图片" toView:weak_self.view];
                    
                }
                ViewPhotoController *viewPhotoController = [[ViewPhotoController alloc] init];
                viewPhotoController.arrayImageUrl = self.model.fromAccArry;
                [weak_self.navigationController pushViewController:viewPhotoController animated:YES];
            };
            
            return cell;
        }
            break;
        case 5:
        {
            /**
             *  投诉服务
             */
            static NSString *identifierId = @"ComplainServiceCell";
            ComplainServiceCell *cell   = [tableView dequeueReusableCellWithIdentifier:identifierId];
            if (!cell) {
                cell = [[ComplainServiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierId];
            }
            cell.model = self.model;
            return cell;
        }
            break;
        case 6:
        {
            /**
             *  处理反馈意见
             */
            static NSString *identifierId = @"ComplainResultCell";
            ComplainResultCell *cell   = [tableView dequeueReusableCellWithIdentifier:identifierId];
            if (!cell) {
                cell = [[ComplainResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierId];
            }
            cell.delaget = self;
            cell.model = self.model;
            return cell;
            }
            break;


        default:
            break;
    }
    return nil;
}


@end
