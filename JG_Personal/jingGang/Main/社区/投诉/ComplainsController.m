//
//  ComplainsController.m
//  jingGang
//
//  Created by dengxf on 15/10/30.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "ComplainsController.h"
#import "PublicInfo.h"
#import "UIButton+Block.h"
#import "PublicInfo.h"
#import "GlobeObject.h"
#import "ComplainSelectedCell.h"
#import "VApiManager.h"
#import "Util.h"
#import "MBProgressHUD.h"

@interface ComplainsController ()<UITableViewDelegate,UITableViewDataSource,ComplainSelectedCellDelegate>

/**
 *  列表视图-
 */
@property (strong,nonatomic) UITableView *tableView;

/**
 *   数据源
 */
@property (strong,nonatomic) NSMutableArray *dataArray;

/**
 *  投诉类型数组
 */
@property (strong,nonatomic) NSMutableArray *selectedComplainArray;

/**
 *  网络请求管理对象
 */
@property (strong,nonatomic) VApiManager *netManager;

@property (assign, nonatomic) NSInteger recordSelectedIndex;

@property (strong,nonatomic) NSIndexPath *selectedIndexPath;

@end

@implementation ComplainsController

#pragma mark --- 懒加载 --
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentOffset = CGPointMake(0, 10);
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithObjects:@"诈骗",@"色情",@"政治",@"侵权",@"其他", nil];
    }
    return _dataArray;
}

- (VApiManager *)netManager {
    if (!_netManager) {
        _netManager = [[VApiManager alloc] init];
    }
    return _netManager;
}


- (NSMutableArray *)selectedComplainArray {
    if (!_selectedComplainArray) {
        _selectedComplainArray = [NSMutableArray array];
    }
    return _selectedComplainArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    // 初始化界面
    [self setupContent];
}

/**
 *   初始化界面
 */
- (void)setupContent {
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.recordSelectedIndex = -1;
    
    self.navigationController.navigationBar.barTintColor = kGetColor(94, 180, 231);
    
    [Util setNavTitleWithTitle:@"举报" ofVC:self];
    
    WEAK_SELF;
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 45)];
    [rightBtn setTitle:@"提交" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(commiteAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    RELEASE(rightBtn);
    RELEASE(item);
    
    /**
     *  加载导航栏返回按钮
     */
    UIButton *navLeftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 25)];
    [navLeftButton setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    [navLeftButton addActionHandler:^(NSInteger tag) {

        [weak_self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:navLeftButton];
    self.navigationItem.leftBarButtonItem = item;
    
    RELEASE(navLeftButton);
    RELEASE(item);
    
    // 初始化列表
    self.tableView.x = 0;
    self.tableView.y = 0;
    self.tableView.width = __MainScreen_Width;
    self.tableView.height = self.view.height - __NavScreen_Height;

}

/**
 *  监听提交事件--
 */
- (void)commiteAction:(UIButton *)commiteButton {
    commiteButton.enabled = NO;
    
    JGLog(@"click");
    
    UsersReportSaveRequest *request = [[UsersReportSaveRequest alloc] init:GetToken];
    request.api_targetId = [NSNumber numberWithInteger:[self.targetId integerValue]];  // 举报对象 id
    request.api_tipsType = @"";  // 举报名称
    
    if (self.complainType == InvitationType) {
        request.api_type = [NSNumber numberWithInteger:0];  // 举报类型|0帖子1资讯
    }else if (self.complainType == InformationType) {
        request.api_type = [NSNumber numberWithInt:1];
    }
    
    //--提交举报
    if (self.recordSelectedIndex > -1) {
        [self.netManager usersReportSave:request success:^(AFHTTPRequestOperation *operation, UsersReportSaveResponse *response) {
            
            [Util showHudAltert:self.view message:@"举报成功"];
            [self dismisControllerWithDelayTime:1.0];
            commiteButton.enabled = YES;

            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [Util showHudAltert:self.view message:[NSString stringWithFormat:@"%@",error.domain]];

            [self dismisControllerWithDelayTime:1.0];
            commiteButton.enabled = YES;

        }];
        
    }else {
        [Util ShowAlertWithOnlyMessage:@"请选择举报原因"];
        commiteButton.enabled = YES;

    }
}

- (void)dismisControllerWithDelayTime:(int64_t)delayTime {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        if (self.complainType == InvitationType) {
//            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//        }else if (self.complainType == InformationType) {
//            [self.navigationController popToRootViewControllerAnimated:YES];
//        }
//        [self.navigationController popToRootViewControllerAnimated:YES];
        [self.navigationController popViewControllerAnimated:YES];

    });

}

#pragma  mark ---TableViewDelegate --
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellId = @"identifierId";
    ComplainSelectedCell *cell   = [tableView dequeueReusableCellWithIdentifier:CellId];
    if (!cell) {
        cell = [[ComplainSelectedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
    }
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    ComplainSelectedCell *cell = (ComplainSelectedCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell stSelectedWithIndexPath:indexPath];
    
  
    if (self.selectedIndexPath != indexPath) {
        ComplainSelectedCell *cell = (ComplainSelectedCell *)[tableView cellForRowAtIndexPath:self.selectedIndexPath];
        [cell hiddenSelectedIndexPath];
    }else {
        self.selectedIndexPath = nil;
        self.recordSelectedIndex = -1;
        return;
    }
    
    self.selectedIndexPath = indexPath;
    self.recordSelectedIndex = indexPath.row;

}

-(void)tableView:(UITableView * )tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    [cell setSeparatorInset:UIEdgeInsetsZero];
    
    [cell setLayoutMargins:UIEdgeInsetsZero];
    
}


#pragma mark  ---- ComplainSelectedCellDelegate ----
- (void)complainSelectedCell:(ComplainSelectedCell *)complainSelectedell didSelectedCells:(NSIndexPath *)selectedCell {
    
}

- (void)complainSelectedCell:(ComplainSelectedCell *)complainSelectedCell didCancelSelectedCells:(NSIndexPath *)cancelSelectedCells {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
