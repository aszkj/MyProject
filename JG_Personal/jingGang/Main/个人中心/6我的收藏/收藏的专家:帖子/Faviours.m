//
//  Faviours.m
//  jingGang
//
//  Created by wangying on 15/6/1.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "Faviours.h"
#import "FaviousCell.h"
#import "PublicInfo.h"
#import "MyStore.h"
#import "SearchCell.h"
#import "MyStoreCell.h"
#import "userDefaultManager.h"
#import "UIImageView+AFNetworking.h"
#import "H5Base_url.h"
#import "WebDayVC.h"
#import "expertsViewController.h"
#import "UIViewExt.h"
#import "shareView.h"
#import "JGShareView.h"
#import "FollwerContent.h"
#import "Util.h"
#import "MJRefresh.h"
#import "GlobeObject.h"
#import "NodataShowView.h"

#import "comsultationTableViewCell.h"

@interface Faviours ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView *views;
    UIButton *btnss;
     NSMutableArray *arr;
    UILabel *li ;
    NSInteger indexs;
    UITableView *_tableView;
    UIView *topView;
    BOOL isclick;
    VApiManager *_VApManager;
    NSMutableArray *arr_bg; //收藏专家
    NSMutableArray *arr_teizi;//收藏帖子
    NSMutableArray *arr_guan;//收藏官方帖子
    NSMutableArray *arr_yinyang;//收藏营养健康师
    NSNumber *tiezi;
     UIImageView *img;
    UILabel *l_ss;
    UIView *view;
    
    
//    UIView *_viewforshare;
//    shareView *share_view;
    int pageNum1;
    int pageNum2;
}
@end

NSString *const favioursCell = @"comsultationTableViewCell";

@implementation Faviours
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Do any additional setup after loading the view.
       arr = [[NSMutableArray alloc]init];
    arr_bg = [[NSMutableArray alloc]init];
    arr_teizi = [[NSMutableArray alloc]init];
    arr_guan = [[NSMutableArray alloc]init];
    arr_yinyang = [[NSMutableArray alloc]init];
    
    tiezi = @2;
    
    pageNum1 = 0;
    pageNum2 = 0;
    
    self.view.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"home_title"] forBarMetrics:UIBarMetricsDefault];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    if (self.indes == 0) {
        titleLabel.text = @"我收藏的专家";
        [self doSomeRequest:@1];
    }else
    {
        titleLabel.text = @"收藏的帖子";
        [self storetext:tiezi];
    }
    self.navigationItem.titleView = titleLabel;
    RELEASE(titleLabel);
    
    UIButton *leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0.0f, 16.0f, 40.0f, 25.0f)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButton;
    RELEASE(leftBtn);
    RELEASE(leftButton);
    
    
   UIView  *viewss= [[UIView alloc]initWithFrame:CGRectMake(20, 100, 90, 40)];
    viewss.backgroundColor = [UIColor redColor];
    [self.view addSubview:viewss];
    RELEASE(viewss);
    
    [self creatBtn];
    [self creatTableView];
    
    WEAK_SELF;
    __block NSNumber *_tiezi = tiezi;
    [_tableView addFooterWithCallback:^{
        if (weak_self.indes == 0) {
            if (type == 0) {
                [weak_self doSomeRequest:@1];
            }else{
                [weak_self doSomeRequest:@2];
            }
        }else{
            [weak_self storetext:_tiezi];
        }
    }];
    
    CGFloat width = __MainScreen_Width/2-60;
    CGFloat height = __MainScreen_Height/2 - 70;
    view =[[UIView alloc]initWithFrame:CGRectMake(width, height, 120, 100)];
     view.hidden = NO;
    
    l_ss = [[UILabel alloc]initWithFrame:CGRectMake(0, 70, view.frame.size.width, 30)];
    
    l_ss.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    l_ss.textAlignment = NSTextAlignmentCenter;
    if (self.indes == 0) {
        
        img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"blank_expert"]];
//        img.frame = CGRectMake(20, 0, 60, 60);
                img.frame = CGRectMake((view.size.width-60)/2, 0, 60, 60);
//        l_ss.text = @"您还没收藏专家";
        l_ss.text = @"暂无收藏";
    }else
    {
        img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"blank_post"]];
