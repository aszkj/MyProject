//  RBCustomDatePickerView.h
//  YilidiSeller
//
//  Created by yld on 16/6/14.
//  Copyright © 2016年 yld. All rights reserved.
//


#import "RBCustomDatePickerView.h"

@interface RBCustomDatePickerView()
{
    UIView                      *timeBroadcastView;//定时播放显示视图
    MXSCycleScrollView          *hourScrollView;//时滚动视图
    MXSCycleScrollView          *minuteScrollView;//分滚动视图
    MXSCycleScrollView          *hourScrollViewTwo;//时滚动视图
    MXSCycleScrollView          *minuteScrollViewTwo;//分滚动视图
    UILabel                     *nowPickerShowTimeLabel;//当前picker显示的时间
    UILabel                     *selectTimeIsNotLegalLabel;//所选时间是否合法
    NSString                    *result;
    UIView                      *bgView;
}
@end

@implementation RBCustomDatePickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setTimeBroadcastView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark -custompicker
//设置自定义datepicker界面
- (void)setTimeBroadcastView
{
    bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.70;
    [self addSubview:bgView];
    
    timeBroadcastView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2-278.5/2, kScreenHeight/2-300/2-64, 278.5, 300.0)];
    timeBroadcastView.layer.borderColor = kGetColor(237.0, 237.0, 237.0).CGColor;
    timeBroadcastView.backgroundColor = [UIColor whiteColor];
    timeBroadcastView.layer.borderWidth = 1.0;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(timeBroadcastView.frame.size.width/2-30, 5, 60, 20)];
    [label setBackgroundColor:[UIColor whiteColor]];
    [label setFont:[UIFont systemFontOfSize:14.0]];
    [label setTextColor:kGetColor(51, 51, 51)];
    [label setTextAlignment:NSTextAlignmentCenter];
    label.text = @"营业时间";
    [timeBroadcastView addSubview:label];
    timeBroadcastView.layer.cornerRadius = 8;//设置视图圆角
    timeBroadcastView.layer.masksToBounds = YES;
    CGColorRef cgColor = [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1.0].CGColor;
    timeBroadcastView.layer.borderColor = cgColor;
    timeBroadcastView.layer.borderWidth = 2.0;
    [self addSubview:timeBroadcastView];

    UIView *middleSepView = [[UIView alloc] initWithFrame:CGRectMake(0, 95, 278.5, 38)];
    [middleSepView setBackgroundColor:kGetColor(249.0, 138.0, 20.0)];
//    [timeBroadcastView addSubview:middleSepView];
    [self setHourScrollView];
    [self setMinuteScrollView];
    [self setHourScrollViewTwo];
    [self setMinuteScrollViewTwo];

    
    UILabel *starlabel = [[UILabel alloc] initWithFrame:CGRectMake(hourScrollView.frame.origin.x+15, hourScrollView.frame.origin.y+hourScrollView.frame.size.height+10, 60, 20)];
    [starlabel setBackgroundColor:[UIColor clearColor]];
    [starlabel setFont:[UIFont systemFontOfSize:14.0]];
    [starlabel setTextColor:kGetColor(51, 51, 51)];
    [starlabel setText:@"开始时间"];
    [starlabel setTextAlignment:NSTextAlignmentCenter];
    [timeBroadcastView addSubview:starlabel];
    
    
    
    
    UILabel *endlabel = [[UILabel alloc] initWithFrame:CGRectMake(hourScrollViewTwo.frame.origin.x+15, hourScrollView.frame.origin.y+hourScrollViewTwo.frame.size.height+10, 60, 20)];
    [endlabel setBackgroundColor:[UIColor whiteColor]];
    [endlabel setFont:[UIFont systemFontOfSize:14.0]];
    [endlabel setTextColor:kGetColor(51, 51, 51)];
    [endlabel setText:@"结束时间"];
    [endlabel setTextAlignment:NSTextAlignmentCenter];
    [timeBroadcastView addSubview:endlabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(5, endlabel.frame.origin.y+endlabel.frame.size.height+5, timeBroadcastView.frame.size.width-10, 0.5)];
    [line setBackgroundColor:UIColorFromRGB(0xcccccc)];
    [timeBroadcastView addSubview:line];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setFrame:CGRectMake(timeBroadcastView.frame.size.width/2-150, line.frame.origin.y+2, 300, 50)];
    [btn addTarget:self action:@selector(_buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setTintColor:[UIColor blackColor]];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [timeBroadcastView addSubview:btn];
    
    
    [self currentTime];
}

- (void)_buttonClick {
    
    if (_timePickerBlock) {
        _timePickerBlock(result);
    }
    
}

