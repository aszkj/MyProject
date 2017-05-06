//
//  JGActivityWebController.m
//  jingGang
//
//  Created by dengxf on 15/12/30.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "JGActivityWebController.h"
#import "PositionAdvertBO.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "VApiManager.h"
#import "GlobeObject.h"
#import "MJExtension.h"
#import "UIAlertView+Extension.h"
#import "JGShareView.h"
#import "GlobeObject.h"
#import "PublicInfo.h"
#import "JGActivityHotSaleApiBO.h"
#import "JGActivityCommonController.h"
#import "JGActivityColumnHelper.h"
#import "KJGoodsDetailViewController.h"
@interface JGActivityWebController ()<UIWebViewDelegate>

/*** 广告栏对象   */
@property (strong,nonatomic) PositionAdvertBO *advBO;

@property (strong,nonatomic) UIWebView *web;

@property (copy , nonatomic) NSString *linkString;

@property (nonatomic, strong)JGShareView *shareView;

@property (copy , nonatomic) NSString *headerRequest;

@property (nonatomic,assign) BOOL isPushType;

@end

@implementation JGActivityWebController

- (instancetype)initWithAdvertBO:(PositionAdvertBO *)AdvBO withHeaderRequest:(NSString *)headerRequest ApiBO:(id)apiBO isPushType:(BOOL)isPushType{
    if (self = [super init]) {
        self.isPushType = isPushType;
        self.advBO = AdvBO;
        self.headerRequest = headerRequest;
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 35)];
        titleLable.textColor = [UIColor whiteColor];
        titleLable.font = [UIFont systemFontOfSize:22.0f];
        NSDictionary *apiBODic = [NSDictionary dictionaryWithDictionary:(NSDictionary *)apiBO];
        titleLable.text = apiBODic[@"hotName"];
        titleLable.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = titleLable;
        RELEASE(titleLable);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configContent];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = status_color;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = JGColor(173, 0, 19, 1);
}

- (void)backToMain {
    if (self.isPushType) {
        [self dismissViewControllerAnimated:NO completion:^{
            
        }];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)configContent {
    // // 165 11 34
    self.view.backgroundColor = JGColor(165, 11, 34, 1);
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(backToMain) target:self];
    self.navigationController.navigationBar.translucent = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UIWebView *web = [[UIWebView alloc] init];
    web.delegate = self;
    web.x = 0;
    web.y = 0;
    web.width = ScreenWidth;
    web.height = ScreenHeight - NavBarHeight;
    
    NSString *adUrl = [NSString stringWithFormat:@"%@",self.headerRequest];
    NSURL *url = [NSURL URLWithString:adUrl];
    NSURLRequest *reqest = [NSURLRequest requestWithURL:url];
    [web loadRequest:reqest];
    web.backgroundColor = JGColor(165, 11, 34, 1);
    [self.view addSubview:web];
    self.web = web;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self makeJsEnvirement];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(JGShareView *)shareViewWithInviteCode:(NSString *)code {
    NSString *shareContent = @"一百块都不给你？\n先注册，再动手，福利不是天天有。";
    if (!shareContent) {
        shareContent = kInvitationShareDescription1(@"");
    }
    NSString *strInviteTitle = [NSString stringWithFormat:@"这里有百元现金券！ 我只告诉你 我的义渠君...."];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
//    NSURL *storeUrl = [NSURL fileURLWithPath: [basePath  stringByAppendingPathComponent:@"jg_wxshared"]];
    
    NSString *shareUrl = [NSString stringWithFormat:@"%@/mobile_register.htm?invitationCode=%@&from=singlemessage&isappinstalled=1",Shop_url,code];
    
    NSString *imageUrlStr = [NSString stringWithFormat:@"%@/static/ticket_share.png",StaticBase_Url];
    
    _shareView = [JGShareView shareViewWithTitle:strInviteTitle content:shareContent imgUrlStr:imageUrlStr ulrStr:shareUrl contentView:self.view shareImagePath:nil];
    _shareView.weiBoShareModel.shareContent = kWeiboShareContent(@"", @"");
    
    return _shareView;
}

-(void)makeJsEnvirement {
    JSContext *context = [self.web valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    WeakSelf;
    // 买商品
    context[@"requestBuy"] = ^() {
        NSArray *args = [JSContext currentArguments];
        if (args.count) {
            NSString *linkString = TNSString([args[0] toString]) ;
            dispatch_async(dispatch_get_main_queue(), ^{
                KJGoodsDetailViewController *detailController = [[KJGoodsDetailViewController alloc] init];
                detailController.goodsID = [NSNumber numberWithInteger:[linkString integerValue]];
                [bself.navigationController pushViewController:detailController animated:NO];
            });
        }
    };
    
    // 抢
    [bself _userInfoQueryWithUid:^(NSString *uid) {
        dispatch_async(dispatch_get_main_queue(), ^{
            JSContext *robContext =  [self.web valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];;
            NSString *jsString = [NSString stringWithFormat:@"function getTicketValidate() { return '%@';}",uid];
            [robContext evaluateScript:jsString];
        });
    }];
    
    JSContext *robContext = [self.web valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    robContext[@"getTicketValidate"] = ^() {
        [bself _userInfoQueryWithUid:^(NSString *uid) {
            dispatch_async(dispatch_get_main_queue(), ^{
                JSContext *robContext =  [self.web valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];;
                NSString *jsString = [NSString stringWithFormat:@"function getTicketValidate() { return '%@';}",uid];
                [robContext evaluateScript:jsString];
            });
        }];
    };
    //requestShareTicket
    JSContext *shareContext = [self.web valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    shareContext[@"requestShareTicket"] = ^() {
        [bself getInviteCode:^(NSString *inviteCode) {
            StrongSelf;
            [[strongSelf shareViewWithInviteCode:inviteCode] show];
        }];
    };
}

#pragma mark - 用户信息查询
-(void)_userInfoQueryWithUid:(void(^)(NSString *))uidBlock{
    dispatch_async(dispatch_get_main_queue(), ^{
        UsersCustomerSearchRequest *request = [[UsersCustomerSearchRequest alloc] init:GetToken];
        [[[VApiManager alloc] init] usersCustomerSearch:request success:^(AFHTTPRequestOperation *operation, UsersCustomerSearchResponse *response) {
            NSDictionary *cus = [NSDictionary dictionaryWithDictionary:(NSDictionary *)response.customer];
            NSString *uid = TNSString(cus[@"uid"]) ;
            BLOCK_EXEC(uidBlock,uid);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            BLOCK_EXEC(uidBlock,nil);
        }];
    });
    
}

/**
 *  获取用户uid
 * */
- (void)getInviteCode:(void(^)(NSString *))inviteCodeBlock {
    WEAK_SELF
    dispatch_async(dispatch_get_main_queue(), ^{
        UsersCustomerSearchRequest *request = [[UsersCustomerSearchRequest alloc] init:GetToken];
        VApiManager *vapManager = [[VApiManager alloc] init];
        [vapManager usersCustomerSearch:request success:^(AFHTTPRequestOperation *operation, UsersCustomerSearchResponse *response) {
            UserCustomer *customer = [UserCustomer objectWithKeyValues:response.customer];
            if (customer.invitationCode.length) {
                if (inviteCodeBlock) {
                    inviteCodeBlock(customer.invitationCode);
                }
            }
            [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
        }];
    });
}


//- (void)forword {
//    [self.web goForward];
//}
//
//- (void)back {
//    [self.web goBack];
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
