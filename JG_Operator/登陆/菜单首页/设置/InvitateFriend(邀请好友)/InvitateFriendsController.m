//
//  InvitateFriendsController.m
//  jingGang
//
//  Created by HanZhongchou on 15/12/22.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "InvitateFriendsController.h"
#import "JGShareView.h"
#import "VApiManager.h"
#import "Global.h"
#import "MJExtension.h"
#import "UIBarButtonItem+WNXBarButtonItem2.h"
//#import "PublicInfo.h"
#import "MyErWeiMaView.h"
//#import "H5page_URL.h"
#import "ALActionSheetView.h"
#import "Masonry.h"
#import "InputInviteCodeController.h"
#import "InviteDetailController.h"
#import "ShareSettingController.h"


//http://static.jgyes.cn/static/app/yqfx.html#abc
@interface InvitateFriendsController () {
    
    VApiManager *_vapManager;
    NSNumber    *_giveIntegral;
    NSString    *_invitationCode;
}


@property (weak, nonatomic) IBOutlet UIButton *imiditelyInvitateAction;

@property (nonatomic, strong)JGShareView *shareView;

@property (nonatomic, strong)ErweiMoModel *erweiMaModel;

@property (nonatomic, strong)MyErWeiMaView *myErWeiMaView;
/**
 *  分享内容
 */
@property (nonatomic, copy)  NSString *shareContent;

@property (weak, nonatomic) IBOutlet UILabel *invitationCodeLabel;

@end

@implementation InvitateFriendsController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    [self _init];
    
    
    //请求分享内容
    [self _requestShareContent];
    
    
}

- (void)_requestShareContent {
    
    UsersShareInfoGetRequest *request = [[UsersShareInfoGetRequest alloc] init:GetToken];
    
    
    [_vapManager usersShareInfoGet:request success:^(AFHTTPRequestOperation *operation, UsersShareInfoGetResponse *response) {
        
        NSLog(@"分享 response %@",response);
        self.shareContent = response.shareInfo;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
}


- (void)_init {
    
    self.invitationCodeLabel.text = self.strInvitateCode;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _vapManager = [[VApiManager alloc] init];
    self.navigationItem.title = @"我的二维码";
    self.imiditelyInvitateAction.layer.cornerRadius = 4.0;
    
}


- (void)_registerMakeIntegralRequest {
    
    SnsIntegralGetRequest *request = [[SnsIntegralGetRequest alloc] init:GetToken];
    request.api_type = @1;
    [_vapManager snsIntegralGet:request success:^(AFHTTPRequestOperation *operation, SnsIntegralGetResponse *response) {
        
        if ([response isMemberOfClass:[SnsIntegralGetResponse class]]) {
            _giveIntegral = response.integral;
        }else if ([response isMemberOfClass:[NSDictionary class]]){
            SnsIntegralGetResponse *integralResponse = [SnsIntegralGetResponse objectWithKeyValues:response];
            NSLog(@"注册送 %@积分",integralResponse.integral);
            _giveIntegral = integralResponse.integral;
        }
        
        self.imiditelyInvitateAction.enabled = YES;
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
        
    }];
    
    
}


-(void)_usersInfoRequest {
    
    UsersCustomerSearchRequest *request = [[UsersCustomerSearchRequest alloc] init:GetToken];
    [_vapManager usersCustomerSearch:request success:^(AFHTTPRequestOperation *operation, UsersCustomerSearchResponse *response) {
        
        UserCustomer *customer = [UserCustomer objectWithKeyValues:response.customer];
        
        self.erweiMaModel = [[ErweiMoModel alloc] init];
        self.erweiMaModel.userErWeiMoHtmlStr = [NSString stringWithFormat:@"%@%@%@",StaticBase_Url,@"/static/app/yqfx.html#",_invitationCode];
        self.erweiMaModel.userInvitationCode = _invitationCode;
        self.erweiMaModel.userNickName = customer.nickName;
        self.erweiMaModel.userHeaderUrlStr = customer.headImgPath;
        [self _registerMakeIntegralRequest];

        
        //        [self _setErWeiMaHtmlContent];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self _registerMakeIntegralRequest];
    }];
    
}








-(JGShareView *)shareView {
    
    NSString *shareContent = self.shareContent;
    if (!shareContent) {
        shareContent = kInvitationShareDescription1(_giveIntegral);
    }
    
    _shareView = [JGShareView shareViewWithTitle:shareContent content:shareContent imgUrlStr:kLogShareUrl ulrStr:kInvitationCodeShareUrlCode(_invitationCode) contentView:self.view shareImagePath:nil];
    
    _shareView.weiBoShareModel.shareContent = kWeiboShareContent(self.strInvitateCode, self.shareContent);
    JGLog(@"%@",_shareView.weiBoShareModel.shareContent);
    return _shareView;
}




- (IBAction)invitateAction:(id)sender {
    
    [self.shareView show];
    
}


@end
