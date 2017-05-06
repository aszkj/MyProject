//
//  GuideScrollView.h
//  weimi
//
//  Created by ray on 16/3/1.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GuideEndBlock)();


@interface GuideScrollView : UIScrollView

@property (nonatomic) UIPageControl *pageControl;
@property (nonatomic) NSInteger numberOfPages;
@property (nonatomic, copy) GuideEndBlock guideEndBlock;
@property (nonatomic) UIButton *skipButton;

- (void)setImage:(UIImageView *)imageView label:(UILabel *)titleLabel index:(NSInteger)index;

@end
