//
//  XKJHStatisticsHeader.m
//  Merchants_JingGang
//
//  Created by 鹏 朱 on 15/9/7.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHStatisticsHeader.h"
#import "UIImage+SizeAndTintColor.h"

@interface XKJHStatisticsHeader()
{
    NSString *yearStr;
    NSString *monthStr;
    NSString *dayStr;
}
@property (nonatomic,strong)CalenderView *birthCalenderView;

@end
@implementation XKJHStatisticsHeader


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = background_Color;
        UIView *timeBgview = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, 43)];
        timeBgview.backgroundColor = [UIColor whiteColor];
        [self addSubview:timeBgview];
        
        UIImageView *timeImg = [UIImageView new];
        timeImg.image = IMAGE(@"period");
        [timeBgview addSubview:timeImg];
        [timeImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(timeBgview.mas_top).with.offset(15);
            make.left.equalTo(timeBgview.mas_left).with.offset(KLeftMargin);
            make.width.equalTo(@13);
            make.height.equalTo(@13);
        }];

        UILabel *timeText = [UILabel new];
        timeText.font = kFontSizeBold16;
        timeText.text = @"时间段统计";
        timeText.textColor = KColorText666666;
        [timeBgview addSubview:timeText];
        [timeText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(timeBgview.mas_top).with.offset(13.5);
            make.left.equalTo(timeBgview.mas_left).with.offset(28);
            make.width.equalTo(@100);
        }];

        UIView *incomeBgview = [[UIView alloc] initWithFrame:CGRectMake(0, 54, kScreenWidth, 40)];
        incomeBgview.backgroundColor = [UIColor whiteColor];
        [self addSubview:incomeBgview];
        
        UILabel *incomeText = [UILabel new];
        incomeText.font = kFontSize12;
        incomeText.text = @"时间段";
        incomeText.textColor = KColorText999999;
        [incomeBgview addSubview:incomeText];
        [incomeText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(incomeBgview.mas_top).with.offset(13);
            make.left.equalTo(incomeBgview.mas_left).with.offset(KLeftMargin);
            make.width.equalTo(@42);
        }];
        
        UIButton *startTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [startTimeBtn setTitleColor:KColorText999999 forState:UIControlStateNormal];
        startTimeBtn.backgroundColor = background_Color;
        startTimeBtn.titleLabel.font = [UIFont systemFontOfSize:13.5];
        [startTimeBtn setTitle:@"1999-08-12" forState:UIControlStateNormal];
        startTimeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        startTimeBtn.titleEdgeInsets = UIEdgeInsetsMake(0,5,0,10);
        [startTimeBtn addTarget:self action:@selector(popTimeBox:) forControlEvents:UIControlEventTouchUpInside];
        [incomeBgview addSubview:startTimeBtn];
        [startTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(incomeBgview.mas_top).with.offset(6);
            make.left.equalTo(incomeBgview.mas_left).with.offset(57);
            make.width.equalTo(@100);
            make.height.equalTo(@28);
        }];
        self.startTimeBtn = startTimeBtn;
        
        UIImageView *startImg = [UIImageView new];
        startImg.image = [IMAGE(@"life_arr_down_icon")imageWithTintColor:[UIColor lightGrayColor]];
        [startTimeBtn addSubview:startImg];
        [startImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(startTimeBtn.mas_centerY);
            make.right.equalTo(startTimeBtn.mas_right).with.offset(-5);
            make.width.equalTo(@10);
            make.height.equalTo(@8);
        }];

        UIButton *endTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [endTimeBtn setTitleColor:KColorText999999 forState:UIControlStateNormal];
        endTimeBtn.backgroundColor = background_Color;
        endTimeBtn.titleLabel.font = [UIFont systemFontOfSize:13.5];
        [endTimeBtn setTitle:@"1999-08-12" forState:UIControlStateNormal];
        endTimeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        endTimeBtn.titleEdgeInsets = UIEdgeInsetsMake(0,5,0,10);
        [endTimeBtn addTarget:self action:@selector(popTimeBox:) forControlEvents:UIControlEventTouchUpInside];
        [incomeBgview addSubview:endTimeBtn];
        [endTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(incomeBgview.mas_top).with.offset(6);
            make.left.equalTo(incomeBgview.mas_left).with.offset(170);
            make.width.equalTo(@100);
            make.height.equalTo(@28);
        }];
        self.endTimeBtn = endTimeBtn;
        
        UIImageView *endImg = [UIImageView new];
        endImg.image = [IMAGE(@"life_arr_down_icon")imageWithTintColor:[UIColor lightGrayColor]];
        [endTimeBtn addSubview:endImg];
        [endImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(endTimeBtn.mas_centerY);
            make.right.equalTo(endTimeBtn.mas_right).with.offset(-5);
            make.width.equalTo(@10);
            make.height.equalTo(@8);
        }];

        UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        confirmBtn.backgroundColor = kGetColor(89, 196, 240);
        confirmBtn.titleLabel.font = kFontSize15;
        confirmBtn.layer.cornerRadius = kRadius;
        confirmBtn.layer.masksToBounds = YES;
        [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        [confirmBtn addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
        [incomeBgview addSubview:confirmBtn];
        [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(incomeBgview.mas_top).with.offset(6);
            make.right.equalTo(incomeBgview.mas_right).with.offset(-10);
            make.width.equalTo(@35);
            make.height.equalTo(@28);
        }];

        UIView *moneyBgview = [[UIView alloc] initWithFrame:CGRectMake(0, 104, kScreenWidth, 44)];
        moneyBgview.backgroundColor = [UIColor whiteColor];
        [self addSubview:moneyBgview];
        
        UIImageView *moneyImg = [UIImageView new];
        moneyImg.image = IMAGE(@"Income");
        [moneyBgview addSubview:moneyImg];
        [moneyImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(moneyBgview.mas_top).with.offset(15.5);
            make.left.equalTo(moneyBgview.mas_left).with.offset(KLeftMargin);
            make.width.equalTo(@13);
            make.height.equalTo(@13);
        }];
        
        UILabel *moneyText = [UILabel new];
        moneyText.font = kFontSizeBold16;
        moneyText.text = @"收入总值";
        moneyText.textColor = KColorText666666;
        [moneyBgview addSubview:moneyText];
        [moneyText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(moneyBgview.mas_top).with.offset(14);
            make.left.equalTo(moneyBgview.mas_left).with.offset(28);
            make.width.equalTo(@100);
        }];
        
        UIView *totalBillBgview = [[UIView alloc] initWithFrame:CGRectMake(0, 149, kScreenWidth, 76)];
        totalBillBgview.backgroundColor = [UIColor whiteColor];
        [self addSubview:totalBillBgview];
        
        UILabel *totalBillText = [UILabel new];
        totalBillText.font = [UIFont boldSystemFontOfSize:20];
