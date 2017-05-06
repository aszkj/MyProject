//
//  DLFeedbackVC.m
//  YilidiBuyer
//
//  Created by yld on 16/5/28.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLFeedbackVC.h"
#import "AFNHttpRequestOPManager+DLUnNomalApi.h"
#import "DLRequestUrl.h"
@interface DLFeedbackVC ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *adviceButton;

@property (weak, nonatomic) IBOutlet UIButton *faultButton;

@property (weak, nonatomic) IBOutlet UIButton *consultingButton;

@property (weak, nonatomic) IBOutlet UITextView *feedBackField;

@end

@implementation DLFeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark ------------------------Init---------------------------------
#pragma mark ------------------------Private-------------------------


#pragma mark ------------------------Api----------------------------------
- (void)_submitData {

    
    [AFNHttpRequestOPManager getInfoWithSubUrl:kUrl_Feeback parameters:@{@"feebackContent":_feedBackField.text} block:^(id result, NSError *error) {
        
        
    }];

}
#pragma mark ------------------------Page Navigate---------------------------


#pragma mark ------------------------View Event---------------------------
- (IBAction)adviceClick:(id)sender {
    _adviceButton.selected=YES;
    if (_adviceButton.selected==YES) {
        [_adviceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_adviceButton setBackgroundColor:UIColorFromRGB(0xff6600)];
        _consultingButton.backgroundColor = [UIColor whiteColor];
        [_consultingButton setTitleColor:UIColorFromRGB(0xff6600) forState:UIControlStateNormal];
        _faultButton.backgroundColor = [UIColor whiteColor];
        [_faultButton setTitleColor:UIColorFromRGB(0xff6600) forState:UIControlStateNormal];
        _faultButton.selected =NO;
        _consultingButton.selected =NO;
    }
}
- (IBAction)faultClick:(id)sender {
    _faultButton.selected=YES;
    if (_faultButton.selected==YES) {
        [_faultButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_faultButton setBackgroundColor:UIColorFromRGB(0xff6600)];
        _consultingButton.backgroundColor = [UIColor whiteColor];
        [_consultingButton setTitleColor:UIColorFromRGB(0xff6600) forState:UIControlStateNormal];
        _adviceButton.backgroundColor = [UIColor whiteColor];
        [_adviceButton setTitleColor:UIColorFromRGB(0xff6600) forState:UIControlStateNormal];
        _adviceButton.selected =NO;
        _consultingButton.selected =NO;
    }

}
- (IBAction)consultingClick:(id)sender {
    _consultingButton.selected=YES;
    if (_consultingButton.selected==YES) {
        [_consultingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_consultingButton setBackgroundColor:UIColorFromRGB(0xff6600)];
        _faultButton.backgroundColor = [UIColor whiteColor];
        [_faultButton setTitleColor:UIColorFromRGB(0xff6600) forState:UIControlStateNormal];
        _adviceButton.backgroundColor = [UIColor whiteColor];
        [_adviceButton setTitleColor:UIColorFromRGB(0xff6600) forState:UIControlStateNormal];
        _faultButton.selected =NO;
        _consultingButton.selected =NO;
    }

}

- (IBAction)submitButtonClick:(id)sender {
    
    if (_feedBackField.text.length==0) {
        
        [self showSimplyAlertWithTitle:@"提示" message:@"请详细描述您遇到的问题" sureAction:^(UIAlertAction *action) {
            
        }];
        
    }else{
    
        [self _submitData];
        
    }
    
    
}


#pragma mark ------------------------Delegate-----------------------------
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView

{
    if ([textView.text isEqualToString:@" 亲 , 详细描述您遇到的问题，或您的建议~"]) {
        textView.text=@"";
    }
    
    
    _feedBackField.textColor = [UIColor blackColor];
    
    return YES;
    
}

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------



@end
