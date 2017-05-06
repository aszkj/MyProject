//
//  NewDetailVC.m
//  jingGang
//
//  Created by wangying on 15/5/30.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "NewDetailVC.h"
#import "NewDetailCell.h"
#import "PublicInfo.h"
#import "expertsViewController.h"
#import "Util.h"
#import "UIViewExt.h"
#import "TMCache.h"
#import "GlobeObject.h"
#import "MJRefresh.h"
#import "H5page_URL.h"
#import "sucsessViewController.h"
//缓存列表key
#define Zixun_Message_Key @"Zixun_Message_Key"
#define Custom_Message_key @"Custom_Message_key"


@interface NewDetailVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSInteger selectIndex;
    NSMutableArray *arrs;
    UIImageView * n_imag;
    NSInteger index;
    UIView * n_view;
    NSInteger text;
    NSArray *arr_data;
    
    TMCache* _cache;//缓存类

    JGMessageManager *_msgManager;
    
    NSMutableArray  *_upFreshArr;//上拉刷新缓存数组
    NSInteger _upFreshNum;//上拉刷新刷新位置
    
    UIView *view;
}

@property (nonatomic, retain)NSMutableArray *dataArr;//数据源

@end

@implementation NewDetailVC



#pragma mark -----viewDidLoad
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //初始化消息管理者
    _msgManager = [JGMessageManager shareInstances];
    
    //初始化历史消息和新产生的消息
    [self _initDataCacheMsgAndNewMsg];
    

    self.view.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    arr_data = [[NSUserDefaults standardUserDefaults]objectForKey:@"ConsultingList"];
    
   
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"home_title"] forBarMetrics:UIBarMetricsDefault];

    
    UIView *view_bg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 30)];

    
    //n_imag = [[UIImageView alloc]initWithFrame:view_bg.frame];
        [view_bg addSubview:n_imag];
        n_imag.image = [UIImage imageNamed:@"per_button_left"];
    

    if (self.indett == 0) {
//     l.text = @"公告";
        [Util setNavTitleWithTitle:@"公告" ofVC:self];
    }else{
    
//        l.text = @"咨询";
        [Util setNavTitleWithTitle:@"咨询" ofVC:self];
    }
    
  
    UIButton *leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0.0f, 16.0f, 40.0f, 25.0f)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    if (_dataArr.count == 0) {

        CGFloat width = __MainScreen_Width/2-60;
        CGFloat height = __MainScreen_Height/2 - 50;
       view =[[UIView alloc]initWithFrame:CGRectMake(width, height, 120, 100)];
        [self.view addSubview:view];
       // view.hidden = YES;
        UILabel *l_ss = [[UILabel alloc]initWithFrame:CGRectMake(0, 70, view.frame.size.width, 30)];
        l_ss.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        [view addSubview:l_ss];
        
        UIImageView *img = nil;
        img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"blank_notice"]];
            l_ss.text = @"您暂时还没有消息";
        l_ss.font = [UIFont systemFontOfSize:15];
        img.frame = CGRectMake(20, 0, 60, 60);
        l_ss.top = img.bottom + 5;
        [view addSubview:img];
        
        RELEASE(l_ss);
        RELEASE(img);
        
    }else{
    
        [self creatTableView];
    }
    
    RELEASE(view_bg);
    RELEASE(leftButton);
    RELEASE(leftBtn);
}

#pragma mark - 初始化 历史消息和新产生的消息
-(void)_initDataCacheMsgAndNewMsg{

    //先读取历史消息
    _cache = [TMCache sharedCache];
    if (!_dataArr) {//
        self.dataArr = [NSMutableArray array];
    }
    //上拉刷新起始位置初始化
    _upFreshNum = 0;
    
    
    if (self.showMessageType == Consult_Message_Type) {//咨询消息展示
        
        [_dataArr addObjectsFromArray:_msgManager.unreadInfoMsgArr];
        [_dataArr addObjectsFromArray:[_cache objectForKey:Zixun_Message_Key]];
        [_msgManager resetInfoMsgForMessageType:Consult_Message_Type];
        
    }else if (self.showMessageType == Custom_Message_Type){//自定义消失展示
        
        [_dataArr addObjectsFromArray:_msgManager.unreadCustomMsgArr];
        [_dataArr addObjectsFromArray:[_cache objectForKey:Custom_Message_key]];
        [_msgManager resetInfoMsgForMessageType:Custom_Message_Type];
    }
    
    
    
    
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    n_view.hidden = YES;
    
    if (_dataArr.count >= 15) {//历史记录若大于等于15条，，则移除15条之后的
        NSIndexSet *set = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(15, _dataArr.count-15)];
        [_dataArr removeObjectsAtIndexes:set];
        RELEASE(set);
    }
    
    //缓存消息数组
    if (self.showMessageType == Consult_Message_Type) {
        
        [_cache setObject:_dataArr forKey:Zixun_Message_Key];
    }else if (self.showMessageType == Custom_Message_Type){
        [_cache setObject:_dataArr forKey:Custom_Message_key];
    }
    
}




-(void)leftClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -----ui
-(void)creatTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
     _tableView.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight =  105;
    [self.view addSubview:_tableView];
    
}

-(void)_upRresh{

    //每次刷新两条
    if (_upFreshArr.count > _upFreshNum) {
        NSMutableArray *newAddArr = [NSMutableArray arrayWithCapacity:2];
        for (NSInteger i=_upFreshNum; i<_upFreshNum+2; i++) {
            if (i < _upFreshArr.count) {//防止越界
                
                [newAddArr addObject:_upFreshArr[i]];
            }
        }
        [_dataArr addObjectsFromArray:newAddArr];
        _upFreshNum += 2;
        [_tableView reloadData];
    }
    
    //结束上拉刷新
    [_tableView footerEndRefreshing];

}//上拉刷新




#pragma mark ------tableDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        
        NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"NewDetailCell" owner:self options:nil];
        cell = [arr objectAtIndex:0];
    }
    UILabel *l_bg = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 5)];
    l_bg.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    [cell.contentView addSubview:l_bg];
    RELEASE(l_bg);
    
    NSDictionary *dic = _dataArr[indexPath.row];
    if (_dataArr.count >0) {
//        if (self.showMessageType == Consult_Message_Type) {
//            NSString *content = [dic[@"aps"] objectForKey:@"alert"];
//            cell.textTitle.text = content;
//        }else if (self.showMessageType == Custom_Message_Type) {
            cell.textTitle.text = dic[@"content"];
//        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = _dataArr[indexPath.row];
//    CGFloat height = 0.0;
//    if (self.showMessageType == Consult_Message_Type) {
//        
//    }else if (self.showMessageType == Custom_Message_Type) {
//    
//    
//    }
    NSString *content = dic[@"content"];
    CGSize cellSize = kStringSize(content, 14, kScreenWidth-30, 1000) ;
    return cellSize.height + 50;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.indett == 0) { //公告
        
    }else{
        
        NSDictionary *dic = _dataArr[indexPath.row];
        NSNumber *consultID = dic[@"extras"][@"id"];
        sucsessViewController *sucsessVC = [[sucsessViewController alloc] init];
        sucsessVC.Web_URL = kConsultDetailWebUrlWithID(consultID);
        [self.navigationController pushViewController:sucsessVC animated:YES];
    }
}
@end
