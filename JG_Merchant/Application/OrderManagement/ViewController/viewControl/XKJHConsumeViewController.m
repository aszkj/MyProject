//
//  XKJHConsumeViewController.m
//  Merchants_JingGang
//
//  Created by thinker on 15/9/2.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHConsumeViewController.h"
#import "XKJHConsumeSucceed.h"
#import <MBProgressHUD.h>
#import "XKJHCouponDetailsViewController.h"
#import "JGScanQCodeViewController.h"
#import "JGCheckConsumeController.h"
#import "UIAlertView+Blocks.h"
#import "UIAlertView+Extension.h"

@interface XKJHConsumeViewController ()<UIAlertViewDelegate>
{
    VApiManager *_vapiManager;
}

@property (weak, nonatomic  ) IBOutlet UITextField *textField;
@property (weak, nonatomic  ) IBOutlet UIButton    *certainBtn;

//消费成功提示
@property (nonatomic, strong) XKJHConsumeSucceed *succeedView;
//消费劵有误提示
@property (nonatomic, strong) UIView             *prompt;

// 二维码只有一个消费码数组
@property (strong,nonatomic) NSArray *groupSn;

@end

@implementation XKJHConsumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (NSArray *)groupSn {
    if (!_groupSn) {
        _groupSn = [NSArray array];
    }
    return _groupSn;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.textField.text = nil;
}
#pragma mark - 实例化UI
- (void)initUI
{
//    self.textField.text = @"7110579597";
    _vapiManager = [[VApiManager alloc] init];
    [Util setNavTitleWithTitle:@"劵消费" ofVC:self];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(btnClick) target:self];
    self.view.backgroundColor = VCBackgroundColor;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.certainBtn.layer.cornerRadius = 5;
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
}
//返回上一级界面
- (void) btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 扫码消费
- (IBAction)qrCodeAction:(id)sender {
    WEAK_SELF;
    JGScanQCodeViewController * sqVC = [[JGScanQCodeViewController alloc] initWithCodeSuccess:^(NSString *codeInfo) {
        
        [weak_self consumeCodeInfo:codeInfo nothing:^{
           // 没有未消费码
            [UIAlertView xf_showWithTitle:@"没有更多消费码" message:nil delay:1.2 onDismiss:^{
                
            }];
        } one:^(NSArray *groupSn) {
            /**
             *  
             {
             groupAccPath = "http://f1.jgyes.cn/2,15798077ed8f";
             groupId = 110;
             groupName = mm12121;
             groupSn = 0998481204;
             status = 0;
             totalPrice = 1;
             },
             */
            // 只有一个消费码 提示是否消费  点确定直接调用确认消费接口
            
            if (!groupSn.count) {
                return ;
            }
            weak_self.groupSn = groupSn;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"是否确认消费?" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alertView.tag = 100991;
            [alertView show];
            
        } more:^(NSDictionary *ParamsDic,NSString *orderId) {
            JGCheckConsumeController *check = [[JGCheckConsumeController alloc] initWithCodeParams:ParamsDic orderId:orderId];
            [weak_self.navigationController pushViewController:check animated:YES];
            
        }];
    } fail:^{
        
    }];
    UINavigationController * nVC = [[UINavigationController alloc]initWithRootViewController:sqVC];
    [self presentViewController:nVC animated:YES completion:nil];
}

