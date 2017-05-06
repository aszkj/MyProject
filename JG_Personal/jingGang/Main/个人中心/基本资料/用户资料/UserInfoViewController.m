//
//  UserInfoViewController.m
//  jingGang
//
//  Created by ray on 15/11/24.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoViewModel.h"
#import "UIImage+SizeAndTintColor.h"
#import "CalenderView.h"

@interface UserInfoViewController () <UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic) UserInfoViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITextField *invitCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *mobilTF;
@property (weak, nonatomic) IBOutlet UITextField *mailTF;
@property (weak, nonatomic) IBOutlet UITextField *nickNameTF;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *sexTF;
@property (weak, nonatomic) IBOutlet UITextField *heightTF;
@property (weak, nonatomic) IBOutlet UITextField *weightTF;
@property (weak, nonatomic) IBOutlet UITextField *birthdayTF;
@property (weak, nonatomic) IBOutlet UITextField *xuexinTF;
@property (weak, nonatomic) IBOutlet UITextField *invitPerson;
@property (weak, nonatomic) IBOutlet UITextField *belongMerchantTF;
@property (weak, nonatomic) IBOutlet UITextField *transHistoryTF;
@property (weak, nonatomic) IBOutlet UITextField *transGeneticTF;
@property (weak, nonatomic) IBOutlet UITextField *allergicHistoryTF;
@property (weak, nonatomic) IBOutlet UIImageView *markImage;
@property (nonatomic) CalenderView *calenderView;
@property (nonatomic) UIView *dateBackView;
@property (weak, nonatomic) IBOutlet UIView *bloodView;
@property (weak, nonatomic) IBOutlet UIView *sexView;
@property (nonatomic) UIButton *confirmButton;

@end

@implementation UserInfoViewController


#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.confirmButton];
    self.navigationItem.title = @"个人信息";
    [self setViewsMASConstraint];
}

- (void)bindViewModel {
    [super bindViewModel];
    @weakify(self)
    [[[self.viewModel.getUserInfoCommand executionSignals] switchToLatest] subscribeNext:^(id x) {
        @strongify(self)
        __weak MyUserCustomer *userInfo = self.viewModel.userInfo;
        self.invitCodeTF.text = userInfo.invitationCode;
        self.invitPerson.text = userInfo.referee;
        self.belongMerchantTF.text = userInfo.merchant;
        
        self.mobilTF.text = userInfo.mobile;
//        RAC(userInfo, mobile) = self.mobilTF.rac_textSignal;
        self.mailTF.text = userInfo.email;
//        RAC(userInfo, email) = self.mailTF.rac_textSignal;
        self.nickNameTF.text = userInfo.nickName;
//        RAC(userInfo, nickName) = self.nickNameTF.rac_textSignal;
        self.nameTF.text = userInfo.name;
//        RAC(userInfo, name) = self.nameTF.rac_textSignal;
        RAC(self.sexTF, text) = RACObserve(userInfo, sexStr);

        self.heightTF.text = userInfo.heightStr;
//        [self.heightTF.rac_textSignal subscribeNext:^(NSString *text) {
//            @strongify(self)
////            if (![Util isPureFloat:text]) {
////                self.heightTF.text = userInfo.heightStr;
////            } else {
//                userInfo.heightStr = text;
////            };
//        }];
        self.weightTF.text = userInfo.weightStr;
//        [self.weightTF.rac_textSignal subscribeNext:^(NSString *text) {
//            @strongify(self)
////            if ((![Util isPureFloat:text] && ![text isEqualToString:@""]) || text.longLongValue > 220) {
////                self.weightTF.text = userInfo.weightStr;
////            } else {
//                userInfo.weightStr = text;
////            };
//        }];

        RAC(self.birthdayTF, text) = RACObserve(userInfo, birthdate);
        RAC(self.xuexinTF, text) = RACObserve(userInfo, blood);
        self.allergicHistoryTF.text = userInfo.allergicHistory;
//        RAC(userInfo, allergicHistory) = self.allergicHistoryTF.rac_textSignal;
        self.transGeneticTF.text = userInfo.transGenetic;
//        RAC(userInfo, transGenetic) = self.transGeneticTF.rac_textSignal;
        self.transHistoryTF.text = userInfo.transHistory;
//        RAC(userInfo, transHistory) = self.transHistoryTF.rac_textSignal;

    }];
    [[[self.viewModel.updateUserInfoCommand executionSignals] switchToLatest] subscribeNext:^(id x) {
        @strongify(self)
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"修改信息成功" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }];
    
    
    [self.viewModel.getUserInfoCommand execute:nil];
}


