//
//  WSJMerchantEvaluateViewController.m
//  jingGang
//
//  Created by thinker on 15/9/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJMerchantEvaluateViewController.h"
#import "PublicInfo.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "WSJMerchantEvaluateTableViewCell.h"
#import "WSJEvaluateModel.h"
#import "VApiManager.h"
#import "GlobeObject.h"
#import "MJRefresh.h"
#import "mapObject.h"
#import "NodataShowView.h"
#define pageSize @(10)

@interface WSJMerchantEvaluateViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _page;
    VApiManager *_vapiManager;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong ) NSMutableArray *dataSource;


@end

static NSString *merchantEvaluateTabelViewCell = @"merchantEvaluateTabelViewCell";

@implementation WSJMerchantEvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
#pragma mark - 网络请求数据
- (void)requestData
{
    //TODO:查看评论
    WEAK_SELF
    GroupEvaluateListRequest *evaluateLiStRequest = [[GroupEvaluateListRequest  alloc] init:GetToken];
    evaluateLiStRequest.api_pageNum = @(_page);
    evaluateLiStRequest.api_pageSize = pageSize;
    evaluateLiStRequest.api_storeId = self.api_classId;
    [_vapiManager groupEvaluateList:evaluateLiStRequest success:^(AFHTTPRequestOperation *operation, GroupEvaluateListResponse *response) {
        NSLog(@"pinglun ---- %@",response);
        for (NSDictionary *dict in response.evaluateList)
        {
            WSJEvaluateModel *model = [[WSJEvaluateModel alloc]init];
            model.titleImageURL = dict[@"avatarUrl"];
            model.starCount = [dict[@"score"] intValue];
            model.titleName  = dict[@"nickName"];
            model.date = dict[@"evaluateTime"];
            model.evaluateContent = dict[@"content"];
            if ([dict[@"photoUrls"] length] > 2) {
                [model.dataImageArray addObjectsFromArray:[dict[@"photoUrls"] componentsSeparatedByString:@";"]];
            }
            model.shopkeeper = dict[@"replyContent"];
            [weak_self.dataSource addObject:model];

        }
        if (weak_self.dataSource.count > 0) {
            [weak_self.tableView reloadData];
        }else {
            [NodataShowView showInContentView:self.view withReloadBlock:nil alertTitle:@"暂无评价"];
        }
        [weak_self.tableView headerEndRefreshing];
        [weak_self.tableView footerEndRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"评价 ---- %@",error);
        [weak_self.tableView headerEndRefreshing];
        [weak_self.tableView footerEndRefreshing];
    }];
    
    
    
//    WSJEvaluateModel *m = [[WSJEvaluateModel alloc] init];
//    
//    m.starCount = 3;
//    
//    m.titleImageURL = @"http://f1.jgyes.com/1,20bc0e8abf0f";
//    
//    m.titleName = @"威乐weloo";
//    
//    m.evaluateContent = @"东西已收到，感觉很好，与店家描述相近。1";
//    
//    m.date = @"2015 - 09 - 8";
//    
//    [self.dataSource addObject:m];
//    
//    WSJEvaluateModel *model = [[WSJEvaluateModel alloc] init];
//    
//    model.starCount = 5;
//    
//    model.titleImageURL = @"http://f1.jgyes.com/1,20bc0e8abf0f";
//    
//    model.titleName = @"安卓苹果";
//    
//    model.evaluateContent = @"东西已收到，感觉很好，与店家描述相近。东西已收到，感觉很好，与店家描述相近。东西已收到，感觉很好，与店家描述相近。东西已收到，感觉很好";
//    
//    model.date = @"2015 - 09 - 3";
//    
//    [model.dataImageArray addObjectsFromArray:@[@"http://f1.jgyes.com/1,20bc0e8abf0f",@"http://f1.jgyes.com/1,20bc0e8abf0f"]];
//    
//    model.shopkeeper = @"[掌柜回复]：亲，非常感谢您对我们的惠顾与肯定！希望宝贝给您嗲去见见的心情哦~期待您的下次光临，更优质的购物体验在等着您哦！体验在等着您哦！！！";
//    
////    model.supplement = @"[追加评论]：亲，非常感谢您对我们的惠顾与肯定！希望宝贝给您嗲去见见的心情哦~期待您的下次光临，更优质的购物体验在等着您哦！体验在等着您哦！！！";
//    
//    [self.dataSource addObject:model];
//    
//    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (self.dataSource.count == 0) {
//        self.noEvaluateLabel.hidden = NO;
//    }
//    else
//    {
//        self.noEvaluateLabel.hidden = YES;
//    }
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSJMerchantEvaluateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:merchantEvaluateTabelViewCell];
    WSJEvaluateModel *model = self.dataSource[indexPath.row];
    cell.model = model;
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSJEvaluateModel *model = self.dataSource[indexPath.row];
    return model.O2OHeight;
}

#pragma mark - 实例化UI
- (void)initUI
{
    _vapiManager = [[VApiManager alloc] init];
    self.dataSource = [NSMutableArray array];
    [self.tableView registerNib:[UINib nibWithNibName:@"WSJMerchantEvaluateTableViewCell" bundle:nil] forCellReuseIdentifier:merchantEvaluateTabelViewCell];
    self.tableView.tableFooterView = [UIView new];
    WEAK_SELF
    [self.tableView addHeaderWithCallback:^{
        _page = 1;
        [weak_self.dataSource removeAllObjects];
        [weak_self requestData];
    }];
    [self.tableView addFooterWithCallback:^{
        _page ++;
        [weak_self requestData];
    }];
    [self.tableView headerBeginRefreshing];
    
    //返回上一级控制器按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(btnClick) target:self];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //设置背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
}
//返回上一级界面
- (void) btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(__MainScreen_Width/2 - 30, __StatusScreen_Height, 60, 40)];
    l.text = @"商户的评论";
    l.font = [UIFont systemFontOfSize:18];
    l.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = l;
}


@end
