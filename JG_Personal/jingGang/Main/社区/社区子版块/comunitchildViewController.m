//
//  comunitchildViewController.m
//  jingGang
//
//  Created by yi jiehuang on 15/5/26.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "comunitchildViewController.h"
#import "AppDelegate.h"
#import "PublicInfo.h"
#import "comuChildTableViewCell.h"
#import "communitTableViewCell.h"
#import "communitBtn.h"
#import "shareView.h"
#import "JGShareView.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "FollwerContent.h"
#import "WebDayVC.h"
#import "H5Base_url.h"
#import "PostCircleController.h"
#import "VApiManager+Aspects.h"
#import "Util.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "GFtieziViewController.h"

#import "communitCardTableViewCell.h"
#import "mainPublicTableViewHeader.h"


@interface comunitchildViewController ()
{
    BOOL _isShare;
    VApiManager       *_VApManager;
    NSInteger _isFinish;

    int pageNum;
    
    UILabel *titleLabel;
    NSString *jtitle;
    UILabel * num_lab;
    UILabel * dis_lab;
    
    /**
     *  官方数据
     */
    NSMutableArray *tieziGf;
    UIImageView *navBarHairlineImageView;
    BOOL _translucent;
    UIColor *_barTintColor;
}


@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *news_array;

@end
NSString *const communityChildTableViewCell = @"communityChildTableViewCell";
@implementation comunitchildViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.news_array removeAllObjects];
    [tieziGf removeAllObjects];
    pageNum = 1;
    _isFinish = 0;
    [self doSomeRequesttype:@2];
    [self doSomeRequesttype:@1];
    
    
    
    navBarHairlineImageView.hidden = YES;
//    _translucent = self.navigationController.navigationBar.translucent;
//    _barTintColor = self.navigationController.navigationBar.barTintColor;
    
    self.navigationController.navigationBar.barTintColor = status_color;
    self.navigationController.navigationBar.translucent = NO;
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
//    self.navigationController.navigationBar.barTintColor = _barTintColor;
    navBarHairlineImageView.hidden = NO;
}

#pragma mark - 创建tableView头视图
- (UIView *)getHeaderView
{
    float midel_view_h  = 160;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, midel_view_h)];
    headerView.backgroundColor = background_Color;
    
    
    UIView * midel_view = [[UIView alloc]init];
    midel_view.frame = CGRectMake(0, 0, __MainScreen_Width, midel_view_h - 10);
    midel_view.backgroundColor = status_color;//[UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1];
    [headerView addSubview:midel_view];
    
    
    UIImageView * head_img = [[UIImageView alloc]init];
    head_img.image = [UIImage imageNamed:_head_img_str];
    head_img.frame = CGRectMake(0, 0, 55, 55);
    head_img.layer.cornerRadius = 55/2;
    head_img.clipsToBounds = YES;
    head_img.center = CGPointMake(self.view.center.x, midel_view_h/2-40);
    [midel_view addSubview:head_img];
    
    
    num_lab = [[UILabel alloc]init];
    num_lab.frame = CGRectMake(0, head_img.frame.origin.y+head_img.frame.size.height+10, __MainScreen_Width, 15);
    num_lab.font = [UIFont systemFontOfSize:13];
    num_lab.textAlignment = NSTextAlignmentCenter;
    num_lab.textColor = [UIColor whiteColor];
    [midel_view addSubview:num_lab];
    
    dis_lab = [[UILabel alloc]init];
    dis_lab.frame = CGRectMake(30, num_lab.frame.origin.y+num_lab.frame.size.height-5, __MainScreen_Width-60, 70);
    dis_lab.font = [UIFont systemFontOfSize:14];
    dis_lab.numberOfLines = 3;
    dis_lab.textAlignment = NSTextAlignmentCenter;
    dis_lab.textColor = [UIColor whiteColor];
    [midel_view addSubview:dis_lab];
    return headerView;
}
#pragma mark - 创建TableView
-(UITableView *)myTableView
{
    if (_myTableView == nil) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, __MainScreen_Width, __MainScreen_Height - 64) style:UITableViewStyleGrouped];
        [_myTableView registerNib:[UINib nibWithNibName:@"communitCardTableViewCell" bundle:nil] forCellReuseIdentifier:communityChildTableViewCell];
        _myTableView.rowHeight = communitCellRowHeight;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.tableFooterView = [UIView new];
        [self.view addSubview:_myTableView];
    }
    return _myTableView;
}
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.news_array = [[NSMutableArray alloc]init];
    tieziGf = [[NSMutableArray alloc]init];
    _VApManager = [[VApiManager alloc]init];
    
    
    self.view.backgroundColor = background_Color;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(backToMain) target:self];
    //右上角的发帖子button
    UIButton *rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(0.0f, 0, 40.0f, 40.0f)];
    [rightBtn setImage:[UIImage imageNamed:@"com_new_pressed"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(goToPostTiezi) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarbuttonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
//    self.navigationItem.rightBarButtonItem = rightButton;
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem barButtonItemSpace:-12],rightBarbuttonItem];
    [Util setNavTitleWithTitle:self.JGTitle ofVC:self];
    
    
    //隐藏控制器下划线
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    navBarHairlineImageView = [self findHairlineImageViewUnder:navigationBar];
    
    
    [self updateCircleInfo];
    
    WEAK_SELF
    self.myTableView.tableHeaderView = [self getHeaderView];
    [_myTableView addFooterWithCallback:^{
        _isFinish = 1;
        pageNum ++;
        [weak_self doSomeRequesttype:@1];
    }];
    
    [_myTableView addHeaderWithCallback:^{
        _isFinish = 0;
        [weak_self updateCircleInfo];
        [weak_self.news_array removeAllObjects];
        [tieziGf removeAllObjects];
        pageNum = 1;
        [weak_self doSomeRequesttype:@2];
        [weak_self doSomeRequesttype:@1];
    }];
}

