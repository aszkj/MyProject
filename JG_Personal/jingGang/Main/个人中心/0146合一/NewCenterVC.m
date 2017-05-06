//
//  NewCenterVC.m
//  jingGang
//
//  Created by wangying on 15/5/29.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "NewCenterVC.h"
#import "NewCenterCell.h"
#import "NewDetailVC.h"
#import "MyAnswerCell.h"
#import "AnswerVC.h"
#import "GlobeObject.h"



#import "IRequest.h"
#import "Faviours.h"
#import "TestHistoryVC.h"
#import "PublicInfo.h"
#import "AppDelegate.h"
#import "VApiManager.h"
#import "userDefaultManager.h"
#import "UIImageView+AFNetworking.h"
#import "expertsViewController.h"
#import "JGMessageManager.h"
#import "MJRefresh.h"
#import "sucsessViewController.h"
#import "Util.h"
#import "CollectionGoodsViewController.h"
#import "CollectionShopsViewController.h"
#import "CollectionServiceViewController.h"
#import "WSJCollectionMerchantViewController.h"
#import "MERHomePageViewController.h"
#import "PhysicalReportDetailController.h"
#import "NoticeController.h"

@interface NewCenterVC ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate>
{

    UITableView *_tableView;
    UIButton *button_na;
    UIView *bg_view ;
    NSInteger text;
    VApiManager *_VApManager;
    NSMutableArray *arr_data;

    
    JGMessageManager* _msgManager;

    int pageNum;
    
    UIView *view ;
    UIView * abge_bg;
}
@end

@implementation NewCenterVC

-(instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
#pragma mark -----viewDidLoad
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    abge_bg =[[UIView alloc]initWithFrame:CGRectMake(0, -30, __MainScreen_Width, 30)];
    
    abge_bg.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
   // abge_bg.backgroundColor =[UIColor redColor];
    [self.view addSubview:abge_bg];
    
    
    button_na.hidden = NO;
    [_tableView reloadData];
    self.tabBarController.tabBar.hidden = YES;
    
   
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat width = __MainScreen_Width/2-60;
    CGFloat height = __MainScreen_Height/2 - 50;
    view =[[UIView alloc]initWithFrame:CGRectMake(width, height-40, 120, 100)];
    UILabel *l_ss = [[UILabel alloc]initWithFrame:CGRectMake(0, 70, view.frame.size.width, 30)];
    
    l_ss.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    [view addSubview:l_ss];
    view.hidden = YES;
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"blank_ask"]];
    l_ss.text = @"您还没有提问";
    img.frame = CGRectMake(20, 0, 60, 60);
    [view addSubview:img];
    [self.view addSubview:view];
    RELEASE(l_ss);
    RELEASE(img);
    
    
    self.view.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    
    //初始化消息模块
    [self _initMsgModuel];
    pageNum = 1;
    arr_data = [[NSMutableArray alloc]init];
    
   // [self dosomeRequest];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"home_title"] forBarMetrics:UIBarMetricsDefault];

    UIButton *leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0.0f, 16.0f, 40.0f, 25.0f)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    //增加好点的返回键
    [Util makeWellClickBGBtnAtNavBar:self.navigationController.navigationBar withBtnSize:60 onResponseMethodStr:@"leftClick" isLeftItem:YES inResponseObject:self];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButton;
       UIButton *rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(0.0f, 16.0f, 40.0f, 25.0f)];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButton;
   
    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
    if (self.index == 0) {
        
        l.text = @"消息中心";
        //[self dosomeRequest];
    } else if (self.index == 1) {
        l.text = @"我的问答";
         pageNum = 0;
        [self dosomeRequest];
    } else if (self.index == 4) {
        l.text = @"我的健康档案";
    } else {
        l.text = @"我的收藏";
    }
    
    l.textColor = [UIColor whiteColor];
    l.font = [UIFont boldSystemFontOfSize:18];
    
    self.navigationItem.titleView = l;
    [self creatTableView];
    WEAK_SELF;
    if (self.index == 1) {
        [_tableView addFooterWithCallback:^{
            [weak_self dosomeRequest];
        }];

    }

}

#pragma mark - 初始化消息模块
-(void)_initMsgModuel{

    _msgManager = [JGMessageManager shareInstances] ;
    
    //消息管理者增加资讯消息数监听者
    [_msgManager addObserver:self forKeyPath:@"unreadInfoMsgCount" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    //自定义消息监听
    [_msgManager addObserver:self forKeyPath:@"unreadCustomMsgCount" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
}


#pragma kvo - 消息数目改变响应回调函数
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"change:-------%@",change);
    
    [_tableView reloadData];
}


