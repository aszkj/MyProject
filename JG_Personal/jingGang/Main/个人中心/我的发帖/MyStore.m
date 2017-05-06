//
//  MyStore.m
//  jingGang
//
//  Created by wangying on 15/6/5.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "MyStore.h"
#import "PublicInfo.h"
#import "FaviousCell.h"
#import "MyStoreCell.h"
#import "SearchCell.h"
#import "AppDelegate.h"
#import "VApiManager.h"
#import "UIImageView+AFNetworking.h"
#import "WebDayVC.h"
#import "H5Base_url.h"
#import "shareView.h"
#import "comuChildTableViewCell.h"
#import "communitTableViewCell.h"
#import "UIViewExt.h"
#import "FollwerContent.h"
#import "Util.h"
#import "communitBtn.h"
#import "MJRefresh.h"

@interface MyStore ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSInteger text;
    VApiManager *_VApManager;
    NSMutableArray *arr_data;
    
    NSMutableArray    *_share_lab_arr,*_falow_lab_arr,*_num_lab_arr,*_like_lab_arr;//存放点赞lab等的数组
    NSMutableArray    *_share_btn_arr;//分享按钮数组
   // NSMutableArray *
    
    
    UIView *view ;
    UIImageView *img;
    
    UIView *_viewforshare;
    shareView *share_view;

    
    

    int pageNum;

}
@end

