//
//  DLOrderProcessView.m
//  YilidiBuyer
//
//  Created by yld on 16/5/27.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLOrderProcessView.h"

const CGFloat kImageWidth  = 16;
const CGFloat kImageHeight = 16.0;
const CGFloat kLabelWidth  = 45.0;
const CGFloat kLabelHeight = 10.0;
const CGFloat kButtonWidth  = kLabelWidth;
const CGFloat kButtonHeight = kImageHeight + kLabelHeight + 12.0;

const CGFloat kLineGap = 10;


@interface DLOrderProcessButton : UIButton

@end

@implementation DLOrderProcessButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.userInteractionEnabled = NO;
        
        [self setImage:[UIImage imageNamed:@"06"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"05"] forState:UIControlStateSelected];
        
    }
    
    return self;
}

/**
 *  布局item的image跟label
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整图片
    self.imageView.frame = CGRectMake(3, (kButtonWidth - kImageWidth) / 2.0, kImageWidth, (kButtonWidth - kImageWidth) / 2.0);
 }

@end

/*---------------DLOrderProcessView里面封装了DLOrderProcessButton-------------------*/

@interface DLOrderProcessView ()

@property(nonatomic,strong) NSMutableArray *itemArray;

@end


@implementation DLOrderProcessView

- (NSMutableArray *)itemArray
{
    if (_itemArray == nil) {
        
        _itemArray = [NSMutableArray array];
    }
    
//    self.backgroundColor = [UIColor blueColor];
    return _itemArray;
}

/**
 *  设置数据源
 *
 *  @param data 数据源
 */
- (void)setCount:(NSInteger)count
{
    _count = count;
    
    if (count == 0) {
        
        return;
    }
    
    for (int i  = 0; i < count; i++) {
        
        DLOrderProcessButton *item = [DLOrderProcessButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:item];
        [self.itemArray addObject:item];
    }
    
    // self.frame的宽度根据item的个数来动态变化
    CGRect rect = self.frame;
    // 默认是10
    _lineGap = kLineGap;
    rect.size = CGSizeMake(kButtonHeight,(kButtonWidth+_lineGap) * count - _lineGap);
    self.frame = rect;
    
}

/**
 *  设置线条之间的间距
 *
 *  @param lineGap 间距的长度
 */
- (void)setLineGap:(CGFloat)lineGap
{
    _lineGap = lineGap;
    
    CGRect rect = self.frame;
    rect.size = CGSizeMake(kButtonHeight,(kButtonWidth+_lineGap) * self.itemArray.count - _lineGap-kImageHeight);
    self.frame = rect;
}

/**
 *  根据订单的状态显示不同的颜色状态
 *
 *  @param orderStatus 订单状态
 */
- (void)setOrderStatus:(OrderProcessStatus)orderStatus
{
    _orderStatus = orderStatus;
    
    DLOrderProcessButton *selectedItem = self.itemArray[_orderStatus];
    for (DLOrderProcessButton *item in self.itemArray) {
        
        if (selectedItem == item) {
            
            item.selected = YES;
            
        }else {
            
            item.selected = NO;
        }
    }
}

/**
 *  布局item的frame
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (int i = 0; i < self.itemArray.count; i++) {
        
        DLOrderProcessButton *item = self.itemArray[i];
        item.frame = CGRectMake(0, (kButtonWidth+_lineGap)*i, kButtonWidth, kButtonHeight);
    }
}

/**
 *  画中间那根灰色的线
 */
- (void)drawRect:(CGRect)rect {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //创建UIBezierPath路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 设置起点
    [path moveToPoint:CGPointMake(self.frame.size.width/2-kImageWidth/2, self.frame.size.width /2.0)];
    
    // 添加一条线到某个点
    [path addLineToPoint:CGPointMake(self.frame.size.width/2 - kImageWidth /2.0, self.frame.size.height)];
    
    //把路径添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    // 设置宽度
    CGContextSetLineWidth(ctx, 1.5);
    // 设置颜色
    [[UIColor lightGrayColor] set];
    
    // 把上下文渲染到视图
    CGContextStrokePath(ctx);
    
}


@end
