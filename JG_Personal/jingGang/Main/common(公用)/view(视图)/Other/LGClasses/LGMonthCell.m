//
//  LGMonthCell.m
//  TestArrayCalendar
//
//  Created by AQ on 15-1-18.
//  Copyright (c) 2015年 AQ. All rights reserved.
//

#import "LGMonthCell.h"
#import "LGMonthModel.h"
#import "LGDayModel.h"
#import "LGDayButton.h"
#import "LGCalendarTableView.h"
#import "LGCancelDateButton.h"
#define MONTH_MARGIN 25

@interface LGMonthCell()
{
    LGMonthModel *monthModel;
}
@end

@implementation LGMonthCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self createViews];
        self.contentView.backgroundColor = [UIColor colorWithRed:222.0/255.0 green:222.0/255.0 blue:222.0/255.0 alpha:1.0];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.firstSelectedDate = nil;
        self.contentView.opaque = NO;
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+ (instancetype)monthCellWithTableView:(UITableView *)tableView
{
    LGMonthCell *cell = (LGMonthCell *)[tableView dequeueReusableCellWithIdentifier:@"monthCell"];
    if (cell == nil) {
        cell = [[LGMonthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"monthCell"];
    }
    return cell;
}

- (void)layoutSubviews
{
    [self adjustFrame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)createViews
{

    btnsCount = 0;
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, 0, self.contentView.frame.size.width, MONTH_MARGIN);
    [self addViewOnCell:label];
    self.labelTitle = label;
    
    CGFloat subWidth = (self.contentView.frame.size.width-20)/7;
    
    
    NSArray *arrayWeek = [NSArray arrayWithObjects:@"日", @"一",@"二",@"三",@"四",@"五",@"六",nil];
    NSMutableArray *arrayTemp = [[NSMutableArray alloc] init];
    for(int i = 0;i<7;i++)
    {
        label = [[UILabel alloc] init];
        label.text = [arrayWeek objectAtIndex:i];
        label.textAlignment = NSTextAlignmentCenter;
        label.frame = CGRectMake(10+subWidth*i, MONTH_MARGIN, subWidth, subWidth/2);
        [self addViewOnCell:label];
        if(i == 0 || i == 6)
        {
            label.textColor = [UIColor colorWithRed:233.0/255.0 green:89.0/255.0 blue:17.0/255.0 alpha:1.0];
        }
        label.backgroundColor = [UIColor colorWithRed:206.0/255.0 green:206.0/255.0 blue:206.0/255.0 alpha:1.0];
        [arrayTemp addObject:label];
    }
    self.arrayWeekLabels = arrayTemp;
    
    arrayTemp = [[NSMutableArray alloc] init];
    for (int i = 0; i<6;i++) {
        for (int j = 0; j<7; j++) {
            LGDayButton *btn = [LGDayButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(10+subWidth*j, MONTH_MARGIN+subWidth/2+(subWidth*2/3)*i, subWidth, subWidth*2/3);
            btn.backgroundColor = [UIColor lightGrayColor];
            btn.layer.borderWidth = 0.5;
            btn.layer.borderColor = [UIColor colorWithRed:233.0/255.0 green:233.0/255.0 blue:233.0/255.0 alpha:1.0].CGColor;
            [self addViewOnCell:btn];
            [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
            //[btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor whiteColor];
            btn.enabled = NO;
            
            [arrayTemp addObject:btn];
            
        }
    }
    LGCancelDateButton *btnTemp = [LGCancelDateButton buttonWithType:UIButtonTypeCustom];
    [btnTemp addTarget:self action:@selector(cancelDateChoice:) forControlEvents:UIControlEventTouchUpInside];
    [btnTemp setBackgroundImage:[UIImage imageNamed:@"delete_ico.png"] forState:UIControlStateNormal];
    btnTemp.hidden = YES;
    [self addViewOnCell:btnTemp];
    self.cancelBtn = btnTemp;
    self.arrayDayBtns = arrayTemp;
}

- (void)addViewOnCell:(UIView *)view
{
    CGFloat systemVersion = [[UIDevice currentDevice].systemVersion floatValue];
    if(systemVersion>=7.0&&systemVersion<8.0)
    {
        [self addSubview:view];
    }
    else
    {
        [self.contentView addSubview:view];
    }
}

- (NSMutableAttributedString *)getAttributeStringFromYear:(NSInteger )year andMonth:(NSInteger)month
{
    //假设str = @"Using NSAttributed String";
    NSString *str1 = [NSString stringWithFormat:@"%ld",(long)year];
    NSString *str2 = [NSString stringWithFormat:@"%ld",(long)month];
    NSString *strLong = [NSString stringWithFormat:@"%@年%@月",str1,str2];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:strLong];
    
    NSRange range1 = [strLong rangeOfString:str1];
    NSRange range2 = [strLong rangeOfString:str2];
    NSRange range3 = [strLong rangeOfString:@"年"];
    NSRange range4 = [strLong rangeOfString:@"月"];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range1];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range3];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range4];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:18.0] range:range1];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:18.0] range:range2];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial" size:13.0] range:range3];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial" size:13.0] range:range4];
    
    return str;
}

