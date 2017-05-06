//
//  ComplainManagerController.m
//  Operator_JingGang
//
//  Created by dengxf on 15/10/27.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "ComplainManagerController.h"
#import "ComplainCell.h"
#import "ComplainModel.h"
#import "ComplainDetailController.h"
#import "KeyWordSearchController.h"
#import "MJRefresh.h"
#define JGHeight 44.0f

@interface ComplainManagerController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,ComplainDetailControllerDelegate>

/**
 *  新投诉按钮
 */
@property (strong,nonatomic) UIButton *freshComplainButton;
/**
 *  已完成按钮
 */
@property (strong,nonatomic) UIButton *completeButton;
/**
 *  当前页面已选中的按钮
 */
@property (strong,nonatomic) UIButton *selectedButton;
/**
 *  按钮底部的线
 */
@property (strong,nonatomic) UIView *bottomLine;
/**
 *  列表的底视图
 */
@property (strong,nonatomic) UIScrollView *bgScrollView;
/**
 *  新投诉列表
 */
@property (strong,nonatomic) UITableView *freshComplainTableView;
/**
 *  新投诉数组
 */
@property (strong,nonatomic) NSMutableArray *freshArray;

/**
 *  已完成列表
 */
@property (strong,nonatomic) UITableView *completedTableView;
/**
 *  已完成数组
 */
@property (strong,nonatomic) NSMutableArray *completedArray;
/**
 *  新投诉页数
 */
@property (nonatomic,strong) NSNumber *freshComplainPage;
/**
 *  已完成页数
 */
@property (nonatomic,strong) NSNumber *completedPage;
/**
 *  投诉状态  1为处理中，3为已完成
 */
@property (nonatomic,assign)   NSInteger complainStatus;
/**
 *  已完成是否第一次刷新
 */
@property (nonatomic,assign)   BOOL  isCompletedFirstRequest;
@end

@implementation ComplainManagerController

// 新投诉数组
- (NSMutableArray *)freshArray {
    if (!_freshArray) {
        _freshArray = [NSMutableArray array];
    }
    return _freshArray;
}

// 已完成数
- (NSMutableArray *)completedArray {
    if (!_completedArray) {
        _completedArray = [NSMutableArray array];
    }
    return _completedArray;
}

// 新投诉列表
- (UITableView *)freshComplainTableView {
    if (!_freshComplainTableView) {
        _freshComplainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _freshComplainTableView.delegate = self;
        _freshComplainTableView.dataSource = self;
        _freshComplainTableView.tableFooterView = [[UIView alloc] init];
        _freshComplainTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self tableViewHeaderRereshing];
        }];
        _freshComplainTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self tableViewFootRereshing];
        }];
        [self.bgScrollView addSubview:_freshComplainTableView];
    }
    return _freshComplainTableView;
}
// 已完成列表
- (UITableView *)completedTableView {
    if (!_completedTableView) {
        _completedTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _completedTableView.delegate = self;
        _completedTableView.dataSource = self;
        _completedTableView.tableFooterView = [[UIView alloc] init];
        _completedTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self tableViewHeaderRereshing];
        }];
        _completedTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self tableViewFootRereshing];
        }];
        [self.bgScrollView addSubview:_completedTableView];
    }
    return _completedTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 初始化界面
    [self setupContent];
    //进入页面开始网络请求

    self.freshComplainPage = [NSNumber numberWithInteger:1];
    self.complainStatus = 1;
    self.completedPage = [NSNumber numberWithInteger:1];
    self.isCompletedFirstRequest = YES;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self netWorkRequestListIsNeedRemoveAllObjWith:NO];
}

