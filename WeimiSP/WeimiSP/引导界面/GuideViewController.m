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
    _guideScrollView.backgroundColor = [UIColor blackColor];
    [_guideScrollView.pageControl setCurrentPageIndicatorTintColor:UIColorFromRGB(0xa38e00)];
    [_guideScrollView.pageControl setPageIndicatorTintColor:UIColorFromRGB(0xd7c026)];
    [_guideScrollView setNumberOfPages:4];
    
    [_guideScrollView setImage:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"introduce11"]]
                         label:[self labelWithTitle:@"夜可期身撩正太\n想聊天"]
                         index:0];
    [_guideScrollView setImage:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"introduce22"]]
                         label:[self labelWithTitle:@"日能上天逗助理\n做总裁"]
                         index:1];
    [_guideScrollView setImage:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"introduce33"]]
                         label:[self labelWithTitle:@"厨房司机全包办\n家政未满18"]
                         index:2];
    [_guideScrollView setImage:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"introduce44"]]
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
    label.font = [UIFont CustomFontOfSize:15.0];
    label.textColor = UIColorFromRGB(0xa3a3a3);
    label.numberOfLines = 0;
    label.hidden = YES;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}


@end