// http://shop.jgyes.com/mobile_register.htm?invitationCode=life59520151228144151,8210571571,1259790066,5268417726,5017641676,8301714048,3792936735
- (void)consumeCodeInfo:(NSString *)info nothing:(void(^)())nothing one:(void(^)(NSArray *oneArray))oneBlock more:(void(^)(NSDictionary *moreArray,NSString *orderId))moreBlock{
    if (!info) {
        return;
    }
    NSArray *infoArray = [info componentsSeparatedByString:@"="];
    if (infoArray.count) {
        // 订单号 例如:1178
        NSString *orderId  = infoArray[1];
        VApiManager *manager = [[VApiManager alloc] init];
        PersonalUnUsedorderDetailsRequest *request = [[PersonalUnUsedorderDetailsRequest alloc] init:GetToken];
        request.api_orderId = [NSNumber numberWithInteger:[orderId integerValue]];
        
        [manager personalUnUsedorderDetails:request success:^(AFHTTPRequestOperation *operation, PersonalUnUsedorderDetailsResponse *response) {
            NSDictionary *orderDetails = [NSDictionary dictionaryWithDictionary:(NSDictionary *)response.orderDetails];
            NSArray *serviceList =  [NSArray arrayWithArray:orderDetails[@"serviceList"]];
            if (serviceList.count) {
                if (serviceList.count == 1 ) {
                    if (oneBlock) {
                        oneBlock(serviceList);
                    }
                }else {
                    if (moreBlock) {
                        moreBlock(orderDetails,orderId);
                    }
                }
                
            }else {
                if (nothing) {
                    nothing();
                }
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            JGLog(@"err:%@",error.domain);
            
        }];
        
    }
}



#pragma mark - 确认消费按钮
- (IBAction)certainConsumeAction:(UIButton *)sender
{
    if (self.textField.text.length == 0)
    {
        [Util ShowAlertWithOnlyMessage:@"劵消费码不能为空!"];
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在验证消费劵...";
    [hud show:YES];
    [self.textField resignFirstResponder];
    // 0998481204
    WEAK_SELF
    GroupVoucherDetailsRequest *detailRequest = [[GroupVoucherDetailsRequest alloc] init:GetToken];
    detailRequest.api_groupSn = self.textField.text;
    [_vapiManager groupVoucherDetails:detailRequest success:^(AFHTTPRequestOperation *operation, GroupVoucherDetailsResponse *response) {
        NSLog(@"cheshi ---- %@",response);
        [MBProgressHUD hideHUDForView:self.view animated: YES];
        GroupGoods *groupGoods = [GroupGoods objectWithKeyValues:response.groupGoodsDetails];
        if (groupGoods)
        {
            XKJHCouponDetailsViewController *detailsVC = [[XKJHCouponDetailsViewController alloc] initWithNibName:@"XKJHCouponDetailsViewController" bundle:nil];
            detailsVC.groupDoods= groupGoods;
            [weak_self.navigationController pushViewController:detailsVC animated:YES];
        }
        else
        {
            [weak_self showAlert];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [Util ShowAlertWithOnlyMessage:@"网络异常..."];
        [MBProgressHUD hideHUDForView:self.view.window  animated:YES];

    }];
}


#pragma mark - 消费券成功提示
- (void)succeedPrompt
{
    self.textField.text = nil;
    self.succeedView.hidden = NO;
    WEAK_SELF
    self.succeedView.succeedBlock = ^(){
        weak_self.succeedView.hidden = YES;
    };
}

#pragma mark - 无效消费码提示
- (void)showAlert
{
    self.textField.text = nil;
    self.prompt.alpha = 1;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(alertEndWithAnimation) userInfo:nil repeats:NO];
}
- (void)alertEndWithAnimation
{
    [UIView animateWithDuration:1 animations:^{
        _prompt.alpha = 0;
    } completion:^(BOOL finished) {
        
    }];
}


- (UIView *)prompt
{
    if (_prompt == nil)
    {
        _prompt = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 75, kScreenHeight /2 - 150, 150, 150)];
        _prompt.backgroundColor = UIColorFromRGB(0X555555);
        _prompt.layer.cornerRadius = 5;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
        label.center = CGPointMake(75, 75);
        label.font = [UIFont systemFontOfSize:18];
        label.text = @"无效的消费码";
        label.textColor = UIColorFromRGB(0Xaaaaaa);
        label.textAlignment = NSTextAlignmentCenter;
        [_prompt addSubview:label];
        [self.view addSubview:_prompt];
        [self.view bringSubviewToFront:_prompt];
    }
    return _prompt;
}
-(XKJHConsumeSucceed *)succeedView
{
    if (_succeedView == nil)
    {
        _succeedView = [[NSBundle mainBundle] loadNibNamed:@"XKJHConsumeSucceed" owner:nil options:nil][0];
        [_succeedView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, kScreenHeight));
        }];
        [self.view.window addSubview:_succeedView];
    }
    return _succeedView;
}
- (IBAction)hiddenKey:(UITapGestureRecognizer *)sender
{
    [self.textField resignFirstResponder];
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 100991) {
        // 扫码单个消费
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"正在验证消费劵...";
        [hud show:YES];
        [self.textField resignFirstResponder];
        GroupVoucherDetailsRequest *detailRequest = [[GroupVoucherDetailsRequest alloc] init:GetToken];
        NSDictionary *groupSnDic = [NSDictionary dictionaryWithDictionary:[self.groupSn firstObject]];
        detailRequest.api_groupSn = [NSString stringWithFormat:@"%@",groupSnDic[@"groupSn"]];
        [_vapiManager groupVoucherDetails:detailRequest success:^(AFHTTPRequestOperation *operation, GroupVoucherDetailsResponse *response) {
            [MBProgressHUD hideHUDForView:self.view animated: YES];
            GroupGoods *groupGoods = [GroupGoods objectWithKeyValues:response.groupGoodsDetails];
            if (groupGoods)
            {
                XKJHCouponDetailsViewController *detailsVC = [[XKJHCouponDetailsViewController alloc] initWithNibName:@"XKJHCouponDetailsViewController" bundle:nil];
                detailsVC.groupDoods= groupGoods;
                [self.navigationController pushViewController:detailsVC animated:YES];
            }
            else
            {
                [self showAlert];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [Util ShowAlertWithOnlyMessage:@"网络异常..."];
            [MBProgressHUD hideHUDForView:self.view.window  animated:YES];
        }];
    }
}

@end