- (void)netWorkRequestListIsNeedRemoveAllObjWith:(BOOL)isNeedRemoveObj
{

    WEAK_SELF
    VApiManager *netManaget = [[VApiManager alloc]init];
    
    ComplaintsUsersListRequest *request = [[ComplaintsUsersListRequest alloc]init:GetToken];
    
    request.api_status = [NSNumber numberWithInteger:self.complainStatus];
    //    1处理中，新投诉    3已完成
    if (self.complainStatus == 1) {
        request.api_pageNum = self.freshComplainPage;
    }else{
        request.api_pageNum = self.completedPage;
    }
    request.api_pageSize = [NSNumber numberWithInteger:10];
    
    [netManaget complaintsUsersList:request success:^(AFHTTPRequestOperation *operation, ComplaintsUsersListResponse *response) {
        
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[response keyValues]];
        //  isNeedRemoveObj  是是否要清空数组，为下拉刷新准备
        [weak_self setupDataWithIsCompletedWithDic:dic isNeedRemoveObj:isNeedRemoveObj];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [weak_self.freshComplainTableView.header endRefreshing];
        [weak_self.freshComplainTableView.footer endRefreshing];
        [weak_self.completedTableView.header endRefreshing];
        [weak_self.completedTableView.footer endRefreshing];
        [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
    }];
}


/**
 *  初始化界面
 */
- (void)setupContent {
    self.title = @"投诉管理";
    
    // 新投诉
    UIButton *freshComplainButton = [self setupButtonWithTitle:@"新投诉"
                                                       frame:CGRectMake(0, 0, kScreenWidth /2, 44)
                                                   titleFont:[UIFont systemFontOfSize:18.0f]
                                                       color:[UIColor grayColor]
                                               selectedColor:status_color
                                             backgroundColor:[UIColor whiteColor]];
    [freshComplainButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:freshComplainButton];
    self.freshComplainButton = freshComplainButton;
    
    
    // 已完成
    UIButton *completeButton = [self setupButtonWithTitle:@"已完成"
                                                    frame:CGRectMake(kScreenWidth /2, 0, kScreenWidth /2, 44)
                                                titleFont:[UIFont systemFontOfSize:18.0f]
                                                    color:[UIColor grayColor]
                                            selectedColor:status_color
                                          backgroundColor:[UIColor whiteColor]];
    [completeButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:completeButton];
    self.completeButton = completeButton;

    // 按钮底部的线条
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.x = 0;
    bottomLine.y = CGRectGetMaxY(self.freshComplainButton.frame);
    bottomLine.width = self.completeButton.width;
    bottomLine.height = 3.2;
    bottomLine.backgroundColor = status_color;
    [self.view addSubview:bottomLine];
    self.bottomLine = bottomLine;
    
    [self buttonClick:self.freshComplainButton];
    
    UIView *whiteBgView = [[UIView alloc] init];
    whiteBgView.x = 16;
    whiteBgView.y = CGRectGetMaxY(self.bottomLine.frame) + 7;
    whiteBgView.width = kScreenWidth - whiteBgView.x * 2;
    whiteBgView.height = 36;
    whiteBgView.backgroundColor = [UIColor whiteColor];
    whiteBgView.layer.cornerRadius = 5;
    
    [self.view addSubview:whiteBgView];
    
    UIImageView *lookImgView = [[UIImageView alloc] init];
    lookImgView.image = [UIImage imageNamed:@"search_shop"];
    lookImgView.x = 7.5;
    lookImgView.width = 16;
    lookImgView.height = 16;
    lookImgView.y = (whiteBgView.height - lookImgView.width) / 2;
    [whiteBgView addSubview:lookImgView];
    
    UIButton *searchButton = [self setupButtonWithTitle:@"商户名称" frame:CGRectMake(CGRectGetMaxX(lookImgView.frame) + 7, 2, whiteBgView.width - lookImgView.width * 2, whiteBgView.height - 4) titleFont:[UIFont systemFontOfSize:14.0f] color:[UIColor lightGrayColor] selectedColor:[UIColor lightGrayColor] backgroundColor:[UIColor clearColor]];
    [whiteBgView addSubview:searchButton];
    searchButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [searchButton addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bottomLine.frame) + 52, kScreenWidth, kScreenHeight - self.bgScrollView.y)];
    scrollView.contentSize = CGSizeMake(kScreenWidth * 2, 0);
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.scrollEnabled = NO;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.bgScrollView = scrollView;

    
    
    
    self.freshComplainTableView.x = 0;
    self.freshComplainTableView.y = 0;
    self.freshComplainTableView.width = kScreenWidth;
    self.freshComplainTableView.rowHeight = 44.0;
    self.freshComplainTableView.height = self.bgScrollView.height;
    
    self.completedTableView.x = kScreenWidth;
    self.completedTableView.y = 0;
    self.completedTableView.width = kScreenWidth;
    self.completedTableView.rowHeight = 44.0;
