//
//  expertsViewController.m
//  jingGang
//
//  Created by yi jiehuang on 15/6/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "expertsViewController.h"
#import "PublicInfo.h"
#import "UIImageView+WebCache.h"
#import "GlobeObject.h"
#import "questionViewController.h"
#import "SVProgressHUD.h"
#import "userDefaultManager.h"

@interface expertsViewController ()
{
    UIScrollView      *_myScrollView;
    float             lab_height,btn_h,btn_wight;
    VApiManager       *_vapManager;
    UIImageView       *head_img;
    UILabel           * dis_lab,*line_lab2;//医生具体介绍和分割线
    UIView            * down_view,* s_view;//介绍医生的view
    UIWebView         * down_view2;//医生详情webView
    NSArray           * lab_array;//存放点赞和好评的数量
    UIView            * middel_view;//模糊视图
    UILabel           * sc_lab,* dz_lab,* lab_l,* lab_r;
    
    UILabel           * btn_lab;//收藏按钮的title
    
    NSInteger         _favoriteCount;
    NSInteger         _praiseCount;
    NSMutableArray    *_favoriteAndPraiseBtnArr;//收藏和点赞按钮数组
    
}


@end

@implementation expertsViewController


- (void)viewWillAppear:(BOOL)animated
{
    [self doSomeRequest];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _vapManager = [[VApiManager alloc]init];
//    lab_height = kStringSize(self.dis_Str, 16.0, __MainScreen_Width-26, MAXFLOAT).height;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"home_title"] forBarMetrics:UIBarMetricsDefault];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"专家";
    self.navigationItem.titleView = titleLabel;

    UIButton *leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0.0f, 16.0f, 40.0f, 25.0f)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButton;


    UIButton *rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(0.0f, 16.0f, 40.0f, 25.0f)];
    //    [rightBtn setTitle:@"新增" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButton;


    btn_lab = [[UILabel alloc]init];
    [self greatUI];
}

