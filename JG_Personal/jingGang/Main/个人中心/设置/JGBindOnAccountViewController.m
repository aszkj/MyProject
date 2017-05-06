//
//  JGBindOnAccountViewController.m
//  jingGang
//
//  Created by Ai song on 16/2/25.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import "JGBindOnAccountViewController.h"
#import "JGBindOnAccountTableViewCell.h"
#import "VApiManager.h"
#import "Util.h"
#import "PublicInfo.h"
#import "ThirdPaltFormLoginHelper.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApiObject.h"
#import "WXApi.h"
#import "AppDelegate.h"
#import "TieThirdPlatFormController.h"
#import "ThirdPlatformInfo.h"
@interface JGBindOnAccountViewController ()<UITableViewDataSource,UITableViewDelegate>{
    VApiManager *_vapiManager;
    NSInteger        _thirdPlatNum;
    NSString        *_thirdPlatOpenID;
    NSString        * unionId;
    ThirdPaltFormLoginHelper    *_thirdPlatFormHelper;
    MBProgressHUD * _thirdLoginHub;
    NSString        *_thirdPlatToken;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (copy, nonatomic) NSArray *titleArray;
@property (copy, nonatomic) NSArray *pictureArray;
@property (copy, nonatomic) NSMutableArray *arrayData;
@end

@implementation JGBindOnAccountViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestBindStutus];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _vapiManager = [[VApiManager alloc] init];
    [self initData];
    [self initUI];
    [self requestBindStutus];
    // Do any additional setup after loading the view from its nib.
}
- (void)initUI{
    UIButton *button_na = [[UIButton alloc]initWithFrame:CGRectMake(20, 30, 35, __NavScreen_Height-15)];
    [button_na setImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    //增加好点的返回键
    [Util makeWellClickBGBtnAtNavBar:self.navigationController.navigationBar withBtnSize:60 onResponseMethodStr:@"btnClick" isLeftItem:YES inResponseObject:self];
    [button_na addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:button_na];
    self.navigationItem.leftBarButtonItem = bar;
    RELEASE(button_na);
    RELEASE(bar);
    //设置标题
    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(__MainScreen_Width/2 - 30, __StatusScreen_Height, 60, 40)];
    l.text = @"账号绑定";
    l.font = [UIFont systemFontOfSize:18];
    l.textColor = [UIColor whiteColor];
    l.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = l;
    RELEASE(l);
    //设置tableview
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = self.view.backgroundColor;
    [self hideTableView];
}
//tableView样式设置
- (void)hideTableView{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 1)];
    footView.backgroundColor = [UIColor colorWithRed:10/255.0 green:10/255.0 blue:10/255.0 alpha:0.2];
    self.tableView.tableFooterView = footView;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 10)];
    headerView.backgroundColor = [UIColor colorWithRed:10/255.0 green:10/255.0 blue:10/255.0 alpha:0.2];
    self.tableView.tableHeaderView = headerView;
    
}
- (void)initData{
    self.titleArray = [NSArray arrayWithObjects:@"微信账号",@"微博账号",@"QQ帐号",nil];
    self.pictureArray = [NSArray arrayWithObjects:@"weChat",@"weibo",@"qq",nil];
    self.arrayData = [NSMutableArray arrayWithCapacity:3];
}
//request 绑定状态
- (void)requestBindStutus{
    BindingListRequest *request = [[BindingListRequest alloc] init:GetToken];
    [_vapiManager bindingList:request success:^(AFHTTPRequestOperation *operation, BindingListResponse *response) {
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        
        NSLog(@"%@ %@",dict,response);
        
        [self dealResponseDataToReloadTableView:dict];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (void)dealResponseDataToReloadTableView:(NSDictionary *)dic{
    NSArray *arrayDat = dic[@"list"];
    self.arrayData = [NSMutableArray arrayWithArray:arrayDat];
    
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 58;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indetifierStr = @"JGBindOnAccountTableViewCell";
    JGBindOnAccountTableViewCell *cell = (JGBindOnAccountTableViewCell *)[tableView dequeueReusableCellWithIdentifier:indetifierStr];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"JGBindOnAccountTableViewCell" owner:self options:nil];
        cell = [nib lastObject];
    }
    cell.imageV.image = [UIImage imageNamed:self.pictureArray[indexPath.row]];
    cell.titleLabel.text = self.titleArray[indexPath.row];
    cell.swithView.on = NO;
    cell.swithView.tag = indexPath.row+10086;
    [cell.swithView addTarget:self action:@selector(swithViewClick:) forControlEvents:UIControlEventValueChanged];
    if(indexPath.row == 0){
        if([self.arrayData containsObject:@4]){
            cell.imageV.image = [UIImage imageNamed:@"weChatBind"];
            cell.swithView.on = YES;
        }
    }else if (indexPath.row == 1){
        if([self.arrayData containsObject:@5]){
            cell.imageV.image = [UIImage imageNamed:@"weiboBind"];
            cell.swithView.on = YES;
        }
    }else if (indexPath.row == 2){
        if([self.arrayData containsObject:@3]){
            cell.imageV.image = [UIImage imageNamed:@"qqBind"];
            cell.swithView.on = YES;
        }
    }
    
    
    return cell;
}
- (void)swithViewClick:(id)sender{
    UISwitch *swith = (UISwitch *)sender;
    if(!swith.isOn){
//        调解绑接口
        OpenIdBindingDeleteRequest *request = [[OpenIdBindingDeleteRequest alloc] init:GetToken];
        if(swith.tag == 10086){
            request.api_type = @"4";
        }
        else if (swith.tag == 10087){
            request.api_type = @"5";
        }
        else if (swith.tag == 10088){
            request.api_type = @"3";
        }
        [_vapiManager openIdBindingDelete:request success:^(AFHTTPRequestOperation *operation, OpenIdBindingDeleteResponse *response) {
             NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"%@",dict);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }else{
//        调绑定接口
        if(swith.tag == 10086){
            _thirdPlatNum = 4;
        }
        else if (swith.tag == 10087){
            _thirdPlatNum = 5;
        }
        else if (swith.tag == 10088){
            _thirdPlatNum = 3;
        }
        [self _beginThirdLogin:swith];
    }
}
- (void)_beginThirdLogin:(UISwitch *)swit{
    
    ShareType thirdAuthType;
    switch (_thirdPlatNum) {
        case 3:
            //QQ
            thirdAuthType = ShareTypeQQSpace;
            break;
        case 4:
            //微信
        {
            thirdAuthType = ShareTypeWeixiTimeline;
            [self loginWithWeiXin];
            return;
        }
            break;
        case 5:
            //微博
            thirdAuthType = ShareTypeSinaWeibo;
            break;
            
        default:
            break;
    }
    
    [ShareSDK getUserInfoWithType:thirdAuthType authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
        JGLog(@"用户openID %@",[userInfo uid]);
        _thirdPlatOpenID = [userInfo uid];// oGIrss4dtNKvchUDTspvYv4tI-nA
        _thirdPlatToken = [[ShareSDK getCredentialWithType:thirdAuthType] token];
        if (_thirdPlatOpenID) {
            //查询是否绑定
            [self _queryUserWhetherTiedToThirdPlat];
        }
        else{
            swit.on = NO;
        }
    }];
    
}
#pragma mark - 查询是否绑定过第三方平台
-(void)_queryUserWhetherTiedToThirdPlat {
    
    _thirdLoginHub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    VApiManager *vapManager = [[VApiManager alloc] init];
    OpenIdBindingCheckRequest *request = [[OpenIdBindingCheckRequest alloc] init:@""];
    request.api_openId = _thirdPlatOpenID;
    request.api_type = @(_thirdPlatNum);
    if(!unionId){
        request.api_unionId = @"";
    }else{
        request.api_unionId = unionId;
    }
    
    
    [vapManager openIdBindingCheck:request success:^(AFHTTPRequestOperation *operation, OpenIdBindingCheckResponse *response) {
        JGLog(@"检查绑定结果 %@",response);
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        NSNumber *isBinding = dict[@"isBinding"];
        if (!isBinding.integerValue) {//没绑定，进入绑定页
            [_thirdLoginHub hide:YES];
            [self _cominToTheTiePage];
//        }else {//绑定了，登录
//            _thirdLoginHub.labelText = @"正在进行登录..";
////            [self _thirdPlatLogin];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [_thirdLoginHub hide:YES];
        [Util ShowAlertWithOnlyMessage:error.localizedDescription];
    }];
    
}
-(void)_cominToTheTiePage {
    TieThirdPlatFormController *tieInfoVC = [[TieThirdPlatFormController alloc] init];
    tieInfoVC.thirdPlatToken = _thirdPlatToken;
    tieInfoVC.thirdPlatTypeNumber = @(_thirdPlatNum);
    tieInfoVC.thirdPlatOpenID = _thirdPlatOpenID;
    //    微信需要unionID ，微博，qq不需要
    if(!unionId){
        tieInfoVC.unionId = @"";
    }else{
        tieInfoVC.unionId = unionId;
    }

    tieInfoVC.tagV = 1;
    [self.navigationController pushViewController:tieInfoVC animated:YES];
}
- (void)loginWithWeiXin {
    SendAuthReq *req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo,snsapi_base";
    req.state = @"";
    [WXApi sendReq:req];
    AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.getWXCode = YES;
    app.wxCodeBlock = ^(NSString *code){
        JGLog(@"code:%@",code);
        NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",Weixin_AppID,Weixin_AppSecret,code];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURL *zoneUrl = [NSURL URLWithString:url];
            NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
            NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (data) {
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    NSString *access_token = dic[@"access_token"];
                    NSString *openid = dic[@"openid"];
                    _thirdPlatOpenID = openid;
                    JGLog(@"\n---------openid:%@",openid);
                    _thirdPlatToken = access_token;
                    JGLog(@"\n---------access_token:%@",access_token);
                    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",access_token,openid];
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        NSURL *zoneUrl = [NSURL URLWithString:url];
                        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
                        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (data) {
                                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                NSString *wxunionid = dic[@"unionid"];
                                unionId = wxunionid;
                                JGLog(@"\n---------unionid:%@",wxunionid);
                                if (_thirdPlatOpenID) {
                                    //查询是否绑定
                                    [self _queryUserWhetherTiedToThirdPlat];
                                }
                            }
                        });
                    });
                }
            });
        });
    };
    return ;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
