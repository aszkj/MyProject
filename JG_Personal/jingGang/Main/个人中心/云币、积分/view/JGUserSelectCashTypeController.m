//
//  JGUserSelectCashTypeController.m
//  jingGang
//
//  Created by dengxf on 16/1/8.
//  Copyright © 2016年 yi jiehuang. All rights reserved.
//

#import "JGUserSelectCashTypeController.h"
#import "JGCashBankView.h"
#import "JGCashALiView.h"
#import "GlobeObject.h"
#import "UIAlertView+Extension.h"
typedef void(^(ClosePopControllerBlock))(void);
typedef void(^(ClosePopControllerWithInfoBlock))(NSInteger payType,id model);;

@interface JGUserSelectCashTypeController ()<UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (strong,nonatomic) UIScrollView *contentScrollView;

/**
 *  银行卡容器 */
@property (strong,nonatomic) JGCashBankView *bankView;
/**
 *  支付宝容器 */
@property (strong,nonatomic) JGCashALiView *aliView;

// 简单的关闭界面
@property (copy , nonatomic) ClosePopControllerBlock closeBlock;

/**
 *  带有信息的关闭界面
 */
@property (copy , nonatomic) ClosePopControllerWithInfoBlock closeWithInfoBlock;


/**
 *  银行图标名字
 */
@property (copy , nonatomic) NSString *bankIncoName;

/**
 *  监控选择提现方式事件 */
- (IBAction)selectedCashTypeAction:(UISegmentedControl *)sender;

- (IBAction)closeControllerAction:(id)sender;


@end

@implementation JGUserSelectCashTypeController

- (UIScrollView *)contentScrollView {
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] init];
        self.contentScrollView.showsVerticalScrollIndicator = NO;
        self.contentScrollView.showsHorizontalScrollIndicator = NO;
        self.contentScrollView.bounces = NO;
        self.contentScrollView.backgroundColor = [UIColor whiteColor];
        self.contentScrollView.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.23].CGColor;
        self.contentScrollView.layer.borderWidth = 0.5;
        self.contentScrollView.layer.cornerRadius = 2;
        self.contentScrollView.pagingEnabled = YES;
        self.contentScrollView.delegate = self;
        [self.view addSubview:_contentScrollView];
    }
    return _contentScrollView;
}

- (instancetype)initWithSelecteCashControllerWithCloseBlock:(void (^)())close infoBlock:(void (^)(NSInteger, id))info{
    if (self = [super init]) {
        self.closeBlock = close;
        self.closeWithInfoBlock = info;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化ui界面
    [self configContent];
    
    if (self.cloudPredepositCash) {
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:(NSDictionary *)self.cloudPredepositCash];
        NSString *cashPayment = dict[@"cashPayment"];
        if ([cashPayment isEqualToString:@"chinabank"]) {
            // 属于银行卡提现类型
            [self.segmentedControl setSelectedSegmentIndex:0];
            self.contentScrollView.contentOffset = CGPointMake(0, 0);
            self.bankView.userNameTextField.text = dict[@"cashUserName"];
            self.bankView.bankCardNumberTextField.text = dict[@"cashAccount"];
            self.bankView.openAccountBankTextField.text = dict[@"cashBank"];
            self.bankView.branchBankTextField.text = dict[@"cashSubbranch"];
        }else if ([cashPayment isEqualToString:@"alipay"]) {
            // 属于支付宝提现类型
            [self.segmentedControl setSelectedSegmentIndex:1];
            self.contentScrollView.contentOffset = CGPointMake(self.contentScrollView.width, 0);
            self.aliView.userNameTextField.text = dict[@"cashUserName"];
            self.aliView.aliAccountTextField.text = dict[@"cashAccount"];
        }
    }
}

/**
 *  设置默认提现表单 */
- (void)setCloudPredepositCash:(id)cloudPredepositCash {
    _cloudPredepositCash = cloudPredepositCash;
}

- (void)configContent {
    // 初始化内容ScrollView容器
    self.contentScrollView.x = 10;
    self.contentScrollView.y = CGRectGetMaxY(self.segmentedControl.frame) + 5;
    self.contentScrollView.width = ScreenWidth - 2 * 10 - 2 * 10;
    self.contentScrollView.height = 178.0;
    self.contentScrollView.contentSize = CGSizeMake(self.contentScrollView.width * 2, 178.0);

    // 默认提现方式为 - -银行
    self.segmentedControl.selectedSegmentIndex = 0;
    
    // 银行视图
    WeakSelf;
    JGCashBankView *bankView = [[JGCashBankView alloc] initWithCashBankViewForSelectedBankWithInfoBlock:^(NSDictionary *dic) {
        // dic 返回当前选中的银行信息
        StrongSelf;
        if (dic) {
            NSArray *values = [dic allValues];
            NSString *bankName = [values lastObject];
            strongSelf.bankView.openAccountBankTextField.text = bankName;
            strongSelf.bankIncoName = [[dic allKeys] lastObject];
        }
    }];
    bankView.x = 0;
    bankView.y = 0;
    bankView.width = self.contentScrollView.width;
    bankView.height = self.contentScrollView.height;
    [self.contentScrollView addSubview:bankView];
    self.bankView = bankView;
    
    // 支付宝视图
    JGCashALiView *aliView = [[JGCashALiView alloc] init];
    aliView.x = CGRectGetMaxX(self.bankView.frame);
    aliView.y = 0;
    aliView.width = self.bankView.width;
    aliView.height = 90;
    [self.contentScrollView addSubview:aliView];
    self.aliView = aliView;
    
    UIButton *completeButton = [[UIButton alloc] init];
    completeButton.x = self.contentScrollView.x + 10;
    completeButton.y = CGRectGetMaxY(self.contentScrollView.frame) + 10;
    completeButton.width = ScreenWidth - 20 - completeButton.x * 2;
    completeButton.height = 40;
    [completeButton setBackgroundColor:status_color];
    [completeButton setTitle:@"完成" forState:UIControlStateNormal];
    [self.view addSubview:completeButton];
    completeButton.layer.cornerRadius = 4;
    [completeButton addTarget:self action:@selector(completedSelectedCashTypeAction:) forControlEvents:UIControlEventTouchUpInside];
}