//        img.frame = CGRectMake(20, 0, 60, 60);
          img.frame = CGRectMake((view.size.width-60)/2, 0, 60, 60);
        //        l_ss.text = @"您还没收藏帖子";
        l_ss.text = @"暂无收藏";
    }
   // view.backgroundColor =[UIColor redColor];
    [self.view addSubview:view];
    
    [view addSubview:l_ss];
    [view addSubview:img];
    view.hidden = YES;
}

-(void)doSomeRequest:(NSNumber *)indes;
{
    
    [arr_yinyang removeAllObjects];
    [arr_bg removeAllObjects];
    
    _VApManager = [[VApiManager alloc]init];
    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
    NSLog(@"token   %@",accessToken);
    UsersExpertsQueryRequest *usersPraiseRequest = [[UsersExpertsQueryRequest alloc] init:accessToken];
    usersPraiseRequest.api_expertsType = indes;
    usersPraiseRequest.api_pageNum = @1;
    usersPraiseRequest.api_pageSize = @(5);
    usersPraiseRequest.api_type = @"2";
    
    
    [_VApManager usersExpertsQuery:usersPraiseRequest success:^(AFHTTPRequestOperation *operation, UsersExpertsQueryResponse *response) {
        
        NSLog(@"查询收藏的专家列表成功");
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"dict ===------- %@",dict);
        
        NSArray *str = [dict objectForKey:@"experts"];

        for (int i = 0; i<str.count; i++) {
            
            if ([indes intValue] == 1)
            {
                
               [arr_bg addObject:str[i]];
            }else
            {
                [arr_yinyang addObject:str[i]];
            }
           
        }
//          view.hidden = NO;
        NSLog(@"----arr_count == %lu",(unsigned long)arr_bg.count);
        if(indexs == 0)//抗衰老／官方
        {
            if (arr_bg.count == 0) {
                view.hidden = NO;
            }else {
                view.hidden = YES;
            }
        }
        if (indexs == 1)//健康管理师
        {
            
            if (arr_yinyang.count == 0) {
                view.hidden = NO;
            }else {
                view.hidden = YES;
            }
        }
        

        [_tableView reloadData];
        [_tableView footerEndRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        [_tableView reloadData];
        [_tableView footerEndRefreshing];
        NSLog(@"------查询收藏的专家列表失败-------%@",error);
    }];
    
    
  
   // [self creatDefault];
    
}
-(void)storetext:(NSNumber *)inds
{

//    [arr_teizi removeAllObjects];
//    [arr_guan removeAllObjects];
//    if (type == 0) {
//        [self doSomeRequest:@1];
//    }else{
//        [self doSomeRequest:@2];
//    }
    _VApManager = [[VApiManager alloc]init];
    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
   
    UsersInvitationQueryRequest *usersInvitationQueryRequest = [[UsersInvitationQueryRequest alloc] init:accessToken];
    // usersInvitationQueryRequest.api_times = @11;
    usersInvitationQueryRequest.api_circleType = inds;
    if (inds.integerValue == 1) {
        pageNum1 ++;
        usersInvitationQueryRequest.api_pageNum = @(pageNum1);
    }else{
        pageNum2++;
        usersInvitationQueryRequest.api_pageNum = @(pageNum2);
    }
    
    usersInvitationQueryRequest.api_pageSize = @4;
    usersInvitationQueryRequest.api_type = @"1";
    
    [_VApManager usersInvitationQuery:usersInvitationQueryRequest success:^(AFHTTPRequestOperation *operation, UsersInvitationQueryResponse *response) {
        NSLog(@"查询收藏帖子列表成功");
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        
        NSLog(@"查询官方帖子成功%@",dict);
        NSArray *atts = [dict objectForKey:@"circle"];
        
        for (int i =0; i<atts.count; i++) {
            
            
            
            if ([inds intValue] == 2) {
                
                [arr_guan addObject:atts[i]];
            }
            else
            {
              [arr_teizi addObject:atts[i]];
            }
        }
        
//        view.hidden = NO;
        if(indexs == 0)//guanfang
        {
            if (arr_guan.count == 0) {
                view.hidden = NO;
            }else {
                view.hidden = YES;
            }
        }
        if (indexs == 1) {
            
            if (arr_teizi.count == 0) {
                view.hidden = NO;
            }else {
                view.hidden = YES;
            }
        }

        NSLog(@"%lu",(unsigned long)arr_teizi.count);
        [_tableView reloadData];
        [_tableView footerEndRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_tableView footerEndRefreshing];
        NSLog(@"查询收藏帖子列表失败--%@",error);
    }];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_tableView reloadData];
}
-(void)viewWillDisappear:(BOOL)animated
{

    [super viewWillDisappear:animated];
    topView.hidden = YES;
}
-(void)creatBtn
{
    views = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    
    CGFloat width = self.view.frame.size.width/2;
    NSArray *title = [NSArray arrayWithObjects:@"官方帖子",@"用户帖子", nil];
    NSArray *title_n = [NSArray arrayWithObjects:@"抗衰老专家",@"健康管理师", nil];
    for (int i =0; i<2; i++) {
        btnss = [UIButton buttonWithType:UIButtonTypeCustom];
        btnss.frame = CGRectMake(i*width, 0, width, 38);
        btnss.tag = i+1;
        btnss.backgroundColor = [UIColor whiteColor];
        if(self.indes == 0)
        {
        [btnss setTitle:title_n[i] forState:UIControlStateNormal];
        }else
        {
        [btnss setTitle:title[i] forState:UIControlStateNormal];
        }
        [btnss setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.7] forState:UIControlStateNormal];
        [btnss setTitleColor:[UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1] forState:UIControlStateSelected];
        btnss.titleLabel.font = [UIFont systemFontOfSize:15];
        btnss.titleLabel.textAlignment = NSTextAlignmentCenter;
        if (btnss.tag == 1) {
            btnss.selected = YES;
        }
        [btnss addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [views addSubview:btnss];
        [arr addObject:btnss];
    }
    li = [[UILabel alloc]initWithFrame:CGRectMake(0, 38, width, 2)];
    li.backgroundColor = [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1];
    
    [views addSubview:li];
    [self.view addSubview:views];
}