- (void)adjustFrame
{
    btnsCount = 0;
    LGMonthModel *monthTemp = monthModel;
    LGDayModel *dayTemp = [monthTemp.daysArray objectAtIndex:0];
    
    NSInteger totalTemp = dayTemp.weekDay-1+monthTemp.daysArray.count;

    self.labelTitle.frame = CGRectMake(10, 0, self.contentView.frame.size.width, MONTH_MARGIN);
    
    CGFloat subWidth = (self.contentView.frame.size.width-20)/7;
    
    
    
    for(int i = 0;i<self.arrayWeekLabels.count;i++)
    {
        UILabel  *label = [self.arrayWeekLabels objectAtIndex:i];
        label.frame = CGRectMake(10+subWidth*i, MONTH_MARGIN, subWidth, subWidth/2);
       
    }
    
    

    for (int i = 0; i<6;i++) {
        for (int j = 0; j<7; j++) {
            LGDayButton *btn = [self.arrayDayBtns objectAtIndex:btnsCount];
            btnsCount++;
            if(totalTemp<=28)
            {
                if(i<=3)
                {
                    btn.frame = CGRectMake(10+subWidth*j, MONTH_MARGIN+subWidth/2+(subWidth*2/3)*i, subWidth, subWidth*2/3);
                }
                else
                {
                    btn.frame = CGRectMake(0, 0, 0, 0);
                }
                
            }
            else if(totalTemp>28 && totalTemp<=35)
            {
                if(i<=4)
                {
                    btn.frame = CGRectMake(10+subWidth*j, MONTH_MARGIN+subWidth/2+(subWidth*2/3)*i, subWidth, subWidth*2/3);
                }
                else
                {
                    btn.frame = CGRectMake(0, 0, 0, 0);
                }
            }
            else
            {
                btn.frame = CGRectMake(10+subWidth*j, MONTH_MARGIN+subWidth/2+(subWidth*2/3)*i, subWidth, subWidth*2/3);
            }
           
            
            NSInteger interval = [btn.date timeIntervalSinceDate:self.cancelBtn.date];
            if(interval<60*60&&interval>=0 && btn.date!=nil)
            {
                self.cancelBtn.frame = CGRectMake(0, 0, btn.frame.size.width/3,btn.frame.size.width/3);
                self.cancelBtn.center = CGPointMake(CGRectGetMaxX(btn.frame), CGRectGetMinY(btn.frame));
            }
        }
    }
    
    

}