// 完成选择提现方式
- (void)completedSelectedCashTypeAction:(UIButton *)btn {
    // 进行信息验证
    BOOL ret = [self verifyUserCommitInfo:^(NSInteger selectedPayType,id infoModel) {
        // 信息已填写完全
        BLOCK_EXEC(self.closeWithInfoBlock,selectedPayType,infoModel);
    }];
    if (!ret) {
        return;
    }
}

/**
 *  验证选择提现方式信息 */
- (BOOL)verifyUserCommitInfo:(void(^)(NSInteger selectedPayType,id infoModel))info {
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        // 验证银行卡
        if (self.bankView.userNameTextField.text.length == 0 || self.bankView.bankCardNumberTextField.text.length == 0  || self.bankView.openAccountBankTextField.text.length == 0  || self.bankView.branchBankTextField.text.length == 0 ) {
            // 信息不全
            [UIAlertView xf_showWithTitle:@"提现信息不完整" message:nil delay:1.2 onDismiss:^{
                
            }];
            return NO;
        }else {
            if (self.bankView.bankCardNumberTextField.text.length < 6) {
                
                [UIAlertView xf_showWithTitle:@"银行卡号信息有误" message:nil delay:1.2 onDismiss:^{
                    
                }];
                return NO;
            }
            
            /**
             *   处理银行卡卡号字符串*/
            NSString *cardNumber = self.bankView.bankCardNumberTextField.text;
            NSArray *numbers = [cardNumber componentsSeparatedByString:@" "];
            cardNumber = [numbers componentsJoinedByString:@""];
            self.bankView.bankCardNumberTextField.text = cardNumber;
            
            JGBankInfoModel *bankModel = [self createBankInfoModelWithUserName:self.bankView.userNameTextField.text bankCardNumber:self.bankView.bankCardNumberTextField.text openAccountBank:self.bankView.openAccountBankTextField.text branchBank:self.bankView.branchBankTextField.text];
            BLOCK_EXEC(info,self.segmentedControl.selectedSegmentIndex,bankModel);
            return YES;
        }
    }else {
        // 验证支付宝
        if (self.aliView.userNameTextField.text.length == 0 || self.aliView.aliAccountTextField.text.length == 0 ) {
            return NO;
        }else {
            JGAliInfoModel *aliModel = [self createAliInfoModelWithUserName:self.aliView.userNameTextField.text userAccout:self.aliView.aliAccountTextField.text];
            BLOCK_EXEC(info,self.segmentedControl.selectedSegmentIndex,aliModel);
            return YES;
        }
    }
    return NO;
}

- (JGAliInfoModel *)createAliInfoModelWithUserName:(NSString *)userName userAccout:(NSString *)userAccout {
    JGAliInfoModel *aliModel = [[JGAliInfoModel alloc] init];
    aliModel.userName = userName;
    aliModel.userAccout = userAccout;
    return aliModel;
}

/**
 *  创建一个填写完信息的模型
 *  @param userName        持卡人本人姓名
 *  @param bankCardNumber  银行卡号
 *  @param openAccountBank 开户银行
 *  @param branchBank      开户支行 */
- (JGBankInfoModel *)createBankInfoModelWithUserName:(NSString *)userName bankCardNumber:(NSString *)bankCardNumber openAccountBank:(NSString *)openAccountBank branchBank:(NSString *)branchBank  {
    JGBankInfoModel *bankModel = [[JGBankInfoModel alloc] init];
    bankModel.userName = userName;
    bankModel.cardNumber = bankCardNumber;
    bankModel.openAccoutBank = openAccountBank;
    bankModel.branchBank = branchBank;
    bankModel.bankIncoImageName = self.bankIncoName;
    return bankModel;
}

/**
 *  监控选择提现方式事件*/
- (IBAction)selectedCashTypeAction:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
        {
            // 银行卡提现
            self.contentScrollView.contentOffset = CGPointMake(0, 0);
        }
            break;
        case 1:
        {
            // 支付宝
            self.contentScrollView.contentOffset = CGPointMake(self.contentScrollView.width, 0);
        }
            break;
        default:
            break;
    }
    
}

- (IBAction)closeControllerAction:(id)sender {
    BLOCK_EXEC(self.closeBlock);
}

#pragma mark UIScrollViewDelegate 
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffset = self.contentScrollView.contentOffset.x;
    if (contentOffset == 0) {
        if (self.segmentedControl.selectedSegmentIndex == 0) {
            return;
        }else {
            self.segmentedControl.selectedSegmentIndex = 0;
        }
    }else {
        if (self.segmentedControl.selectedSegmentIndex == 1) {
            return;
        }else {
            self.segmentedControl.selectedSegmentIndex = 1;
        }
    }
}

@end