static int type ;//检测什么类型的专家
-(void)BtnClick:(UIButton *)sender
{
    
    indexs = sender.tag - 1;
    btnss.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i<arr.count; i++) {
        UIButton *btns = arr[i];
        btns.selected = NO;
    }
    sender.selected = YES;
    
    CGFloat liWidth =  (sender.tag - 1)*sender.frame.size.width;
    CGRect frame = li.frame;
    frame.origin.x = liWidth;
    li.frame = frame;
    if (arr.count>0) {
    
    [_tableView reloadData];
        
    }
    
    if (indexs == 0) {
        tiezi = @2;
    }else{
        tiezi = @1;
    }
    
    if(self.indes == 0)
    {
        
        if ([tiezi  isEqual:@2]) {
            [self doSomeRequest:@1];
            type = 0;
            
        }else{
        [self doSomeRequest:@2];
            type = 2;
        }
    
        
    }else
    {
    [self storetext:tiezi];
    }
    
}
-(void)creatTableView
{//45

    NSLog(@"cheshi ---- %g",5*__Other_Height);
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, __MainScreen_Width, __MainScreen_Height-5*__Other_Height -45)];

    _tableView.dataSource = self;
    _tableView.delegate = self;
   // _tableView.rowHeight = 127;
   [_tableView registerNib:[UINib nibWithNibName:@"SearchCell" bundle:nil] forCellReuseIdentifier:@"cells"];
    [_tableView registerNib:[UINib nibWithNibName:@"MyStoreCell" bundle:nil] forCellReuseIdentifier:@"cellst"];
    [_tableView registerNib:[UINib nibWithNibName:@"SearchCell" bundle:nil] forCellReuseIdentifier:@"cellfa"];
    [_tableView registerNib:[UINib nibWithNibName:@"comsultationTableViewCell" bundle:nil] forCellReuseIdentifier:favioursCell];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    [self.view addSubview:_tableView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 3;
    if (self.indes == 0) {
        if (indexs == 0) {
            //arr_bg
            return arr_bg.count;
        }else
        {
            return arr_yinyang.count;
        }
    }else
        {
            if (indexs == 0) {
                return arr_guan.count;
            }
            else
            {
                return arr_teizi.count;
            }
        
        }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    float height = 0;
    NSLog(@"----%ld",(long)self.indes);
    if (self.indes == 0) {
        height = comsulationTableViewCellHeight;
    }else {
        height = 109;
    }
    return height;
}

-(UITableViewCell *)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.indes == 0) {  ///收藏专家
    
        comsultationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:favioursCell];