//    self.completedTableView.height = self.bgScrollView.height;
    self.completedTableView.height = kScreenHeight - (freshComplainButton.height + 64 + bottomLine.height + searchButton.height);
    
    // 初始化数据源
//    self.freshArray = [self setupDataWithIsCompleted:NO];
//    self.completedArray = [self setupDataWithIsCompleted:YES];
}

- (void)searchClick {
    KeyWordSearchController *keyWordController = [[KeyWordSearchController alloc] init];
    keyWordController.complainStatus = self.complainStatus;
    [self.navigationController pushViewController:keyWordController animated:YES];
}

/**
 *  处理数据源
 *
 */
- (void)setupDataWithIsCompletedWithDic:(NSDictionary *)dic isNeedRemoveObj:(BOOL)isNeedRemoveObj{
    
    NSArray *array = [NSArray arrayWithArray:dic[@"groupComplaintBOs"]];
    
    
    if (self.complainStatus == 1) {
        if (isNeedRemoveObj) {
            [self.freshArray removeAllObjects];
        }
        for (NSInteger i = 0; i < array.count; i++) {
            NSDictionary *dict = [NSDictionary dictionaryWithDictionary:array[i]];
            [self.freshArray addObject:[ComplainModel objectWithKeyValues:dict]];
        }
        //假数据
//        for (NSInteger i = 0; i < 6; i++) {
//            ComplainModel *model = [[ComplainModel alloc]init];
//            model.name = @"哈哈哈";
//            model.id   = @"12";
//            model.storeName = @"太平洋";
//            model.addTime = @"1900-10-10 10:10";
//            model.isHandled = YES;
//            [self.freshArray addObject:model];
//        }
        
        [self.freshComplainTableView reloadData];
    }

    if (self.complainStatus == 3) {
        if (isNeedRemoveObj) {
            [self.completedArray removeAllObjects];
        }
        for (NSInteger i = 0; i < array.count; i++) {
            NSDictionary *dict = [NSDictionary dictionaryWithDictionary:array[i]];
            [self.completedArray addObject:[ComplainModel objectWithKeyValues:dict]];
        }
//        假数据
//        for (NSInteger i = 0; i < 6; i++) {
//            ComplainModel *model = [[ComplainModel alloc]init];
//            model.name = @"哈哈哈";
//            model.id   = @"12";
//            model.storeName = @"太平洋";
//            model.addTime = @"1900-10-10 10:10";
//            model.isHandled = NO;
//            [self.completedArray addObject:model];
//        }

        
        self.isCompletedFirstRequest = NO;
        [self.completedTableView reloadData];
    }
    
    
    
    
    [self.freshComplainTableView.header endRefreshing];
    [self.freshComplainTableView.footer endRefreshing];
    [self.completedTableView.header endRefreshing];
    [self.completedTableView.footer endRefreshing];
    [MBProgressHUD hideHUDForView:self.view animated:YES];

}

- (UIButton *)setupButtonWithTitle:(NSString *)title
                             frame:(CGRect)frame
                         titleFont:(UIFont *)font
                             color:(UIColor *)normalColor
                     selectedColor:(UIColor *)selectedColor
                   backgroundColor:(UIColor *)backgroundColor{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setFrame:frame];
    button.titleLabel.font = font;
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    [button setTitleColor:selectedColor forState:UIControlStateSelected];
    [button setBackgroundColor:backgroundColor];
    return button;
}

/**
 *  监听头部点击事件
 *
 */
- (void)buttonClick:(UIButton *)btn {
    
    [self.view endEditing:YES];
    
    if (self.selectedButton == btn) {
        return;
    }
    NSInteger offSet = btn.x / (kScreenWidth / 2);
    
    [UIView animateWithDuration:0.22 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.bottomLine.x = btn.x;
        self.bgScrollView.contentOffset = CGPointMake(offSet * kScreenWidth, 0);
    } completion:^(BOOL finished) {        
    }];
    if (btn == self.freshComplainButton) {
        self.freshComplainButton.selected = YES;
        self.completeButton.selected = NO;
        self.complainStatus = 1;
    }else {
        self.freshComplainButton.selected = NO;
        self.completeButton.selected = YES;
        if (self.isCompletedFirstRequest) {
            self.complainStatus = 3;
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [self netWorkRequestListIsNeedRemoveAllObjWith:NO];
        }
    }
    self.selectedButton = btn;
}
/**
 *  下拉刷新方法
 */
