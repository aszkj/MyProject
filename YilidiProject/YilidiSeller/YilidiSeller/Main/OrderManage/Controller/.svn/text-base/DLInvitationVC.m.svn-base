//
//  DLInvitationVC.m
//  YilidiSeller
//
//  Created by yld on 16/6/3.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLInvitationVC.h"
#import "DLInvitationRecordVC.h"
#import "DLQrCodeView.h"
#import "GlobleConst.h"
#import "UIImageView+sd_SetImg.h"
@interface DLInvitationVC ()
@property (nonatomic,strong)DLQrCodeView *codeView;
@property (nonatomic,strong)UIView *viewBG;
@end

@implementation DLInvitationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _init];
    [self _initRightItem];
    self.pageTitle =@"邀请有礼";
    self.navigationController.view.backgroundColor  = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ------------------------Init---------------------------------
- (void)_init {
    
    
    NSDictionary *dic = [kUserDefaults objectForKey:HomeResponeData];
    if (dic!=nil) {
        _recommendedCode.text = [NSString stringWithFormat:@"%@",dic[@"invitationCode"]];
        
    }
    
    _viewBG = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _viewBG.backgroundColor = [UIColor blackColor];
    _viewBG.alpha=0.7;
    _viewBG.hidden=YES;
    [self.view addSubview:_viewBG];

   
    
}

- (void)_initRightItem {

    UIImageView *rightView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 22)];
    rightView.image = [UIImage imageNamed:@"record"];
    rightView.backgroundColor = [UIColor clearColor];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 22)];
    [btn addTarget:self action:@selector(_rightClick) forControlEvents:UIControlEventTouchUpInside];
    [btn addSubview:rightView];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
}
#pragma mark ------------------------Private-------------------------
- (void)_rightClick {

    DLInvitationRecordVC *recordVC = [[DLInvitationRecordVC alloc]init];
    [self navigatePushViewController:recordVC animate:YES];
}

#pragma mark ------------------------Api----------------------------------
#pragma mark ------------------------Page Navigate---------------------------


#pragma mark ------------------------View Event---------------------------

- (IBAction)qrCodeClick:(id)sender {
    
    _codeView =  BoundNibView(@"DLQrCodeView", DLQrCodeView);
    _codeView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 234);
    _viewBG.hidden=NO;
    _codeView.invitationCode.text = _recommendedCode.text;
    [UIView animateWithDuration:0.3 animations:^{
        
        _codeView.frame = CGRectMake(0, kScreenHeight-234-64, kScreenWidth, 234);
        [_codeView.codeImage sd_SetImgWithUrlStr:@"http://upload.yldbkd.com:8080/images/qrcode/buyer.png" placeHolderImgName:nil];
        
    } completion:^(BOOL finished) {
        
        
    }];

    WEAK_SELF
    _codeView.cancelBlock = ^{

        [UIView animateWithDuration:0.3 animations:^{

            weak_self.codeView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 234);
            weak_self.viewBG.hidden=YES;
        } completion:^(BOOL finished) {


        }];

        
    };
    
    [self.view addSubview:self.codeView];
}


#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------



@end
