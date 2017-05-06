//
//  LGUIView.m
//  LGIndexView
//
//  Created by 雨逍 on 2016/12/5.
//  Copyright © 2016年 刘干. All rights reserved.
//

#import "LGUIView.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface LGUIView ()

@property (assign, nonatomic) NSInteger currentIndex;

@end


@implementation LGUIView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark  *********************************************** initWithFrame ***********************************************

- (instancetype)initWithFrame:(CGRect)frame indexArray:(NSArray *)array
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.indexArray = [NSArray arrayWithArray:array];
        
        CGFloat hh = self.frame.size.height/self.indexArray.count;
        
        for (int i = 0; i < array.count; i ++)
        {
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, i * hh, 17, 17)];
            label.center = CGPointMake(self.frame.size.width/2, i * hh + hh/2);
            label.text = self.indexArray[i];
            label.tag = TAG + i;
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = STR_COLOR;
            label.font = FONT_SIZE;
            if (i==0) {
                label.backgroundColor = SELETED_BGCOLOR;
                label.textColor = MARK_COLOR;
            }
            label.layer.cornerRadius = 8.5;
            label.layer.masksToBounds = YES;
            
            [self addSubview:label];
            _currentIndex = -1;
            _number = label.font.pointSize;
        }
        
//        [self addSubview:self.animationLabel];
    }
    
    return self;
}

#pragma mark  *********************************************** 懒加载 ***********************************************

-(UILabel *)animationLabel
{
    if (!_animationLabel)
    {
        _animationLabel = [[UILabel alloc]initWithFrame:CGRectMake(-WIDTH/2 + self.frame.size.width/2-14, kScreenHeight/2-60, 60, 60)];
        _animationLabel.layer.masksToBounds = YES;
        _animationLabel.layer.cornerRadius = 5.0f;
        _animationLabel.backgroundColor = SELETED_BGCOLOR;
        _animationLabel.textColor = MARK_COLOR;
        _animationLabel.alpha = 0;
        _animationLabel.textAlignment = NSTextAlignmentCenter;
        _animationLabel.font = [UIFont systemFontOfSize:18];
    }
    
    return _animationLabel;
}

#pragma mark  *********************************************** AnimationWithSection ***********************************************

-(void)animationWithSection:(NSInteger)section
{
    self.selectedBlock(section);
    [self setCurrentSelectedIndex:section];
    _animationLabel.text = self.indexArray[section];
    _animationLabel.alpha = 1.0;
}

#pragma mark  *********************************************** PanAnimationFinish ***********************************************

-(void)panAnimationFinish
{
    CGFloat hh = self.frame.size.height/self.indexArray.count;
    
    for (int i = 0; i < self.indexArray.count; i ++)
    {
        UILabel * label = (UILabel *)[self viewWithTag:TAG + i];
        
        [UIView animateWithDuration:0.2 animations:^{
            
            label.center = CGPointMake(self.frame.size.width/2, i * hh + hh/2);
            label.font = FONT_SIZE;
            label.alpha = 1.0;
//            label.textColor = STR_COLOR;//初始黑色

        }];
    }
    
        [UIView animateWithDuration:1 animations:^{
    
            self.animationLabel.alpha = 0;
    
        }];
}


- (void)setCurrentSelectedIndex:(NSInteger)index {
    
    if (_currentIndex != index) {
        _currentIndex = index;
    }else{

        return;
    }
    
    for (int i = 0; i < self.indexArray.count; i ++) {
        UILabel * label = (UILabel *)[self viewWithTag:TAG + i];
        if (i == _currentIndex) {
            
            label.textColor = MARK_COLOR;
            label.backgroundColor =  SELETED_BGCOLOR;
            label.alpha = 1.0;
        } else {
            label.backgroundColor =  [UIColor clearColor];
            label.textColor = STR_COLOR;
        }
        
        
    }
}

#pragma mark  *********************************************** PanAnimationBegin ***********************************************

-(void)panAnimationBeginWithToucher:(NSSet<UITouch *> *)touches
{
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGFloat hh = self.frame.size.height/self.indexArray.count;
    
    for (int i = 0; i < self.indexArray.count; i ++)
    {
        UILabel * label = (UILabel *)[self viewWithTag:TAG + i];
        if (fabs(label.center.y - point.y) <= ANIMATION_HEIGHT)
        {
            [UIView animateWithDuration:0.2 animations:^{
                
                label.center = CGPointMake(label.bounds.size.width/2 - sqrt(fabs(ANIMATION_HEIGHT * ANIMATION_HEIGHT - fabs(label.center.y - point.y) * fabs(label.center.y - point.y))), label.center.y);
                
                label.font = [UIFont systemFontOfSize:_number + (ANIMATION_HEIGHT - fabs(label.center.y - point.y)) * FONT_RATE];
                //索引文字滑动颜色
                if (fabs(label.center.y - point.y) * ALPHA_RATE <= 0.08)
                {
                    //                    label.textColor = MARK_COLOR;
                    //                    label.alpha = 1.0;
                    
                    [self animationWithSection:i];
                    //
                    //                    for (int j = 0; j < self.indexArray.count; j ++)
                    //                    {
                    //                        UILabel * label = (UILabel *)[self viewWithTag:TAG + j];
                    //                        if (i != j)
                    //                        {
                    //                            label.textColor = STR_COLOR;
                    //                            label.alpha = fabs(label.center.y - point.y) * ALPHA_RATE;
                    //                        }
                    //                    }
                }
            }];
        }else
        {
            [UIView animateWithDuration:0.2 animations:^
             {
                 label.center = CGPointMake(self.frame.size.width/2, i * hh + hh/2);
                 label.font = FONT_SIZE;
                 label.alpha = 1.0;
             }];
        }
    }
}


#pragma mark  *********************************************** UIResponder ***********************************************

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self panAnimationBeginWithToucher:touches];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self panAnimationBeginWithToucher:touches];
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self panAnimationFinish];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self panAnimationFinish];
}

#pragma mark  *********************************************** reloadVoice ***********************************************

-(void)selectIndexBlock:(MyBlock)block
{
    self.selectedBlock = block;
}

#pragma mark  *********************************************** dealloc ***********************************************

-(void)dealloc
{
    self.animationLabel = nil;
    self.indexArray = nil;
    self.selectedBlock = nil;
}

@end