//        totalBillText.text = @"41'283'777'777";
        totalBillText.textColor = KColorText666666;
        totalBillText.textAlignment = NSTextAlignmentCenter;
        [totalBillBgview addSubview:totalBillText];
        [totalBillText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(totalBillBgview.mas_top).with.offset(28);
            make.left.equalTo(totalBillBgview.mas_left).with.offset(KLeftMargin);
            make.width.equalTo(@(kScreenWidth - KLeftMargin*2));
        }];
        self.totalBillText = totalBillText;
        
        UIView *yearStatisticsBgview = [[UIView alloc] initWithFrame:CGRectMake(0, 235, kScreenWidth, 44)];
        yearStatisticsBgview.backgroundColor = [UIColor whiteColor];
        [self addSubview:yearStatisticsBgview];

        UIImageView *yearStatisticsImg = [UIImageView new];
        yearStatisticsImg.image = IMAGE(@"Statistics");
        [yearStatisticsBgview addSubview:yearStatisticsImg];
        [yearStatisticsImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(yearStatisticsBgview.mas_top).with.offset(15.5);
            make.left.equalTo(yearStatisticsBgview.mas_left).with.offset(KLeftMargin);
            make.width.equalTo(@13);
            make.height.equalTo(@13);
        }];
        
        UILabel *yearStatisticsText = [UILabel new];
        yearStatisticsText.font = kFontSizeBold16;
        yearStatisticsText.text = @"当前年的月统计";
        yearStatisticsText.textColor = KColorText666666;
        [yearStatisticsBgview addSubview:yearStatisticsText];
        [yearStatisticsText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(yearStatisticsBgview.mas_top).with.offset(14);
            make.left.equalTo(yearStatisticsBgview.mas_left).with.offset(28);
            make.width.equalTo(@150);
        }];

        UIView *monthStatisticsBgview = [[UIView alloc] initWithFrame:CGRectMake(0, 279, kScreenWidth, 29)];
        monthStatisticsBgview.backgroundColor = KColorText0b5f9b;
        [self addSubview:monthStatisticsBgview];

        UILabel *time = [UILabel new];
        time.font = kFontSize14;
        time.text = @"时间";
        time.textColor = [UIColor whiteColor];
        time.textAlignment = NSTextAlignmentCenter;
        [monthStatisticsBgview addSubview:time];
        [time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(monthStatisticsBgview.mas_top).with.offset(7.5);
            make.left.equalTo(monthStatisticsBgview.mas_left).with.offset(KLeftMargin);
            make.width.equalTo(@(kScreenWidth/2 - 2*KLeftMargin));
        }];
        
        UILabel *income = [UILabel new];
        income.font = kFontSize14;
        income.text = @"收入";
        income.textColor = [UIColor whiteColor];
        income.textAlignment = NSTextAlignmentCenter;
        [monthStatisticsBgview addSubview:income];
        [income mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(monthStatisticsBgview.mas_top).with.offset(7.5);
            make.right.equalTo(monthStatisticsBgview.mas_right).with.offset(-KLeftMargin);
            make.width.equalTo(@(kScreenWidth/2 - 2*KLeftMargin));
        }];
        
        UIView *middleLine = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 0.5, 0, 1, 29)];
        middleLine.backgroundColor = [UIColor whiteColor];
        [monthStatisticsBgview addSubview:middleLine];
    }
    return self;
}

