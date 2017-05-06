//
//  BaseViewController.m
//  weimi
//
//  Created by thinker on 16/1/18.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "BaseTabBarController.h"
#import "UIButton+Block.h"
#import "AppDelegate.h"
#import "XKJHNavRootController.h"

@interface BaseTabBarController ()

@property (nonatomic, strong) UIButton *weimiBtn;
@property (nonatomic, strong) UIImageView *weimiRed;
@property (nonatomic, strong) UIButton *NewMessageBtn;
@property (nonatomic, strong) UIButton *findBtn;
@property (nonatomic, strong) UIImageView *findRed;

@property (nonatomic,strong)UINavigationController *findNavi;
@property (nonatomic,strong)UINavigationController *weimiMainNavi;

@end

@implementation BaseTabBarController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initInfo];
    [self.tabBar addSubview:self.tabBarCustomView];
//    [_tabBarCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@0);
//        make.bottom.equalTo(@0);
//        make.right.equalTo(@0);
//        make.height.equalTo(@(49));
//    }];
    self.weimiBtn.selected = YES;
    
    
}

- (void)initInfo {
    
//    [kAppDelegate uploadApnToken];
//    [kAppDelegate uploadPhonesInfo];
//    [kAppDelegate uploadLocationInfo];
//    [kAppDelegate initIMServerInfo];
    
}

#pragma mark - getter

-(void)setHiddenWeimiRed:(BOOL)hiddenWeimiRed
{
    _hiddenWeimiRed = hiddenWeimiRed;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.weimiRed.hidden = hiddenWeimiRed;
    });
}
-(void)setHiddenFindRed:(BOOL)hiddenFindRed
{
    _hiddenFindRed = hiddenFindRed;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.findRed.hidden = hiddenFindRed;
    });
}

-(UIImageView *)weimiRed
{
    if (!_weimiRed) {
        _weimiRed = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 12)];
//        _weimiRed.layer.cornerRadius = CGRectGetWidth(_weimiRed.frame) / 2;
//        _weimiRed.clipsToBounds = YES;
        _weimiRed.hidden = YES;
        _weimiRed.image = [UIImage imageNamed:@"redImage"];
    }
    return _weimiRed;
}
-(UIImageView *)findRed
{
    if (!_findRed) {
        _findRed = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 12)];
//        _findRed.layer.cornerRadius = CGRectGetWidth(_weimiRed.frame) / 2;
//        _findRed.clipsToBounds = YES;
        _findRed.hidden = YES;
        _findRed.image = [UIImage imageNamed:@"redImage"];
    }
    return _findRed;
}

-(UIView *)tabBarCustomView
{
    if (!_tabBarCustomView) {
        _tabBarCustomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 49)];
        _tabBarCustomView.backgroundColor = UIColorFromRGB(0Xffffff);
        
        [_tabBarCustomView addSubview:self.weimiBtn];
        [_tabBarCustomView addSubview:self.NewMessageBtn];
        [_tabBarCustomView addSubview:self.findBtn];
        
        CGFloat width = kScreenWidth / 3;
        [_weimiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.top.equalTo(@0);
            make.bottom.equalTo(@0);
            make.width.equalTo(@(width));
        }];
        [_NewMessageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_weimiBtn.mas_right).with.offset(0);
            make.top.equalTo(@0);
            make.bottom.equalTo(@0);
            make.width.equalTo(@(width));
        }];
        [_findBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@0);
            make.top.equalTo(@0);
            make.bottom.equalTo(@0);
            make.width.equalTo(@(width));
        }];
        
    }
    return _tabBarCustomView;
}

-(UIButton *)weimiBtn
{
    if (!_weimiBtn) {
        _weimiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _weimiBtn.tag = 0;
        [_weimiBtn addTarget:self action:@selector(tabBarAction:) forControlEvents:UIControlEventTouchUpInside];
        [_weimiBtn setImage:[UIImage imageNamed:@"homePage_weimi"] forState:UIControlStateNormal];
        [_weimiBtn setImage:[UIImage imageNamed:@"homePage_weimiSelect"] forState:UIControlStateSelected];
        _weimiBtn.backgroundColor = [UIColor whiteColor];
        [_weimiBtn setTitle:@"唯秘" forState:UIControlStateNormal];
        _weimiBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        _weimiBtn.titleEdgeInsets = UIEdgeInsetsMake(30, 0, 0, 30);
        _weimiBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 15, 0);
        [_weimiBtn setTitleColor:UIColorFromRGB(0Xb0b0b0) forState:UIControlStateNormal];
        [_weimiBtn setTitleColor:UIColorFromRGB(0X32c861) forState:UIControlStateSelected];
        [_weimiBtn addSubview:self.weimiRed];
        CGFloat x = kScreenWidth / 6 + _weimiBtn.imageView.image.size.width / 2;
        CGFloat y = 10;
        _weimiRed.center = CGPointMake(x, y);
        
    }
    return _weimiBtn;
}
-(UIButton *)NewMessageBtn
{
    if (!_NewMessageBtn) {
        _NewMessageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_NewMessageBtn setImage:[UIImage imageNamed:@"homePage_add"] forState:UIControlStateNormal];
        [_NewMessageBtn setImage:[UIImage imageNamed:@"homePage_addHighlighted"] forState:UIControlStateHighlighted];
        [_NewMessageBtn addTarget:self action:@selector(newMessageAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _NewMessageBtn;
}
-(UIButton *)findBtn
{
    if (!_findBtn) {
        _findBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _findBtn.tag = 1;
        [_findBtn addTarget:self action:@selector(tabBarAction:) forControlEvents:UIControlEventTouchUpInside];
        [_findBtn setImage:[UIImage imageNamed:@"homePage_find"] forState:UIControlStateNormal];
        [_findBtn setImage:[UIImage imageNamed:@"homePage_findSelect"] forState:UIControlStateSelected];
        [_findBtn setTitle:@"发现" forState:UIControlStateNormal];
        _findBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        _findBtn.titleEdgeInsets = UIEdgeInsetsMake(30, 0, 0, 30);
        _findBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 15, 0);
        [_findBtn setTitleColor:UIColorFromRGB(0Xb0b0b0) forState:UIControlStateNormal];
        [_findBtn setTitleColor:UIColorFromRGB(0X32c861) forState:UIControlStateSelected];
        [_findBtn addSubview:self.findRed];
        CGFloat x = kScreenWidth / 6 + _findBtn.imageView.image.size.width / 2;
        CGFloat y = 10;
        _findRed.center = CGPointMake(x, y);
    }
    return _findBtn;
}


#pragma mark - private methord

- (void)tabBarAction:(UIButton *)btn
{
    _weimiBtn.selected = NO;
    _NewMessageBtn.selected = NO;
    _findBtn.selected = NO;
    btn.selected = YES;
    self.selectedIndex = btn.tag;
}

- (void)newMessageAction
{
}


@end