- (void)greatUI
{
    _myScrollView = [[UIScrollView alloc]init];
    _myScrollView.frame = self.view.frame;
    _myScrollView.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1];
    [self.view addSubview:_myScrollView];
    float top_view_h = 114;
    UIImageView * top_img = [[UIImageView alloc]init];
    top_img.frame = CGRectMake(0, 0, __MainScreen_Width, top_view_h+42);
    top_img.image = [UIImage imageNamed:@"ask_back_pic.jpg"];
    [_myScrollView addSubview:top_img];

    middel_view = [[UIView alloc]init];
    middel_view.frame = CGRectMake(0, top_img.frame.size.height-42, __MainScreen_Width, 42);
    middel_view.backgroundColor = [UIColor colorWithWhite:0.94 alpha:0.4];
    [_myScrollView addSubview:middel_view];
    
    UIImageView * image = [[UIImageView alloc]init];
    image.frame = CGRectMake(30, top_view_h/2-40, 175, 80);
    image.image =[UIImage imageNamed:@"ask_back_portrait"];
    [_myScrollView addSubview:image];

    
    UIImageView * bg_head_img = [[UIImageView alloc]init];
    bg_head_img.image = [UIImage imageNamed:@"home_title"];
    bg_head_img.frame = CGRectMake(0, 0, 80,80);
    bg_head_img.center = CGPointMake(70, top_view_h/2);
    bg_head_img.layer.cornerRadius = 40;
    bg_head_img.clipsToBounds = YES;
    [_myScrollView addSubview:bg_head_img];

    head_img = [[UIImageView alloc]init];
    [head_img sd_setImageWithURL:[NSURL URLWithString:self.img_str] placeholderImage:[UIImage imageNamed:@"per_defult_head"]];
    head_img.frame = CGRectMake(0, 0, 72,72);
    head_img.center = CGPointMake(bg_head_img.center.x, bg_head_img.center.y);
    head_img.layer.cornerRadius = 36;
    head_img.clipsToBounds = YES;
    [_myScrollView addSubview:head_img];
    
    UILabel * name_lab = [[UILabel alloc]init];
    name_lab.frame = CGRectMake(head_img.frame.origin.x+head_img.frame.size.width+5, top_view_h/2-20, 80, 15);
    name_lab.text = self.name_str;
    name_lab.font = [UIFont systemFontOfSize:16];
    name_lab.textColor = [UIColor whiteColor];
    [_myScrollView addSubview:name_lab];

    
    UILabel * sex_lab = [[UILabel alloc]init];
    sex_lab.frame = CGRectMake(head_img.frame.origin.x+head_img.frame.size.width+5, top_view_h/2+5, 80, 32);
    sex_lab.numberOfLines = 2;
    sex_lab.text = self.sex_str;
    sex_lab.font = [UIFont systemFontOfSize:14];
    sex_lab.textColor = [UIColor whiteColor];
    [_myScrollView addSubview:sex_lab];

    
    btn_h = top_view_h/2-30;
    btn_wight = 32;
    NSArray * img_array = [NSArray arrayWithObjects:@"ask_coll",@"ask_zan", nil];
    NSArray * img_selecte_Arr = @[@"ask_coll02",@"ask_zan02"];
    NSArray * name_array = [NSArray arrayWithObjects:@"收藏",@"点赞", nil];
    sc_lab = [[UILabel alloc]init];
    dz_lab = [[UILabel alloc]init];
    _favoriteAndPraiseBtnArr = [NSMutableArray arrayWithCapacity:2];
    for (int i = 0; i < 2; i ++) {
        UIButton * button = [[UIButton alloc]init];
        button.tag = i+10;
        button.frame = CGRectMake(__MainScreen_Width-80, btn_h+(btn_wight+6)*i, 76, btn_wight);
        [button setBackgroundImage:[UIImage imageNamed:@"ask_back_zan"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"ask_back_zan_pressed"] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_myScrollView addSubview:button];

        UIButton *btn = [[UIButton alloc] init];
        [btn setImage:[UIImage imageNamed:img_array[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:img_selecte_Arr[i]] forState:UIControlStateSelected];
        btn.frame = CGRectMake(8, 9, 14, 13);
        [button addSubview:btn];
        [_favoriteAndPraiseBtnArr addObject:btn];
        
        if (i == 1) {
            UILabel * lab = dz_lab;
            lab.text = [name_array objectAtIndex:i];
            lab.font = [UIFont systemFontOfSize:12];
            lab.textColor = [UIColor grayColor];
            lab.frame = CGRectMake(btn.frame.origin.x+btn.frame.size.width+3, 0, 45, btn_wight);
            [button addSubview:lab];
        }else{
            btn_lab.text = [name_array objectAtIndex:i];
            btn_lab.font = [UIFont systemFontOfSize:12];
            btn_lab.textColor = [UIColor grayColor];
            btn_lab.frame = CGRectMake(btn.frame.origin.x+btn.frame.size.width+3, 0, 40, btn_wight);
            [button addSubview:btn_lab];
        }
    }
    NSArray * middle_img = [NSArray arrayWithObjects:@"ask_coll02",@"ask_zan02", nil];
    UIImageView * img_l = [[UIImageView alloc]init];
    img_l.image = [UIImage imageNamed:[middle_img objectAtIndex:0]];
    img_l.frame = CGRectMake(40+0*__MainScreen_Width/2, middel_view.frame.size.height/2-7, 15, 14);
    [middel_view addSubview:img_l];
    UIImageView * img_r = [[UIImageView alloc]init];
    img_r.image = [UIImage imageNamed:[middle_img objectAtIndex:1]];
    img_r.frame = CGRectMake(40+1*__MainScreen_Width/2, middel_view.frame.size.height/2-7, 15, 14);
    [middel_view addSubview:img_r];
    
    lab_l = [[UILabel alloc]init];
    lab_l.frame = CGRectMake(img_l.frame.size.width+img_l.frame.origin.x+8, 0, 100, middel_view.frame.size.height);
    [middel_view addSubview:lab_l];
    lab_r = [[UILabel alloc]init];
    lab_r.frame = CGRectMake(img_r.frame.size.width+img_r.frame.origin.x+8, 0, 100, middel_view.frame.size.height);
    [middel_view addSubview:lab_r];
    
    RELEASE(img_l);
    RELEASE(img_r);
    
    [self greatInfo];//构造收藏和点赞
    NSArray * lab_array2 = [NSArray arrayWithObjects:@"马上电话咨询",@"向TA咨询", nil];
    
    s_view = [[UIView alloc]init];
    s_view.frame = CGRectMake(0, top_img.frame.size.height, __MainScreen_Width, 50);
    s_view.backgroundColor = [UIColor colorWithRed:89.0/255 green:196.0/255 blue:240.0/255 alpha:1];
    [_myScrollView addSubview:s_view];
    UILabel * line_lab = [[UILabel alloc]init];
    line_lab .frame = CGRectMake(__MainScreen_Width/2, 0, 0.5, 50);
    line_lab.backgroundColor = [UIColor whiteColor];
    [s_view addSubview:line_lab];

    NSArray * last_img = [NSArray arrayWithObjects:@"ask_call",@"ask_consult", nil];
    for (int i = 0; i < 2; i ++) {
        UIImageView * img = [[UIImageView alloc]init];
        img.image = [UIImage imageNamed:[last_img objectAtIndex:i]];
        img.frame = CGRectMake(13+i*__MainScreen_Width/2, 15, 24, 20);
        [s_view addSubview:img];


        UILabel * lab  = [[UILabel alloc]init];
        lab.textColor = [UIColor whiteColor];
        lab.text = [lab_array2 objectAtIndex:i];
        lab.frame = CGRectMake(img.frame.origin.x+img.frame.size.width+5, 5, 150, s_view.frame.size.height-10);
        [s_view addSubview:lab];

        
        UIButton * btn = [[UIButton alloc]init];
        btn.frame = CGRectMake(20+i*(__MainScreen_Width/2), 10, __MainScreen_Width/2-40, s_view.frame.size.height-20);
        btn.backgroundColor = [UIColor clearColor];
        btn.tag = i + 500;
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [s_view addSubview:btn];

    }
    
    down_view  = [[UIWebView alloc]init];
    down_view.backgroundColor = [UIColor whiteColor];
    down_view.frame = CGRectMake(0, s_view.frame.origin.y+s_view.frame.size.height+10, __MainScreen_Width, lab_height+32+20);
    NSLog(@"alalal-----lab_height = %.2f",lab_height);
    down_view.backgroundColor = [UIColor whiteColor];
    [_myScrollView addSubview:down_view];
    
    line_lab2 = [[UILabel alloc]init];
    line_lab2.frame = CGRectMake(0, 32, __MainScreen_Width, 0.5);
    line_lab2.backgroundColor = [UIColor lightGrayColor];
    [down_view addSubview:line_lab2];
    
    UILabel * down_lab = [[UILabel alloc]init];
    down_lab.frame = CGRectMake(13, 0, 100, 32);
    down_lab.textColor = [UIColor colorWithRed:89.0/255 green:196.0/255 blue:240.0/255 alpha:1];
    down_lab.text = @"医生介绍";
    [down_view addSubview:down_lab];

    
    dis_lab = [[UILabel alloc]init];
    dis_lab.frame = CGRectMake(13, line_lab2.frame.origin.y+10, __MainScreen_Width-26, lab_height);
    dis_lab.numberOfLines = 0;
    dis_lab.font = [UIFont systemFontOfSize:16];
//    [down_view addSubview:dis_lab];
    
    down_view2 = [[UIWebView alloc]init];
    down_view2.frame = CGRectMake(13, 0, __MainScreen_Width-26, lab_height+50);
    [down_view addSubview:down_view2];
    
    _myScrollView.contentSize = CGSizeMake(__MainScreen_Width, down_view.frame.origin.y+down_view.frame.size.height+20+__Other_Height);
    NSLog(@"contentSize = %.2f",down_view.frame.origin.y+down_view.frame.size.height+20);
}

