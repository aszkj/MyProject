//
//  SearchVC.m
//  jingGang
//
//  Created by wangying on 15/6/3.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "SearchVC.h"
#import "PublicInfo.h"
#import "SearchCell.h"
#import "userDefaultManager.h"
#import "VApiManager.h"
#import "MJRefresh.h"
#import "UIViewExt.h"
#import "UIImageView+WebCache.h"
#import "WebDayVC.h"
#import "H5page_URL.h"
#import "H5Base_url.h"
#import "FollwerContent.h"
#import "shareView.h"
#import "Util.h"
#import "GlobeObject.h"
#import "JGShareView.h"
#import "communitCardTableViewCell.h"
#import "NodataShowView.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"

@interface SearchVC ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    UISearchBar *search;
    UITableView *_tableView;
    UIView * topView;
    VApiManager   *_VApManager;
    NSMutableArray *arr_data;
    NSInteger pageNum;
    NSString *_title;
    UIView *_viewforshare;
    shareView *share_view;
}

@property (nonatomic, strong) NodataShowView *promptView;

@end

NSString *const communitySearchTableViewCell = @"communitCardTableViewCell";

@implementation SearchVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    topView.hidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    self.tabBarController.tabBar.hidden = NO;
    topView.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
  
    arr_data = [[NSMutableArray alloc]init];
    topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __MainScreen_Width, __Other_Height+1)];
    topView.backgroundColor = [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1];
    [self.navigationController.view addSubview:topView];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(leftClick) target:self];
    self.view.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1];
    UIButton *left_b =[[UIButton alloc]initWithFrame:CGRectMake(20, 25, 35, 25)];
    [left_b setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    
    [left_b addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    

    [topView addSubview:left_b];
    
    
    UILabel *l_bt =[[UILabel alloc]initWithFrame:CGRectMake(__MainScreen_Width/2 - 40, 20, 80, 40)];
    l_bt.text = @"搜索帖子";
    l_bt.font = [UIFont systemFontOfSize:18];
    l_bt.textColor =[ UIColor whiteColor];
    [topView addSubview:l_bt];
    RELEASE(l_bt);
    
    [self creatSearchBar];
    [self creatTableView];
    
    
    
    _viewforshare = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __MainScreen_Width, __MainScreen_Height)];
    _viewforshare.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
    UIButton * btn = [[UIButton alloc]initWithFrame:_viewforshare.frame];
    [btn addTarget:self action:@selector(viewforshareBtn) forControlEvents:UIControlEventTouchUpInside];
    [_viewforshare addSubview:btn];

    
    share_view = [shareView instance];
    share_view.frame = CGRectMake(0, __MainScreen_Height, __MainScreen_Width, 200);
    [_viewforshare addSubview:share_view];
    [share_view.cacel_btn setBackgroundImage:[UIImage imageNamed:@"com_cancel_pressed"] forState:UIControlStateHighlighted];
//    [share_view.cacel_btn addTarget:self action:@selector(viewforshareBtn) forControlEvents:UIControlEventTouchUpInside];
#warning --修改block里面的强引用----
    __block typeof(self) bself = self;
    share_view.cancelShareBlock = ^(){
        [bself viewforshareBtn];
    };
    //    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_viewforshare];
    [self.view bringSubviewToFront:_viewforshare];
    _viewforshare.hidden = YES;
}


-(void)creatSearchBar
{
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 64, __MainScreen_Width, 58)];
    view.backgroundColor = [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1];
    [self.view addSubview:view];
   
    search = [[UISearchBar alloc]initWithFrame:CGRectMake(20, 7, __MainScreen_Width - 40, 36)];
    search.barTintColor = [UIColor whiteColor];
    search.placeholder = @"输入帖子关键字";
    search.delegate = self;

    [view addSubview:search];
    
    RELEASE(view);
}
-(void)dosomeRequest
{
    _VApManager = [[VApiManager alloc]init];
    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
    
    UsersInvitationSearchRequest *usersInvitationSearchRequest = [[UsersInvitationSearchRequest alloc] init:accessToken];
    usersInvitationSearchRequest.api_pageNum = @(pageNum);
    usersInvitationSearchRequest.api_pageSize = @(10);
    usersInvitationSearchRequest.api_title = _title;
    [_VApManager usersInvitationSearch:usersInvitationSearchRequest success:^(AFHTTPRequestOperation *operation, UsersInvitationSearchResponse *response) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"搜索成功---%@",dict);
        NSArray *arr = [dict objectForKey:@"invitation"];
        if (pageNum == 0) {
            [arr_data removeAllObjects];
        }else{
            [_tableView footerEndRefreshing];
        }
        for (int i =0; i<arr.count; i++) {
            [arr_data addObject:arr[i]];
        }
        if (arr_data.count < [[dict objectForKey:@"total"] integerValue]) {
            _tableView.footerHidden = NO;
        }else{
            _tableView.footerHidden = YES;
        }
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"搜索失败");
    }];
}