//        MyStoreCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cellst"];
        
//        tableView.rowHeight = 85;
//        NSLog(@"arr.count --------%d",arr_bg.count);
//        cell.iconImg.layer.borderWidth = 3;
//        
//        cell.iconImg.layer.borderColor = [[UIColor colorWithRed:89/255.0 green:196/255.0 blue:241/255.0 alpha:1]CGColor];
        
        if (indexs == 0) {//专家
        
        
        if (arr_bg.count>0) {
            
            NSDictionary *dic = arr_bg[indexPath.row];
            [cell setEntity:dic];
//            [cell.iconImg setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"headImgPath"]] placeholderImage:[UIImage imageNamed:@"per_defult_head"]];
//            cell.medicLab.text = [dic objectForKey:@"title"];
//            cell.schoolLab.text = [dic objectForKey:@"desc"];
//            cell.nameLab.text = [dic objectForKey:@"name"];
        }
        
        }else{
        
            if (arr_yinyang.count >0) {
                
                
                NSDictionary *dic = arr_yinyang[indexPath.row];
                [cell setEntity:dic];
//                [cell.iconImg setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"headImgPath"]] placeholderImage:[UIImage imageNamed:@"per_defult_head"]];
//                cell.medicLab.text = [dic objectForKey:@"title"];
//                cell.schoolLab.text = [dic objectForKey:@"desc"];
//                cell.nameLab.text = [dic objectForKey:@"name"];
                
            }
        }
        return cell;
        
    }
    else //收藏帖子
    {
        
        
        SearchCell *cell;
        
        if (indexs == 0) { //官方
            
//            FaviousCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellfa"];
//            
//             tableView.rowHeight = 127;
            
            cell =[tableView dequeueReusableCellWithIdentifier:@"cellfa"];
            tableView.rowHeight = 106;
            cell.iconImg.layer.cornerRadius = 0;

            if (arr_guan.count >0) {
                
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSDictionary *dic = [arr_guan objectAtIndex:indexPath.row];
            cell.titleText.text = [dic objectForKey:@"title"];
            cell.nameText.text = [dic objectForKey:@"userName"];
            [cell.follow_text setTitle:[NSString stringWithFormat:@"跟帖(%@)",[dic objectForKey:@"replyCount"]] forState:UIControlStateNormal];
            cell.timeText.text = [NSString stringWithFormat:@"发布于%@",[dic objectForKey:@"replyTime"]];
            cell.zan_text.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"praiseCount"]];
            CGSize titleSize = [cell.nameText.text sizeWithFont:cell.nameText.font constrainedToSize:CGSizeMake(MAXFLOAT, cell.nameText.height)];
            [cell.nameText setWidth:titleSize.width];
            [cell.timeText setLeft:cell.nameText.right];
            [cell.iconImg setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"thumbnail"]] placeholderImage:cell.iconImg.image];
            
            
            [cell.zan_btn setImage:[UIImage imageNamed:@"com_zambia"] forState:UIControlStateNormal];
            [cell.zan_btn setImage:[UIImage imageNamed:@"com_zambia_pressed"] forState:UIControlStateSelected];
            cell.zan_btn.tag = indexPath.row;
            [cell.zan_btn addTarget:self action:@selector(zanClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.zan_btn.selected = [[dic objectForKey:@"isPraise"] boolValue];
            if (cell.zan_btn.selected) {
                cell.zan_text.textColor = [UIColor redColor];
            }else{
                cell.zan_text.textColor = [UIColor lightGrayColor];
            }
            
            [cell.faviour setImage:[UIImage imageNamed:@"com_collect"] forState:UIControlStateNormal];
            [cell.faviour setImage:[UIImage imageNamed:@"com_collect_pressed"] forState:UIControlStateSelected];
            cell.faviour.tag = indexPath.row;
            [cell.faviour addTarget:self action:@selector(faviourClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.faviour.selected = [[dic objectForKey:@"isFavo"] boolValue];
            if (cell.faviour.selected) {
                cell.faiour_text.textColor = [UIColor redColor];
            }else{
                cell.faiour_text.textColor = [UIColor lightGrayColor];
            }
            cell.follow_btn.tag = indexPath.row;
            cell.share_btn.tag = indexPath.row;
            [cell.follow_btn addTarget:self action:@selector(reply:) forControlEvents:UIControlEventTouchUpInside];
            [cell.share_btn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
            
            }
            
            
              return cell;
            
        }else if(indexs == 1)// 用户帖子
        {
            cell =[tableView dequeueReusableCellWithIdentifier:@"cells"];
            tableView.rowHeight = 106;

            
//            if (arr_teizi.count >0) {
//            
//                NSDictionary *ssd = arr_teizi[indexPath.row];
//                [cell.iconImg setImageWithURL:[NSURL URLWithString:[ssd objectForKey:@"headImgPath"]] placeholderImage:[UIImage imageNamed:@"per_defult_head"]];
//                cell.titleText.text = [ssd objectForKey:@"title"];
//                cell.nameText.text = [ssd objectForKey:@"userName"];
//                cell.timeText.text = [ssd objectForKey:@"publicTime"];
//                cell.zan_text.text =[NSString stringWithFormat:@"%@",[ssd objectForKey:@"praiseCount"]];
//            }
            
            
            
            if (arr_teizi.count>0) {
                
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSDictionary *dic = [arr_teizi objectAtIndex:indexPath.row];
            cell.titleText.text = [dic objectForKey:@"title"];
            cell.nameText.text = [dic objectForKey:@"userName"];
            [cell.follow_text setTitle:[NSString stringWithFormat:@"跟帖(%@)",[dic objectForKey:@"replyCount"]] forState:UIControlStateNormal];
            cell.timeText.text = [NSString stringWithFormat:@"发布于%@",[dic objectForKey:@"replyTime"]];
            cell.zan_text.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"praiseCount"]];
            CGSize titleSize = [cell.nameText.text sizeWithFont:cell.nameText.font constrainedToSize:CGSizeMake(MAXFLOAT, cell.nameText.height)];
            [cell.nameText setWidth:titleSize.width];
            [cell.timeText setLeft:cell.nameText.right];
               
             cell.iconImg.contentMode = UIViewContentModeScaleAspectFill;
            [cell.iconImg setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"headImgPath"]] placeholderImage:cell.iconImg.image];
            
            
            [cell.zan_btn setImage:[UIImage imageNamed:@"com_zambia"] forState:UIControlStateNormal];
            [cell.zan_btn setImage:[UIImage imageNamed:@"com_zambia_pressed"] forState:UIControlStateSelected];
            cell.zan_btn.tag = indexPath.row;
            [cell.zan_btn addTarget:self action:@selector(zanClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.zan_btn.selected = [[dic objectForKey:@"isPraise"] boolValue];
            if (cell.zan_btn.selected) {
                cell.zan_text.textColor = [UIColor redColor];
            }else{
                cell.zan_text.textColor = [UIColor lightGrayColor];
            }
            
            [cell.faviour setImage:[UIImage imageNamed:@"com_collect"] forState:UIControlStateNormal];
            [cell.faviour setImage:[UIImage imageNamed:@"com_collect_pressed"] forState:UIControlStateSelected];
            cell.faviour.tag = indexPath.row;
            [cell.faviour addTarget:self action:@selector(faviourClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.faviour.selected = [[dic objectForKey:@"isFavo"] boolValue];
            if (cell.faviour.selected) {
                cell.faiour_text.textColor = [UIColor redColor];
            }else{
                cell.faiour_text.textColor = [UIColor lightGrayColor];
            }
            cell.follow_btn.tag = indexPath.row;
            cell.share_btn.tag = indexPath.row;
            [cell.follow_btn addTarget:self action:@selector(reply:) forControlEvents:UIControlEventTouchUpInside];
            [cell.share_btn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
            
            }
            return cell;
        
        }
        
    
    }
    
    return nil;
}

-(void)leftClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
    
    if (self.indes==0) {
        if (indexs == 0) {
           
            NSDictionary *sis = arr_bg[indexPath.row];
            expertsViewController *eax =[[expertsViewController alloc]init];
            
//            UINavigationController *nas = [[UINavigationController alloc]initWithRootViewController:eax];
            
            eax.img_str = [sis objectForKey:@"headImgPath"];
            eax.name_str = [sis objectForKey:@"name"];
            eax.sex_str = [NSString stringWithFormat:@"%@",[sis objectForKey:@"sex"]];
            eax.phone_num = [NSString stringWithFormat:@"%@",[sis objectForKey:@"mobile"]];
            eax.dis_Str = [sis objectForKey:@"description"];
            eax.uId = [NSString stringWithFormat:@"%@",[sis objectForKey:@"uid"]];
//            nas.navigationBar.barTintColor = [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1];
            [self.navigationController pushViewController:eax animated:YES];
            RELEASE(eax);
  
           
        }else{
            
            
            NSDictionary *sis = arr_yinyang[indexPath.row];
            expertsViewController *eax =[[expertsViewController alloc]init];
            
//            UINavigationController *nas = [[UINavigationController alloc]initWithRootViewController:eax];
            
            eax.img_str = [sis objectForKey:@"headImgPath"];
            eax.name_str = [sis objectForKey:@"name"];
            eax.sex_str = [NSString stringWithFormat:@"%@",[sis objectForKey:@"sex"]];
            eax.phone_num = [NSString stringWithFormat:@"%@",[sis objectForKey:@"mobile"]];
            eax.dis_Str = [sis objectForKey:@"description"];
            eax.uId = [NSString stringWithFormat:@"%@",[sis objectForKey:@"uid"]];
//            nas.navigationBar.barTintColor = [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1];
            [self.navigationController pushViewController:eax animated:YES];
            RELEASE(eax);
        }
        
    }
    
    
    if(self.indes == 1 && indexs == 1)
   {
       if (arr_teizi.count>0) {
           
           WebDayVC *weh = [[WebDayVC alloc]init];
           
           NSDictionary * dic = [arr_teizi objectAtIndex:indexPath.row];
           NSString *url = [NSString stringWithFormat:@"%@%@%@",Base_URL,user_tiezi,[dic objectForKey:@"id"]];
           NSLog(@"%@",url);
           weh.strUrl = url;
           weh.ind = 1;
           int type = [[dic objectForKey:@"adType"] intValue];
           if (type == 1) {
               weh.dic = dic;
           }else if (type == 0) {
               weh.dic = dic;
           }
           UINavigationController *nas = [[UINavigationController alloc]initWithRootViewController:weh];
           nas.navigationBar.barTintColor = [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1];
           [self presentViewController:nas animated:YES completion:nil];
           
           RELEASE(weh);
           RELEASE(nas);
       }
   }
    if(self.indes == 1&&indexs == 0)
    {
        WebDayVC *weh = [[WebDayVC alloc] init];
        NSDictionary * dic = [arr_guan objectAtIndex:indexPath.row];
        NSString *url = [NSString stringWithFormat:@"%@%@%@",Base_URL,user_tiezi,[dic objectForKey:@"id"]];
        NSLog(@"%@",url);
        weh.strUrl = url;
        weh.ind = 1;
        int type = [[dic objectForKey:@"adType"] intValue];
        if (type == 1) {
            weh.dic = dic;
        }else if (type == 0) {
            weh.dic = dic;
        }
        UINavigationController *nas = [[UINavigationController alloc]initWithRootViewController:weh];
        nas.navigationBar.barTintColor = [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1];
        [self presentViewController:nas animated:YES completion:nil];
        RELEASE(weh);
        RELEASE(nas);
    }
 }




-(void)zanClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:btn.tag inSection:0];
    SearchCell *cell = (SearchCell *)[_tableView cellForRowAtIndexPath:indexPath];
    NSMutableDictionary *dic = nil;
    if (indexs == 0) {
        dic = [NSMutableDictionary dictionaryWithDictionary:[arr_guan objectAtIndex:btn.tag]];
    }else{
    dic = [NSMutableDictionary dictionaryWithDictionary:[arr_teizi objectAtIndex:btn.tag]];
    }
    NSInteger praiseCount = [[dic objectForKey:@"praiseCount"] integerValue];
    if (btn.selected) {
        praiseCount++;
        [dic setObject:@(praiseCount) forKey:@"praiseCount"];
        [dic setObject:@(YES) forKey:@"isPraise"];
        
        
        if (indexs == 0) {
            [arr_guan replaceObjectAtIndex:btn.tag withObject:dic];
            
        }else
        {
            
            [arr_teizi replaceObjectAtIndex:btn.tag withObject:dic];
            
        }
 
       
        cell.zan_text.textColor = [UIColor redColor];
        cell.zan_text.text = [NSString stringWithFormat:@"%ld",(long)praiseCount];
        [self praiseClickChange:[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]]];
    }else{
        praiseCount--;
        [dic setObject:@(praiseCount) forKey:@"praiseCount"];
        [dic setObject:@(NO) forKey:@"isPraise"];
        
        if (indexs == 0) {
            [arr_guan replaceObjectAtIndex:btn.tag withObject:dic];

        }else
        {
        
            [arr_teizi replaceObjectAtIndex:btn.tag withObject:dic];

        }
        
        
                cell.zan_text.textColor = [UIColor lightGrayColor];
        cell.zan_text.text = [NSString stringWithFormat:@"%ld",(long)praiseCount];
        [self dissmissPraise:[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]]];
    }
}