#pragma mark - private methord

- (void)popTimeBox:(UIButton *)button {
    
    if (!_birthCalenderView) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"CalenderView" owner:nil options:nil];
        _birthCalenderView = (CalenderView *)[nibs lastObject];
    }
    
    self.birthCalenderView.selectBirthBlock = ^(NSString *year,NSString *month,NSString *day){
        
        [button setTitle:[NSString stringWithFormat:@"%@-%@-%@",year,month,day] forState:UIControlStateNormal];
    };

    NSArray *birthArr = [[button titleForState:UIControlStateNormal] componentsSeparatedByString:@"-"];
    if (birthArr && birthArr.count >= 3) {
        NSInteger yearNum = [birthArr[0] integerValue];
        NSInteger monthNum = [birthArr[1] integerValue];
        NSInteger dayNum = [birthArr[2] integerValue];
        
        [_birthCalenderView setSelectedRowWithYearNum:yearNum monthNum:monthNum dayNum:dayNum];
    }

    [_birthCalenderView show];
}

-(void)varityTest{
    
//    [self.birthBtn setTitle:[NSString stringWithFormat:@"%@-%@-%@",yearStr,monthStr,dayStr] forState:UIControlStateNormal];
}

- (void)confirm:(UIButton *)button {
    
    if (_btnPressBlock) {
        _btnPressBlock([_startTimeBtn titleForState:UIControlStateNormal],[_endTimeBtn titleForState:UIControlStateNormal]);
    }
}

@end