-(void)more{
    pageNum++;
    [self dosomeRequest];
}

-(void)creatTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 130, __MainScreen_Width, __MainScreen_Height-130)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = communitCellRowHeight;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [_tableView registerNib:[UINib nibWithNibName:@"communitCardTableViewCell" bundle:nil] forCellReuseIdentifier:communitySearchTableViewCell];
    [_tableView registerNib:[UINib nibWithNibName:@"SearchCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    WEAK_SELF
    [_tableView addFooterWithCallback:^{
        [weak_self more];
    }];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (arr_data.count == 0) {
        [NodataShowView showInContentView:tableView withReloadBlock:^{
            [tableView reloadData];
        } requestResultType:NoDataType];
    }
    else
    {
        [NodataShowView hideInContentView:tableView];
    }
    return [arr_data count];
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
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAK_SELF
    communitCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:communitySearchTableViewCell];
    NSDictionary *dic = [arr_data objectAtIndex:indexPath.row];
    [cell customCellWithDict:dic withCircle:YES withTimePast:@"发"];
    cell.shareBlock= ^(){
        [weak_self shareWithIndexPath:indexPath];
    };
    cell.fallowBlock = ^(){
        [weak_self replyWithDict:dic];
    };
    cell.numWithBlock = ^(NSDictionary *dict){
        [arr_data removeObjectAtIndex:indexPath.row];
        [arr_data insertObject:dict atIndex:indexPath.row];
        [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

    };
    cell.likeWithBlock = ^(NSDictionary *dict){
        [arr_data removeObjectAtIndex:indexPath.row];
        [arr_data insertObject:dict atIndex:indexPath.row];
        [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
    };
    return cell;
#if 0
    SearchCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dic = [arr_data objectAtIndex:indexPath.row];
    cell.titleText.text = [dic objectForKey:@"title"];
    cell.nameText.text = [dic objectForKey:@"userName"];
    [cell.follow_text setTitle:[NSString stringWithFormat:@"跟帖(%@)",[dic objectForKey:@"replyCount"]] forState:UIControlStateNormal];
    cell.timeText.text = [NSString stringWithFormat:@"发布于%@",[dic objectForKey:@"replyTime"]];
    cell.zan_text.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"praiseCount"]];
    CGSize titleSize = [cell.nameText.text sizeWithFont:cell.nameText.font constrainedToSize:CGSizeMake(MAXFLOAT, cell.nameText.height)];
    [cell.nameText setWidth:titleSize.width];
    [cell.timeText setLeft:cell.nameText.right];
    NSString *url = [NSString stringWithFormat:@"%@_%ix%i",[dic objectForKey:@"headImgPath"],(int)cell.iconImg.frame.size.width*2,(int)cell.iconImg.frame.size.height*2];
    [cell.iconImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"home_head"]];
    
    
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
    return cell;
#endif
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WebDayVC *weh = [[WebDayVC alloc]init];
    
    NSDictionary * dic = [arr_data objectAtIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults]setObject:[dic objectForKey:@"title"] forKey:@"circleTitle"];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",Base_URL,user_tiezi,[dic objectForKey:@"id"]];
    NSLog(@"%@",url);
    weh.strUrl = url;
    weh.ind = 1;
    weh.dic = dic;
    weh.backBlock = ^(){
         [self dosomeRequest];
    };
    int type = [[dic objectForKey:@"adType"] intValue];
    if (type == 1) {
        weh.dic = dic;
    }
    UINavigationController *nas = [[UINavigationController alloc]initWithRootViewController:weh];
    nas.navigationBar.barTintColor = [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1];
    [self presentViewController:nas animated:YES completion:nil];
    
    RELEASE(weh);
    RELEASE(nas);
}

