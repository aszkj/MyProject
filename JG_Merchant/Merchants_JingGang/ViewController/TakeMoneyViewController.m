//
//  TakeMoneyViewController.m
//  Merchants_JingGang
//
//  Created by thinker on 15/9/5.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "TakeMoneyViewController.h"
#import "DebugSet.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "UIAlertView+Blocks.h"
#import "ServiceManagerViewController.h"
#import "RTTakeMoneyViewModel.h"
#import "NSString+BlankString.h"
#import "UIView+Loading.h"
#import "Util.h"
#import "TakeRecordViewController.h"
#import "ChangYunbiPasswordViewController.h"

@interface TakeMoneyViewController ()
@property (weak, nonatomic) IBOutlet UIView *yuerView;
@property (weak, nonatomic) IBOutlet UIView *takeWayView;
@property (weak, nonatomic) IBOutlet UIView *nameView;
@property (weak, nonatomic) IBOutlet UIView *bankView;
@property (weak, nonatomic) IBOutlet UIView *commentView;
@property (weak, nonatomic) IBOutlet UIView *passwordView;
@property (weak, nonatomic) IBOutlet UIView *accountView;
@property (weak, nonatomic) IBOutlet UITextField *yuerText;
@property (weak, nonatomic) IBOutlet UITextField *accountText;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *bankTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;

@property (weak, nonatomic) IBOutlet UILabel *takeWayLabel;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bankHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *accountHeight;

@property (nonatomic) RTTakeMoneyViewModel *viewModel;
@end

@implementation TakeMoneyViewController

#pragma mark - life cycle
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUIContent];
    [self setViewsMASConstraint];
    [self bindUIAction];
    self.yuerText.keyboardType = UIKeyboardTypeDecimalPad;
}

- (void)bindViewModel {
    [super bindViewModel];
    @weakify(self);
    RAC(self.yuerText,placeholder) = [RACObserve(self.viewModel, balance) map:^id(NSNumber *value) {
        return [NSString stringWithFormat:@"可提现余额：%@元",[NSString decoratedString:value.stringValue insertString:@"," everyRange:3]];
    }];
    
    [self.yuerText.rac_textSignal subscribeNext:^(NSString *text) {
        @strongify(self)
        if ([text isEqualToString:@""]) { text = @"0";  }
        if (![Util isPureFloat:text] || text.longLongValue > self.viewModel.balance.longLongValue) {
            self.yuerText.text = self.viewModel.cashAmount.stringValue;
        };
    }];
    [[self.yuerText.rac_textSignal distinctUntilChanged] subscribeNext:^(NSString *value) {
        @strongify(self);
        if ([Util isValidateNumber:value] || [value isEqualToString:@""]) {
            self.viewModel.cashAmount = @(value.doubleValue);
        }
    }];
    [RACObserve(self.takeWayLabel, text) subscribeNext:^(NSString *text) {
        self.viewModel.cashPayment = text;
    }];
    
    RAC(self.viewModel,cashName) = self.nameTextField.rac_textSignal;
    RAC(self.viewModel,cashBank) = self.bankTextField.rac_textSignal;
    RAC(self.viewModel,cashAccount) = self.accountText.rac_textSignal;
    RAC(self.viewModel,cashPassword) = self.passwordText.rac_textSignal;
    RAC(self.viewModel,cashInfo) = self.commentTextView.rac_textSignal;
    [[[self.viewModel.getBankInfoCommand executionSignals] switchToLatest] subscribeNext:^(id x) {
        @strongify(self)
        self.accountText.text = self.viewModel.cashAccount;
        self.nameTextField.text = self.viewModel.cashName;
        self.bankTextField.text = self.viewModel.cashBank;
    }];

    [[self.confirmButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.viewModel.takeMoneyCommand execute:nil];
    }];
    RACSignal *isExcuting = [RACSignal
                             combineLatest:@[
                                             self.viewModel.getYunbiCommand.executing,
                                             self.viewModel.takeMoneyCommand.executing,
                                             self.viewModel.getBankInfoCommand.executing
                                             ]
                             reduce:^(NSNumber *getYunbiExcuting,NSNumber *takeMoneyExcuting,NSNumber *getBankInfoExcuting) {
                                 return @(getYunbiExcuting.boolValue || takeMoneyExcuting.boolValue || getBankInfoExcuting.boolValue);
                             }];
    [isExcuting subscribeNext:^(NSNumber *executing) {
        @strongify(self)
        if ([executing boolValue]) {
            [self.view showLoading];
        }else {
            [self.view hideLoading];
        }
    }];
    
    RAC(self.confirmButton,enabled) = [RACSignal
                                       combineLatest:@[
                                                       RACObserve(self.viewModel,cashPayment),
                                                       RACObserve(self.viewModel,cashAccount),
                                                       RACObserve(self.viewModel,cashPassword),
                                                       self.yuerText.rac_textSignal,
                                                       RACObserve(self.viewModel, cashBank),
                                                       RACObserve(self.viewModel, cashName),
                                                       ]
                                       reduce:^(NSString *payment,NSString *cashAccount,NSString *cashPassword,NSString *cashAmount,NSString *cashBank,NSString *cashName){
                                           @strongify(self)
                                           if (!self.bankView.hidden) {
                                               return @(payment.length>0 && cashAccount.length>0 && cashPassword.length>0 && cashAmount.length>0 && cashBank.length>0 &&cashName.length>0);
                                           } else if (self.accountView.hidden) {
                                               return @(payment.length>0 && cashPassword.length>0 && cashAmount.length>0);
                                           } else {
                                               return @(payment.length>0 && cashAccount.length>0 && cashPassword.length>0 && cashAmount.length>0);
                                           }
                                       }];
    [[RACObserve(self.confirmButton, enabled) distinctUntilChanged]
     subscribeNext:^(NSNumber *isEnable) {
        if (isEnable.boolValue) {
            self.confirmButton.backgroundColor = [UIColor colorWithRed:21/255.0 green:63/255.0 blue:94/255.0 alpha:1.0];
        } else {
            self.confirmButton.backgroundColor = [UIColor colorWithRed:21/255.0 green:63/255.0 blue:94/255.0 alpha:0.5];
        }
    }];
    [self.viewModel.getYunbiCommand execute:nil];
    [self.viewModel.getBankInfoCommand execute:nil];
    
    UIControl *eventControl = (UIControl *)self.takeWayView;
    [[eventControl rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         @strongify(self);
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"选择提现方式"
                                                             message:nil
                                                            delegate:self
                                                   cancelButtonTitle:@"取消"
                                                   otherButtonTitles:@"网银支付",@"支付宝", nil];
         
         [[alterView rac_buttonClickedSignal] subscribeNext:^(NSNumber *indexNumber) {
             NSInteger index = indexNumber.integerValue;
             if (index == 0) {  return; }
             self.takeWayLabel.text = [alterView buttonTitleAtIndex:index];
             if (2 == index) {
                 [self zhifubaoSelect];
             } else if (1 == index) {
                 [self wangyingSelect];
             }
         }];
         
         [alterView show];
     }];

}