- (void)tableViewHeaderRereshing
{
    if (self.complainStatus == 1) {
        self.freshComplainPage = [NSNumber numberWithInteger:1];
        [self netWorkRequestListIsNeedRemoveAllObjWith:YES];
    }else{
        self.completedPage = [NSNumber numberWithInteger:1];
        [self netWorkRequestListIsNeedRemoveAllObjWith:YES];
    }
}

/**
 *  上拉加载方法
 */
- (void)tableViewFootRereshing
{
    NSInteger page = 0;
    if (self.complainStatus == 1) {
        page = [self.freshComplainPage integerValue];
        page++;
        self.freshComplainPage = [NSNumber numberWithInteger:page];
    }else{
        page = [self.completedPage integerValue];
        page++;
        self.completedPage = [NSNumber numberWithInteger:page];
    }
    [self netWorkRequestListIsNeedRemoveAllObjWith:NO];

}
- (UIView *)setupHeaderView:(NSArray *)titleArray {
    CGFloat width = kScreenWidth / 4;
    UIView *headerView = [[UIView alloc] init];
    headerView.width = kScreenWidth;
    headerView.height = JGHeight;
    headerView.backgroundColor = kGetColor(10, 66, 99);
    for (int i = 0 ; i < titleArray.count; i++) {
        NSString *titleText = [NSString stringWithFormat:@"%@",titleArray[i]];
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.x = width * i;
        titleLab.y = 0;
        titleLab.width = width;
        titleLab.height = JGHeight;
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.backgroundColor = [UIColor clearColor];
        titleLab.textColor = [UIColor whiteColor];
        titleLab.font = [UIFont systemFontOfSize:14];
        titleLab.text = titleText;
        [headerView addSubview:titleLab];
    }
    return headerView;
}

#pragma mark --- TableViewDelegate ---

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return JGHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self setupHeaderView:@[@"投诉人",@"被投诉商户",@"投诉时间",@"操作"]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.freshComplainTableView) {
        return self.freshArray.count;
    }else
        return self.completedArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellId = @"identifierId";
    ComplainCell *cell   = [tableView dequeueReusableCellWithIdentifier:CellId];
    if (!cell) {
        cell = [[ComplainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
    }
    if (tableView == self.freshComplainTableView) {
        cell.compModel = self.freshArray[indexPath.row];
        cell.isHandled = YES;

    }else{
        cell.compModel = self.completedArray[indexPath.row];
        cell.isHandled = NO;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ComplainDetailController *detailController = [[ComplainDetailController alloc] init];
    
    ComplainModel *model;
    if (tableView == self.freshComplainTableView) {
        model = self.freshArray[indexPath.row];
    }else{
        model = self.completedArray[indexPath.row];
    }
    
    //待处理传YES    已完成NO
    if (tableView == self.freshComplainTableView) {
        detailController.isHandled = YES;
    }else{
        detailController.isHandled = NO;
    }
    
    detailController.apiID = [NSString stringWithFormat:@"%@",model.id];
    [self.navigationController pushViewController:detailController animated:YES];
}


#pragma mark ---ComplainDetailControllerDelegate
- (void)nofitiCationComplainMainListRefreshData
{
    self.freshComplainPage = [NSNumber numberWithInteger:1];
    [self netWorkRequestListIsNeedRemoveAllObjWith:YES];
}

#pragma mark --- UIScrollViewDelegate ---
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (scrollView == self.bgScrollView) {
//        NSInteger page =  scrollView.contentOffset.x / kScreenWidth;
//        switch (page) {
//            case 0:
//            {
//                [self buttonClick:self.freshComplainButton];
//
//            }
//                break;
//             case 1:
//            {
//                [self buttonClick:self.completeButton];
//            }
//                break;
//            default:
//                break;
//        }
//    }
}
@end
