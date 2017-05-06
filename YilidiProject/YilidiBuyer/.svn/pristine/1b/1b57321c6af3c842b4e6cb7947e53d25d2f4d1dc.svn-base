//
//  DLHelpView.m
//  YilidiBuyer
//
//  Created by yld on 16/5/13.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLHelpView.h"

@interface DLHelpView ()


@property(nonatomic)UILabel *titleLable;
@property(nonatomic)UIButton *btn;
@property(nonatomic)UIImageView *iv;

@end


@implementation DLHelpView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customView];
    }
    return self;
}
-(void)customView
{
    _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, self.frame.size.width-50, self.frame.size.height)];
    _titleLable.font = [UIFont systemFontOfSize:15];
    _iv = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-40, 16, 19, 11)];
    [_iv setImage:[UIImage imageNamed:@"xialajiantou"]];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, _titleLable.frame.origin.y+_titleLable.frame.size.height+2, kScreenWidth, 1)];
    view.backgroundColor = kGetColor(229, 229, 229);
    [self addSubview:_iv];
    [self addSubview:_titleLable];
    [self addSubview:view];
    //添加点击的手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
}

-(void)onTap:(UITapGestureRecognizer *)tap
{
    if (self.block) {
        self.block();
    }
}

-(void)updateWith:(NSString *)title WithStatus:(BOOL)status
{
    _titleLable.text = title;

    
    CGAffineTransform willTransform;
    if (status) {
        willTransform = CGAffineTransformMakeRotation(M_PI);
        
    }else {
        willTransform = CGAffineTransformIdentity;
      
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        _iv.transform = willTransform;
        [self layoutIfNeeded];
    }];
    
    
}
@end