-(void)btnClicks
{
    NSLog(@"4444444444");
}
-(void)leftClick
{
    if (self.navigationController.viewControllers.count > 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    //[self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.view endEditing:YES];
    _title = searchBar.text;
    pageNum = 0;
    [self dosomeRequest];
}



#pragma mark - 取消点赞
-(void)dissmissPraise:(NSDictionary *)dict withIndexPath:(NSIndexPath *)index
{
    _VApManager = [[VApiManager alloc]init];
    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
    UsersCanclePraiseRequest *usersCanclePraiseRequest = [[UsersCanclePraiseRequest alloc] init:accessToken];
    usersCanclePraiseRequest.api_fid = dict[@"id"];
    [_VApManager usersCanclePraise:usersCanclePraiseRequest success:^(AFHTTPRequestOperation *operation, UsersCanclePraiseResponse *response) {
        NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc] initWithDictionary:dict];
        [mutableDict setObject:@(0) forKey:@"isPraise"];
        [mutableDict setObject:@([dict[@"praiseCount"] intValue] - 1) forKey:@"praiseCount"];
        [arr_data removeObjectAtIndex:index.row];
        [arr_data insertObject:mutableDict atIndex:index.row];
        [_tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
        NSLog(@"取消点赞成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"取消点赞失败");
    }];
}

#pragma mark - 点赞
-(void)praiseClickChange:(NSDictionary *)dict withIndexPath:(NSIndexPath *)index
{
    _VApManager = [[VApiManager alloc]init];
    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
    
    UsersPraiseRequest *usersPraiseRequest = [[UsersPraiseRequest alloc] init:accessToken];
    
    usersPraiseRequest.api_fid = dict[@"id"];
    WEAK_SELF
    [_VApManager usersPraise:usersPraiseRequest success:^(AFHTTPRequestOperation *operation, UsersPraiseResponse *response) {
        NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc] initWithDictionary:dict];
        [mutableDict setObject:@(1) forKey:@"isPraise"];
        [mutableDict setObject:@([dict[@"praiseCount"] intValue] + 1) forKey:@"praiseCount"];
        [arr_data removeObjectAtIndex:index.row];
        [arr_data insertObject:mutableDict atIndex:index.row];
        [_tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
        NSLog(@"---点赞成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"---%@",error);
    }];
}

//-(void)faviourClick:(UIButton *)btn{
//    btn.selected = !btn.selected;
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:btn.tag inSection:0];
//    SearchCell *cell = (SearchCell *)[_tableView cellForRowAtIndexPath:indexPath];
//    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[arr_data objectAtIndex:btn.tag]];
//    if (btn.selected) {
//        [dic setObject:@(YES) forKey:@"isFavo"];
//        cell.faiour_text.textColor = [UIColor redColor];
//        [arr_data replaceObjectAtIndex:btn.tag withObject:dic];
//        [self favoriteUser:[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] typte:@"1"];
//    }else{
//        [dic setObject:@(NO) forKey:@"isFavo"];
//        cell.faiour_text.textColor = [UIColor lightGrayColor];
//        [arr_data replaceObjectAtIndex:btn.tag withObject:dic];
//        [self usersfavioritesCancle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]]];
//    }
//}

