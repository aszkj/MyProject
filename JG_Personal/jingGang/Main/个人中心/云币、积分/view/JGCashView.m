//
//  JGCashView.m
//  jingGang
//
//  Created by dengxf on 16/1/7.
//  Copyright © 2016年 yi jiehuang. All rights reserved.
//

#import "JGCashView.h"
#import "UITextField+Blocks.h"
#import "JGDropdownMenu.h"
#import "JGCloudAndValueManager.h"
#import "JGInputPayPassword.h"
#import "UIAlertView+Extension.h"

typedef void(^CashSuccessBlock)(CloudBuyerCashSaveResponse *response);

@interface JGCashView ()<UIAlertViewDelegate>
/**
 *  支付的图标 */
@property (weak, nonatomic) IBOutlet UIImageView *incoImage;

/**
 *  支付名称 */
@property (weak, nonatomic) IBOutlet UILabel *payTypeName;

/**
 *  支付信息 */
@property (weak, nonatomic) IBOutlet UILabel *payTypeInfo;


@property (weak, nonatomic) IBOutlet UIButton *selecteCashTypeButton;


/**
 *  提现金额金额 */
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;


/**
 *  记录选择银行支付信息模型 */
@property (strong,nonatomic) JGBankInfoModel *selectBankInfoModel;

/**
 *  记录选择支付宝支付信息模型 */
@property (strong,nonatomic) JGAliInfoModel *selectAliInfoModel;

/**
 *  记录选择支付的类型 */
@property (assign, nonatomic) NSInteger selectPayType;

/**
 *  记录提现密码 */
@property (copy , nonatomic) NSString *cashPayPassword;

/**
 *  备注
 */
@property (weak, nonatomic) IBOutlet UITextField *composeTextField;

/**
 *  是否设置cashId为空
 */
@property (assign, nonatomic) BOOL isSettedCashIdNull;

/**
 *  提现成功回调
 */
@property (copy , nonatomic) CashSuccessBlock cashSuccess;



@end

@implementation JGCashView

- (instancetype)initWithCashActionSuccess:(void (^)(CloudBuyerCashSaveResponse *))cashSuccess
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
//        self.contentSize = CGSizeMake(ScreenWidth, 600);
        [self.selecteCashTypeButton setBackgroundColor:[UIColor whiteColor]];
        [self.selecteCashTypeButton setTitle:@"请选择提现方式" forState:UIControlStateNormal];
        [self.selecteCashTypeButton setTitleColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.68] forState:UIControlStateNormal];
        self.cashSuccess = cashSuccess;
    }
    return self;
}

- (NSArray *)plistArray {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"bankinfo" ofType:@"plist"];
    NSArray *data = [[NSArray alloc] initWithContentsOfFile:plistPath];
    return data;
}

- (void)setTotleValue:(NSString *)totleValue {
    _totleValue = totleValue;
    self.amountTextField.placeholder = totleValue;
}

- (void)setCloudPredepositCash:(CloudForm *)cloudPredepositCash {
    // cashPayment 提现类型
    _cloudPredepositCash = cloudPredepositCash;
    // 将按钮设置为透明色、按钮标题设置为空
    [self.selecteCashTypeButton setBackgroundColor:[UIColor clearColor]];
    [self.selecteCashTypeButton setTitle:@"" forState:UIControlStateNormal];
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:(NSDictionary *)cloudPredepositCash];
    NSString *cashPayment = dict[@"cashPayment"];
    if ([cashPayment isEqualToString:@"chinabank"]) {
        // 提现银行卡
        // 银行图标
        NSArray *plistData = [self plistArray];
        for (NSDictionary *plistDict in plistData) {
            NSArray *plistArray = [plistDict allValues];
            NSString *bankName = [plistArray lastObject];
            if ([bankName isEqualToString:dict[@"cashBank"]]) {
                plistArray = [plistDict allKeys];
                NSString *iconImage = [plistArray lastObject];
                self.incoImage.image = [UIImage imageNamed:iconImage];
                self.payTypeName.text = dict[@"cashBank"];
                self.payTypeInfo.text = [self intercepteBankCardNumberOfFourTail:TNSString(dict[@"cashAccount"])];
            }
        }
    }else {
        // 提现支付宝
        self.incoImage.image = [UIImage imageNamed:@"jg_aliicon"];
        self.payTypeName.text = dict[@"cashUserName"];
        self.payTypeInfo.text = dict[@"cashAccount"];
    }
}

