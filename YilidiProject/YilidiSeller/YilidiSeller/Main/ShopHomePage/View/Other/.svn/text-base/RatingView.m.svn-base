//
//  RatingView.m
//  Movie
//
//  Created by Mac on 14-8-20.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "RatingView.h"

@implementation RatingView

- (void)_initSubviews
{
    _grayView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:_grayView];
    
    _yellowView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:_yellowView];
    
 
}

- (void)awakeFromNib
{
    [self _initSubviews];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initSubviews];
    }
    return self;
}


// 首先父视图layoutsubviews 然后再调子视图
- (void)layoutSubviews
{

    [super layoutSubviews];
    
    //设置高度
    CGFloat height = self.frame.size.height;
    
    //设置比例
    UIImage *gray = [UIImage imageNamed:@"grayStar"];
    _grayView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"grayStar"]];

    _yellowView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"yellowStar"]];

    _grayView.transform = CGAffineTransformMakeScale(height/gray.size.width, height/gray.size.height);
       _yellowView.transform = CGAffineTransformMakeScale(height/gray.size.width, height/gray.size.height);
    // 计算比例
    CGFloat rate = _rating / 10;
    
    // 总宽
    CGFloat allWidth = height * 5;
    
    _grayView.frame = CGRectMake(0, 0, allWidth, height);
    _yellowView.frame = CGRectMake(0, 0, allWidth * rate, height);

    // 设置frame
    CGRect rect = self.frame;
    rect.size.width = allWidth +40;
    self.frame = rect;

    
    
}
@end
