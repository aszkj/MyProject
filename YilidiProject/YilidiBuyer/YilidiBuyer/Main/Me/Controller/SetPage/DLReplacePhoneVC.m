//
//  DLReplacePhoneVC.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 17/2/21.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLReplacePhoneVC.h"
#import "DLBindingPhoneVC.h"

@interface DLReplacePhoneVC ()

@end

@implementation DLReplacePhoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTitle = @"手机号绑定";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)replaceClick:(id)sender {
    DLBindingPhoneVC *bindingVC = [[DLBindingPhoneVC alloc]init];
    [self navigatePushViewController:bindingVC animate:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
