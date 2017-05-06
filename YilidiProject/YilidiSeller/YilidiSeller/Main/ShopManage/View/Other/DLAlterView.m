//
//  DLAlterView.m
//  YilidiSeller
//
//  Created by yld on 16/6/15.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLAlterView.h"
#import "JKCountDownButton.h"
@interface DLAlterView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *bigView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *phonetext;
@property (nonatomic, strong) UITextField *codeText;
@property (nonatomic, strong) NSMutableString *textStr;
@property (nonatomic, strong)JKCountDownButton *countDownCode;
@end


@implementation DLAlterView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7];
        self.bigView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 40, 160)];
        _bigView.layer.cornerRadius = 10;
        _bigView.layer.masksToBounds = YES;
        _bigView.backgroundColor = [UIColor whiteColor];
        _bigView.center = CGPointMake(kScreenWidth / 2, kScreenHeight / 2);
        [self addSubview:_bigView];
       
       
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.bigView.frame.size.width/2-50, 5, 100, 20)];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.layer.masksToBounds = YES;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"更换门店热线";
        _titleLabel.font = [UIFont systemFontOfSize:15];
        [_bigView addSubview:_titleLabel];
        
        UILabel *storePhoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 60, 20)];
        [storePhoneLabel setText:@"门店热线"];
        [storePhoneLabel setFont:[UIFont systemFontOfSize:15]];
        [_bigView addSubview:storePhoneLabel];
         _phonetext = [[UITextField alloc]initWithFrame:CGRectMake(75, 50, 120, 20)];
        _phonetext.placeholder = @"请输入手机号";
        _phonetext.textAlignment = NSTextAlignmentLeft;
//        _phonetext.delegate = self;
        [_phonetext setFont:[UIFont systemFontOfSize:15]];
//        _phonetext.backgroundColor = [UIColor redColor];
        _phonetext.keyboardType = UIKeyboardTypePhonePad;
        [_phonetext addTarget:self action:@selector(_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [_bigView addSubview:_phonetext];
        
        _countDownCode = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
        //_phonetext.frame.origin.y+_phonetext.frame.size.width+5
        _countDownCode.frame = CGRectMake(CGRectGetWidth(_bigView.frame)-93, 50, 90, 20);
        [_countDownCode setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_countDownCode.titleLabel setFont:[UIFont systemFontOfSize:15]];
        _countDownCode.backgroundColor = UIColorFromRGB(0x339999);
        [_bigView addSubview:_countDownCode];
        
        [_countDownCode addToucheHandler:^(JKCountDownButton*sender, NSInteger tag) {
            sender.enabled = NO;
            
            [sender startWithSecond:60];
            
            [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
                NSString *title = [NSString stringWithFormat:@"%dS",second];
                return title;
            }];
            [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
                countDownButton.enabled = YES;
                return @"点击重新获取";
                
            }];
            
        }];

        
       
        UILabel *codeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, 60, 20)];
        [codeLabel setText:@"验证码"];
        [codeLabel setFont:[UIFont systemFontOfSize:15]];
        [_bigView addSubview:codeLabel];
        _codeText = [[UITextField alloc]initWithFrame:CGRectMake(75, 80, 120, 20)];
        _codeText.placeholder = @"请输入验证码";
        _codeText.textAlignment = NSTextAlignmentLeft;
//        _codeText.delegate = self;
        [_codeText addTarget:self action:@selector(_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [_codeText setFont:[UIFont systemFontOfSize:15]];
//        _codeText.backgroundColor = [UIColor redColor];
        _codeText.keyboardType = UIKeyboardTypePhonePad;
        [_bigView addSubview:_codeText];

        
        
        UIButton *replaceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        replaceButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        replaceButton.layer.borderWidth = .3f;
        replaceButton.bounds = CGRectMake(0, 0, CGRectGetWidth(_bigView.frame)/ 2, 44);
        replaceButton.center = CGPointMake(CGRectGetWidth(_bigView.bounds)/4, CGRectGetHeight(_bigView.bounds) - 44 + 24);
        [replaceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [replaceButton addTarget:self action:@selector(replaceClick) forControlEvents:UIControlEventTouchUpInside];
        [replaceButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [replaceButton setTitle:@"更换号码" forState:UIControlStateNormal];
        [_bigView addSubview:replaceButton];
        
        UIButton *noreplaceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        noreplaceButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [noreplaceButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        noreplaceButton.layer.borderWidth = .3f;
        noreplaceButton.bounds = CGRectMake(0, 0, CGRectGetWidth(_bigView.frame)/ 2, 44);
        noreplaceButton.center = CGPointMake(3 * CGRectGetWidth(_bigView.bounds)/4, CGRectGetHeight(_bigView.bounds) - 44 + 24);
        [noreplaceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [noreplaceButton setTitle:@"暂不更换" forState:UIControlStateNormal];
        [noreplaceButton addTarget:self action:@selector(noreplaceClick) forControlEvents:UIControlEventTouchUpInside];
        
        [_bigView addSubview:noreplaceButton];
        _bigView.transform = CGAffineTransformMakeScale(0, 0);
        _titleLabel.transform = CGAffineTransformMakeScale(0,0);
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)_textFieldDidChange:(UITextField *)textField
{
    if (textField == self.phonetext) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
    
    if (textField == self.codeText) {
        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
        }
    }
    
}
- (void)noreplaceClick {
    [self dissmiss];
   
}

- (void)dissmiss {
    [UIView animateWithDuration:.2 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [_titleLabel resignFirstResponder];
    }];
}

- (void)replaceClick {
    [self dissmiss];
    if (_textBlock) {
        _textBlock(_phonetext.text,_codeText.text);
    }
}

- (void)keyboardShow:(NSNotification *)no {
    CGRect recg = [no.userInfo[@"UIKeyboardBoundsUserInfoKey"] CGRectValue];
    if (recg.origin.y != kScreenHeight) {
        if (recg.origin.y - _bigView.frame.origin.y < CGRectGetHeight(_bigView.frame) + 20) {
            [UIView animateWithDuration:0.25 animations:^{
                [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                _titleLabel.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(_bigView.frame)/2);
                _bigView.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(_bigView.frame)/2);
            }];
        }
    }
}

- (void)keyboardHide:(NSNotification *)no {
    [UIView animateWithDuration:1 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        _bigView.transform = CGAffineTransformIdentity;
        _titleLabel.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        //        [selfBlock removeFromSuperview];
    }];
}


- (void)show {
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    [window addSubview:self];
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 / 0.8 options:0 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        //        self.alpha = 1;
        _bigView.transform = CGAffineTransformIdentity;
        _titleLabel.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [_titleLabel becomeFirstResponder];
    }];
}


@end
