//
//  SetCount.m
//  jingGang
//
//  Created by wangying on 15/5/30.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "SetCount.h"
@interface SetCount ()<UITextFieldDelegate>
{

   
}

@end
@implementation SetCount
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       // [self creatUI];
        self.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.1];
    }
    return self;
}
-(void)creatUI
{
   
    _scroll_base = [[UIScrollView alloc]initWithFrame:self.bounds];
    _scroll_base.contentSize = CGSizeMake(_scroll_base.frame.size.width, _scroll_base.frame.size.height);
    _scroll_base.scrollEnabled = NO;
    _scroll_base.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endediteText)];
   [_scroll_base addGestureRecognizer:tap];
    [self addSubview:_scroll_base];
   
    
    // 原密码 新密码  确认密码
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(0, 54, self.frame.size.width, 44)];
    view3.backgroundColor = [UIColor whiteColor];
    UILabel *password = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 47, 44)];
    password.text = @"原密码:";
    password.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    password.font = [UIFont systemFontOfSize:14];
    UITextField *passText = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(password.frame)+3, 0, 150, 44)];
    passText.placeholder = @"请输入原密码";
    passText.secureTextEntry = YES;
    passText.tag = 101;
    passText.delegate = self;
    passText.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    passText.font = [UIFont systemFontOfSize:14];
    [view3 addSubview:password];

    [view3 addSubview:passText];

    [_scroll_base addSubview:view3];

    UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(0, 99, self.frame.size.width, 44)];
    view4.backgroundColor = [UIColor whiteColor];
    UILabel *newPass = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 47, 44)];
    newPass.text = @"新密码:";
    newPass.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    newPass.font = [UIFont systemFontOfSize:14];
    UITextField *passTextN= [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(password.frame) +3, 0, 150, 44)];
    passTextN.placeholder = @"请输入新密码";
    passTextN.secureTextEntry = YES;
    passTextN.tag = 102;
    passTextN.delegate = self;
    passTextN.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    passTextN.font = [UIFont systemFontOfSize:14];
    [view4 addSubview:newPass];
    [view4 addSubview:passTextN];

    [_scroll_base addSubview:view4];

    UIView *view5 = [[UIView alloc]initWithFrame:CGRectMake(0, 144, self.frame.size.width, 44)];
    view5.backgroundColor = [UIColor whiteColor];
    UILabel *checkPass = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 62, 44)];
    checkPass.text = @"确认密码:";
    checkPass.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    checkPass.font =[UIFont systemFontOfSize:14];
    UITextField *passTextC = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(checkPass.frame) +3 , 0, 150, 44)];
    passTextC.placeholder = @"在次输入新密码";
    passTextC.secureTextEntry = YES;
    passTextC.tag = 103;
    passTextC.delegate = self;
    passTextC.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    passTextC.font = [UIFont systemFontOfSize:14];
    [view5 addSubview:checkPass];

    [view5 addSubview:passTextC];

    [_scroll_base addSubview:view5];

    

    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    _scroll_base.scrollEnabled = YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
//    CGRect rect = _scroll_base.frame;
//    rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//    _scroll_base.frame = rect;
//    _scroll_base.scrollEnabled = NO;
    if (textField.tag == 101) {
        //self.oldPass = textField.text;
        [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:@"oldText"];
     
    }
    if (textField.tag == 102) {
      //  self.newPass = textField.text;
      
          [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:@"newText"];
    }
    if (textField.tag == 103) {
      
        [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:@"sureText"];
    }
//    if (textField.tag == 1023) {//email
//        [[NSUserDefaults standardUserDefaults]setObject:textField.text forKey:@"emain"];
//    }
    
}
-(void)endediteText
{
//    
//    CGRect rect = _scroll_base.frame;
//    rect = CGRectMake(0, 50, self.frame.size.width, self.frame.size.height);
//    _scroll_base.frame = rect;
//    _scroll_base.scrollEnabled = NO;
   [self endEditing:YES];
}
@end