@implementation MyStore
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
  self.view.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    text = 1;
    
    arr_data = [[NSMutableArray alloc]init];
    UIButton *btn_bg =[[UIButton alloc]initWithFrame:CGRectMake(10, 7, 30, 25)];
    [btn_bg setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    //增加好点的返回键
    [Util makeWellClickBGBtnAtNavBar:self.navigationController.navigationBar withBtnSize:60 onResponseMethodStr:@"BtnCLickBar" isLeftItem:YES inResponseObject:self];
    [btn_bg addTarget:self action:@selector(BtnCLickBar) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar_btn = [[UIBarButtonItem alloc]initWithCustomView:btn_bg];
    self.navigationItem.leftBarButtonItem = bar_btn;
    RELEASE(bar_btn);
    
    UILabel *l_btn = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    l_btn.text = @"我发的帖子";
    l_btn.font = [UIFont systemFontOfSize:18];
    l_btn.textColor = [UIColor whiteColor];
    
    self.navigationItem.titleView = l_btn;

    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    BOOL isNetWork =  [app connectedToNetwork];
   
    if (!isNetWork) {
        
        CGFloat width = __MainScreen_Width/2-60;
        CGFloat height = __MainScreen_Height/2 - 70;
        UIView *viewss =[[UIView alloc]initWithFrame:CGRectMake(width, height, 120, 150)];
        [self.view addSubview:viewss];
        UILabel *l_ss = [[UILabel alloc]initWithFrame:CGRectMake(5, 70, viewss.frame.size.width, 30)];
        
        UILabel *l_t = [[UILabel alloc]initWithFrame:CGRectMake(0, 90, viewss.frame.size.width, 60)];
        
        l_ss.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        l_t.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        l_t.text = @"请检查您的网络设置或者点击刷新重试";
        
        [viewss addSubview:l_t];
        l_t.font = [UIFont systemFontOfSize:13];
        l_t.numberOfLines = 2;
        [viewss addSubview:l_ss];
        UIImageView *imgss;
        imgss = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"blank_wifi"]];
        l_ss.text = @"网络连接失败";
       // l_ss.font = [UIFont systemFontOfSize:16];
        imgss.frame = CGRectMake(20, 0, 60, 60);
        [viewss addSubview:imgss];
        
       
        RELEASE(imgss);
    }
    else {
        
        CGFloat width = __MainScreen_Width/2-60;
        view =[[UIView alloc]initWithFrame:CGRectMake(width, 150, 120, 100)];
        view.hidden = YES;
        UILabel *l_ss = [[UILabel alloc]initWithFrame:CGRectMake(0, 70, view.frame.size.width, 30)];
             l_ss.text = @"您还没有发过帖子";
             l_ss.font = [UIFont systemFontOfSize:16];
        l_ss.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        [view addSubview:l_ss];
        RELEASE(l_ss);
        [self.view addSubview:view];
        [view addSubview:img];
        img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"blank_post"]];
              img.frame = CGRectMake(20, 0, 60, 60);
    }
    [self creatTableView];
     pageNum = 1;
    [self dosomeRequest];
   
    

    WEAK_SELF
    [_tableView addFooterWithCallback:^{
//        pageNum++;
        [weak_self dosomeRequest];
    }];
    

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
    share_view.cancelShareBlock = ^(){
        [self viewforshareBtn];
    };
    //    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_viewforshare];
    [self.view bringSubviewToFront:_viewforshare];
    _viewforshare.hidden = YES;
    
}
-(void)dosomeRequest
{
    _VApManager = [[VApiManager alloc]init];
    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
    
    UsersMyselfInvitationListRequest *usersMyselfInvitationListRequest = [[UsersMyselfInvitationListRequest alloc] init:accessToken];
    usersMyselfInvitationListRequest.api_pageNum = @(pageNum);
    usersMyselfInvitationListRequest.api_pageSize = @5;
    
     [_VApManager usersMyselfInvitationList:usersMyselfInvitationListRequest success:^(AFHTTPRequestOperation *operation, UsersMyselfInvitationListResponse *response) {
        
        
        NSLog(@"查询用户发的帖子成功");
        
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"dict === %@",dict);
        
         NSArray *arr = [dict objectForKey:@"invitations"];
        
         if (arr.count == 0 && pageNum == 1) {
            
             view.hidden =  NO;
             [self.view bringSubviewToFront:view];
         }else {
             view.hidden = YES;
             for (int i =0; i<arr.count; i++) {
                 [arr_data addObject:arr[i]];
             }
             [_tableView reloadData];
             [_tableView footerEndRefreshing];
             pageNum ++;
         }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_tableView footerEndRefreshing];
        NSLog(@"查询用户发的帖子失败");
    }];
}
-(void)BtnCLickBar
{
    if (self.cent == 9) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)creatTableView
{
  
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,__Other_Height, __MainScreen_Width, __MainScreen_Height-__Other_Height)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"SearchCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [_tableView registerNib:[UINib nibWithNibName:@"comuChildTableViewCell" bundle:nil] forCellReuseIdentifier:@"myCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"communitTableViewCell" bundle:nil] forCellReuseIdentifier:@"yuanCell"];
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.cent == 9) {
       return arr_data.count;
    }
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cent == 9) {
        
//        comuChildTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
//        tableView.rowHeight = 115;
//        NSDictionary *dic = [arr_data objectAtIndex:indexPath.row];
//        [cell.head setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"headImgPath"]] placeholderImage:cell.head.image];
//        cell.head.layer.cornerRadius = CGRectGetHeight(cell.head.frame) / 2;
//        cell.head.clipsToBounds = YES;
//        cell.main.text = [dic objectForKey:@"title"];
//        cell.time.text = [NSString stringWithFormat:@"%@发布于%@",[dic objectForKey:@"userName"],[dic objectForKey:@"replyTime"]];
//        cell.fallowlab.text = [NSString stringWithFormat:@"跟帖(%@)",[dic objectForKey:@"replyCount"]];
//        cell.numlab.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"praiseCount"]];
//        
//        cell.fallowBT.tag = indexPath.row;//收藏
//        cell.shareBT.tag = indexPath.row;//分享
//        [cell.fallowBT addTarget:self action:@selector(reply:) forControlEvents:UIControlEventTouchUpInside];
//        [cell.shareBT addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
//        
//        //赞
//        cell.numbtn.tag = indexPath.row;
//        [cell.numBT addTarget:self action:@selector(zanClick:) forControlEvents:UIControlEventTouchUpInside];
//        cell.numbtn.selected = [[dic objectForKey:@"isPraise"] boolValue];
//        if (cell.numbtn.selected) {
//            ((communitBtn*)cell.numbtn).isSel = true;
//            cell.numlab.textColor = [UIColor redColor];
//            [cell.numbtn setImage:[UIImage imageNamed:@"com_zambia_pressed"] forState:UIControlStateNormal];
//        }else{
//            ((communitBtn*)cell.numbtn).isSel = false;
//            cell.numlab.textColor = [UIColor lightGrayColor];
//            [cell.numbtn setImage:[UIImage imageNamed:@"com_zambia"] forState:UIControlStateNormal];
//        }

        
#if 1
        SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        tableView.rowHeight = 106;
  
        
        NSDictionary *dic = [arr_data objectAtIndex:indexPath.row];
        cell.titleText.text = [dic objectForKey:@"title"];
        cell.nameText.text = [dic objectForKey:@"userName"];
        [cell.follow_text setTitle:[NSString stringWithFormat:@"跟帖(%@)",[dic objectForKey:@"replyCount"]] forState:UIControlStateNormal];
        cell.timeText.text = [NSString stringWithFormat:@"发布于%@",[dic objectForKey:@"replyTime"]];
        cell.zan_text.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"praiseCount"]];
        CGSize titleSize = [cell.nameText.text sizeWithFont:cell.nameText.font constrainedToSize:CGSizeMake(MAXFLOAT, cell.nameText.height)];
        [cell.nameText setWidth:titleSize.width];
        [cell.timeText setLeft:cell.nameText.right];
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

       // }
        