- (NSInteger)showDataWith:(LGMonthModel *)model
{
    monthModel = model;
    self.cancelBtn.hidden = YES;
    isCanBeCancel = NO;

    for(int i = 0;i<self.arrayDayBtns.count;i++)
    {
        LGDayButton *btnTemp = [self.arrayDayBtns objectAtIndex:i];
        btnTemp.worldDayLabel.hidden = YES;
        btnTemp.chiDayLabel.hidden = YES;
        btnTemp.worldDayLabel.textColor = [UIColor blackColor];
        btnTemp.chiDayLabel.textColor = [UIColor blackColor];
        btnTemp.enabled = NO;
        btnTemp.date = nil;
        btnTemp.tag = i;
        [btnTemp setBackgroundColor:[UIColor whiteColor]];
        [btnTemp setTitle:@"" forState:UIControlStateNormal];
    }

    self.labelTitle.attributedText = [self getAttributeStringFromYear:model.worldYear andMonth:model.worldMoth];
    LGDayModel *day = [model.daysArray objectAtIndex:0];
   
    NSInteger first = day.weekDay-1;
    for(int i = 0;i<model.daysArray.count;i++)
    {
        
       LGDayModel *day = [model.daysArray objectAtIndex:i];
        LGDayButton *btn = [self.arrayDayBtns objectAtIndex:first+i];
        btn.date = day.dayDate;
       
        btn.worldDayLabel.hidden = NO;
        btn.chiDayLabel.hidden = NO;
        if([btn.date timeIntervalSinceDate:self.currentDate]==0)
        {
            btn.worldDayLabel.textColor = [UIColor colorWithRed:233.0/255.0 green:89.0/255.0 blue:17.0/255.0 alpha:1.0];
            btn.chiDayLabel.textColor = [UIColor colorWithRed:233.0/255.0 green:89.0/255.0 blue:17.0/255.0 alpha:1.0];
        }
        
        if(day.weekDay == 1 || day.weekDay == 7)
        {
            btn.worldDayLabel.textColor = [UIColor colorWithRed:43.0/255.0 green:143.0/255.0 blue:10.0/255.0 alpha:1.0];
            btn.chiDayLabel.textColor = [UIColor colorWithRed:43.0/255.0 green:143.0/255.0 blue:10.0/255.0 alpha:1.0];
        }
        
        if([btn.date timeIntervalSinceDate:self.currentDate]<0)
        {
            btn.worldDayLabel.textColor = [UIColor grayColor];
            btn.chiDayLabel.textColor = [UIColor grayColor];
        }
//        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
//        [dateFormat setDateFormat:@"yyyyMMdd"];//设定时间格式,这里可以设置成自己需要的格式
//        for(int i = 0;i<self.arrayHouseStatus.count;i++)
//        {
//            HouseStatusInfo *houseStatusInfo = [self.arrayHouseStatus objectAtIndex:i];
//            NSString *stringStarDate = [NSString stringWithFormat:@"%ld",(long)[houseStatusInfo.startTime integerValue]];
//            NSString *stringEndDate = [NSString stringWithFormat:@"%ld",(long)[houseStatusInfo.startTime integerValue]];
//            if([btn.date timeIntervalSinceDate:[dateFormat dateFromString:stringStarDate]]>=0&&[btn.date timeIntervalSinceDate:[dateFormat dateFromString:stringEndDate]]<=0)
//            {
//                btn.houseStatusInfo = houseStatusInfo;
//            }
//            else
//            {
//                btn.houseStatusInfo = nil;
//            }
//        }
        
        btn.enabled = YES;
        btn.worldDayLabel.text = [NSString stringWithFormat:@"%ld",(long)day.worldDay];
        btn.chiDayLabel.text = day.chiDayStr;
        if(self.tableView.dateCheckIn!=nil&&self.tableView.dateCheckOut!=nil)
        {
            if([self isAvailable:btn.date])
            {
                [btn setBackgroundColor:[UIColor colorWithRed:43.0/255.0 green:167.0/255.0 blue:221.0/255.0 alpha:1.0]];
            }
        }
        NSInteger interval = [btn.date timeIntervalSinceDate:self.cancelBtn.date];
        if(interval<60*60 && interval>=0)
        {
            self.cancelBtn.hidden = NO;
            isCanBeCancel = YES;
            self.cancelBtn.frame = CGRectMake(0, 0, btn.frame.size.width/3,btn.frame.size.width/3);
            self.cancelBtn.center = CGPointMake(CGRectGetMaxX(btn.frame), CGRectGetMinY(btn.frame));
        }
        
        NSLog(@"%@ %d",btn.date,self.cancelBtn.hidden);
        
    }
    
    return first+model.daysArray.count-1;
}



- (BOOL)isAvailable:(NSDate *)date
{
    if([date timeIntervalSinceDate:self.tableView.dateCheckIn]>=0 &&[self.tableView.dateCheckOut timeIntervalSinceDate:date]>=0)
        return YES;
    else
        return NO;
    
}


- (void)cancelDateChoice:(LGDayButton *)btn
{
    btn.hidden = YES;
    btn.date = nil;
    self.firstSelectBtn.selected = NO;
    self.tableView.btnPressCount = 0;

    [self.firstSelectBtn setBackgroundColor:[UIColor whiteColor]];
    [self.delegate clearDates];
    [self.delegate changeTitle];
    
}

- (void)pressBtn:(LGDayButton *)btn
{
    
    [self.delegate chooseDate:btn andCell:self];
}

@end