//取消点赞
-(void)dissmissPraise:(NSString *)fid
{
    _VApManager = [[VApiManager alloc]init];
    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
    UsersCanclePraiseRequest *usersCanclePraiseRequest = [[UsersCanclePraiseRequest alloc] init:accessToken];
    usersCanclePraiseRequest.api_fid = fid;
    [_VApManager usersCanclePraise:usersCanclePraiseRequest success:^(AFHTTPRequestOperation *operation, UsersCanclePraiseResponse *response) {
        NSLog(@"取消点赞成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"取消点赞失败");
    }];
}

//点赞
-(void)praiseClickChange:(NSString *)fid
{
    _VApManager = [[VApiManager alloc]init];
    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
    
    UsersPraiseRequest *usersPraiseRequest = [[UsersPraiseRequest alloc] init:accessToken];
    
    usersPraiseRequest.api_fid = fid;
    
    NSLog(@" ---------circle%@",fid);
    [_VApManager usersPraise:usersPraiseRequest success:^(AFHTTPRequestOperation *operation, UsersPraiseResponse *response) {
        NSLog(@"---点赞成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"---%@",error);
    }];
}

-(void)faviourClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:btn.tag inSection:0];
    SearchCell *cell = (SearchCell *)[_tableView cellForRowAtIndexPath:indexPath];
    NSMutableDictionary *dic = nil;
    if (indexs == 0) {
        dic = [NSMutableDictionary dictionaryWithDictionary:[arr_guan objectAtIndex:btn.tag]];
    }else{
        dic = [NSMutableDictionary dictionaryWithDictionary:[arr_teizi objectAtIndex:btn.tag]];
    }
    if (btn.selected) {
        [dic setObject:@(YES) forKey:@"isFavo"];
        cell.faiour_text.textColor = [UIColor redColor];
        if (indexs == 0) {
             [arr_guan replaceObjectAtIndex:btn.tag withObject:dic];
        }
        else{
        [arr_teizi replaceObjectAtIndex:btn.tag withObject:dic];
        }
        [self favoriteUser:[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] typte:@"1"];
    }else{
        [dic setObject:@(NO) forKey:@"isFavo"];
        cell.faiour_text.textColor = [UIColor lightGrayColor];
        
        if (indexs == 0) {
            [arr_guan replaceObjectAtIndex:btn.tag withObject:dic];
        }
        else{
            [arr_teizi replaceObjectAtIndex:btn.tag withObject:dic];
        }
        
        
       // [arr_data replaceObjectAtIndex:btn.tag withObject:dic];
        [self usersfavioritesCancle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]]];
    }
}

