//
//  DLCordovaH5VC+shareModule.m
//  YilidiBuyer
//
//  Created by mm on 16/12/20.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLCordovaH5VC+shareModule.h"
#import "XMShareWechatUtil.h"
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
#import "NSObject+SUIAdditions.h"

const void *shareBgViewKey = @"shareBgViewKey";
const void *shareBottomViewKey = @"shareBottomViewKey";


@implementation DLCordovaH5VC (shareModule)

- (void)initShareModule{
    
    UIView *_viewBG=nil;
    
    _viewBG = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self sui_setAssociatedRetainObject:_viewBG key:shareBgViewKey];
    _viewBG.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    _viewBG.hidden=YES;
    
    WEAK_SELF
    WEAK_OBJ(_viewBG)
    [_viewBG addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        DLShareBottomView *bottomView = (DLShareBottomView *)[weak_self sui_getAssociatedObjectWithKey:shareBottomViewKey];
        [UIView animateWithDuration:0.3 animations:^{
            bottomView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 135);
            weak__viewBG.hidden=YES;
        } completion:^(BOOL finished) {
            
        }];
        
    }];
    
    [self.view addSubview:_viewBG];
    
}




#pragma mark ------------------------Private-------------------------
- (void)_shareToAllClick {
    UIView *_viewBG= [self sui_getAssociatedObjectWithKey:shareBgViewKey];
    DLShareBottomView *_bottomView = (DLShareBottomView *)[self sui_getAssociatedObjectWithKey:shareBottomViewKey];
    if (_viewBG.hidden ==YES) {
        
        _bottomView =  BoundNibView(@"DLShareBottomView", DLShareBottomView);
        [self sui_setAssociatedRetainObject:_bottomView key:shareBottomViewKey];

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
        
        
        [self.view addSubview:_bottomView];
    }
}


- (void)initSharePlugin{
    

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
    
}


#pragma mark ------------------------Api----------------------------------
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













@end
