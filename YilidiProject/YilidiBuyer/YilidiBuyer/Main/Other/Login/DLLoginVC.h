//
//  DLLoginVC.h
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/10/8.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLBuyerBaseController.h"
#import "ProjectRelativEmerator.h"
#import "JKCountDownButton.h"
typedef void(^BackPerHomePageBlock)(NSInteger backHomePageIndex);

@interface DLLoginVC : DLBuyerBaseController

@property (nonatomic,assign)BOOL enterFromLoginOrLogout;
@property (strong, nonatomic) IBOutlet JKCountDownButton *getCodeBtn;

@property (nonatomic,assign)ComeToLoginPageType comeToLoginPageType;
@property (strong, nonatomic) IBOutlet UITextField *phoneFiled;
@property (strong, nonatomic) IBOutlet UITextField *codeField;
@property (strong, nonatomic) IBOutlet UITextField *passWordFiled;
@property (strong, nonatomic) IBOutlet UITextField *InviteCodeField;
@property (strong, nonatomic) IBOutlet UIView *regisBtnBgView;
@property (strong, nonatomic) IBOutlet UIButton *selectedButton;
@property (strong, nonatomic) IBOutlet UILabel *isInvitationLabel;
@property (strong, nonatomic) IBOutlet UIImageView *loginHeadImage;
@property (strong, nonatomic) IBOutlet UIView *wechatAndQQbgView;
@property (strong, nonatomic) IBOutlet UIButton *wechatBtn;
@property (strong, nonatomic) IBOutlet UIButton *qqBtn;

/**
 *  从各个首页进入登陆页，
 */
- (void)comFromPerHomePageOfIndex:(NSInteger)homeIndex backBlock:(BackPerHomePageBlock)backBlock;

@end