- (void)bindUIAction {

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.viewModel.active = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animate {
    [super viewWillDisappear:animate];
    self.viewModel.active = NO;
}

- (void)viewDidLayoutSubviews {
}

#pragma mark - UITableViewDelegate



#pragma mark - CustomDelegate



#pragma mark - event response

- (void)zhifubaoSelect {
    self.bankView.hidden = YES;
    self.nameView.hidden = YES;
    self.accountView.hidden = NO;
    
    self.bankHeight.constant = 0;
    self.nameHeight.constant = 0;
    
    self.nameTextField.text = nil;
    self.bankTextField.text = nil;
    self.viewModel.cashBank = nil;
    self.viewModel.cashName = nil;
    
    self.accountHeight.constant = 44.0;
    self.accountText.keyboardType = UIKeyboardTypeDefault;
}

- (void)wangyingSelect {
    self.bankView.hidden = NO;
    self.nameView.hidden = NO;
    self.accountView.hidden = NO;
    
    self.viewModel.cashBank = nil;
    self.viewModel.cashName = nil;
    
    self.bankHeight.constant = 44.0;
    self.nameHeight.constant = 44.0;
    self.accountHeight.constant = 44.0;
    self.accountText.keyboardType = UIKeyboardTypeNumberPad;
}

#pragma mark - private methods

- (void)errorHandle:(NSError *)error {
    if (error.code == 4) {
        self.passwordText.text = @"";
        self.viewModel.cashPassword = @"";
    }
    if ([error.domain isEqualToString:@"cash_passwor_not_exist"]) {
        [self.navigationController pushViewController:[[ChangYunbiPasswordViewController alloc] init] animated:YES];
    }
}

- (void)setUIContent {
    self.title = @"提现";
    self.view.backgroundColor = background_Color;
    self.commentTextView.backgroundColor = self.view.backgroundColor;
    
    self.yuerText.keyboardType = UIKeyboardTypeDecimalPad;
    self.accountText.keyboardType = UIKeyboardTypeNumberPad;
}

- (void)addTopLineView:(UIView *)superView {
    
    UIView *lineView = [self lineView:[UIColor lightGrayColor]];
    [superView addSubview:lineView];
    [lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.top.equalTo(superView);
        make.height.equalTo(@(0.5));
        make.width.equalTo(@(kScreenWidth));
    }];
}
- (void)addBottomLineView:(UIView *)superView {
    UIView *lineView = [self lineView:[UIColor lightGrayColor]];
    [superView addSubview:lineView];
    [lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.bottom.equalTo(superView);
        make.height.equalTo(@(0.5));
    }];
}
- (void)addVerticalLine:(UIView *)superView {
    UIView *lineView = [self lineView:[UIColor lightGrayColor]];
    [superView addSubview:lineView];
    [lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(0.5));
        make.top.equalTo(superView);
        make.bottom.equalTo(superView);
        make.left.equalTo(superView).with.offset(89);
    }];
}

- (void)setViewsMASConstraint {

    [self addTopLineView:self.yuerView];
    [self addTopLineView:self.takeWayView];
    [self addTopLineView:self.nameView];
    [self addVerticalLine:self.nameView];
    [self addTopLineView:self.bankView];
    [self addVerticalLine:self.bankView];
    [self addTopLineView:self.commentView];
    [self addBottomLineView:self.commentView];
    [self addTopLineView:self.passwordView];
    [self addBottomLineView:self.passwordView];
    [self addVerticalLine:self.passwordView];
    [self addTopLineView:self.accountView];
    [self addVerticalLine:self.accountView];
}

#pragma mark - getters and settters

- (RTTakeMoneyViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[RTTakeMoneyViewModel alloc] init];
        @weakify(self)
        _viewModel.pushBlock = ^(){
            @strongify(self)
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"提现成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [[alertView rac_buttonClickedSignal] subscribeNext:^(NSNumber *indexNumber) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alertView show];
        };
    }
    return _viewModel;
}

- (UIView *)lineView:(UIColor *)viewColor {
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectZero];
    lineView.backgroundColor = viewColor;
    return lineView;
}


#pragma mark - debug operation
- (void)updateOnClassInjection {
//    [self viewDidLoad];
    [self setUIContent];
}


@end