-(void)updateCircleInfo
{
    _VApManager = [[VApiManager alloc]init];
    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
    UsersCircleQueryRequest *usersCircleQueryRequest = [[UsersCircleQueryRequest alloc] init:accessToken];
    usersCircleQueryRequest.api_circleId = @(self.cycleId);
    [_VApManager usersCircleQuery:usersCircleQueryRequest success:^(AFHTTPRequestOperation *operation, UsersCircleQueryResponse *response) {
        NSDictionary *dic = (NSDictionary *)response.circleInfo;
        num_lab.text = [NSString stringWithFormat:@"帖子数:%@",[dic objectForKey:@"invitationCount"]];
        jtitle = [NSString stringWithFormat:@"%@圈",[dic objectForKey:@"title"]];
        dis_lab.text = [dic objectForKey:@"content"];
        NSLog(@"社区介绍－－－－－－%@  圈子名称 －－－－－ %@",dis_lab.text,titleLabel.text);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}


-(void)goToPostTiezi
{
    UNLOGIN_HANDLE
    PostCircleController *publish = [[PostCircleController alloc] initWithNibName:@"PostCircleController" bundle:nil];
    publish.circleId = self.cycleId;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:publish];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        NSInteger rows = tieziGf.count;
        if (rows > 2) {
            rows = 2;
        }
        return rows ;
    }else {
        return self.news_array.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAK_SELF
    communitCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:communityChildTableViewCell];
    NSDictionary *dict;
    if (indexPath.section == 0 && indexPath.row < tieziGf.count ) {//官方的cell
        dict = tieziGf[indexPath.row];
        [cell customCellWithDict:dict withCircle:NO withTimePast:@"在"];
    }
    else if (indexPath.row < self.news_array.count)  //用户的cell
    {
        dict = self.news_array[indexPath.row];
        [cell customCellWithDict:dict withCircle:YES withTimePast:@"发"];
    }
    
    cell.numWithBlock = ^(NSDictionary *dict){
        if (indexPath.section == 0) {
            [tieziGf removeObjectAtIndex:indexPath.row];
            [tieziGf insertObject:dict atIndex:indexPath.row];
        }
        else
        {
            [weak_self.news_array removeObjectAtIndex:indexPath.row];
            [weak_self.news_array insertObject:dict atIndex:indexPath.row];
        }
        
        [_myTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    };
    cell.likeWithBlock = ^(NSDictionary *dict){
        if (indexPath.section == 0) {
            [tieziGf removeObjectAtIndex:indexPath.row];
            [tieziGf insertObject:dict atIndex:indexPath.row];
        }
        else
        {
            [weak_self.news_array removeObjectAtIndex:indexPath.row];
            [weak_self.news_array insertObject:dict atIndex:indexPath.row];
        }
        
        [_myTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    };
    cell.shareBlock = ^(){
        
        [weak_self shareWithIndexPath:indexPath];
    };
    cell.fallowBlock = ^(){
        [weak_self fallowBack:dict];
    };
    return cell;
    


}
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if(indexPath.section == 1)//帖子
    {
        
        if (self.news_array.count>0) {
            
            WebDayVC *weh = [[WebDayVC alloc]init];
            
            NSDictionary * dic = [self.news_array objectAtIndex:indexPath.row];
            [[NSUserDefaults standardUserDefaults]setObject:[dic objectForKey:@"title"] forKey:@"circleTitle"];
            NSString *url = [NSString stringWithFormat:@"%@%@%@",Base_URL,user_tiezi,[dic objectForKey:@"id"]];
            NSLog(@"%@",url);
            weh.strUrl = url;
            weh.ind = 1;
            weh.dic = [self.news_array objectAtIndex:indexPath.row];
//            weh.backBlock = ^(){
//                [self doSomeRequesttype:@1];
//            };
            
            UINavigationController *nas = [[UINavigationController alloc]initWithRootViewController:weh];
            nas.navigationBar.barTintColor = [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1];
            [self presentViewController:nas animated:YES completion:nil];
        }
    }
    else
    {
        
        NSLog(@"444444444");
        if (tieziGf.count >0) {
            
            NSDictionary *srf = tieziGf[indexPath.row];
            [[NSUserDefaults standardUserDefaults]setObject:[srf objectForKey:@"title"] forKey:@"circleTitle"];
            NSString *str = [NSString stringWithFormat:@"%@%@%@",Base_URL,user_tiezi,[srf objectForKey:@"id"]];
            NSLog(@"官方url ======%@",str);
            NSLog(@"%@",str);
            WebDayVC *web = [[WebDayVC alloc]init];
            web.strUrl = str;
            web.ind = 5;
            web.dic = [tieziGf objectAtIndex:indexPath.row];
//            web.backBlock = ^(){
//                [self doSomeRequesttype:@2];
//            };
            UINavigationController *nas = [[UINavigationController alloc]initWithRootViewController:web];
            nas.navigationBar.barTintColor = [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1];
            [self presentViewController:nas animated:YES completion:nil];
        }
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return __table_section_h;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    mainPublicTableViewHeader *headerView = [[NSBundle mainBundle] loadNibNamed:@"mainPublicTableViewHeader" owner:self options:nil][0];
    headerView.statusImageView.hidden = YES;
    headerView.statusLabel.hidden = YES;
    headerView.titleNameLabel.textColor = [UIColor whiteColor];
    if (section == 0) {
        headerView.titleImageView.image = [UIImage imageNamed:@"com_off"];
        headerView.titleNameLabel.text = @"官方帖子";
        headerView.backgroundColor = [UIColor colorWithRed:255.0/255 green:146.0/225 blue:65.0/255 alpha:1];
        [headerView.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [headerView.rightBtn setTitle:@"更多>" forState:UIControlStateNormal];
        [headerView.rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        headerView.titleImageView.image = [UIImage imageNamed:@"com_per"];
        headerView.titleNameLabel.text = @"用户帖子";
        headerView.backgroundColor = COMMONTOPICCOLOR;
    }
    
    
    return headerView;

}

-(void)viewDidLayoutSubviews
{
    if ([_myTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_myTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([_myTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_myTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
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
#pragma mark- 更多 ifs
- (void)rightBtnClick:(UIButton *)btn
{
    GFtieziViewController *gftieziListView = [[GFtieziViewController alloc]init];
    gftieziListView.circleId = self.cycleId;

    gftieziListView.titleName = self.JGTitle;
//    gftieziListView.commentBlcock = ^(BOOL success){
//        if (success) {
//            pageNum = 1;
//            [tieziGf removeAllObjects];
//            [self doSomeRequesttype:@2];
//        }
//    };
    [Util preSentVCWithRootVC:gftieziListView withPrensentVC:self];
      NSLog(@"====");
}



- (void) backToMain
{

    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark- 请求官方帖子和用户帖子
/**
 *  请求官方帖子和用户帖子
 *
 *  @param nuser 1为用户帖子，2，为官方帖子
 */
-(void)doSomeRequesttype:(NSNumber *)nuser
{
    UsersCircleInvitationListRequest *userCirCleInvitationList = [[UsersCircleInvitationListRequest alloc] init:GetToken];
    userCirCleInvitationList.api_circleId = @(_cycleId);
    userCirCleInvitationList.api_invitationType = nuser;
    if ([nuser intValue] == 1) {
        userCirCleInvitationList.api_pageNum = @(pageNum);
    }
    else
    {
        userCirCleInvitationList.api_pageNum = @1;
    }
   
    userCirCleInvitationList.api_pageSize = @5;
    
    WEAK_SELF
    [_VApManager usersCircleInvitationList:userCirCleInvitationList success:^(AFHTTPRequestOperation *operation, UsersCircleInvitationListResponse *response) {
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        
        NSArray * array = [dict objectForKey:@"circle"];
        
        if ([nuser intValue] == 1) {
            [weak_self.news_array addObjectsFromArray:array];
            
        }else{

            tieziGf = [array mutableCopy];
        }
        _isFinish ++;
        if (_isFinish == 2)
        {
             [_myTableView reloadData];
        }
        if ([nuser integerValue] == 1) {
            [weak_self.myTableView headerEndRefreshing];
            [weak_self.myTableView footerEndRefreshing];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败");
        if ([nuser integerValue] == 1) {
            [weak_self.myTableView headerEndRefreshing];
            [weak_self.myTableView footerEndRefreshing];
        }
    }];
}


#pragma mark - 跟帖
-(void)fallowBack:(NSDictionary *)dic
{
    UNLOGIN_HANDLE
    [[NSUserDefaults standardUserDefaults]setObject:dic[@"title"]  forKey:@"circleTitle"];
    FollwerContent *follow = [[FollwerContent alloc]init];
    NSNumber *nubm = dic[@"id"];
    
    follow.num = nubm;
    
    follow.commentBlcock = ^(BOOL success){
        if (success) {
            // pageNum = 1;
            [self.news_array removeAllObjects];
        }
    };
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:follow];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - 分享
-(void)shareWithIndexPath:(NSIndexPath *)index{
    if (_isShare) {
        return;
    }
    _isShare = YES;
    
    NSDictionary *dict;
    if (index.section == 0) {
        dict = tieziGf[index.row];
    }
    else
    {
        dict = self.news_array[index.row];
    }
    NSString *share_title = dict[@"title"];//[cellDic objectForKey:@"title"];;
    
    NSString *imageUrl = [dict objectForKey:@"thumbnail"];
    if(imageUrl == nil){
        imageUrl = [dict objectForKey:@"headImgPath"];
    }
    NSString *share_imagerUrl = imageUrl;
    NSString *share_URL = [NSString stringWithFormat:@"%@%@%@",Base_URL,user_tiezi,[dict objectForKey:@"id"]];
    
    UsersInvitationDetailsRequest *usersInvitationDetailsRequest = [[UsersInvitationDetailsRequest alloc] init:GetToken];
    
    usersInvitationDetailsRequest.api_invnId = [dict objectForKey:@"id"];
    WEAK_SELF
    [_VApManager usersInvitationDetails:usersInvitationDetailsRequest success:^(AFHTTPRequestOperation *operation, UsersInvitationDetailsResponse *response) {
        JGShareView *shareView = [JGShareView shareViewWithTitle:share_title content:response.content imgUrlStr:share_imagerUrl ulrStr:share_URL contentView:weak_self.view shareImagePath:nil];
        [shareView show];
        shareView.hiddenBlock = ^(){
            _isShare = NO;
        };
        communitCardTableViewCell *cell = [_myTableView cellForRowAtIndexPath:index];
        cell.isShare = YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _isShare = NO;
        [Util ShowAlertWithOutCancelWithTitle:@"提示" message:@"请求分享内容失败"];
    }];
    
}

@end