#pragma mark - 点击收藏，点赞按钮
- (void)buttonClick:(UIButton *)btn
{
    UNLOGIN_HANDLE
    NSLog(@"btn.tag = %ld",(long)btn.tag);
    if (btn.tag == 10) {
        //收藏
        NSLog(@"is_favor == %d",is_favor);
        if (is_favor == 0) {
            [SVProgressHUD showInView:self.view status:@"正在完成操作" networkIndicator:NO posY:-1 maskType:1];
            NSString * accessToken = [userDefaultManager GetLocalDataString:@"Token"];
            UsersFavoritesRequest * usersFavorite = [[UsersFavoritesRequest alloc]init:accessToken];
            usersFavorite.api_fid = self.uId;
            usersFavorite.api_type = @"2";
            [_vapManager usersFavorites:usersFavorite success:^(AFHTTPRequestOperation *operation, UsersFavoritesResponse *response) {
                [SVProgressHUD dismiss];
                NSMutableDictionary * dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
                NSLog(@"用户收藏dict ==== %@",dict);
                is_favor = 1;
                
                //刷新收藏UI
                _favoriteCount ++;
                [self _reFreshFavoriteLabel];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [SVProgressHUD dismiss];
                NSLog(@"失败, %@",error);
            }];
        }else{
            UIAlertView * alertVc = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您已经收藏了该专家，是否取消收藏？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alertVc.tag = 10;
            alertVc.delegate = self;
            [alertVc show];


        }
    }else if (btn.tag == 11){
        //点赞
        [SVProgressHUD showInView:self.view status:@"正在完成操作" networkIndicator:NO posY:-1 maskType:1];
        NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
        UsersExpertsPraiseRequest *UsersExpertsPraise = [[UsersExpertsPraiseRequest alloc] init:accessToken];
        UsersExpertsPraise.api_expertsId = [NSNumber numberWithInt:[self.uId intValue]];
        NSLog(@"当前被点赞的专家id ＝ %@",self.uId);
        [_vapManager usersExpertsPraise:UsersExpertsPraise success:^(AFHTTPRequestOperation *operation, UsersExpertsPraiseResponse *response) {
            [SVProgressHUD dismiss];
            NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
            NSLog( @"dict---->%@",dict);
            if ([[dict objectForKey:@"code"] intValue] == 4) {
                UIAlertView * alertVc = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您已经给该位医生点过赞，是否取消点赞？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alertVc.tag = 11;
                alertVc.delegate = self;
                [alertVc show];

            }else {
            
                [SVProgressHUD dismissWithSuccess:@"点赞成功"];
                //刷新点赞UI
                ++_praiseCount;
                [self _reFreshPraiseLabel:YES];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"失败, %@",error);
            [SVProgressHUD dismiss];
        }];

    }else if (btn.tag == 500) {
        NSLog(@"phoneNum = %@",self.phone_num);
        [self systemCall:self.phone_num];
    }else if (btn.tag == 501){
        questionViewController * quesVC = [[questionViewController alloc]init];
        quesVC.uID = self.uId;
        [self.navigationController pushViewController:quesVC animated:YES];

    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 11) {
        if (buttonIndex == 1) {
            [self doCancel];//取消点赞
        }
    }else {
        if (buttonIndex == 1) {
            [self doCancel_favor];//取消收藏
        }
    }
}