//取消收藏成功
-(void)usersfavioritesCancle:(NSString *)fid
{
    _VApManager = [[VApiManager alloc]init];
    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
    
    UsersFavoritesCancleRequest *usersFavoritesCancleRequest = [[UsersFavoritesCancleRequest alloc] init:accessToken];
//    usersFavoritesCancleRequest.api_type = [@1 stringValue];
    usersFavoritesCancleRequest.api_fid = fid;
    //usersFavoritesCancleRequest.api_type = type;
    [_VApManager usersFavoritesCancle:usersFavoritesCancleRequest success:^(AFHTTPRequestOperation *operation, UsersFavoritesCancleResponse *response) {
        NSLog(@"取消收藏成功");
        NSLog(@"%@===",response);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}
//收藏
-(void)favoriteUser:(NSString *)fid typte:(NSString *)type
{
    _VApManager = [[VApiManager alloc]init];
    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
    
    UsersFavoritesRequest *usersFavorites = [[UsersFavoritesRequest alloc] init:accessToken];
    usersFavorites.api_fid = fid;
    usersFavorites.api_type = type;
    [_VApManager usersFavorites:usersFavorites success:^(AFHTTPRequestOperation *operation, UsersFavoritesResponse *response) {
        
        NSLog(@"收藏成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

-(void)reply:(UIButton *)btn{
    UNLOGIN_HANDLE
    
    [UIView animateWithDuration:0.2 animations:^{
        [btn setImage:[UIImage imageNamed:@"com_reply_pressed"] forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        [btn setImage:[UIImage imageNamed:@"com_reply"] forState:UIControlStateNormal];
    }];
    
    NSDictionary *dic ;
    if (indexs == 0) {
       dic = [arr_guan objectAtIndex:btn.tag];
    }else
    {
      dic = [arr_teizi objectAtIndex:btn.tag];
    }
    
    FollwerContent *follow = [[FollwerContent alloc]init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:follow];
    NSNumber *nubm = @([[dic objectForKey:@"id"] integerValue]);
    if ([dic objectForKey:@"id"]) {
        nubm = @([[dic objectForKey:@"id"] integerValue]);
    }else{
        nubm = @([[dic objectForKey:@"itemId"] integerValue]);
    }
    [[NSUserDefaults standardUserDefaults]setObject:[dic objectForKey:@"title"] forKey:@"circleTitle"];
    // [[NSUserDefaults standardUserDefaults]objectForKey:@"circleTitle"]];
    follow.num = nubm;
    [self presentViewController:nav animated:YES completion:nil];
    
    RELEASE(follow);
    RELEASE(nav);
}


-(void)share:(UIButton*)btn{
    
    NSMutableDictionary *dic = nil;
    if (indexs == 0) {
        dic = [NSMutableDictionary dictionaryWithDictionary:[arr_guan objectAtIndex:btn.tag]];
    }else{
        dic = [NSMutableDictionary dictionaryWithDictionary:[arr_teizi objectAtIndex:btn.tag]];
    }
    
    NSString *share_title = [dic objectForKey:@"title"];;
    
    NSString *imageUrl = [dic objectForKey:@"thumbnail"];
    if(imageUrl == nil){
        imageUrl = [dic objectForKey:@"headImgPath"];
    }
    NSString *share_imgeURL = imageUrl ? imageUrl :k_ShareImage;//[cellDic objectForKey:@"thumbnail"];
    NSString *share_URL = [NSString stringWithFormat:@"%@%@%@",Base_URL,user_tiezi,[dic objectForKey:@"id"]];
//    share_view.shareUrl = str;
    
    
    _VApManager = [[VApiManager alloc]init];
    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
    
    UsersInvitationDetailsRequest *usersInvitationDetailsRequest = [[UsersInvitationDetailsRequest alloc] init:accessToken];
    
    if ([dic objectForKey:@"id"]) {
        usersInvitationDetailsRequest.api_invnId = @([[dic objectForKey:@"id"] integerValue]);
    }else{
        usersInvitationDetailsRequest.api_invnId = @([[dic objectForKey:@"itemId"] integerValue]);
    }
    
    WEAK_SELF
    [_VApManager usersInvitationDetails:usersInvitationDetailsRequest success:^(AFHTTPRequestOperation *operation, UsersInvitationDetailsResponse *response) {
        
        JGShareView *shareView = [JGShareView shareViewWithTitle:share_title content:response.content imgUrlStr:share_imgeURL ulrStr:share_URL contentView:weak_self.view shareImagePath:nil];
        [shareView show];
//        [share_view setShareContent:response.content];
//        //        share_view.shareContent = [NSString stringWithFormat:@"%@",response.content];// response.content;
//        _viewforshare.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
//            share_view.frame = CGRectMake(0, __MainScreen_Height-250, __MainScreen_Width, 250);
            [btn setImage:[UIImage imageNamed:@"com_share_pressed"] forState:UIControlStateNormal];
        } completion:^(BOOL finished) {
            [btn setImage:[UIImage imageNamed:@"com_share"] forState:UIControlStateNormal];
        }];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [Util ShowAlertWithOutCancelWithTitle:@"提示" message:@"请求分享内容失败"];
    }];
    
}


//-(void)viewforshareBtn{
//    [UIView animateWithDuration:0.5 animations:^{
//        share_view.frame = CGRectMake(0, __MainScreen_Height, __MainScreen_Width, 250);
//    } completion:^(BOOL finished) {
//        _viewforshare.hidden = YES;
//    }];
//}




@end