#endif
        
        return cell;
    }
    else
    {

    MyStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellfas"];

    NSArray *item;

    if (!cell) {
        
        item = [[NSBundle mainBundle] loadNibNamed:@"MyStoreCell" owner:self options:nil];
        
            cell = [item objectAtIndex:0];
            tableView.rowHeight = 104;
        
        }
    return cell;
    }
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (self.cent == 9) {//搜索相关cell
        
        return 115;
    }
    return 85;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (self.cent == 9) {
        WebDayVC *weh = [[WebDayVC alloc]init];
        
        NSDictionary * dic = [arr_data objectAtIndex:indexPath.row];
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
    NSMutableDictionary *dic = [[arr_data objectAtIndex:btn.tag] mutableCopy];
    NSInteger praiseCount = [[dic objectForKey:@"praiseCount"] integerValue];
    if (btn.selected) {
        praiseCount++;
        [dic setObject:@(praiseCount) forKey:@"praiseCount"];
        [dic setObject:@(YES) forKey:@"isPraise"];
        [arr_data replaceObjectAtIndex:btn.tag withObject:dic];
        cell.zan_text.textColor = [UIColor redColor];
        cell.zan_text.text = [NSString stringWithFormat:@"%ld",(long)praiseCount];
        [self praiseClickChange:[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]]];
    }else{
        praiseCount--;
        [dic setObject:@(praiseCount) forKey:@"praiseCount"];
        [dic setObject:@(NO) forKey:@"isPraise"];
        [arr_data replaceObjectAtIndex:btn.tag withObject:dic];
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
    NSMutableDictionary *dic = [[arr_data objectAtIndex:btn.tag] mutableCopy];
    if (btn.selected) {
        [dic setObject:@(YES) forKey:@"isFavo"];
        cell.faiour_text.textColor = [UIColor redColor];
        [arr_data replaceObjectAtIndex:btn.tag withObject:dic];
        [self favoriteUser:[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] typte:@"1"];
    }else{
        [dic setObject:@(NO) forKey:@"isFavo"];
        cell.faiour_text.textColor = [UIColor lightGrayColor];
        [arr_data replaceObjectAtIndex:btn.tag withObject:dic];
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
    
    NSDictionary *dic = [arr_data objectAtIndex:btn.tag];
    
        FollwerContent *follow = [[FollwerContent alloc]init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:follow];
    NSNumber *nubm = [dic objectForKey:@"id"];
    [[NSUserDefaults standardUserDefaults]setObject:[dic objectForKey:@"title"] forKey:@"circleTitle"];
   // [[NSUserDefaults standardUserDefaults]objectForKey:@"circleTitle"]];
    follow.num = nubm;
    [self presentViewController:nav animated:YES completion:nil];



}


-(void)share:(UIButton *)btn{
    
    NSMutableDictionary *cellDic = [[arr_data objectAtIndex:btn.tag] mutableCopy];
    share_view.shareTitle = [cellDic objectForKey:@"title"];;
    
    NSString *imageUrl = [cellDic objectForKey:@"thumbnail"];
    if(imageUrl == nil){
        imageUrl = [cellDic objectForKey:@"headImgPath"];
    }
    share_view.shareHeadImgUrl = imageUrl;//[cellDic objectForKey:@"thumbnail"];
    NSString *str = [NSString stringWithFormat:@"%@%@%@",Base_URL,user_tiezi,[cellDic objectForKey:@"id"]];
    share_view.shareUrl = str;
    
    
    _VApManager = [[VApiManager alloc]init];
    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
    
    UsersInvitationDetailsRequest *usersInvitationDetailsRequest = [[UsersInvitationDetailsRequest alloc] init:accessToken];
    
    if ([cellDic objectForKey:@"id"]) {
        usersInvitationDetailsRequest.api_invnId = [cellDic objectForKey:@"id"];
    }else{
        usersInvitationDetailsRequest.api_invnId = [cellDic objectForKey:@"itemId"];
    }
    

    
    [_VApManager usersInvitationDetails:usersInvitationDetailsRequest success:^(AFHTTPRequestOperation *operation, UsersInvitationDetailsResponse *response) {
        
        [share_view setShareContent:response.content];
        //        share_view.shareContent = [NSString stringWithFormat:@"%@",response.content];// response.content;
        _viewforshare.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            share_view.frame = CGRectMake(0, __MainScreen_Height-200, __MainScreen_Width, 200);
//            [btn setImage:[UIImage imageNamed:@"com_share_pressed"] forState:UIControlStateNormal];
        } completion:^(BOOL finished) {
//            [btn setImage:[UIImage imageNamed:@"com_share"] forState:UIControlStateNormal];
        }];
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
