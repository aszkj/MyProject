//
//  QuickBodyTestHomeController.m
//  jingGang
//
//  Created by 张康健 on 15/11/24.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "QuickBodyTestHomeController.h"
#import "QuickTestController.h"
#import "Util.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"

@interface QuickBodyTestHomeController ()

@end

@implementation QuickBodyTestHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [Util setNavTitleWithTitle:@"快速体检" ofVC:self];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(back) target:self];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)beginQuickTestAction:(id)sender {
    
    QuickTestController *quickTestVC = [[QuickTestController alloc] init];
    [self.navigationController pushViewController:quickTestVC animated:YES];
    
}

@end
