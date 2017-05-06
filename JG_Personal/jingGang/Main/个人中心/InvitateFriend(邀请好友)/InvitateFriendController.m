//
//  InvitateFriendController.m
//  jingGang
//
//  Created by 张康健 on 15/10/27.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "InvitateFriendController.h"
#import "JGShareView.h"
#import "VApiManager.h"
#import "GlobeObject.h"
#import "MJExtension.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "PublicInfo.h"
#import "MyErWeiMaView.h"
#import "H5page_URL.h"
#import "ALActionSheetView.h"
#import "Masonry.h"
#import "InputInviteCodeController.h"
#import "InviteDetailController.h"
#import "ShareSettingController.h"


//http://static.jgyes.cn/static/app/yqfx.html#abc
@interface InvitateFriendController () {

    VApiManager *_vapManager;
    NSNumber    *_giveIntegral;
    NSString    *_invitationCode;
    BOOL        _isShowMyErWeiMa;
}
@property (weak, nonatomic) IBOutlet UIWebView *erweiMaWebView;

@property (weak, nonatomic) IBOutlet UIButton *imiditelyInvitateAction;

@property (nonatomic, strong)JGShareView *shareView;

@property (nonatomic, strong)ErweiMoModel *erweiMaModel;

@property (nonatomic, strong)MyErWeiMaView *myErWeiMaView;


@property (weak, nonatomic) IBOutlet UILabel *invitationCodeLabel;

@property (nonatomic, strong)NSString *shareContent;

@end

@implementation InvitateFriendController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _vapManager = [[VApiManager alloc] init];
    self.imiditelyInvitateAction.enabled = NO;
    
    [self _init];
    
    
    //获取用户信息，得到邀请码
    [self _usersInfoRequest];

    
    //获取注册会员赠送的积分
//    [self _registerMakeIntegralRequest];
    
    //请求分享内容
    [self _requestShareContent];
    
}


- (void)_init {
    
//    self.navigationController.navigationBar.barTintColor = kGetColor(94, 180, 231);
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    [Util setNavTitleWithTitle:@"邀请好友" ofVC:self];
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(back) target:self];
//    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem initWithNormalImage:@"icon_menu" target:self action:@selector(lookMyErWeiMaView) width:3 height:17];

    
}

- (void)_requestShareContent {
    
    UsersShareInfoGetRequest *request = [[UsersShareInfoGetRequest alloc] init:GetToken];
    
    
    [_vapManager usersShareInfoGet:request success:^(AFHTTPRequestOperation *operation, UsersShareInfoGetResponse *response) {

        NSLog(@"分享 response %@",response);
        self.shareContent = response.shareInfo;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        
    }];
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
        NSLog(@" 邀请码 %@",customer.invitationCode);
        self.invitationCodeLabel.text = customer.invitationCode;
        _invitationCode = customer.invitationCode;
        
        self.erweiMaModel = [[ErweiMoModel alloc] init];
        self.erweiMaModel.userErWeiMoHtmlStr = [NSString stringWithFormat:@"%@%@%@",StaticBase_Url,@"/static/app/yqfx.html#",_invitationCode];
        self.erweiMaModel.userInvitationCode = _invitationCode;
        self.erweiMaModel.userNickName = customer.nickName;
        self.erweiMaModel.userHeaderUrlStr = customer.headImgPath;
        [self _registerMakeIntegralRequest];
        [self showMyErWeiMaCongigure];
        
//        [self _setErWeiMaHtmlContent];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self _registerMakeIntegralRequest];
    }];

}

-(void)_setErWeiMaHtmlContent {
    
    [self.erweiMaWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_erweiMaModel.userErWeiMoHtmlStr]]];

}

-(void)lookMyErWeiMaView {

    [self showActionSheet];

}

-(void)showActionSheet {

    ALActionSheetView *actionSheetView = [ALActionSheetView showActionSheetWithTitle:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"我的二维码",@"填写邀请码",@"邀请明细",@"分享设置"] handler:^(ALActionSheetView *actionSheetView, NSInteger buttonIndex) {
        if (buttonIndex == 0) {//我的二维码
            [self showMyErWeiMaCongigure];
        }else if(buttonIndex == 1){
            //填写邀请码
            InputInviteCodeController *inputInviteCodeController = [[InputInviteCodeController alloc]init];
            [self.navigationController pushViewController:inputInviteCodeController animated:YES];
        }else if (buttonIndex == 2){
            //邀请明细
            InviteDetailController *inviteDetailController = [[InviteDetailController alloc]init];
            [self.navigationController pushViewController:inviteDetailController animated:YES];
            
        }else if (buttonIndex == 3){
            //分享设置
            ShareSettingController *shareSettinVC = [[ShareSettingController alloc] init];
            shareSettinVC.shareContent = self.shareContent;
            WEAK_SELF
            shareSettinVC.shareContentEditSuccessBlcok = ^(NSString *shareContent) {
                weak_self.shareContent = shareContent;
            };
            [self.navigationController pushViewController:shareSettinVC animated:YES];
        }
    }];
    
    
    [actionSheetView show];
}


-(void)showMyErWeiMaCongigure {
    if (!self.myErWeiMaView.erweimoModel) {
        self.myErWeiMaView.erweimoModel = _erweiMaModel;
    }
    self.myErWeiMaView.hidden = NO;
    _isShowMyErWeiMa = YES;
    [Util setNavTitleWithTitle:@"我的二维码" ofVC:self];
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem new];

}

-(void)hiddenMyErWeiMaConfigure {

    self.myErWeiMaView.hidden = YES;
    _isShowMyErWeiMa = NO;
    [Util setNavTitleWithTitle:@"邀请好友" ofVC:self];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem initWithNormalImage:@"icon_menu" target:self action:@selector(lookMyErWeiMaView) width:3 height:17];
    
}

- (void)back {
    if (!_isShowMyErWeiMa) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self hiddenMyErWeiMaConfigure];
    }
    
}


-(JGShareView *)shareView {
    
//    if (!_shareView) {
    
        NSString *shareContent = self.shareContent;
        if (!shareContent) {
            shareContent = kInvitationShareDescription1(_giveIntegral);
        }
        
        _shareView = [JGShareView shareViewWithTitle:shareContent content:shareContent imgUrlStr:kLogShareUrl ulrStr:kInvitationCodeShareUrlCode(_invitationCode) contentView:self.view];
        _shareView.weiBoShareModel.shareContent = kWeiboShareContent(_invitationCode, _giveIntegral);
        _shareView.wxShareModel.shareContent = shareContent;
        _shareView.wxFriendShareModle.shareTitle = shareContent;
        
//    }
    return _shareView;
}



-(MyErWeiMaView *)myErWeiMaView {
    if (!_myErWeiMaView) {
        _myErWeiMaView = BoundNibView(@"ErweimaView", MyErWeiMaView);
        [self.view addSubview:_myErWeiMaView];
        WEAK_SELF;
        [_myErWeiMaView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weak_self.view);
        }];
    }
    
    return _myErWeiMaView;
}


- (IBAction)invitateAction:(id)sender {
    
    [self.shareView show];
    
}


@end
