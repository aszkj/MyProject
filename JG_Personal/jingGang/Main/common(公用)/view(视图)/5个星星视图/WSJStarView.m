//
//  WSJStarView.m
//  jingGang
//
//  Created by thinker on 15/9/9.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJStarView.h"
#import "PublicInfo.h"

@interface WSJStarView ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation WSJStarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self initUI];
    }
    return self;
}
- (void)awakeFromNib
{
//    [self initUI];
}

#pragma mark - 实例化UI
- (void)initUI
{
    CGFloat distance = 5;
    self.dataSource = [NSMutableArray array];
    CGFloat width = (self.frame.size.width - distance * 4) / 5;
    for ( NSInteger i = 0 ; i < 5 ; i ++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake( (width + distance) * i, 0, width, self.frame.size.height);
        [btn setImage:[UIImage imageNamed:@"Star1"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"Star"] forState:UIControlStateSelected];
        btn.tag = 1000 + i;
        [self.dataSource addObject:btn];
        [self addSubview:btn];
    }
}

-(void)setCount:(NSInteger)count
{
    _count = count;
    for (UIView *v  in [self subviews])
    {
        [v removeFromSuperview];
    }
    CGFloat distance = 3;
    CGFloat width = (self.frame.size.width - distance * 4) / 5;
    for (NSInteger i = 0 ; i < 5;  i ++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake( (width + distance) * i, 0, width, self.frame.size.height);
        if (i < count)
        {
            [btn setImage:[UIImage imageNamed:@"Star"] forState:UIControlStateNormal];
        }
        else
        {
            [btn setImage:[UIImage imageNamed:@"Star1"] forState:UIControlStateNormal];
        }
        [self addSubview:btn];
    }
//    for (NSInteger i = 0 ; i < count;  i++)
//    {
//        UIButton *btn = (UIButton *)[self viewWithTag:(1000 + i)];
//        btn.selected = YES;
//    }
}

@end