-(void)dosomeRequest
{
    pageNum++;
    _VApManager = [[VApiManager alloc]init];
    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
    
    UsersConsultingListRequest *usersConsultingListRequest = [[UsersConsultingListRequest alloc] init:accessToken];
    
    usersConsultingListRequest.api_pageNum = @((pageNum));
    usersConsultingListRequest.api_pageSize = @10;
    
    [_VApManager usersConsultingList:usersConsultingListRequest success:^(AFHTTPRequestOperation *operation, UsersConsultingListResponse *response) {
        NSLog(@"查询我的问答成功");
        
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"-consultingResult-----%@",dict);
        
        NSArray *ars = [dict objectForKey:@"consultingResult"];
        
        for (int i =0; i<ars.count; i++) {
            
            [arr_data addObject:ars[i]];
        }
        if (arr_data.count >0) {
              view.hidden = YES;

            
            [[NSUserDefaults standardUserDefaults]setObject:arr_data forKey:@"ConsultingList"];
        }else
        {
            view.hidden = NO;
            [self.view bringSubviewToFront:view];

        }
        [_tableView reloadData];
        [_tableView footerEndRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_tableView footerEndRefreshing];
        NSLog(@"查询我的问答失败%@",error);
    }];
    
}



-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    button_na.hidden = YES;
}
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//   
//}
-(void)leftClick
{

    if ([self.witch isEqualToString:@"mainVc"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    //移除消息数目观察者
    [_msgManager removeObserver:self forKeyPath:@"unreadInfoMsgCount"];
    //移除自定义消息观察者
    [_msgManager removeObserver:self forKeyPath:@"unreadCustomMsgCount"];
    
}

#pragma mark -----UI
-(void)creatTableView
{
    _tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0, 64, __MainScreen_Width, __MainScreen_Height - 64);
   NSLog(@"frame.height = %f",_tableView.frame.size.height);
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
   // _tableView.backgroundColor = [UIColor orangeColor];
    UILabel *l_bg = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 5)];
    l_bg.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    _tableView.tableHeaderView = l_bg;
    _tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    
    [self.view addSubview:_tableView];
    
    RELEASE(l_bg);
    
}
#pragma mark -----TableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.index == 4) {
        return 3;
    }
    if (self.index == 1) {
        return arr_data.count;
    }
    if (self.index == 6)
    {
        return 6;
    }if (self.index == 0) {
        return 2;
    }
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.index == 0 ||self.index == 6 ||self.index == 4) {
    
    NewCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cells"];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone; //无线

    if (!cell) {
        
        NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"NewCenterCell" owner:self options:nil];
        cell = [arr objectAtIndex:0];
    }
        if (indexPath.row==0) {//通知
//            //暂时隐藏消息view
//            cell.msgBgView.hidden = YES;
//            cell.countText.hidden = YES;
            if (_msgManager.unreadCustomMsgCount == 0) {//没有消息

                cell.countText.hidden = YES;
            }else{//显示消息num

                cell.countText.hidden = NO;

                cell.countText.text = [NSString stringWithFormat:@"%ld",(long)_msgManager.unreadCustomMsgCount];
            }
        }else if(indexPath.row == 1){//资讯
            if (_msgManager.unreadInfoMsgCount == 0) {//没有消息

                cell.countText.hidden = YES;
            }else{//显示消息num

                cell.countText.hidden = NO;
                cell.countText.text = [NSString stringWithFormat:@"%ld",(long)_msgManager.unreadInfoMsgCount];
            
            }
            
        }else if (indexPath.row == 2){
            
        }
        
        
        cell.backgroundColor = [UIColor whiteColor];
        UIView *bgV = [[UIView alloc]initWithFrame:cell.frame];
        cell.selectedBackgroundView = bgV;//设置点击颜色
        RELEASE(bgV);
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
     
        [cell getIndexRow:indexPath.row index:self.index];
        if (indexPath.row == 1) {
        
//        if (arr_data.count >99) {
//                cell.countText.text = @"99+";
//           }else
//            {
//                cell.countText.text = [NSString stringWithFormat:@"%d",arr_data.count];
//             }
           }
        
        return cell;
    }
    else if (self.index == 1)//我的问答
    {
     
        MyAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            
            NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"MyAnswerCell" owner:self options:nil];
            cell = [arr objectAtIndex:0];
        }
        UILabel *l_bg = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,5)];
        l_bg.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
        [cell.contentView addSubview:l_bg];

        [cell getData:indexPath.row];
        
        if (arr_data.count >0) {
            
        NSDictionary *dis = arr_data[indexPath.row];
            
            JGLog(@"disdisdisdisdis%@",dis);
            
            [[NSUserDefaults standardUserDefaults]setObject:[dis objectForKey:@"id"] forKey:@"zixunid"];
            
            JGLog(@" ddddddd%@",[dis objectForKey:@"id"]);
            cell.AnswerText.text = [dis objectForKey:@"title"];
            if ([dis objectForKey:@"newRepayTime"]) {
                cell.timeText.text = [NSString stringWithFormat:@"最后回答时间：%@",[dis objectForKey:@"newRepayTime"]];
            }else{
                cell.timeText.text = [NSString stringWithFormat:@"最后回答时间：暂无"];
            }
            
            NSDictionary *sid = [dis objectForKey:@"userExperts"];
             [cell.iconImg setImageWithURL:[NSURL URLWithString:[sid objectForKey:@"headImgPath"]] placeholderImage:[UIImage imageNamed:@"per_defult_head"]];
            
            cell.questText.text = [NSString stringWithFormat:@"回答专家：%@",[sid objectForKey:@"name"]];
        
        }
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.index == 0) {//消息中心

        if (indexPath.row == 0) {//自定义消息点击
//            newDetail.showMessageType = Custom_Message_Type;
            NoticeController *noticeVC = [[NoticeController alloc] init];
            //进入公告页
            [self.navigationController pushViewController:noticeVC animated:YES];
        }else if (indexPath.row == 1){//咨询消息点击
            NewDetailVC *newDetail = [[NewDetailVC alloc]init];
            newDetail.showMessageType = Consult_Message_Type;
            newDetail.indett = indexPath.row;
            [self.navigationController pushViewController:newDetail animated:YES];
        }

        
    }
    else if (self.index == 1)//
    {
        
        if (arr_data.count >0) {
            
            NSDictionary *dis = arr_data[indexPath.row];
            sucsessViewController * sucVc = [[sucsessViewController alloc]init];
            NSString * huifu_id = [dis objectForKey:@"id"];
            sucVc.web_id = huifu_id;
            sucVc.experts_id = [[dis objectForKey:@"userExperts"] objectForKey:@"uid"];
            AbstractRequest *request = [[AbstractRequest alloc] init:GetToken];
            sucVc.Web_URL = [NSString stringWithFormat:@"%@/consulting/my_consulting?id=%d",request.baseUrl,[huifu_id intValue]];
            sucVc.is_answer = @"Is_Answer";
            NSLog(@"我的问答跳转的web_url ===== %@",sucVc.Web_URL);
            [self.navigationController pushViewController:sucVc animated:YES];
            RELEASE(sucVc);
        }

    }
    else if(self.index == 6)//收藏
    {
        if (indexPath.row == 2)
        {
            CollectionGoodsViewController *shopsVC = [[CollectionGoodsViewController alloc] init];
            [self.navigationController pushViewController:shopsVC animated:YES];
        }
        else if (indexPath.row == 3)
        {
            CollectionShopsViewController *shopsVC = [[CollectionShopsViewController alloc] init];
            [self.navigationController pushViewController:shopsVC animated:YES];
        }
        else if (indexPath.row == 4)
        {
            CollectionServiceViewController *serviceVC = [[CollectionServiceViewController alloc] init];
            [self.navigationController pushViewController:serviceVC animated:YES];
        }
        else if (indexPath.row == 5)
        {
            WSJCollectionMerchantViewController *VC = [[WSJCollectionMerchantViewController alloc] initWithNibName:@"WSJCollectionMerchantViewController" bundle:nil];
            [self.navigationController pushViewController:VC animated:YES];
        }
        else
        {
            Faviours *fav =[[Faviours alloc]init];
            fav.indes = indexPath.row;
            [self.navigationController pushViewController:fav animated:YES];
            RELEASE(fav);
        }
    }
    /**
     *  我的档案跳转
     *
     *  @param self.index 点击哪个页面
     *
     *  @return nil
     */
    else if(self.index == 4)
    {
#pragma mark - FOURTH
        if(indexPath.row == 0) {
            TestHistoryVC *test =[[TestHistoryVC alloc]init];
            [self.navigationController pushViewController:test animated:YES];
                RELEASE(test);
        } else if(indexPath.row == 1){
            /**
             点击跳转暂时跳到体检报告详情页面,更换注释即可更换跳转到之前的页面
             */
//            PhysicalReportDetailController *VC = [[PhysicalReportDetailController alloc]init];
//            [self.navigationController pushViewController:VC animated:YES];
            MERHomePageViewController *VC = [[MERHomePageViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else{
            
        }
    }else
    {
    
    }
        
}
-(void)btnClickChang
{
    bg_view.hidden = YES;
    [_tableView reloadData];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int height = 0;
    if (self.index == 0 || self.index == 6 ||self.index == 4) {
        height = 70;
    }else if (self.index == 1)
    {
        height = 92;
    }
    return height;
}



@end
