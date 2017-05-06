//
//  DLShopCartVirtualVC.m
//  YilidiBuyer
//
//  Created by yld on 16/6/16.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLShopCartVirtualVC.h"
#import "DLShopCarVC.h"
#import "ProjectRelativeDefineNotification.h"
#import "DLMainTabBarController.h"
#import "UIButton+Block.h"
#import "ProjectRelativeMaco.h"
#import <Masonry/Masonry.h>

@interface DLShopCartVirtualVC ()

@property (nonatomic, strong)UIView *emptyShopCartView;

@end

@implementation DLShopCartVirtualVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.emptyShopCartView.hidden = NO;
    self.pageTitle = @"购物车";
}

- (void)_comtoHomePage {
    afterSecondsLoadData(0.1,UIViewController *rootVC = rootController;
                         if ([rootVC isMemberOfClass:[DLMainTabBarController class]]) {
                             DLMainTabBarController *mainVC = (DLMainTabBarController *)rootController;
                             [mainVC setTabIndex:MainPageIndex];
                         }
                         )
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
}


- (UIView *)emptyShopCartView {
    
    if (!_emptyShopCartView) {
        _emptyShopCartView = BoundNibView(@"ShopCartIsEmptyView", UIView);
        [self.view addSubview:_emptyShopCartView];
        [_emptyShopCartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
        WEAK_SELF
        UIButton *continueShopButton = (UIButton *)[_emptyShopCartView viewWithTag:1];
        [continueShopButton addActionHandler:^(NSInteger tag) {
            [weak_self _comtoHomePage];
        }];
    }
    return _emptyShopCartView;
}



@end