/**
 *   选择提现方式
 *
 */
- (IBAction)selecetPayTypeAction:(UIButton *)sender {
    JGDropdownMenu *menu = [JGDropdownMenu menu];
    [menu configTouchViewDidDismissController:NO];
    [menu configBgShowMengban];
    __weak typeof(JGDropdownMenu *)weakMenu = menu;
    WeakSelf;
    JGUserSelectCashTypeController *userSelectCashTypeController = [[JGUserSelectCashTypeController alloc] initWithSelecteCashControllerWithCloseBlock:^{
        
        [weakMenu dismiss];
    } infoBlock:^(NSInteger selectPayType, id model) {
        // 0. 银行卡提现    1.支付宝提现
        // 要做出是否要将cashid置空
        JGLog(@"selectedModel:%@",model);
        BOOL isSettedCashIdNull = YES;  // no是使用cashid
        if (!bself.cloudPredepositCash) {
            // 不存在默认提现表单
            isSettedCashIdNull = YES;
        }else {
            // 存在提现表单  确定表单是否改变
            if ([model isKindOfClass:[JGBankInfoModel class]]) {
                // 选择了银行信息模型
                // 如果默认是选择银行的话，就要比较银行信息了，反之是支付宝就将cashid置空
                NSDictionary *BankDict = [NSDictionary dictionaryWithDictionary:(NSDictionary *)bself.cloudPredepositCash];
                if ([BankDict[@"cashPayment"] isEqualToString:@"chinabank"]) {
                    // 默认是银行信息
                    JGBankInfoModel *bankModel = (JGBankInfoModel *)model;
                    if ([bankModel.userName isEqualToString:BankDict[@"cashUserName"]] && [bankModel.cardNumber isEqualToString:TNSString(BankDict[@"cashAccount"])] && [bankModel.openAccoutBank isEqualToString:BankDict[@"cashBank"]] &&[bankModel.branchBank isEqualToString:BankDict[@"cashSubbranch"]] ) {
                        // 提现信息没有改变
                        isSettedCashIdNull = NO;
                    }else {
                        isSettedCashIdNull = YES;
                    }
                }else {
                    isSettedCashIdNull = YES;
                }
            }else if ([model isKindOfClass:[JGAliInfoModel class]]) {
                // 选择了支付宝信息模型
                JGAliInfoModel *aliModel = (JGAliInfoModel *)model;
                NSDictionary *aliDict = [NSDictionary dictionaryWithDictionary:(NSDictionary *)bself.cloudPredepositCash];
                if ([aliDict[@"cashPayment"] isEqualToString:@"alipay"]) {
                    // 如果默认是选择支付宝的话，就要比较支付宝信息了，反之是银行卡，就将cashid置空
                    // 如果默认选择的是支付报信息，
                    // 检测有没有修改提现信息
                    if ([aliDict[@"cashUserName"] isEqualToString:aliModel.userName] && [aliDict[@"cashAccount"] isEqualToString:aliModel.userAccout]) {
                        // 提现信息没有改变
                        isSettedCashIdNull = NO;
                    }else {
                        isSettedCashIdNull = YES;
                    }
                }else {
                    // 之前默认是支付宝 ，现在选择是银行卡  cashid改变
                    isSettedCashIdNull = YES;
                }
            }
            
            
        }
        // 选择支付方式后，记录需不需要将cashIdNull置为空
        bself.isSettedCashIdNull = isSettedCashIdNull;
        [bself updateInterfaceWithSelectedPayType:selectPayType infoModel:model];
        [weakMenu dismiss];
    }];
    if (self.cloudPredepositCash) {
        // 存在默认提现表单传值下去
        userSelectCashTypeController.cloudPredepositCash = self.cloudPredepositCash;
    }
    userSelectCashTypeController.view.width = ScreenWidth - 20;
    userSelectCashTypeController.view.height = 320;
    userSelectCashTypeController.view.x = 10;
    userSelectCashTypeController.view.y = 200;
    menu.contentController = userSelectCashTypeController;
    [menu showWithKeyWindowWithDuration:0.27];
}


