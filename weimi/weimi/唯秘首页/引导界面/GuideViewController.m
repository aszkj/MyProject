//
//  GuideViewController.m
//  weimi
//
//  Created by ray on 16/3/1.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "GuideViewController.h"
#import "GuideScrollView.h"

@interface GuideViewController ()

@property (nonatomic) GuideScrollView *guideScrollView;

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.guideScrollView];
}

- (GuideScrollView *)guideScrollView {
    if (_guideScrollView != nil) return _guideScrollView;
    
    _guideScrollView = [[GuideScrollView alloc] initWithFrame:self.view.bounds];
    _guideScrollView.backgroundColor = [UIColor whiteColor];
    [_guideScrollView.pageControl setCurrentPageIndicatorTintColor:UIColorFromRGB(0x0bb5f6)];
    [_guideScrollView.pageControl setPageIndicatorTintColor:UIColorFromRGB(0xd0eefb)];
    [_guideScrollView setNumberOfPages:4];
    
    [_guideScrollView setImage:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide_01"]]
                         label:[self labelWithTitle:@"夜可期身撩正太\n想聊天"]
                         index:0];
    [_guideScrollView setImage:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide_02"]]
                         label:[self labelWithTitle:@"日能上天逗助理\n做总裁"]
                         index:1];
    [_guideScrollView setImage:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide_03"]]
                         label:[self labelWithTitle:@"厨房司机全包办\n家政未满18"]
                         index:2];
    [_guideScrollView setImage:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide_04"]]
                         label:[self labelWithTitle:@"唯秘\n解锁您的私人贴身助理"]
                         index:3];
    WEAK_SELF;
    _guideScrollView.guideEndBlock = ^() {
        [weak_self dismissViewControllerAnimated:YES completion:nil];
    };
    return _guideScrollView;
}

- (UILabel *)labelWithTitle:(NSString *)title {
    UILabel *label = [UILabel new];
    label.text = title;
    label.font = [UIFont customFontOfSize:23.0];
    //Todo:设置段落间距15.0
    
    
    label.textColor = UIColorFromRGB(0xa3a3a3);
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}


@end
