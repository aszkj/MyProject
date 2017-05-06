//
//  TimerLoopView.m
//  TestPaomadeng
//  根据文字展示上下跑马灯
//  Created by opp_cat on 13-12-3.
//  Copyright (c) 2013年 opp_cat. All rights reserved.
//

#import "TimerLoopView.h"



@implementation LoopObj

//@synthesize LabelName=_LabelName;

@end

@interface TimerLoopView()
{
    UIScrollView *abstractScrollview;
    
    CGPoint _offsetpy;
    
    NSInteger autoIndex;
    
    NSArray *_itemarray;
    
    
    
    CGFloat _height;
    
    CGFloat _width;
    
    
     NSTimer *m_timer;
}

-(void)makeselfUI;

@end

@implementation TimerLoopView

//@synthesize currentOffset;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self makeselfUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self makeselfUI];
    }
    return self;
}

-(void)makeselfUI
{
    
    //offset
    _offsetpy=CGPointMake(0, 0);
    
    _width=self.frame.size.width;
    
    _height=self.frame.size.height;
    
    autoIndex=0;
    self.timeInterValEach = 5.0f;
    //for test
    abstractScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,_width , _height)];
    [self addSubview:abstractScrollview];
    
    //contentSize
    [abstractScrollview setContentSize:CGSizeMake(self.frame.size.width, ([_itemarray count]+1)*_height)];
    
    self.titleColor = [UIColor darkTextColor];
    self.titleFont = [UIFont systemFontOfSize:12];
    
    //add subviews
    if (_itemarray.count) {
        [self _creatButtons];
    }
    
    //abstract!!
    abstractScrollview.contentOffset=CGPointMake(0, 0);
    
}

- (void)configureButton:(UIButton *)button obj:(LoopObj *)obj {
    button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    button.titleLabel.font = self.titleFont;
    [button setTitleColor:self.titleColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button setTitle:obj.titleName forState:UIControlStateNormal];
}

- (void)_creatButtons {
    // 0  1  2   3  4   5  6    7  8   9  .... 0
    for (int i=0; i<[_itemarray count]; i++)
    {
        //loop obj
        LoopObj *obj=(LoopObj*)[_itemarray objectAtIndex:i];
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, _height*i, _width-20, _height)];
        button.tag=10+i;
        [self configureButton:button obj:obj];
        [abstractScrollview addSubview:button];
        
        if (i==[_itemarray count]-1) {//在遍历到数组最后一个时，加了两个button,一个最后一个，一个第一个，第一个button加了两次，头部，尾部
            LoopObj *obj=(LoopObj*)[_itemarray objectAtIndex:0];
            UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, _height*(i+1), _width-50, _height)];
            [self configureButton:button obj:obj];
            button.tag=10+i+1;
            [abstractScrollview addSubview:button];
        }
    }

}

- (void)clickBtn:(UIButton *)btn {
    NSInteger clickIndex = btn.tag - 10;
    if (clickIndex == _itemarray.count) {//说明实际上是第一个button
        clickIndex = 0;
    }
    if (self.clickItemBlock) {
        LoopObj *loopObj = _itemarray[clickIndex];
        self.clickItemBlock(clickIndex,loopObj.titleName);
    }
}

-(CGPoint)currentOffset
{
    return _offsetpy;
}

-(NSArray*)itemarray
{
    return _itemarray;
}


-(void)setItemarray:(NSArray *)itemarray {
    
    _itemarray = itemarray;
    [self _creatButtons];
//    [self makeselfUI];
    [self startTimer];
}

- (id)initWithFrame:(CGRect)frame withitemArray:(NSArray*)teams
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //item
        _itemarray=teams;
        assert([teams count]!=0);
        // Initialization code
         [self makeselfUI];
        [self startTimer];
    }
    return self;
}
//startTimer
- (void)startTimer
{
    if (m_timer == nil) {
        m_timer = [NSTimer timerWithTimeInterval:self.timeInterValEach target:self selector:@selector(updateTitle) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:m_timer forMode:NSRunLoopCommonModes];
    }
}
//stop Timer
- (void)releaseTimer
{
    if ([m_timer isValid]) {
        [m_timer invalidate];
        m_timer = nil;
    }
   
}


- (void)updateTitle
{
    //起始位置
    UIView *topButton = (UIView *)[abstractScrollview viewWithTag:10];
    CGPoint point1 = CGPointMake(0, 0);
    point1.y = topButton.frame.origin.y;
    
    //最后标签位置
    UIView *lastButton=(UIView *)[abstractScrollview viewWithTag:10+[_itemarray count]];
    
    //当前标签位置
    CGPoint point = [abstractScrollview contentOffset];
    
    if (point.y >=lastButton.frame.origin.y) {
        
        autoIndex=0;
        
        abstractScrollview.contentOffset = point1;
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];

    UIView *view=(UIView*)[abstractScrollview viewWithTag:autoIndex+10+1];
    
    CGPoint pointmiddle=CGPointMake(0, view.frame.origin.y);
    
    autoIndex +=1;
    
    abstractScrollview.contentOffset = pointmiddle;
    
    [UIView commitAnimations];
    
}

-(void)dealloc
{
    [self releaseTimer];
}

@end