/**
 *  更新界面
 *  @param selectPayType 选择的支付方式 0.银行卡  1. 支付宝
 *  @param model         选择支付方式的信息 */
- (void)updateInterfaceWithSelectedPayType:(NSInteger)selectPayType infoModel:(id)model {
    // 将按钮设置为透明色、按钮标题设置为空
    [self.selecteCashTypeButton setBackgroundColor:[UIColor clearColor]];
    [self.selecteCashTypeButton setTitle:@"" forState:UIControlStateNormal];
    
    // 记录选择支付的类型
    self.selectPayType = selectPayType;

    switch (selectPayType) {
        case 0:
        {
            JGBankInfoModel *bankModel = (JGBankInfoModel *)model;
            if (!bankModel.bankIncoImageName) {
                NSArray *plistArray = [self plistArray];
                for (NSDictionary *dic in plistArray) {
                    NSArray *values = [dic allValues];
                    NSString *value = [values lastObject];
                    if ([value isEqualToString:bankModel.openAccoutBank]) {
                        NSArray *keys = [dic allKeys];
                        NSString *key = [keys lastObject];
                        self.incoImage.image = [UIImage imageNamed:key];
                    }
                }
            }else {
                self.incoImage.image = [UIImage imageNamed:bankModel.bankIncoImageName];
            }
            self.payTypeName.text = bankModel.openAccoutBank;
            self.payTypeInfo.text = [self intercepteBankCardNumberOfFourTail:bankModel.cardNumber];
            self.selectBankInfoModel = bankModel;
            self.selectAliInfoModel = nil;

        }
            break;
        case 1:
        {
            JGAliInfoModel *aliModel = (JGAliInfoModel *)model;
            self.incoImage.image = [UIImage imageNamed:@"jg_aliicon"];
            self.payTypeName.text = aliModel.userName;
            self.payTypeInfo.text = aliModel.userAccout;
            self.selectAliInfoModel = aliModel;
            self.selectBankInfoModel = nil;

        }
            break;
        default:
            break;
    }
}

/**
 *  截取银行卡号尾数四位 */
- (NSString *)intercepteBankCardNumberOfFourTail:(NSString *)text{
    NSUInteger length = text.length;
    if (length <4) {
        return nil;
    }else {
        NSRange range = NSMakeRange(length - 4, 4);
        NSString *subString = [text substringWithRange:range];
        subString = [NSString stringWithFormat:@"尾号(%@)储蓄卡",subString];
        return subString;
    }
}

