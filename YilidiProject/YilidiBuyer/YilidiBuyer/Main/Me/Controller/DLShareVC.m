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
#import "Operation.h"
#import "UIViewController+showHiddenBottomBarHandle.h"
#import "NSString+Teshuzifu.h"
#import "CDVViewController+cordovaExtend.h"

@interface DLShareVC ()<MFMessageComposeViewControllerDelegate>

@property (nonatomic,strong)UIView *viewBG;
@property (nonatomic,strong)DLShareBottomView *bottomView;

@end

@implementation DLShareVC

- (void)viewDidLoad {
    self.wwwFolderName = @"www";
    self.startPage = @"index";
    [super viewDidLoad];
   
    [self _requestShareUrl];
    
    [self _registerNotification];
    
    [self _init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self showHiddenBottomBarHandle];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;

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




#pragma mark ------------------------Private-------------------------
- (void)_shareToAllClick {
 
    if (self.viewBG.hidden ==YES) {
        
        _bottomView =  BoundNibView(@"DLShareBottomView", DLShareBottomView);
        _bottomView.frame = CGRectMake(0, kScreenHeight-135, kScreenWidth, 135);
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
            
            _bottomView.frame = CGRectMake(0, kScreenHeight-135, kScreenWidth, 135);
           
        } completion:^(BOOL finished) {
            
            
        }];
    
    
        [self.view addSubview:self.bottomView];
    }
}

- (void)_registerNotification {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(observeCordovaWebViewBeginLoad:)
                   name:CDVPluginResetNotification  // 开始加载
                 object:nil];
    [center addObserver:self
               selector:@selector(observeCordovaWebViewFinishedLoad:)
                   name:CDVPageDidLoadNotification  // 加载完成
                 object:nil];
}



- (void)_initCordavaPageWithWebUrl:(NSString *)urlStr {
    
    self.wwwFolderName = @"www";
    self.startPage = urlStr;
    NSURL *url = [self performSelector:@selector(appUrl)];
    if (url)
    {
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        [self.webViewEngine loadRequest:request];
    }
    
    Share *share = (Share *)[self getCommandInstance:@"Share"];
    WEAK_SELF
    share.shareToAllBlock = ^{
        [weak_self _shareToAllClick];
    };
    
    //微信朋友
    share.shareToFriendBlock = ^{
        [weak_self requestShareWechatFriends:@3];
    };
    
    //朋友圈
    share.shareToMomentBlock = ^{
       [weak_self requestShareWechatCircleOfFriends:@2];
    };
    
    share.shareSmsBlock = ^{
        [weak_self requestShareMessage];
    };

    Operation *operation = (Operation *)[self getCommandInstance:@"Operation"];
    operation.htmlBackBlock = ^{
        [weak_self _back];
    };
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
            urlStr = @"http://mtest.yldbkd.com/share/shareForGift.html";
            urlStr = [urlStr resolutionCordovaUrlStr];
            [self _initCordavaPageWithWebUrl:urlStr];
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
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -------------------Delegate Method----------------------

#pragma mark ------------------------Notification-------------------------
- (void)observeCordovaWebViewBeginLoad:(NSNotification *)info  {
    
}

- (void)observeCordovaWebViewFinishedLoad:(NSNotification *)info  {
    [self MB_hideLoadingHub];
    [self callJsMethodConfigure];
   
}



#pragma mark ------------------------Getter / Setter----------------------




@end
