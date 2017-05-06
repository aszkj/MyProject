//
//  DLShareVC.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/9/27.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLShareVC.h"
#import "XMShareWechatUtil.h"
#import <MessageUI/MessageUI.h>
#import "DLShareBottomView.h"
#import "UIView+BlockGesture.h"
#import "XMShareWechatUtil.h"
#import "UIImageView+sd_SetImg.h"
#import <WebKit/WebKit.h>
#import "AFNHttpRequestOPManager+DLUnNomalApi.h"
#import "GlobleConst.h"
#import "UIViewController+hub.h"
#import "Share.h"
@interface DLShareVC ()<MFMessageComposeViewControllerDelegate>

@property (nonatomic,strong)UIView *viewBG;
@property (nonatomic,strong)DLShareBottomView *bottomView;
@property (nonatomic,strong)WKWebView *webView;


@end

@implementation DLShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
   

//    [self _initRightAllOrderItem];
    
    [self _requestShareUrl];

//    [self _initWebPage];
    
    [self _init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ------------------------Init---------------------------------
- (void)_init{

//    self.pageTitle = @"分享有礼";
    
    _viewBG = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _viewBG.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    _viewBG.hidden=YES;
   
    WEAK_SELF
    [_viewBG addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            weak_self.bottomView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 135);
            weak_self.viewBG.hidden=YES;
        } completion:^(BOOL finished) {
            
            
        }];
        
    }];

    [self.view addSubview:_viewBG];
    
  
}

-(void)_initRightAllOrderItem {
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem initWithNormalImage:@"分享" target:self action:@selector(_rightItemClick) width:22 height:22];
    
}

- (void)_initWebPage{

    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
//    [userContentController addScriptMessageHandler:self name:@""];
//    [userContentController addScriptMessageHandler:self name:@""];
//    [userContentController addScriptMessageHandler:self name:@""];
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = userContentController;
    configuration.selectionGranularity = WKSelectionGranularityCharacter;
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) configuration:configuration];
    self.webView.allowsBackForwardNavigationGestures = YES;
//    self.webView.navigationDelegate = self;
//    self.webView.UIDelegate = self;
    
    [self.view addSubview:self.webView];

}
#pragma mark ------------------------Private-------------------------


- (void)_rightItemClick {
 
    if (self.viewBG.hidden ==YES) {
        
        _bottomView =  BoundNibView(@"DLShareBottomView", DLShareBottomView);
        _bottomView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 135);
        _viewBG.hidden=NO;
        WEAK_SELF
    _bottomView.wechatBlock = ^{
           
        [weak_self requestShareWechatFriends:@3];
        
    };
    
    
    
    _bottomView.friendsBlock = ^{
        
        [weak_self requestShareWechatCircleOfFriends:@2];
        

    };
    
    _bottomView.messageBlock = ^{
       
        [weak_self requestShareMessage];
    };
    
        [UIView animateWithDuration:0.3 animations:^{
            
            _bottomView.frame = CGRectMake(0, kScreenHeight-135-64, kScreenWidth, 135);
           
        } completion:^(BOOL finished) {
            
            
        }];
    
    
        [self.view addSubview:self.bottomView];
    }
}

- (void)_initCordavaPageWithWebUrl:(NSString *)urlStr {
    
    self.wwwFolderName = @"www";
//    self.startPage = jFormat(@"%@%@",ServerDomain,kUrl_CordovaTestHtml);
    self.startPage = urlStr;
    NSURL *url = [self performSelector:@selector(appUrl)];
    if (url)
    {
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        [self.webViewEngine loadRequest:request];
    }
    
    Share *share = (Share *)[self getCommandInstance:@"Share"];
    [share.webViewEngine evaluateJavaScript:[NSString stringWithFormat:@"corAppLoadFlag('%@')",@"webPageHasFinishLoaded"] completionHandler:^(id o, NSError *error) {
        
    }];
    
}


#pragma mark ------------------------Api----------------------------------
- (void)_requestShareUrl {
    [self MB_showLoadingHubWithText:nil];
    NSDictionary *parameters = @{@"typeCode":H5PAGETYPE_SHARE_PAGE};
    [AFNHttpRequestOPManager postWithParameters:parameters subUrl:kUrl_GetTypeUrl block:^(NSDictionary *resultDic, NSError *error) {
         [self MB_hideLoadingHub];
        if (error.code!=1) {
           
            return;
        }else{
            
            NSString *urlStr = [NSString stringWithFormat:@"%@",resultDic[EntityKey][@"value"]];
            NSURL *url = [NSURL URLWithString:urlStr];
//            [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
        }
        
    }];

}