- (IBAction)cashWithInputPayPassword:(id)sender {
    // 检测信息是否填完整
    BOOL result = [self checkCashInputFillInComplete];
    if (!result) {
        return;
    }
    
    [self endEditing:YES];
    // 输入支付密码 ---
    // 1. 设置过支付密码 直接显示输入支付密码界面框
    // 2. 没设置过支付密码 跳转到设置支付密码
    [self showHud];
    
    WeakSelf;
    [JGCloudAndValueManager inquiryUserDidSetPayPasswordWithResult:^(BOOL result) {
        [bself hiddenHud];
        if (result) {
            // 已经设置过密码
            JGDropdownMenu *menu = [JGDropdownMenu menu];
            [menu configTouchViewDidDismissController:NO];
            [menu configBgShowMengban];
            __weak typeof(JGDropdownMenu *)weakMenu = menu;
            WeakSelf;
            JGInputPayPassword *payPasswordVC = [[JGInputPayPassword alloc] initWithInputPasswordCompleted:^(NSString *passwordKey) {
                JGLog(@"password:%@",passwordKey);
                StrongSelf;
                strongSelf.cashPayPassword = passwordKey;
                // 消失密码输入界面
                [weakMenu dismiss];
                /**
                 *  验证用户支付密码正确性 */
                WeakSelf;
                [bself showHud];
                [bself endEditing:YES];
                
                [JGCloudAndValueManager validateUserCashPayPassword:passwordKey success:^(BOOL ret) {
                    if (ret) {
                        // 支付密码正确 开始调用提现接口
                        [bself hiddenHud];

                        if (bself.cloudPredepositCash) {
                            NSDictionary *aliDict = [NSDictionary dictionaryWithDictionary:(NSDictionary *)bself.cloudPredepositCash];
                            if ([aliDict[@"cashPayment"] isEqualToString:@"chinabank"]) {
                                bself.selectPayType = 0;
                                
                            }else if ([aliDict[@"cashPayment"] isEqualToString:@"alipay"]) {
                                bself.selectPayType = 1;
                            }
                            
                            if (bself.selectBankInfoModel) {
                                bself.selectPayType = 0;
                            }else if (bself.selectAliInfoModel) {
                                bself.selectPayType = 1;
                            }
                        }
                        [bself callCashWithSelectedType:bself.selectPayType];
                    }else {
                        JGLog(@"no");
                        [bself hiddenHud];
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"支付密码输入有误" message:nil delegate:bself cancelButtonTitle:@"取消" otherButtonTitles:@"忘记密码", nil];
                        [alertView show];
                    }
                } error:^(NSError *error) {
                    [bself hiddenHud];
                }];
            } cancel:^{
                // 取消输入支付密码
                [weakMenu dismiss];
            }];
            payPasswordVC.view.width = ScreenWidth - 20;
            payPasswordVC.view.height = 170;
            payPasswordVC.view.x = 10;
            payPasswordVC.view.y = 0;
            payPasswordVC.amountLab.text = [NSString stringWithFormat:@"￥%@",bself.amountTextField.text];
            menu.contentController = payPasswordVC;
            [menu showWithKeyWindowWithDuration:0.27 CustomYToCenterMargin:100];
        }else {
            // 去设置支付密码
            BLOCK_EXEC(bself.settingPayPasswordAction,SettingPayPasswordType);
        }
        
    } error:^(NSError *error) {
        [bself hiddenHud];
        [UIAlertView xf_showWithTitle:@"网络错误" message:nil delay:0.75 onDismiss:^{
            
        }];
    }];
}

/**
 *  检测信息完整性 */
- (BOOL)checkCashInputFillInComplete {
    // 是否输入金额
    if (self.amountTextField.text.length <= 0 ) {
        [UIAlertView xf_showWithTitle:@"请输入完整信息" message:nil delay:2 onDismiss:^{
            
        }];
        
        return NO;
    }else {
        if (self.cloudPredepositCash) {
            // 默认支付记录存在
            return YES;
            
        }else {
            // 没有支付记录 检测用户有没有选择支付方式
            if (self.selectPayType == 0) {
                // 如果选择银行卡支付 检测银行卡信息模型是否存在
                if (self.selectBankInfoModel) {
                    // 银行卡信息存在
                    return YES;
                }else {
                    // 银行卡信息不存在
                    [UIAlertView xf_showWithTitle:@"请输入完整信息" message:nil onDismiss:^{
                        
                    }];
                    return NO;
                }
            }else {
                // 如果是选择支付宝 检测支付宝信息模型是否存在
                if (self.selectAliInfoModel) {
                    // 支付宝信息存在
                    return YES;
                }else {
                    // 支付宝信息不存在
                    [UIAlertView xf_showWithTitle:@"请输入完整信息" message:nil onDismiss:^{
                        
                    }];
                    return NO;
                }
            }
        }
        return YES;
    }
    return NO;
}


