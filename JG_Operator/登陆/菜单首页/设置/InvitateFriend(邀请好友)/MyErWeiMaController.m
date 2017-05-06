//
//  InvitateFriendController.m
//  jingGang
//
//  Created by 张康健 on 15/10/27.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "MyErWeiMaController.h"
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
#import "InvitateFriendsController.h"
#import "UIView+Screenshot.h"
#import "XKO_BaseInfoResponseInfo.h"

//#import "TakePhotoUpdateImg.h"

//http://static.jgyes.cn/static/app/yqfx.html#abc
@interface MyErWeiMaController () <MyErWeiMaViewDelegate>{

    VApiManager *_vapManager;
    NSNumber    *_giveIntegral;
    NSString    *_invitationCode;
    BOOL        _isShowMyErWeiMa;

}
@property (nonatomic, strong)NSString *erweimaSnapedUrl;

@property (nonatomic, strong)JGShareView *shareView;

@property (nonatomic, strong)ErweiMoModel *erweiMaModel;

@property (nonatomic, strong)MyErWeiMaView *myErWeiMaView;

@property (nonatomic, strong)NSString *shareContent;
@property (nonatomic, strong) UIImage *shareImage;
/**
 *  用户名字,分享者名称，如果有名字就用名字，如果没有名字就用昵称
 */
@property (nonatomic, copy)  NSString *strName;
/**
 *  分享二维码QQ空间，微博需要图片url。微信直接可以发图片
 */
@property (nonatomic, copy)  NSString *strShareErWeiMaImageUrl;




@end

@implementation MyErWeiMaController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _vapManager = [[VApiManager alloc] init];
    
    [self _init];
    self.navigationItem.title = @"邀请好友";
    
    //获取用户信息，得到邀请码
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    [self _usersInfoRequest];
    

    //请求分享内容
    [self _requestShareContent];

    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.navigationController.navigationBar.hidden) {
        self.myErWeiMaView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        self.navigationController.navigationBar.hidden = NO;
    }
    
}