//分享微信好友
- (void)requestShareWechatFriends:(NSNumber *)type{
    [self MB_showLoadingHubWithText:nil];
    
    [AFNHttpRequestOPManager postWithParameters:nil subUrl:kUrl_ShareFriends block:^(NSDictionary *resultDic, NSError *error) {
        [self MB_hideLoadingHub];
        if (isEmpty(resultDic[EntityKey])) {
            return;
        }
    
        XMShareWechatUtil *util = [XMShareWechatUtil sharedInstance];
        util.shareTitle = resultDic[EntityKey][@"title"];
        util.shareText = resultDic[EntityKey][@"content"];
        util.shareUrl = resultDic[EntityKey][@"redirectUrl"];
        if (!isEmpty(resultDic[EntityKey][@"imageUrl"])) {
        util.imageUrl = resultDic[EntityKey][@"imageUrl"];
        
        }
        util.shareType = type;
        [util shareToWeixinSession];
        
        
    }];
    
}
//分享朋友圈
- (void)requestShareWechatCircleOfFriends:(NSNumber *)type{
    [self MB_showLoadingHubWithText:nil];
    
    [AFNHttpRequestOPManager postWithParameters:nil subUrl:kUrl_ShareToMoments block:^(NSDictionary *resultDic, NSError *error) {
    
        [self MB_hideLoadingHub];
        if (isEmpty(resultDic[EntityKey])) {
            return;
        }
        XMShareWechatUtil *util = [XMShareWechatUtil sharedInstance];
        util.imageUrl = resultDic[EntityKey][@"imageUrl"];

        util.shareType = type;
        [util shareToWeixinTimeline];
    }];

    
}

- (void)requestShareMessage{
    [self MB_showLoadingHubWithText:nil];
    NSDictionary *dic = @{};
    WEAK_SELF
    [AFNHttpRequestOPManager postWithParameters:dic subUrl:kUrl_ShareTosms block:^(NSDictionary *resultDic, NSError *error) {
        
        [self MB_hideLoadingHub];
        if (isEmpty(resultDic[EntityKey])) {
            return;
        }
    
        
        
        //首先判断当前设备是否可以发送短信
        if([MFMessageComposeViewController canSendText])
        {
            MFMessageComposeViewController *mc=[[MFMessageComposeViewController alloc] init];
            
            //设置委托
            mc.messageComposeDelegate=weak_self;
            
            //短信内容
            mc.body=resultDic[EntityKey][@"content"];
            
            //设置短信收件方
            //        mc.recipients=[NSArray arrayWithObject:@"10010"];
            
            [weak_self presentViewController:mc animated:YES completion:nil];
        }else{
            
            [Util ShowAlertWithOnlyMessage:@"抱歉，没有此功能"];
            
            
        }

        
    }];

    
}
#pragma mark ------------------------Page Navigate---------------------------

#pragma mark ------------------------View Event---------------------------

#pragma mark ------------------------Delegate-----------------------------
//短信发送的处理结果
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result)
    {
        case MessageComposeResultSent:
            [self performSelector:@selector(_back) withObject:self afterDelay:1];
            
            break;
        case MessageComposeResultCancelled:
            
            [self _back];
            break;
        case MessageComposeResultFailed:
            NSLog(@"text message failed");
            break;
        default:
            NSLog(@"error happens");
            break;
    }
    
}

- (void)_back{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}


#pragma mark -------------------Delegate Method----------------------
////点击Url跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//    
//    NSString *strRequest = navigationAction.request.URL.absoluteString;
//    NSLog(@"%@",strRequest);
//    //  在发送请求之前，决定是否跳转
//    decisionHandler(WKNavigationActionPolicyAllow);
//}
//
//#pragma mark - WKScriptMessageHandler delegate
//- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
//    DDLogVerbose(@"方法名:%@", message.name);
//    DDLogVerbose(@"参数:%@", message.body);
//    // 方法名
//    NSString *methods = [NSString stringWithFormat:@"%@:", message.name];
//    SEL selector = NSSelectorFromString(methods);
//    // 调用方法
//    if ([self respondsToSelector:selector]) {
//        [self performSelector:selector withObject:message.body];
//    } else {
//        JLog(@"未实现方法：%@", methods);
//    }
//}



#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------




@end