- (UserInfoViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[UserInfoViewModel alloc] init];
    }
    return _viewModel;
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == actionSheet.cancelButtonIndex)   return;
    NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
    if (actionSheet.tag == 10) {
        self.viewModel.userInfo.sexStr = title;
    } else if (actionSheet.tag == 11) {
        self.viewModel.userInfo.blood = title;
    }
}
/**
 *  重写返回方法，因为返回的时候不知道为什么设置页面整体会下降需要代理通知设置回来
 */
- (void)btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
    if([self.delegate respondsToSelector:@selector(nofiticationPopUserInfoView)]){
        [self.delegate nofiticationPopUserInfoView];
    }
}


#pragma mark - event response
- (void)changeAction {
    [self.view endEditing:YES];
    [self assignViewModelData];
    [self.viewModel.changeActionCommand execute:nil];
}


-(void)assignViewModelData {
    self.viewModel.userInfo.email = self.mailTF.text;
    self.viewModel.userInfo.nickName = self.nickNameTF.text;
    self.viewModel.userInfo.name = self.nameTF.text;
    self.viewModel.userInfo.heightStr = self.heightTF.text;
    self.viewModel.userInfo.weightStr = self.weightTF.text;
    self.viewModel.userInfo.allergicHistory = self.allergicHistoryTF.text;
    self.viewModel.userInfo.transGenetic = self.transGeneticTF.text;
    self.viewModel.userInfo.transHistory = self.transHistoryTF.text;
}

- (IBAction)changeDateAction {
    NSString *birthday = self.viewModel.userInfo.birthdate;
    if (!IsEmpty(birthday)) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:[NSString stringWithFormat:@"yyyy-MM-dd"]];
        [self.calenderView setCurrentDate:[formatter dateFromString:birthday]];
    }
    [self.view endEditing:YES];
    self.dateBackView.frame = self.view.bounds;
    [self.view addSubview:self.dateBackView];
}

- (void)disappearAction {
    @weakify(self)
    [UIView animateWithDuration:0.5 animations:^{
        @strongify(self)
        self.dateBackView.frame = CGRectMake(0,self.view.frame.size.height,
                                            __MainScreen_Width, self.view.frame.size.height);
        [self.dateBackView removeFromSuperview];
    }];
}

- (void)changeSexAction {
    [self.view endEditing:YES];
    UIActionSheet *sexSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女",nil];
    sexSheet.tag = 10;
    [sexSheet showInView:self.view];
        
}

- (void)changeBloodAction {
    [self.view endEditing:YES];
    UIActionSheet *sexSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"A",@"B",@"AB",@"O",@"其他",nil];
    sexSheet.tag = 11;
    [sexSheet showInView:self.view];
}

#pragma mark - private methods


- (void)setUIAppearance {
    [super setUIAppearance];
    self.heightTF.keyboardType = UIKeyboardTypeNumberPad;
    self.weightTF.keyboardType = UIKeyboardTypeNumberPad;
    self.markImage.image = [self.markImage.image imageWithColor:UIColorFromRGB(0x999999)];
    
    UITapGestureRecognizer *changeSexTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeSexAction)];
    [self.sexView addGestureRecognizer:changeSexTap];
    UITapGestureRecognizer *changeBloodTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeBloodAction)];
    [self.bloodView addGestureRecognizer:changeBloodTap];
}