- (void)_requestShareContent {
    
    UsersShareInfoGetRequest *request = [[UsersShareInfoGetRequest alloc] init:GetToken];
    
    
    [_vapManager usersShareInfoGet:request success:^(AFHTTPRequestOperation *operation, UsersShareInfoGetResponse *response) {
        
        NSLog(@"分享 response %@",response);
        self.shareContent = response.shareInfo;
        self.erweiMaModel.userShareContent = self.shareContent;
        
        [self _usersInfoRequest];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
}



- (void)_init {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.myErWeiMaView.delegate = self;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(back) target:self];
    self.navigationItem.rightBarButtonItem = [self rightButton];
    self.erweiMaModel = [[ErweiMoModel alloc] init];

}



-(void)_usersInfoRequest {
    
    WEAK_SELF
    XKO_BaseInfoRequestInfo *info = [[XKO_BaseInfoRequestInfo alloc] init];
    [self.dataCenter requestOperatorInfoFromModel:info successBlk:^(NSArray *responseData) {
        
        
        NSDictionary *dic = [responseData [0] keyValues];

        _invitationCode = [NSString stringWithFormat:@"%@",dic[@"invitationCode"]];

        weak_self.strName = [NSString stringWithFormat:@"%@",dic[@"userName"]];
        
        weak_self.erweiMaModel.userErWeiMoHtmlStr = [NSString stringWithFormat:@"%@%@%@",StaticBase_Url,@"/static/app/yqfx.html#",_invitationCode];
        weak_self.erweiMaModel.userInvitationCode = _invitationCode;
        weak_self.erweiMaModel.userNickName = weak_self.strName;
//        weak_self.erweiMaModel.userHeaderUrlStr = customer.headImgPath;
        [weak_self showMyErWeiMaCongigure];
        [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
    
    } failBlk:^(NSError *error) {
        [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
        
    }];

    
}






-(void)lookMyErWeiMaView {

    [self showActionSheet];

}

-(void)showActionSheet {

    ALActionSheetView *actionSheetView = [ALActionSheetView showActionSheetWithTitle:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"我的邀请码",@"邀请明细",@"分享设置"] handler:^(ALActionSheetView *actionSheetView, NSInteger buttonIndex) {
        if (buttonIndex == 0) {//我的邀请码
            InvitateFriendsController *invitateFriendsController = [[InvitateFriendsController alloc]init];
            invitateFriendsController.strInvitateCode = _invitationCode;
            [self.navigationController pushViewController:invitateFriendsController animated:YES];
            
        }else if(buttonIndex == 1){
            //填写邀请码
//            InputInviteCodeController *inputInviteCodeController = [[InputInviteCodeController alloc]init];
//            [self.navigationController pushViewController:inputInviteCodeController animated:YES];
            //邀请明细
            InviteDetailController *inviteDetailController = [[InviteDetailController alloc]init];
            [self.navigationController pushViewController:inviteDetailController animated:YES];
        }else if (buttonIndex == 2){
            //分享设置
            ShareSettingController *shareSettinVC = [[ShareSettingController alloc] init];
            shareSettinVC.shareContent = self.shareContent;
            WEAK_SELF
            shareSettinVC.shareContentEditSuccessBlcok = ^(NSString *shareContent) {
                weak_self.shareContent = shareContent;
                weak_self.erweiMaModel.userShareContent = shareContent;
                weak_self.myErWeiMaView.erweimoModel = weak_self.erweiMaModel;
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
//    [Util setNavTitleWithTitle:@"邀请好友" ofVC:self];

}


- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark -- MyErWeiMaViewDelegate
- (void)myErWeiMaViewImmediatelyInviteButtonClick
{
//    //友盟事件点击统计
//    
//    [MobClick endEvent:kShareInviteEventMobClickKey];
    NSString *strNullReturn = [self descriptionNullStringWithUserName:self.strName invitationCode:_invitationCode shareContent:self.shareContent];
    if (strNullReturn) {
        [self hideHubWithOnlyText:strNullReturn];
        return;
    }
    
    
    [self.shareView show];
}

- (void)shareErweimaButtonClick {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"shareImage.png"]];
    // 保存文件的名称
    BOOL result = [UIImagePNGRepresentation(self.shareImage)writeToFile: filePath    atomically:YES];
    if (result) {
        _shareView.wxShareModel.shareImagePath = filePath;
        _shareView.wxFriendShareModle.shareImagePath = filePath;
        _shareView.qqShareModel.shareImagePath = filePath;
        _shareView.weiBoShareModel.shareImagePath = filePath;
        
        
        NSString *strNullReturn = [self descriptionNullStringWithUserName:self.strName invitationCode:_invitationCode shareContent:self.shareContent];
        if (strNullReturn) {
            [self hideHubWithOnlyText:strNullReturn];
            return;
        }
        
        NSString *strInviteTitle = [NSString stringWithFormat:@"我是%@,我向您推荐静港云e生!",self.strName];
        NSString *shareContent = self.shareContent;
        if (!shareContent) {
            shareContent = kInvitationShareDescription1(_giveIntegral);
        }
        
        
        _shareView = [JGShareView shareViewWithTitle:strInviteTitle content:shareContent imgUrlStr:self.strShareErWeiMaImageUrl ulrStr:self.strShareErWeiMaImageUrl  contentView:self.view shareImagePath:filePath];
        [_shareView show];
    }

}

//右侧按钮
- (UIBarButtonItem *)rightButton
{
    UIButton *navRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    navRightButton.frame= CGRectMake(0, 0, 70, 36);

    [navRightButton addTarget:self action:@selector(lookMyErWeiMaView) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(60, 10, 3, 17)];
    imageView.image = [UIImage imageNamed:@"icon_menu"];
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 10, 70, 36)];
    view.backgroundColor = [UIColor clearColor];
    
    [view addSubview:imageView];
    [view addSubview:navRightButton];
    //为了解决按钮过小问题，加了一个透明的大按钮
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:view];
    return item;
}


-(JGShareView *)shareView {
    

    NSString *shareContent = self.shareContent;
    if (!shareContent) {
        shareContent = kInvitationShareDescription1(_giveIntegral);
    }
    NSString *strInviteTitle = [NSString stringWithFormat:@"我是%@,我向您推荐静港云e生!",self.strName];
    
    _shareView = [JGShareView shareViewWithTitle:strInviteTitle content:shareContent imgUrlStr:kLogShareUrl ulrStr:kInvitationCodeShareUrlCode(_invitationCode) contentView:self.view shareImagePath:nil];
    _shareView.weiBoShareModel.shareContent = kWeiboShareContent(_invitationCode, self.shareContent);
    
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
        //邀请码截图获取block
        _myErWeiMaView.erweimaSnapUrlGetBlock = ^(UIImage *image, NSString *shareImageUrl){
            
            weak_self.shareImage = image;
            weak_self.strShareErWeiMaImageUrl = shareImageUrl;
        };
//        //分享二维码block
//        __block JGShareView *shareView = _shareView;
//        _myErWeiMaView.shareErweimaBlock = ^{
//           NSString *strInviteTitle = [NSString stringWithFormat:@"我是%@,我向您推荐静港云e生!",weak_self.strName];
//            [shareView removeFromSuperview];
//            shareView = [JGShareView shareViewWithTitle:nil content:nil imgUrlStr:weak_self.erweimaSnapedUrl ulrStr:weak_self.erweimaSnapedUrl contentView:weak_self.view];
//            shareView.qqShareModel.shareTitle = strInviteTitle;
//            shareView.qqShareModel.shareContent = strInviteTitle;
//            [shareView show];
//        };
    }
    
    return _myErWeiMaView;
}

- (BOOL)judgeStringIsNoNull:(NSString *)str
{
    
    if(!str || [str isEqualToString:@"(null)"] || [str isEqualToString:@""]){
        return YES;
    }else{
        return NO;
    }
}
- (NSString *)descriptionNullStringWithUserName:(NSString *)userName invitationCode:(NSString *)invitationCode shareContent:(NSString *)shareContent{
    if ([self judgeStringIsNoNull:userName]) {
        return @"因网络问题用户昵称不存在";
    }if ([self judgeStringIsNoNull:invitationCode]) {
        return @"因网络问题分享码不存在";
    }if ([self judgeStringIsNoNull:shareContent]) {
        return @"因网络问题分享内容不存在";
    }else{
        return nil;
    }
}





@end
