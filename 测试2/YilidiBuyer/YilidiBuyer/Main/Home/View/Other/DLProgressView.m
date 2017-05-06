//
//  DLProgressView.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/8/19.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLProgressView.h"

@implementation DLProgressView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self _int];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self _int];
    }
    return self;
}

- (void)_int{
    _minImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    UIImage *min = [self buttonImageFromColor:[UIColor whiteColor]];
    UIImage *strechMin = [min stretchableImageWithLeftCapWidth:min.size.width topCapHeight:min.size.height];
    _minImageView.image = strechMin;
    [self addSubview:_minImageView];
    
    _maxImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    UIImage *max = [self buttonImageFromColor:[UIColor redColor]];
    UIImage *strechMax = [max stretchableImageWithLeftCapWidth:max.size.width topCapHeight:max.size.height];
    _maxImageView.image = strechMax;
    [self addSubview:_maxImageView];
    
    self.layer.borderWidth=1.0;
    self.layer.borderColor = [UIColor redColor].CGColor;
    self.maxValue = 10;//默认
}


- (UIImage *)buttonImageFromColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext(); return img;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setValue:(CGFloat)value {
    _value = value;
    [self createProgressImgView];
}

- (void)createProgressImgView {
    // 设置底图
    _minImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    // 设置最大值范围 eg. 100 - 0
    CGFloat maxValue = self.maxValue - self.minValue;
    
    // 计算比例
    CGFloat percent = _value / maxValue;
    // 根据比例和总宽度，计算进度
    CGFloat width = percent * self.frame.size.width;
    
    // 设置进度图frame
    _maxImageView.frame = CGRectMake(0, _minImageView.frame.origin.y, width, _minImageView.frame.size.height);

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self createProgressImgView];
}


@end