- (void)callCashWithSelectedType:(NSInteger)type {
    if (type == 0) {
        // 银行卡提现
        BOOL isSettedCashIdNull = [self shouldTransferPramas];
        CGFloat cashUserId = 0;
        if (isSettedCashIdNull) {
            // 如果将cashId设置为空,不做操作
        }else {
            // 判断是否有默认表单 有的话 就取cash
            if (self.cloudPredepositCash) {
                NSDictionary *cloudPredepositCashDict = [NSDictionary dictionaryWithDictionary:(NSDictionary *)self.cloudPredepositCash];
                NSString *cashUserIdString = TNSString(cloudPredepositCashDict[@"id"]);
                cashUserId = [cashUserIdString floatValue];
                
                if (!self.selectBankInfoModel) {
                    // 如果用户直接使用默认的没选择的话 支付宝模型是为空的
                    self.selectBankInfoModel = [[JGBankInfoModel alloc] init];
                    self.selectBankInfoModel.userName = cloudPredepositCashDict[@"cashUserName"];
                    self.selectBankInfoModel.cardNumber = cloudPredepositCashDict[@"cashAccount"];
                    self.selectBankInfoModel.openAccoutBank = cloudPredepositCashDict[@"cashBank"];
                    self.selectBankInfoModel.branchBank = cloudPredepositCashDict[@"cashSubbranch"];
                }
            }
        }
        
        WeakSelf;
        [JGCloudAndValueManager callCashWithCashPayment:CashPayBankType cashAmount:[self.amountTextField.text floatValue] cashUserName:self.selectBankInfoModel.userName cashBank:self.selectBankInfoModel.openAccoutBank cashAccount:self.selectBankInfoModel.cardNumber cashPassword:self.cashPayPassword cashInfo:self.composeTextField.text cashSubbranch:self.selectBankInfoModel.branchBank needCashId:!isSettedCashIdNull cashId:cashUserId success:^(CloudBuyerCashSaveResponse *response) {
            // 请求成功,提现成功
            [UIAlertView xf_showWithTitle:response.subMsg message:nil onDismiss:^{
                JGLog(@"确定");
                [self endEditing:YES];
                BLOCK_EXEC(bself.cashSuccess,response);
            }];
            
        } fail:^(NSString *failMsg) {
            // 请求成功,但是提现不成功
            [UIAlertView xf_showWithTitle:failMsg message:nil onDismiss:^{
                
            }];
            
        } error:^(NSError *error) {
            // 网络错误
            [UIAlertView xf_showWithTitle:@"网络错误,请重新再试!" message:nil onDismiss:^{
                
            }];
        }];
        
    }else {
        // 支付宝提现
        BOOL isSettedCashIdNull = [self shouldTransferPramas];
        CGFloat cashUserId = 0;
        if (isSettedCashIdNull) {
            // 如果将cashId设置为空,不做操作
        }else {
            // 判断是否有默认表单 有的话 就取cash
            if (self.cloudPredepositCash) {
                NSDictionary *cloudPredepositCashDict = [NSDictionary dictionaryWithDictionary:(NSDictionary *)self.cloudPredepositCash];
                // cashUserId
                NSString *cashUserIdString = TNSString(cloudPredepositCashDict[@"id"]);
                cashUserId = [cashUserIdString floatValue];
                
                if (!self.selectAliInfoModel) {
                    // 如果用户直接使用默认的没选择的话 支付宝模型是为空的
                    self.selectAliInfoModel = [[JGAliInfoModel alloc] init];
                    self.selectAliInfoModel.userName = cloudPredepositCashDict[@"cashUserName"];
                    self.selectAliInfoModel.userAccout = cloudPredepositCashDict[@"cashAccount"];
                }
            }
        }
        
        WeakSelf;
        [JGCloudAndValueManager callCashWithCashPayment:CashPayAliType cashAmount:[self.amountTextField.text floatValue] cashUserName:self.selectAliInfoModel.userName cashBank:@"" cashAccount:self.selectAliInfoModel.userAccout cashPassword:self.cashPayPassword cashInfo:self.composeTextField.text cashSubbranch:@"" needCashId:!isSettedCashIdNull cashId:cashUserId success:^(CloudBuyerCashSaveResponse *response) {
            // 请求成功,提现成功
            [UIAlertView xf_showWithTitle:response.subMsg message:nil onDismiss:^{
                BLOCK_EXEC(bself.cashSuccess,response);
            }];
            
        } fail:^(NSString *failMsg) {
            // 请求成功,但是提现不成功
            [UIAlertView xf_showWithTitle:failMsg message:nil onDismiss:^{
                
            }];
            
        } error:^(NSError *error) {
            // 网络错误
            [UIAlertView xf_showWithTitle:@"网络错误,请重新再试!" message:nil onDismiss:^{
                
            }];
        }];
    }
}

- (BOOL)shouldTransferPramas {
    if (self.cloudPredepositCash) {
        // 如果有默认记录 一般情况下 返回YES 如果更改支付方式或者支付银行 需要返回NO
        return self.isSettedCashIdNull;
    }else {
        return NO;
    }
    return NO;
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        JGLog(@"0");
        // 取消
    }else {
        JGLog(@"1");
        // 忘记密码
        BLOCK_EXEC(self.settingPayPasswordAction,ForgetPayPasswordType);
    }
}
@end
