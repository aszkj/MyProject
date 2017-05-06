//
//  hearingResultView.m
//  jingGang
//
//  Created by thinker on 15/7/25.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "hearingResultView.h"

@implementation hearingResultView
{
    UIImageView *_leftImageView;  //左边图片
    UIImageView *_rightImageView;//右边图片
    UIView *_centerView;           //中间颜色
}

- (void)setFrequency:(NSInteger)frequency
{
    _frequency = frequency;
    float x = (float)(frequency - 20) / 19980 *self.frame.size.width;
    NSLog(@"cheshi --%ld-- %g",frequency,0.0);
    
    if (_intLeft == -1)
    {
        _intLeft = frequency;
        _leftImageView.center = CGPointMake(x, self.frame.size.height / 2);
    }
    else if (_intRight == -1)
    {
        if (_intLeft < frequency)
        {
            _intRight = frequency;
            _rightImageView.hidden = NO;
            _rightImageView.center = CGPointMake(x, self.frame.size.height / 2);
        }
        else
        { 
            _intRight = _intLeft;
            _rightImageView.hidden = NO;
            _rightImageView.center = CGPointMake((float)(_intLeft - 20) / 19980 *self.frame.size.width, self.frame.size.height / 2);
            
            _intLeft = frequency;
            _leftImageView.center = CGPointMake(x, self.frame.size.height / 2);
        }
        
        _centerView.frame = CGRectMake(_leftImageView.center.x, self.frame.size.height / 2 - 1, _rightImageView.frame.origin.x - _leftImageView.frame.origin.x , 2);
    }
    else
    {
        if (frequency < _intLeft)
        {
            _intLeft = frequency;
            _leftImageView.center = CGPointMake(x, self.frame.size.height / 2);
        }
        else if (frequency > _intRight)
        {
            _intRight = frequency;
            _rightImageView.center = CGPointMake(x, self.frame.size.height / 2);
        }
        _centerView.frame = CGRectMake(_leftImageView.center.x, self.frame.size.height / 2 - 1, _rightImageView.frame.origin.x - _leftImageView.frame.origin.x , 2);
    }
    
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    return self;
}
- (void)awakeFromNib
{
    
}
-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    _intLeft = _intRight = -1;
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, rect.size.height / 2 - 1 , rect.size.width, 2)];
    v.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:v];
    
    _leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button"]];
    _rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button"]];
    _leftImageView.bounds = CGRectMake(0, 0, 20, 20);
    _leftImageView.center = CGPointMake(0, rect.size.height / 2);
    
    _rightImageView.bounds = CGRectMake(0, 0, 20, 20);
    _rightImageView.center = CGPointMake(0, rect.size.height / 2);
    _rightImageView.hidden = YES;
    
    
    _centerView = [[UIView alloc] init];
    _centerView.backgroundColor = [UIColor colorWithRed:8.0 / 255 green:196.0 / 255 blue:240.0 / 255 alpha:1];
//    _centerView.backgroundColor = [UIColor blueColor];
    [self addSubview:_centerView];
    
    [self addSubview:_leftImageView];
    [self addSubview:_rightImageView];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