//
- (void)setViewsMASConstraint {
    //删除NSLayoutAttributeTop属性的约束
    [self.scrollView.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ((obj.firstItem != self.scrollView && obj.firstAttribute == NSLayoutAttributeTop) || (obj.secondItem != self.scrollView && obj.secondAttribute == NSLayoutAttributeBottom)) {
            [self.scrollView removeConstraint:obj];
        }
    }];
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull subview, NSUInteger idx, BOOL * _Nonnull stop) {
        [subview.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull subConstraints, NSUInteger idx, BOOL * _Nonnull stop) {
            if ((subConstraints.secondItem == subview && subConstraints.secondAttribute == NSLayoutAttributeBottom) || ((subConstraints.firstItem == subview && subConstraints.firstAttribute == NSLayoutAttributeTop))) {
                [subview removeConstraint:subConstraints];
            }
        }];
    }];
    [self.scrollView updateConstraints];

    [self.mobilTF.superview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView).with.offset(14);
    }];
    [self.nickNameTF.superview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mobilTF.superview.mas_bottom).with.offset(1);
    }];
    [self.nameTF.superview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nickNameTF.superview.mas_bottom).with.offset(1);
    }];
    [self.sexTF.superview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameTF.superview.mas_bottom).with.offset(1);
    }];
    [self.belongMerchantTF.superview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sexTF.superview.mas_bottom).with.offset(1);
    }];
    [self.mailTF.superview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.belongMerchantTF.superview.mas_bottom).with.offset(1);
    }];
    [self.birthdayTF.superview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mailTF.superview.mas_bottom).with.offset(1);
    }];
    
    [self.heightTF.superview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.birthdayTF.superview.mas_bottom).with.offset(14);
    }];
    [self.weightTF.superview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.heightTF.superview.mas_bottom).with.offset(1);
    }];
    [self.bloodView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.weightTF.superview.mas_bottom).with.offset(1);
    }];
    
    [self.allergicHistoryTF.superview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bloodView.mas_bottom).with.offset(14);
    }];
    [self.transHistoryTF.superview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.allergicHistoryTF.superview.mas_bottom).with.offset(1);
    }];
    [self.transGeneticTF.superview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.transHistoryTF.superview.mas_bottom).with.offset(1);
    }];
    
    [self.invitCodeTF.superview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.transGeneticTF.superview.mas_bottom).with.offset(14);
    }];
    [self.invitPerson.superview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.invitCodeTF.superview.mas_bottom).with.offset(1);
        make.bottom.equalTo(self.scrollView).with.offset(-14);
    }];
}

#pragma mark - getters and settters

- (UIView *)dateBackView {
    if (_dateBackView == nil) {
        UIView *blackView = [[UIView alloc] initWithFrame:self.view.bounds];
        blackView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        [blackView addSubview:self.calenderView];
        UITapGestureRecognizer *disappearTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disappearAction)];
        [blackView addGestureRecognizer:disappearTap];
        _dateBackView = blackView;
    }
    return _dateBackView;
}

- (CalenderView *)calenderView {
    if (_calenderView == nil) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"CalenderView" owner:nil options:nil];
        _calenderView = (CalenderView *)[nibs lastObject];
        _calenderView.frame = CGRectMake(0,self.view.bounds.size.height - 292,
                                         __MainScreen_Width, 292);
        NSDate *date = [NSDate date];
        _calenderView.MaxDate = date;
        [_calenderView setCurrentDate:[date dateBySubtractingDays:100*365]];
        @weakify(self)
        _calenderView.selectBirthBlock = ^(NSString *year,NSString *month,NSString *day){
            @strongify(self)
            self.viewModel.userInfo.birthdate = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
            [self disappearAction];
        };
    }
    return _calenderView;
}

- (UIButton *)confirmButton {
    if (_confirmButton == nil) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmButton.frame = CGRectMake(0, 0, 40, 35);
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(changeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}


//#pragma mark - debug operation
//- (void)updateOnClassInjection {
//    [self setViewsMASConstraint];
//}


@end
