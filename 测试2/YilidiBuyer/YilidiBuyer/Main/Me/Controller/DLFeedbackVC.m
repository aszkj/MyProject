//
//  DLFeedbackVC.m
//  YilidiBuyer
//
//  Created by yld on 16/5/28.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLFeedbackVC.h"

@interface DLFeedbackVC ()<UITextViewDelegate>


@property (weak, nonatomic) IBOutlet UITextView *feedBackField;
@property (strong, nonatomic) IBOutlet UILabel *promptLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *top;

@end

@implementation DLFeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTitle = @"意见反馈";
    
    if (kScreenWidth !=iPhone5_width) {
        self.top.constant-=5;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark ------------------------Init---------------------------------
#pragma mark ------------------------Private-------------------------
- (BOOL)isContainsTwoEmoji:(NSString *)string
{
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         //         NSLog(@"hs++++++++%04x",hs);
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f)
                 {
                     isEomji = YES;
                 }
                 //                 NSLog(@"uc++++++++%04x",uc);
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3|| ls ==0xfe0f) {
                 isEomji = YES;
             }
             //             NSLog(@"ls++++++++%04x",ls);
         } else {
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 isEomji = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 isEomji = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 isEomji = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 isEomji = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                 isEomji = YES;
             }
         }
         
     }];
    return isEomji;
}


#pragma mark ------------------------Api----------------------------------
- (void)_postFeedBackData{
    
    
    
    [self showLoadingHub];
    
    
    NSDictionary *requestParam = @{@"content":self.feedBackField.text};
    WEAK_SELF
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:kUrl_UserFeedback block:^(NSDictionary *resultDic, NSError *error) {
        
        
        if (error.code!=1) {
            [weak_self hideLoadingHub];
            return ;
        }
        [weak_self hideHubForText:@"提交成功"];
        [weak_self performSelector:@selector(_back) withObject:weak_self afterDelay:1];
        
        
    }];
    
    
    
}

#pragma mark ------------------------Page Navigate---------------------------
- (void)_back{

     [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ------------------------View Event---------------------------


- (IBAction)submitButtonClick:(id)sender {
    if (self.feedBackField.text.length>0) {
        
        
        [self _postFeedBackData];
       
        
        
    }else{
        [self showSimplyAlertWithTitle:@"提示" message:@"亲，详细描述您遇到的问题" sureAction:^(UIAlertAction *action) {
            
        }];
    }

}



#pragma mark ------------------------Delegate-----------------------------
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length>0) {
        self.promptLabel.hidden = YES;
    }else{
        self.promptLabel.hidden = NO;
        
    }
    
    BOOL flag=[self isContainsTwoEmoji:textView.text];
    
    if (textView == _feedBackField) {
        
        if (flag)
        {
            
            _feedBackField.text = [textView.text substringToIndex:textView.text.length -2];
            [self showSimplyAlertWithTitle:@"提示" message:@"不能输入表情符号" sureAction:^(UIAlertAction *action) {
                
            }];
            
        }
    }
    
    NSInteger number = [textView.text length];
    if (number > 500) {
        
        [self showSimplyAlertWithTitle:@"提示" message:@"输入内容不能大于500" sureAction:^(UIAlertAction *action) {
            
        }];
        
        textView.text = [textView.text substringToIndex:500];
        number = 500;
        
    }
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView

{
    self.promptLabel.hidden = YES;
    
    
    return YES;
    
}


//结束编辑时文本框的颜色
-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (textView.text.length>0) {
        self.promptLabel.hidden = YES;
    }else{
        self.promptLabel.hidden = NO;
        
    }
    return YES;
}



#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------



@end
