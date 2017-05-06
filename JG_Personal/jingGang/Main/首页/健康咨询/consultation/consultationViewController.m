//
//  consultationViewController.m
//  jingGang
//
//  Created by yi jiehuang on 15/5/25.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "consultationViewController.h"
#import "AppDelegate.h"
#import "PublicInfo.h"
#import "comsultationTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "SVProgressHUD.h"
#import "expertsViewController.h"
#import "GlobeObject.h"
#import "RecommentCodeDefine.h"
#import "UIButton+Block.h"
#import "HealthDetailsViewController.h"
#import "H5page_URL.h"
#import "UIView+BlockGesture.h"
#import "MJRefresh.h"
#import "TLTitleSelectorView.h"
#import "UIView+Frame.h"
#import "WebDayVC.h"

@interface consultationViewController ()<SDCycleScrollViewDelegate>
{
    UITableView      *_left_tableView;
    UITableView      *_right_tableView;
    VApiManager      *_vapManager;
    int               pageSize;
    int               pageSizeRight;
    
    int timeCount;
}

@property (nonatomic, retain)NSMutableArray   *arrData_bg;

@property (nonatomic) TLTitleSelectorView *titleView;
@property (nonatomic) UIScrollView *scrollView;
@end

@implementation consultationViewController

- (void)dealloc
{
   
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化父类信息
    [self initBaseVCInfo];
    
    _midleView.hidden = YES;
    _myScrollView.scrollEnabled = NO;
    _myScrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-kStatuBarAndNavBarHeight);
    size = 3;
    
    self.arrData_bg = [NSMutableArray array];
    
    pageSize = 1;
    pageSizeRight = 1;
    _arrData_bg = [[[NSMutableArray alloc]init] mutableCopy];
    
    
    [self RecommentRequest];//首页广告业
    
    [self setLeftBarAndBackgroundColor];
    self.title = @"健康咨询";
    
    _left_array = [[NSMutableArray alloc]init];
    _right_array = [[NSMutableArray alloc]init];
    [self doSomeRequest:1 withPageSize:size withPageSize:1];
    [self doSomeRequest:2 withPageSize:size withPageSize:1];
    
    _left_tableView = [[UITableView alloc]init];
    _left_tableView.backgroundColor = [UIColor clearColor];
    _left_tableView.tag = 1;
    _left_tableView.delegate = self;
    _left_tableView.dataSource = self;
    _right_tableView = [[UITableView alloc]init];
    _right_tableView.backgroundColor = [UIColor clearColor];
    _right_tableView.tag = 2;
    _right_tableView.dataSource = self;
    _right_tableView.delegate = self;

    @weakify(self)
    [_left_tableView addFooterWithCallback:^{
        @strongify(self)
        pageSize = pageSize+1;
        [self doSomeRequest:1 withPageSize:size withPageSize:self->pageSize];
    }];
    [_right_tableView addFooterWithCallback:^{
        pageSizeRight += 1;
        @strongify(self)
        [self doSomeRequest:2 withPageSize:size withPageSize:self->pageSizeRight];
    }];
    
    self.titleView.frame = CGRectMake(0 , self.topScrollView.bottom, __MainScreen_Width, 42);
    [self.myScrollView addSubview:self.titleView];
    
    self.scrollView.frame = CGRectMake(0, self.titleView.bottom, __MainScreen_Width, CGRectGetHeight(self.myScrollView.frame) - self.titleView.bottom);
    [self.myScrollView addSubview:self.scrollView];
    
    _left_tableView.frame = CGRectMake(0, 10, __MainScreen_Width, CGRectGetHeight(self.scrollView.frame));
    _right_tableView.frame = CGRectMake(__MainScreen_Width, 10, __MainScreen_Width, CGRectGetHeight(self.scrollView.frame));
    _left_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _right_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.scrollView addSubview:_left_tableView];
    [self.scrollView addSubview:_right_tableView];
}