#pragma mark - 取消收藏成功
-(void)usersfavioritesCancle:(NSDictionary *)dict withIndexPath:(NSIndexPath *)index
{
    _VApManager = [[VApiManager alloc]init];
    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
    
    UsersFavoritesCancleRequest *usersFavoritesCancleRequest = [[UsersFavoritesCancleRequest alloc] init:accessToken];

    usersFavoritesCancleRequest.api_fid = dict[@"id"];

    [_VApManager usersFavoritesCancle:usersFavoritesCancleRequest success:^(AFHTTPRequestOperation *operation, UsersFavoritesCancleResponse *response) {
        NSLog(@"取消收藏成功");
        NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc] initWithDictionary:dict];
        [mutableDict setObject:@(0) forKey:@"isFavo"];
        [arr_data removeObjectAtIndex:index.row];
        [arr_data insertObject:mutableDict atIndex:index.row];
        [_tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}
#pragma mark - 收藏
-(void)favoriteUser:(NSDictionary *)dict withIndexPath:(NSIndexPath *)index
{
    _VApManager = [[VApiManager alloc]init];
    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
    
    UsersFavoritesRequest *usersFavorites = [[UsersFavoritesRequest alloc] init:accessToken];
    
    usersFavorites.api_fid = dict[@"id"];
    usersFavorites.api_type = @"1";
    [_VApManager usersFavorites:usersFavorites success:^(AFHTTPRequestOperation *operation, UsersFavoritesResponse *response) {
        NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc] initWithDictionary:dict];
        [mutableDict setObject:@(1) forKey:@"isFavo"];
        [arr_data removeObjectAtIndex:index.row];
        [arr_data insertObject:mutableDict atIndex:index.row];
        [_tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
        NSLog(@"收藏成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

-(void)replyWithDict:(NSDictionary *)dic{
    UNLOGIN_HANDLE
    [[NSUserDefaults standardUserDefaults]setObject:dic[@"title"]  forKey:@"circleTitle"];
    FollwerContent *follow = [[FollwerContent alloc]init];
    NSNumber *nubm = dic[@"id"];
    
    follow.num = nubm;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:follow];
    [self presentViewController:nav animated:YES completion:nil];
#if 0
    [UIView animateWithDuration:0.2 animations:^{
        [btn setImage:[UIImage imageNamed:@"com_reply_pressed"] forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        [btn setImage:[UIImage imageNamed:@"com_reply"] forState:UIControlStateNormal];
    }];
    NSDictionary *dic = [arr_data objectAtIndex:btn.tag];
    FollwerContent *follow = [[FollwerContent alloc]init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:follow];
     [[NSUserDefaults standardUserDefaults]setObject:[dic objectForKey:@"title"] forKey:@"circleTitle"];
    NSNumber *nubm = [dic objectForKey:@"id"];
    follow.num = nubm;
    [self presentViewController:nav animated:YES completion:nil];
    RELEASE(follow);
    RELEASE(nav);
#endif
}


-(void)shareWithIndexPath:(NSIndexPath *)index{
    
    NSMutableDictionary *cellDic = arr_data[index.row];// [NSMutableDictionary dictionaryWithDictionary:[arr_data objectAtIndex:btn.tag]];
    NSString *share_title = [cellDic objectForKey:@"title"];;
    
    NSString *imageUrl = [cellDic objectForKey:@"thumbnail"];
    if(imageUrl == nil){
        imageUrl = [cellDic objectForKey:@"headImgPath"];
    }
    share_view.shareHeadImgUrl = imageUrl;//[cellDic objectForKey:@"thumbnail"];
    NSString *str = [NSString stringWithFormat:@"%@%@%@",Base_URL,user_tiezi,[cellDic objectForKey:@"id"]];
    share_view.shareUrl = str;
    
    WEAK_SELF
    _VApManager = [[VApiManager alloc]init];
    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
    
    UsersInvitationDetailsRequest *usersInvitationDetailsRequest = [[UsersInvitationDetailsRequest alloc] init:accessToken];
    
    usersInvitationDetailsRequest.api_invnId = [cellDic objectForKey:@"id"];
    
    [_VApManager usersInvitationDetails:usersInvitationDetailsRequest success:^(AFHTTPRequestOperation *operation, UsersInvitationDetailsResponse *response) {
        
        JGShareView *shareView = [JGShareView shareViewWithTitle:share_title content:response.content imgUrlStr:imageUrl ulrStr:str contentView:weak_self.view shareImagePath:nil];
        [shareView show];
        
        communitCardTableViewCell *cell = [_tableView cellForRowAtIndexPath:index];
        cell.isShare = YES;
#if 0
        [share_view setShareContent:response.content];
        //        share_view.shareContent = [NSString stringWithFormat:@"%@",response.content];// response.content;
        _viewforshare.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            share_view.frame = CGRectMake(0, __MainScreen_Height-200, __MainScreen_Width, 200);
            [btn setImage:[UIImage imageNamed:@"com_share_pressed"] forState:UIControlStateNormal];
        } completion:^(BOOL finished) {
            [btn setImage:[UIImage imageNamed:@"com_share"] forState:UIControlStateNormal];
        }];
#endif
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [Util ShowAlertWithOutCancelWithTitle:@"提示" message:@"请求分享内容失败"];
    }];
}

-(void)viewforshareBtn{
    [UIView animateWithDuration:0.5 animations:^{
        share_view.frame = CGRectMake(0, __MainScreen_Height, __MainScreen_Width, 200);
    } completion:^(BOOL finished) {
        _viewforshare.hidden = YES;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
