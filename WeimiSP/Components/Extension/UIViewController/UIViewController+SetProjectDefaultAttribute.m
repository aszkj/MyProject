//
//  UIViewController+SetProjectDefaultAttribute.m
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/6.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "UIViewController+SetProjectDefaultAttribute.h"


@implementation UIViewController (SetProjectDefaultAttribute)

-(void)setDefaultAttribute {

    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.barTintColor = status_color;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(back) target:self];
}

- (void)back {

}

-(void)dealWeimiError:(NSError *)error {
    
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:error.localizedDescription delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
}

-(void)setVCTtitle:(NSString *)vcTitle {
    
//    [Util setNavTitleWithTitle:vcTitle ofVC:self];
}

@end