-(void)RecommentRequest
{
    
     _vapManager = [[VApiManager alloc]init];
    NSString *token = [userDefaultManager GetLocalDataString:@"Token"];
    SnsRecommendListRequest *request = [[SnsRecommendListRequest alloc] init:token];
    request.api_posCode = Zixun_shouye_jingguan_xiangmu;
    [_vapManager snsRecommendList:request success:^(AFHTTPRequestOperation *operation, SnsRecommendListResponse *response) {
       NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        NSArray *arr = [dict objectForKey:@"advList"];
        
        for (int i =0; i<arr.count; i++) {
            [self.arrData_bg addObject:arr[i]];
        }
        [self reloadToScrollView:self.arrData_bg];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error.localizedDescription);
    }];
}

-(void)reloadToScrollView:(NSMutableArray *)array{

    //获取图片url数组
    NSMutableArray *clearImgUrlArr = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dic in array) {
        
        NSString *clearImgUrl = [NSString stringWithFormat:@"%@_%ix%i",dic[@"adImgPath"],(int)_topScrollView.frame.size.width*2,(int)_topScrollView.frame.size.height*2];
        [clearImgUrlArr addObject:clearImgUrl];
        
    }
    
    //    NSLog(@"clear img arr %@",clearImgUrlArr);
    _topScrollView.delegate = self;
    _topScrollView.imageURLStringsGroup = (NSArray *)clearImgUrlArr;

}

#pragma mark - Top ScrollView delegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    NSDictionary *dic = self.arrData_bg[index];
    WebDayVC *web = [[WebDayVC alloc]init];
    web.strUrl = [NSString stringWithFormat:@"%@%@",Base_URL,[dic objectForKey:@"adUrl"]];
    int type = [[dic objectForKey:@"adType"] intValue];
    if (type == 1) {
        web.dic = dic;
    }
    [[NSUserDefaults standardUserDefaults]setObject:[dic objectForKey:@"adTitle"] forKey:@"circleTitle"];
    UINavigationController *nas = [[UINavigationController alloc]initWithRootViewController:web];
    nas.navigationBar.barTintColor = [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1];
    [self presentViewController:nas animated:YES completion:nil];

}

