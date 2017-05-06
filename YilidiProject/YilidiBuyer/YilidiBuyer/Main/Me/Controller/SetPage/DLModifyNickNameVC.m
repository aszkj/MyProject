//
//  DLModifyNickNameVC.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 17/2/21.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLModifyNickNameVC.h"

@interface DLModifyNickNameVC ()

@end

@implementation DLModifyNickNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTitle = @"修改昵称";
    self.nickNameField.text = self.nameStr;
    UIButton *rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
    rightItem.frame = CGRectMake(0, 0, 40, 40);
    [rightItem setTitle:@"确定" forState:UIControlStateNormal];
    rightItem.titleLabel.textAlignment = NSTextAlignmentRight;
    [rightItem setTitleColor:KSelectedTitleColor forState:UIControlStateNormal];
    rightItem.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [rightItem addTarget:self action:@selector(determine) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightItem];
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem barButtonItemSpace:-8],rightButton];
    
}

- (void)determine {

    if (self.nickNameField.text.length==0) {
        [self showSimplyAlertWithTitle:@"提示" message:@"请输入昵称" sureAction:^(UIAlertAction *action) {
            
        }];
    }else if(self.nickNameField.text.length<4||self.nickNameField.text.length>20){
    
        [self showSimplyAlertWithTitle:@"提示" message:@"昵称格式错误" sureAction:^(UIAlertAction *action) {
            
        }];
    }else{
    
        
        emptyBlock(self.nickNameBlock,self.nickNameField.text);
        [self goBack];
        
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
