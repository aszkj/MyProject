//
//  GuideScrollView.m
//  weimi
//
//  Created by ray on 16/3/1.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "GuideScrollView.h"

@interface GuideScrollView () <UIScrollViewDelegate>


@end

@implementation GuideScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.delegate = self;
    self.pagingEnabled = YES;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.bounces = NO;
}

- (void)didMoveToSuperview
{
    if (self.superview == nil) { return; }
    [self.superview addSubview:self.pageControl];
    [self.superview addSubview:self.skipButton];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.superview);
        make.bottom.equalTo(self.superview).with.offset(-20);
    }];
    [self.skipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(24);
        make.right.equalTo(self).with.offset(-12);
    }];
    [self.skipButton sizeToFit];
}

- (void)setImage:(UIImageView *)imageView label:(UILabel *)titleLabel index:(NSInteger)index
{
    [self addSubview:imageView];
    [self addSubview:titleLabel];
//    CGFloat fitHeight = imageView.image.size.height / imageView.image.size.width * self.frame.size.width;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.equalTo(self);
        make.left.equalTo(self).with.offset(index*CGRectGetWidth(self.frame));
        make.height.equalTo(self);
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).with.offset(50);
        make.centerX.equalTo(imageView);
        make.left.right.mas_equalTo(imageView);
    }];
    
    if (index == self.numberOfPages - 1) {
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endGuidAction)];
        [imageView addGestureRecognizer:tap];
//        UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
//        [button setTitle:@"立即体验" forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(endGuidAction) forControlEvents:UIControlEventTouchUpInside];
//        [button setBackgroundColor:self.pageControl.currentPageIndicatorTintColor];
//        button.layer.cornerRadius = 5.0;
//        [self addSubview:button];
//        [button mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(titleLabel.mas_bottom).with.offset(12);
//            make.left.equalTo(imageView).with.offset(12);
//            make.right.equalTo(imageView).with.offset(-12);
//            make.height.equalTo(@35);
//        }];
    }
}


- (void)endGuidAction
{
    if (self.guideEndBlock != nil) {
        self.guideEndBlock();
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    BOOL islastPage = (scrollView.contentOffset.x > scrollView.frame.size.width * (self.numberOfPages-2));
    if (islastPage && self.pageControl.hidden == NO) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.pageControl.hidden = YES;
        });
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger pageNumber = self.contentOffset.x / self.frame.size.width;
    [self.pageControl setCurrentPage:pageNumber];
    if (pageNumber < self.numberOfPages - 1 && self.pageControl.hidden == YES) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.pageControl.hidden = NO;
        });
    }
    
}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    NSInteger pageNumber = self.contentOffset.x / self.frame.size.width;
//    [self.pageControl setCurrentPage:pageNumber];
//    if (pageNumber == _numberOfPages - 1)
//    {
//        _pageControl.hidden = YES;
//    }
//    else
//    {
//        _pageControl.hidden = NO;
//    }
//}

#pragma mark - getter and setter

- (void)setNumberOfPages:(NSInteger)numberOfPages {
    if (_numberOfPages == numberOfPages) return;
    _numberOfPages = numberOfPages;
    self.contentSize = CGSizeMake(self.frame.size.width * numberOfPages, self.frame.size.height);
    self.pageControl.numberOfPages = numberOfPages;
}

- (UIPageControl *)pageControl {
    if (_pageControl != nil) { return _pageControl; }
    _pageControl = [[UIPageControl alloc] init];
    [_pageControl setPageIndicatorTintColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    [_pageControl setCurrentPageIndicatorTintColor:[UIColor whiteColor]];
    [_pageControl setNumberOfPages:3];
    return _pageControl;
}

- (UIButton *)skipButton {
    if (_skipButton != nil) { return _skipButton; }
    _skipButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [_skipButton setTitle:@"跳过" forState:UIControlStateNormal];
    [_skipButton addTarget:self action:@selector(endGuidAction) forControlEvents:UIControlEventTouchUpInside];
    _skipButton.layer.borderColor = [UIColor whiteColor].CGColor;
    _skipButton.layer.borderWidth = 0.5;
    _skipButton.layer.cornerRadius = 8.0;
    [_skipButton setContentEdgeInsets:UIEdgeInsetsMake(6, 12, 6, 12)];
    return _skipButton;
}

@end