static int size;
//static int pageSize;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"self.left.array = %ld----self.right.array ==%ld",(long)_left_array.count,(long)_right_array.count);
    if (tableView.tag ==1) {
        return self.left_array.count;
    }else{
        return self.right_array.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    comsultationTableViewCell * cell = nil;
    tableView.rowHeight = 115;
    if (!cell) {
        NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"comsultationTableViewCell" owner:self options:nil];
        cell = [arr objectAtIndex:0];
    }
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (tableView.tag == 1) {
        NSLog(@"左边表格");
        [cell setEntity:[self.left_array objectAtIndex:indexPath.row]];
    }else if (tableView.tag == 2) {
        NSLog(@"右边表格");
        [cell setEntity:[self.right_array objectAtIndex:indexPath.row]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float  height = 115;
    return height;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    expertsViewController * experVc = [[expertsViewController alloc]init];
    if (tableView.tag == 1) {
        NSLog(@"left----cell-----index-----%ld",(long)indexPath.row);
        experVc.img_str  = [[self.left_array objectAtIndex:indexPath.row] objectForKey:@"headImgPath"];
        experVc.name_str = [[self.left_array objectAtIndex:indexPath.row] objectForKey:@"name"];
        experVc.dis_Str = [[self.left_array objectAtIndex:indexPath.row] objectForKey:@"desc"];
        NSString * sex = [[self.left_array objectAtIndex:indexPath.row] objectForKey:@"title"];
//        if ([sex intValue]==1) {
//            experVc.sex_str = [NSString stringWithFormat:@"男性医生"];
//        }else{
//            experVc.sex_str = [NSString stringWithFormat:@"女性医生"];
//        }
        experVc.sex_str = sex;
        experVc.uId = [[self.left_array objectAtIndex:indexPath.row] objectForKey:@"uid"];
        experVc.phone_num = [[self.left_array objectAtIndex:indexPath.row] objectForKey:@"mobile"];
        
    }else{
        NSLog(@"right----cell-----index-----%ld",(long)indexPath.row);
        experVc.img_str  = [[self.right_array objectAtIndex:indexPath.row] objectForKey:@"headImgPath"];
        experVc.name_str = [[self.right_array objectAtIndex:indexPath.row] objectForKey:@"name"];
//        ....
        experVc.dis_Str = [[self.right_array objectAtIndex:indexPath.row] objectForKey:@"desc"];
        NSLog(@"详情－－－－ %@",experVc.dis_Str);
        NSString * sex = [[self.right_array objectAtIndex:indexPath.row] objectForKey:@"title"];
//        if ([sex intValue]==1) {
//            experVc.sex_str = [NSString stringWithFormat:@"男性医生"];
//        }else{
//            experVc.sex_str = [NSString stringWithFormat:@"女性医生"];
//        }
        experVc.sex_str = sex;
        
        experVc.uId = [[self.right_array objectAtIndex:indexPath.row] objectForKey:@"uid"];
        experVc.phone_num = [[self.right_array objectAtIndex:indexPath.row] objectForKey:@"mobile"];
    }
    [self.navigationController pushViewController:experVc animated:YES];

}


-(void)viewDidLayoutSubviews
{
    if ([_left_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_left_tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([_left_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_left_tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([_right_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_right_tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([_right_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_right_tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)doSomeRequest:(int)number withPageSize:(int)size withPageSize:(int)api_pageSize
{
    NSLog(@"刷新专家");
//    NSLog(@"experts type %d pageSize : %d",number,pageSize);
    
    
    [SVProgressHUD showInView:self.view status:@"正在刷新数据" networkIndicator:NO posY:-1 maskType:1];
    _vapManager = [[VApiManager alloc]init];
    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
    UsersExpertsListRequest *UsersExpertsList = [[UsersExpertsListRequest alloc] init:accessToken];
    NSNumber * num = [NSNumber numberWithInt:number];
    UsersExpertsList.api_experType = num;
    UsersExpertsList.api_pageSize  = [NSNumber numberWithInt:size];
    UsersExpertsList.api_pageNum   = [NSNumber numberWithInt:api_pageSize];
    
    [_vapManager usersExpertsList:UsersExpertsList success:^(AFHTTPRequestOperation *operation, UsersExpertsListResponse *response) {
        [SVProgressHUD dismiss];
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"num = %d, 咨询界面dict = %@",number,dict);
        NSArray * array = [dict objectForKey:@"experts"];
//        [_myScrollView footerEndRefreshing];
        if (array.count == 0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"暂无更多数据" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];

            if (number == 1) {
                [_left_tableView footerEndRefreshing];
            }else{
                [_right_tableView footerEndRefreshing];
            }
        }
        for (int i = 0; i < array.count; i++) {
            if (number == 1) {
                _left_tableView.hidden = NO;
                [_left_tableView footerEndRefreshing];
                [self.left_array addObject:[array objectAtIndex:i]];
                [_left_tableView reloadData];
            }else{
                _right_tableView.hidden = NO;
                [_right_tableView footerEndRefreshing];
                [self.right_array addObject:[array objectAtIndex:i]];
                [_right_tableView reloadData];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"失败");
        [_myScrollView footerEndRefreshing];
        [SVProgressHUD dismiss];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- getter

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [UIScrollView new];
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(2 * __MainScreen_Width, 0);
    }
    return _scrollView;
}

- (TLTitleSelectorView *)titleView {
    if (_titleView == nil) {
        _titleView = [[TLTitleSelectorView alloc] initWithTitles:@"抗衰老专家",@"健康管理师", nil];
        @weakify(self)
        _titleView.buttonPressBlock = ^(NSInteger index) {
            @strongify(self)
            [self.scrollView setContentOffset:CGPointMake(index * __MainScreen_Width, 0) animated:YES];
        };
    }
    return _titleView;
}

@end