- (void)currentTime {

//    NSDate *now = [NSDate date];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
//    NSString *dateString = [dateFormatter stringFromDate:now];
//    NSString *str = [NSString stringWithFormat:@"%@:%@",[dateString substringWithRange:NSMakeRange(8, 2)],[dateString substringWithRange:NSMakeRange(10, 2)]];
//    result = [NSString stringWithFormat:@"%@-%@",str,str];
    result = [NSString stringWithFormat:@"08:30-22:00"];
}
//设置年月日时分的滚动视图
- (void)setHourScrollView
{
    hourScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(15, 20, 45.0, 190.0)];
    hourScrollView.tag=100;
    NSInteger hourint = [self setNowTimeShow:0 nowTimeStr:@"20150101083060"];
    [hourScrollView setCurrentSelectPage:(hourint-2)];
    hourScrollView.delegate = self;
    hourScrollView.datasource = self;
    [self setAfterScrollShowView:hourScrollView andCurrentPage:1];
    [timeBroadcastView addSubview:hourScrollView];
}
//设置年月日时分的滚动视图
- (void)setMinuteScrollView
{
    minuteScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(60, 20, 45.0, 190.0)];
    minuteScrollView.tag=100;
    NSInteger minuteint = [self setNowTimeShow:1 nowTimeStr:@"20150101083060"];
    [minuteScrollView setCurrentSelectPage:(minuteint-2)];
    minuteScrollView.delegate = self;
    minuteScrollView.datasource = self;
    [self setAfterScrollShowView:minuteScrollView andCurrentPage:1];
    [timeBroadcastView addSubview:minuteScrollView];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(60+44, 30, 1, 170)];
    lineView.backgroundColor = UIColorFromRGB(0xd7d7d7);
    [timeBroadcastView addSubview:lineView];
}

- (void)setHourScrollViewTwo
{
    hourScrollViewTwo = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(timeBroadcastView.frame.size.width/2+30, 20, 45.0, 190.0)];
    hourScrollViewTwo.tag=101;
    NSInteger hourint = [self setNowTimeShow:0 nowTimeStr:@"20150101220060"];
    [hourScrollViewTwo setCurrentSelectPage:(hourint-2)];
    hourScrollViewTwo.delegate = self;
    hourScrollViewTwo.datasource = self;
    [self setAfterScrollShowView:hourScrollViewTwo andCurrentPage:1];
    [timeBroadcastView addSubview:hourScrollViewTwo];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(timeBroadcastView.frame.size.width/2+31, 30, 1, 170)];
    lineView.backgroundColor = UIColorFromRGB(0xd7d7d7);
    [timeBroadcastView addSubview:lineView];

    
    
    
}
//设置年月日时分的滚动视图
- (void)setMinuteScrollViewTwo
{
    minuteScrollViewTwo = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(timeBroadcastView.frame.size.width/2+75, 20, 45.0, 190.0)];
    minuteScrollViewTwo.tag = 101;
    NSInteger minuteint = [self setNowTimeShow:1 nowTimeStr:@"20150101220060"];
    [minuteScrollViewTwo setCurrentSelectPage:(minuteint-2)];
    minuteScrollViewTwo.delegate = self;
    minuteScrollViewTwo.datasource = self;
    [self setAfterScrollShowView:minuteScrollViewTwo andCurrentPage:1];
    [timeBroadcastView addSubview:minuteScrollViewTwo];
}

- (void)setAfterScrollShowView:(MXSCycleScrollView*)scrollview  andCurrentPage:(NSInteger)pageNumber
{
    UILabel *oneLabel = [[(UILabel*)[[scrollview subviews] objectAtIndex:0] subviews] objectAtIndex:pageNumber];
    [oneLabel setFont:[UIFont systemFontOfSize:12]];
    [oneLabel setTextColor:kGetColor(186.0, 186.0, 186.0)];
    UILabel *twoLabel = [[(UILabel*)[[scrollview subviews] objectAtIndex:0] subviews] objectAtIndex:pageNumber+1];
    [twoLabel setFont:[UIFont systemFontOfSize:14]];
    [twoLabel setTextColor:kGetColor(113.0, 113.0, 113.0)];
    
    UILabel *currentLabel = [[(UILabel*)[[scrollview subviews] objectAtIndex:0] subviews] objectAtIndex:pageNumber+2];
    [currentLabel setFont:[UIFont systemFontOfSize:16]];
    [currentLabel setTextColor:[UIColor redColor]];
    currentLabel.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
    currentLabel.layer.borderWidth = 1.0f;
    //时 分
    UILabel *whenLabel = [[UILabel alloc]initWithFrame:CGRectMake(currentLabel.frame.origin.x+currentLabel.frame.size.width-10, twoLabel.frame.origin.y+2, 10, 10)];
    [whenLabel setText:@"时"];
    [whenLabel setTextColor:[UIColor redColor]];
    [whenLabel setFont:[UIFont systemFontOfSize:8]];
    [hourScrollView addSubview:whenLabel];
    [hourScrollViewTwo addSubview:whenLabel];
    UILabel *pointsLabel = [[UILabel alloc]initWithFrame:CGRectMake(currentLabel.frame.origin.x+currentLabel.frame.size.width-10, twoLabel.frame.origin.y+2, 10, 10)];
    [pointsLabel setText:@"分"];
    [pointsLabel setTextColor:[UIColor redColor]];
    [pointsLabel setFont:[UIFont systemFontOfSize:8]];
    [minuteScrollView addSubview:pointsLabel];
    [minuteScrollViewTwo addSubview:pointsLabel];
    
    
    UILabel *threeLabel = [[(UILabel*)[[scrollview subviews] objectAtIndex:0] subviews] objectAtIndex:pageNumber+3];
    [threeLabel setFont:[UIFont systemFontOfSize:14]];
    [threeLabel setTextColor:kGetColor(113.0, 113.0, 113.0)];
    UILabel *fourLabel = [[(UILabel*)[[scrollview subviews] objectAtIndex:0] subviews] objectAtIndex:pageNumber+4];
    [fourLabel setFont:[UIFont systemFontOfSize:12]];
    [fourLabel setTextColor:kGetColor(186.0, 186.0, 186.0)];
}
#pragma mark mxccyclescrollview delegate
#pragma mark mxccyclescrollview databasesource
- (NSInteger)numberOfPages:(MXSCycleScrollView*)scrollView
{
    if (scrollView == hourScrollView||scrollView == hourScrollViewTwo)
    {
        return 24;
    }
    else if (scrollView == minuteScrollView||scrollView == minuteScrollViewTwo)
    {
        return 60;
    }
    return 60;
}