#pragma mark - 取消点赞
- (void)doCancel
{
    //取消点赞
    [SVProgressHUD showInView:self.view status:@"正在完成操作" networkIndicator:NO posY:-1 maskType:1];
    _vapManager = [[VApiManager alloc]init];
    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
    UsersExpertsUnpraiseRequest *UsersExpertsUnpraise = [[UsersExpertsUnpraiseRequest alloc] init:accessToken];
    UsersExpertsUnpraise.api_expertsId = [NSNumber numberWithInt:[self.uId intValue]];
    
    [_vapManager usersExpertsUnpraise:UsersExpertsUnpraise success:^(AFHTTPRequestOperation *operation, UsersExpertsUnpraiseResponse *response) {
        [SVProgressHUD dismiss];
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        NSLog( @"取消点赞dict---->%@",dict);
        //刷新点赞ui
        --_praiseCount;
        [self _reFreshPraiseLabel:NO];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败, %@",error);
        [SVProgressHUD dismiss];
    }];
    
}
#pragma mark - 取消收藏
- (void)doCancel_favor
{
    //取消收藏
    [SVProgressHUD showInView:self.view status:@"正在完成操作" networkIndicator:NO posY:-1 maskType:1];
    _vapManager = [[VApiManager alloc]init];
    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
    UsersExpertsCancleRequest *UsersExpertsCancle = [[UsersExpertsCancleRequest alloc] init:accessToken];
    UsersExpertsCancle.api_expertsId = self.uId;
    
    [_vapManager usersExpertsCancle:UsersExpertsCancle success:^(AFHTTPRequestOperation *operation, UsersExpertsCancleResponse *response) {
        [SVProgressHUD dismiss];
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        NSLog( @"取消收藏dict---->%@",dict);
        btn_lab.text = @"收藏";
        is_favor = 0;
        //刷新收藏ui
        _favoriteCount --;
        [self _reFreshFavoriteLabel];
        UIButton *favoriteBtn = _favoriteAndPraiseBtnArr[0];
        favoriteBtn.selected = NO;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - 专家详情
- (void)doSomeRequest
{
    [SVProgressHUD showInView:self.view status:@"正在刷新数据" networkIndicator:NO posY:-1 maskType:1];
    _vapManager = [[VApiManager alloc]init];
    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
    UsersExpertsDetailRequest *UsersExpertsDetail = [[UsersExpertsDetailRequest alloc] init:accessToken];
    NSNumber * api_uid = [NSNumber numberWithInt:[self.uId intValue]];
    UsersExpertsDetail.api_uid = api_uid;
    
    [_vapManager usersExpertsDetail:UsersExpertsDetail success:^(AFHTTPRequestOperation *operation, UsersExpertsDetailResponse *response) {
        [SVProgressHUD dismiss];
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"具体专家dict === %@",dict);
        NSString * img_str = [[dict objectForKey:@"expertsDetail"] objectForKey:@"headImgPath"];
        NSLog(@"头像 －－－－－－> %@",img_str);
        [head_img sd_setImageWithURL:[NSURL URLWithString:img_str] placeholderImage:[UIImage imageNamed:@"per_defult_head"]];
//        self.dis_Str = [[dict objectForKey:@"expertsDetail"] objectForKey:@"praiseInfo"];
        self.dis_Str = [[dict objectForKey:@"expertsDetail"] objectForKey:@"description"];
        lab_height = kStringSize(self.dis_Str, 16.0, __MainScreen_Width-26, MAXFLOAT).height;
        lab_height = lab_height+20;
        NSLog(@"计算后得到的lab高度－－－－－－%.2f",lab_height);
        dis_lab.frame = CGRectMake(13, line_lab2.frame.origin.y+10, __MainScreen_Width-26, lab_height);
        dis_lab.text = [NSString stringWithFormat:@"%@",self.dis_Str];
        down_view.frame = CGRectMake(0, s_view.frame.origin.y+s_view.frame.size.height+10, __MainScreen_Width, lab_height);
        down_view2.frame = CGRectMake(0, line_lab2.frame.origin.y, __MainScreen_Width, __MainScreen_Height-s_view.frame.origin.y-s_view.frame.size.height-92);
        NSLog(@"hright-----%.2f,,height2----%.2f,,,y----%.2f",lab_height-50,__MainScreen_Height-s_view.frame.origin.y-s_view.frame.size.height-92,line_lab2.frame.origin.y+s_view.frame.origin.y+s_view.frame.size.height);
        down_view2.scrollView.scrollEnabled = YES;
        down_view2.backgroundColor = [UIColor whiteColor];
        [down_view2 loadHTMLString:dis_lab.text baseURL:nil];
        if (dis_lab.text.length == 0) {
            [down_view2 loadHTMLString:@"该医生暂无介绍" baseURL:nil];
        }
        _myScrollView.contentSize = CGSizeMake(__MainScreen_Width, __MainScreen_Height);
        NSLog(@"最终滑动－－－－－%.2f",down_view.frame.origin.y+down_view.frame.size.height+20+__Other_Height);
        NSNumber * favorCount = [[dict objectForKey:@"expertsDetail"] objectForKey:@"favorCount"];//收藏
        NSNumber * praiseCount = [[dict objectForKey:@"expertsDetail"] objectForKey:@"praiseCount"];//点赞
        
        _favoriteCount = [favorCount integerValue];
        _praiseCount = [praiseCount integerValue];
        
        BOOL isPraise = [[[dict objectForKey:@"expertsDetail"] objectForKey:@"isPraise"] intValue];
        [self _reFreshPraiseLabel:isPraise];

        lab_array = [NSArray arrayWithObjects:[NSString stringWithFormat:@"收藏%@",favorCount],[NSString stringWithFormat:@"点赞%@",praiseCount], nil] ;
        is_favor = [[[dict objectForKey:@"expertsDetail"] objectForKey:@"isFavor"] intValue];
        [self _reFreshFavoriteLabel];
        [self greatInfo];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败");
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - 刷新收藏，label,
-(void)_reFreshFavoriteLabel{
    lab_l.text = [NSString stringWithFormat:@"收藏%ld",_favoriteCount];
    UIButton *favoriteBtn = _favoriteAndPraiseBtnArr[0];
    favoriteBtn.selected = is_favor;
    if (is_favor) {
        btn_lab.text = @"已收藏";
    } else {
        btn_lab.text = @"收藏";
    }
}

#pragma mark - 刷新点赞，label
-(void)_reFreshPraiseLabel:(BOOL)isSelect {
    if (isSelect) {
        dz_lab.text = @"已点赞";
    } else {
        dz_lab.text = @"点赞";
    }
    UIButton *praiseBtn = _favoriteAndPraiseBtnArr[1];
    praiseBtn.selected = isSelect;
    lab_r.text = [NSString stringWithFormat:@"点赞%ld",_praiseCount];
}


static  int   is_favor;//检测是否收藏了此专家

- (void)greatInfo
{
    NSLog(@"1---22---333");
    lab_l.text = [lab_array objectAtIndex:0];
    lab_r.text = [lab_array objectAtIndex:1];
}


#pragma mark - 电话相关
// 调用系统方式拨打
// strPhoneNumber : 电话号码
- (void) systemCall:(NSString *) strPhoneNumber
{
    if (nil == strPhoneNumber || [strPhoneNumber length] == 0)
    {
        return;
    }
    
    if ([self isSystemCanCall:strPhoneNumber])
    {
        NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", strPhoneNumber]];
        [[UIApplication sharedApplication] openURL:phoneURL];
    }
    else
    {
        UIAlertView *uav = [[UIAlertView alloc] initWithTitle:nil message:@"您不能呼叫" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [uav show];

    }
}

// 系统方式拨打是否可以
- (BOOL) isSystemCanCall:(NSString *) strPhoneNumber {
    BOOL bRet = NO;
    
    NSString *strURL = [NSString stringWithFormat:@"tel://%@", strPhoneNumber];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:strURL]])
    {
        bRet = YES;
    }
    
    return bRet;
}

- (void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)showAlertViewWithStr:(NSString *)string
{
    UIAlertView * alertVc = [[UIAlertView alloc]initWithTitle:@"提示" message:string delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];[alertVc show];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
