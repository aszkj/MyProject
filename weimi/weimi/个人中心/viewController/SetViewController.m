//
//  SetViewController.m
//  weimi
//
//  Created by 张康健 on 16/2/19.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "SetViewController.h"
#import "AppDelegate.h"
#import "LoginController.h"
#import "DatabaseCache.h"
#import "FileMangeHelper.h"
#import "UIView+Loading.h"

@interface SetViewController ()
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentLabel;
@property (weak, nonatomic) IBOutlet UIButton *historyLabel;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    
}

#pragma mark ----------------------- Action Method -----------------------
- (void)_init {
    
    self.title = @"设置";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    if (self.telNumber.length > 5) {
        NSString *frontThreeNumber = [self.telNumber substringToIndex:3];
        NSString *backTwoNumber = [self.telNumber substringFromIndex:self.telNumber.length-2];
        self.phoneNumberLabel.text = [NSString stringWithFormat:@"%@******%@",frontThreeNumber,backTwoNumber];
    }
  
    self.versionLabel.text = [NSString stringWithFormat:@"v%@",[Util appVersion]];
    
    [self setLabelFont:self.currentLabel];
    [self setLabelFont:self.versionLabel];
    [self setLabelFont:self.phoneNumberLabel];
    [self setButtonFont:self.logoutButton];
    [self setButtonFont:self.historyLabel];
}

- (void)setLabelFont:(UILabel *)label {
    [label setFont:[UIFont customFontOfSize:14]];
}

- (void)setButtonFont:(UIButton *)button {
    [[button titleLabel] setFont:[UIFont customFontOfSize:15]];
}


- (IBAction)clearTalkHistoryAction:(id)sender {
    [self.view showWithTitle:@"正在清除缓存"];
    [[FileMangeHelper shareInstance] clearDisk];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view showWithTitle:@"清除缓存成功"];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view hideLoading];
    });
}


- (IBAction)logOutAction:(id)sender {
    
    [self userExit];
}

- (void)userExit
{
    NSLog(@"退出用户");
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确定要退出该账户？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alertView show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [kAppDelegate userExit];
    }
}






@end