- (UIView *)pageAtIndex:(NSInteger)index andScrollView:(MXSCycleScrollView *)scrollView
{
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, scrollView.bounds.size.width, scrollView.bounds.size.height/5)];
    l.tag = index+1;
     if (scrollView == hourScrollView||scrollView == hourScrollViewTwo)
    {
        if (index < 10) {
            l.text = [NSString stringWithFormat:@"0%d",index];
        }
        else
            l.text = [NSString stringWithFormat:@"%d",index];
    }
    else if (scrollView == minuteScrollView||scrollView == minuteScrollViewTwo)
    {
        if (index < 10) {
            l.text = [NSString stringWithFormat:@"0%d",index];
        }
        else
            l.text = [NSString stringWithFormat:@"%d",index];
    }
    else
        if (index < 10) {
            l.text = [NSString stringWithFormat:@"0%d",index];
        }
        else
            l.text = [NSString stringWithFormat:@"%d",index];
    
    l.font = [UIFont systemFontOfSize:12];
    l.textAlignment = NSTextAlignmentCenter;
    l.backgroundColor = [UIColor clearColor];
    return l;
}
//设置现在时间
- (NSInteger)setNowTimeShow:(NSInteger)timeType nowTimeStr:(NSString *)timeStr
{
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:timeStr];
    NSString *dateString = [dateFormatter stringFromDate:now];
    switch (timeType) {
      
        case 0:
        {
            NSRange range = NSMakeRange(8, 2);
            NSString *yearString = [dateString substringWithRange:range];
            return yearString.integerValue;
        }
            break;
        case 1:
        {
            NSRange range = NSMakeRange(10, 2);
            NSString *yearString = [dateString substringWithRange:range];
            return yearString.integerValue;
        }
            break;
        
        default:
            break;
    }
    return 0;
}
//选择设置的播报时间
- (void)selectSetBroadcastTime
{
   
    UILabel *hourLabel = [[(UILabel*)[[hourScrollView subviews] objectAtIndex:0] subviews] objectAtIndex:3];
    UILabel *minuteLabel = [[(UILabel*)[[minuteScrollView subviews] objectAtIndex:0] subviews] objectAtIndex:3];
   
    
   
    NSInteger hourInt = hourLabel.tag - 1;
    NSInteger minuteInt = minuteLabel.tag - 1;
  
    NSString *taskDateString = [NSString stringWithFormat:@"%02d%02d",hourInt,minuteInt];
    NSLog(@"Now----%@",taskDateString);
}
//滚动时上下标签显示
- (void)scrollviewDidChangeNumber
{
   
   
    NSString *starStr;
    NSString *endStr;
    if (hourScrollView.tag==100||minuteScrollView.tag == 100)
    {
        UILabel *hourLabel = [[(UILabel*)[[hourScrollView subviews] objectAtIndex:0] subviews] objectAtIndex:3];
        UILabel *minuteLabel = [[(UILabel*)[[minuteScrollView subviews] objectAtIndex:0] subviews] objectAtIndex:3];
        NSInteger hourInt = hourLabel.tag - 1;
        NSInteger minuteInt = minuteLabel.tag - 1;
        starStr = [NSString stringWithFormat:@"%02d:%02d",hourInt,minuteInt];
    }
    
    if (hourScrollViewTwo.tag==101||minuteScrollViewTwo.tag == 101)
    {
        UILabel *hourLabel = [[(UILabel*)[[hourScrollViewTwo subviews] objectAtIndex:0] subviews] objectAtIndex:3];
        UILabel *minuteLabel = [[(UILabel*)[[minuteScrollViewTwo subviews] objectAtIndex:0] subviews] objectAtIndex:3];
        NSInteger hourInt = hourLabel.tag - 1;
        NSInteger minuteInt = minuteLabel.tag - 1;
        endStr = [NSString stringWithFormat:@"%02d:%02d",hourInt,minuteInt];
        
    }
    
   result = [NSString stringWithFormat:@"%@-%@",starStr,endStr];
    NSLog(@"result%@",result);
   
}

@end
