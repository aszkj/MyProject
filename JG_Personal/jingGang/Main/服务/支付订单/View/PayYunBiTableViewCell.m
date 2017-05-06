//
//  PayYunBiTableViewCell.m
//  jingGang
//
//  Created by thinker on 15/8/20.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "PayYunBiTableViewCell.h"
#import "Masonry.h"
#import "PublicInfo.h"

@interface PayYunBiTableViewCell () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *payYunBiTitle;
@property (weak, nonatomic) IBOutlet UIButton *isPayBtn;
@property (weak, nonatomic) IBOutlet UILabel *payMark;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (nonatomic) UIView *lineView;
@property (weak, nonatomic) IBOutlet UIButton *yunbiBgBtn;

@end

@implementation PayYunBiTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self setAppearence];
    [self setViewsMASConstraint];
    self.isPayBtn.tag = 3;
}

#pragma mark - set UI content

- (void)setYunbi:(float)yunbi totalPrice:(float)price
{
    if (yunbi >= price) {
        yunbi = price;
        price = 0.00;
    } else {
        price = price - yunbi;
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"云币支付: %.2f元 还需支付: %.2f元",yunbi,price] ];
    NSDictionary *attributeDict = [ NSDictionary dictionaryWithObjectsAndKeys:
                                   [UIFont systemFontOfSize:13.0],NSFontAttributeName,
                                   status_color,NSForegroundColorAttributeName,
                                   nil
                                   ];
    NSString *colorStr = [NSString stringWithFormat:@"%.2f",price];
    NSRange range = [attributedString.string rangeOfString:colorStr options:NSBackwardsSearch];
    range = NSMakeRange(range.location, colorStr.length);
    [attributedString addAttributes:attributeDict range:range];
    
    self.payYunBiTitle.attributedText = attributedString.copy;
}

#pragma mark - event response

- (IBAction)setButtonSelect:(UIButton *)sender {
    if (sender.isSelected) {
        self.passWord.enabled = NO;
    } else {
        self.passWord.enabled = YES;
    }
    sender.selected = !sender.selected;

    if (self.showPasswordBlock) {
        self.showPasswordBlock(self.passWord.enabled,sender);
    }
}


-(void)setWhetherSetYunbiPasswd:(BOOL)whetherSetYunbiPasswd {
    
    _whetherSetYunbiPasswd = whetherSetYunbiPasswd;
    if (_whetherSetYunbiPasswd) {//设置了云币密码
        [self _alowInputPasswdConfigure];
    }else {//未设置
        [self _forbiddenInputPasswdConfigure];
    }
}

-(void)_alowInputPasswdConfigure {
    self.passWord.userInteractionEnabled = YES;
    self.passWord.placeholder = @"请输入云币密码";
}

-(void)_forbiddenInputPasswdConfigure {
    
    self.passWord.userInteractionEnabled = NO;
    self.passWord.placeholder = @"您还未设置云币密码";
}



#pragma mark - set UI init

- (void)setAppearence
{
    self.passWord.delegate = self;
    self.clipsToBounds = YES;
}

#pragma mark - set Constraint

- (void)needShowPassword:(BOOL)needed
{
    self.isPayBtn.selected = needed;
    UIView *superView = self.contentView;
    if (needed) {
        [superView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@90.0);
            make.width.equalTo(@(__MainScreen_Width));
        }];
    } else {
        [superView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@45.0);
            make.width.equalTo(@(__MainScreen_Width));
        }];
    }
}

- (void)setViewsMASConstraint
{
    UIView *superView = self.contentView;
    [superView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@45.0);
        make.width.equalTo(@(__MainScreen_Width));
    }];
    
    CGFloat standDistance = 12.0;
    CGFloat onePXHeight = 1/[UIScreen mainScreen].scale;
    UIView *lineView = [self lineView];
    self.lineView = lineView;
    [superView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(onePXHeight));
        make.top.equalTo(superView).with.offset(45);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
    }];
    [self.payYunBiTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView).with.offset(standDistance);
        make.top.equalTo(superView).with.offset(8.0);
        make.bottom.equalTo(lineView).with.offset(-8.0);
    }];
    [self.isPayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.equalTo(self.payYunBiTitle.mas_right).with.offset(12);
        make.right.equalTo(superView).with.offset(-standDistance);
        make.centerY.equalTo(self.payYunBiTitle);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    [self.payMark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView).with.offset(8);
        make.left.equalTo(self.payYunBiTitle);
        make.height.equalTo(self.payYunBiTitle);
    }];
    [self.passWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.payMark);
        make.left.equalTo(self.payMark.mas_right).with.offset(2);
        make.right.equalTo(self.isPayBtn);
    }];
    
    [self.yunbiBgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.contentView);
        make.height.mas_equalTo(38);
    }];
}

#pragma mark - getters and settters

- (NSString *)password
{
    return self.passWord.text;
}

- (UIView *)lineView {
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    return lineView;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
