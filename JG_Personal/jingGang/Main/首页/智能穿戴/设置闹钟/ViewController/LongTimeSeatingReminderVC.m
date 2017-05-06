//
//  LongTimeSeatingReminderVC.m
//  jingGang
//
//  Created by 张康健 on 15/6/11.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "LongTimeSeatingReminderVC.h"
#import "GlobeObject.h"
#import "ClockPikcerView.h"
#import "UIView+BlockGesture.h"
#import "UIButton+Block.h"
#import "Util.h"
#import "JGBlueToothManager.h"

#define kBeginTimeKey @"kBeginTimeKey"
#define kEndTimeKey @"kEndTimeKey"
#define kDetaTimeKey @"kDetaTimeKey"

typedef enum : NSUInteger {
    SelectBegin,
    SelectEnd,
    SelectDeta,
} SlectType;

@interface LongTimeSeatingReminderVC (){
    
    UIView *_maskView;
    NSMutableArray *_beginTimeHourArr;
    NSMutableArray *endTimeMinuteArr;
    NSMutableArray *detaTimeArr;
    
    JGBlueToothManager *_jgBlueToothManager;
}

#pragma mark- attribute - 上面部分
@property (retain, nonatomic) IBOutlet UIView *beGingBaseView;
@property (retain, nonatomic) IBOutlet UILabel *beginTimeLabel;
@property (retain, nonatomic) IBOutlet UIView *endBaseView;
@property (retain, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (retain, nonatomic) IBOutlet UIView *detaBaseView;
@property (retain, nonatomic) IBOutlet UILabel *detaTimeLabel;
#pragma mark - attribute - 下面选择日期
@property (retain, nonatomic) IBOutlet UIView *beginAndEndSelectTimeView;
@property (retain, nonatomic) IBOutlet UIView *timeView;

@property (retain, nonatomic) IBOutlet UIView *dataSelcteTimeView;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *selectTimeViewbottonConstraint;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *selectTimeViewHeightConstraint;
@property (retain, nonatomic) IBOutlet ClockPikcerView *pikerBegin;
@property (retain, nonatomic) IBOutlet ClockPikcerView *pikerEnd;
@property (retain, nonatomic) IBOutlet ClockPikcerView *detaPicker;


@property (nonatomic,strong)NSMutableArray *beginTimeHourArr;
@property (nonatomic,strong)NSMutableArray *endTimeMinuteArr;
@property (nonatomic,strong)NSMutableArray *detaTimeArr;


@property (nonatomic,assign)BOOL isSelectTime;

@property (nonatomic,assign)BOOL isSelectBeginToEnd;

@property (nonatomic,assign)BOOL isClockOpen;

@property (nonatomic,assign)SlectType slectType;

@property (nonatomic,strong)UIView *maskView;



@end

@implementation LongTimeSeatingReminderVC


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self _init];
    
    [self _loadNavLeft];
    
    [self _loadNavRight];
    
    
    [self _loadTitleView];

}

#pragma mark - load navItem
-(void)_loadNavLeft{
    
    UIButton *navLeftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 25)];
    [navLeftButton setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    WEAK_SELF;
    [navLeftButton addActionHandler:^(NSInteger tag) {
        [weak_self.navigationController popViewControllerAnimated:YES];
    }];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:navLeftButton];
    self.navigationItem.leftBarButtonItem = item;
    
    RELEASE(navLeftButton);
    RELEASE(item);
}


-(void)_loadTitleView{
    
    self.title = @"久坐提醒";
        
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                          NSFontAttributeName:[UIFont systemFontOfSize:18.0]}];
}

-(void)_loadNavRight{
    
    UIButton *navLeftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 45)];
//    [navLeftButton setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    [navLeftButton setTitle:@"保存" forState:UIControlStateNormal];
    
    WEAK_SELF;
    [navLeftButton addActionHandler:^(NSInteger tag) {
//        [self.navigationController popViewControllerAnimated:YES];

        [weak_self _setLongTimeSeating];
        
        [weak_self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:nil afterDelay:0.3];
        
        
    }];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:navLeftButton];
    self.navigationItem.rightBarButtonItem = item;
    
    RELEASE(navLeftButton);
    RELEASE(item);
}


-(void)_setLongTimeSeating{
    
    _jgBlueToothManager = [JGBlueToothManager shareInstances];
    
    NSString *beginText = self.beginTimeLabel.text;
    NSString *endText = self.endTimeLabel.text;
    NSString *detaText = self.detaTimeLabel.text;
    
    
    int beginHour=0,beginMinutes=0;
    [self setTimeStrWithTimeStr:beginText withHour:&beginHour withMinute:&beginMinutes];
    
    int endHour=0,endMinute=0;
    [self setTimeStrWithTimeStr:endText withHour:&endHour withMinute:&endMinute];
    
    int detaMinute = [detaText intValue];
    if ([[detaText substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"0"]) {
        detaMinute = [[detaText substringWithRange:NSMakeRange(1, 1)] intValue];
    }
    
    WarnEventType warnEventType = WarnEventTypeOpen;
    if (!self.isClockOpen) {//如果关了
        warnEventType = WarnEventTypeClose;
    }
    
    [_jgBlueToothManager setLongSeatingRemindingFromBeginHour:beginHour beginMinute:beginMinutes endHour:endHour endMinute:endMinute duration:detaMinute reminderType:RemindTypeClock withWarnType:warnEventType];
}

-(void)setTimeStrWithTimeStr:(NSString *)timeStr withHour:(int *)p_hour withMinute:(int *)p_minute{
    
    
    NSString *beginhourStr = [timeStr substringWithRange:NSMakeRange(0, 2)];
    NSString *beginminuteStr = [timeStr substringWithRange:NSMakeRange(3, 2)];
    
    
    *p_hour = [beginhourStr intValue];
    //若第一位是0的话，只取第二位
    if ([[beginhourStr substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"0"]) {
        *p_hour = [[beginhourStr substringWithRange:NSMakeRange(1, 1)] intValue];
    }
    
    *p_minute = [beginminuteStr intValue];
    //若第一位是0的话，只取第二位
    if ([[beginminuteStr substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"0"]) {
        *p_minute = [[beginminuteStr substringWithRange:NSMakeRange(1, 1)] intValue];
    }
}


#pragma mark - Action & Event
- (IBAction)detaTimeEditAction:(id)sender {
    
    self.slectType = SelectDeta;
    [self _timeSelctedViewUP:NO];
}


- (IBAction)clockOpenOrCloseAction:(id)sender {

    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;

    self.isClockOpen = !self.isClockOpen;
    
}

- (IBAction)endEditAction:(id)sender {
    self.slectType = SelectEnd;
    [self _timeSelctedViewUP:YES];
}


- (IBAction)beginTimeEditAction:(id)sender {
    self.slectType = SelectBegin;
    [self _timeSelctedViewUP:YES];
}

- (IBAction)timeSureAction:(id)sender {
    
    if (self.slectType == SelectBegin) {
        self.beginTimeLabel.text = [NSString stringWithFormat:@"%@:%@",self.pikerBegin.selectedTimeStr,self.pikerEnd.selectedTimeStr];
        
    }else if (self.slectType == SelectEnd){
        self.endTimeLabel.text = [NSString stringWithFormat:@"%@:%@",self.pikerBegin.selectedTimeStr,self.pikerEnd.selectedTimeStr];
        
    }else{
        self.detaTimeLabel.text = self.detaPicker.selectedTimeStr;
    }
    
    [self _timeSelctedViewDown];
}



#pragma mark - private Method
-(void)_timeSelctedViewUP:(BOOL)isBeginToEnd{
    
    self.isSelectBeginToEnd = isBeginToEnd;

    self.maskView.hidden = NO;
    if (isBeginToEnd) {
        self.beginAndEndSelectTimeView.hidden = NO;
        self.dataSelcteTimeView.hidden = YES;
        self.pikerBegin.data = self.beginTimeHourArr;
        [self.pikerBegin reloadAllComponents];
        self.pikerEnd.data = self.endTimeMinuteArr;
        [self.pikerEnd reloadAllComponents];
    }else{
        self.beginAndEndSelectTimeView.hidden = YES;
        self.dataSelcteTimeView.hidden = NO;
        self.detaPicker.data = self.detaTimeArr;
        [self.detaPicker reloadAllComponents];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.selectTimeViewbottonConstraint.constant = 0;
        [self.view layoutIfNeeded];
        self.isSelectTime = YES;
    }];
}


-(void)_timeSelctedViewDown{

    self.maskView.hidden = YES;

    [UIView animateWithDuration:0.3 animations:^{
        self.selectTimeViewbottonConstraint.constant = -self.selectTimeViewHeightConstraint.constant;
        [self.view layoutIfNeeded];
        self.isSelectTime = NO;
    }];

}



-(void)_init{

    self.navigationController.navigationBar.barTintColor = kGetColor(90, 169, 241);
    
    self.selectTimeViewbottonConstraint.constant = -self.selectTimeViewHeightConstraint.constant;
    
    self.isSelectTime = NO;
    
    UIColor *borderColor = kGetColor(235, 235, 235);
    
//    _jgBlueToothManager = [[JGBlueToothManager shareInstances] retain];
    
    //设置圆角
    [self setViewRadius:0.0 borderWidth:1 borderColor:borderColor ofView:self.beGingBaseView];
    [self setViewRadius:0.0 borderWidth:1 borderColor:borderColor ofView:self.endBaseView];
    [self setViewRadius:0.0 borderWidth:1 borderColor:borderColor ofView:self.detaBaseView];
    
    NSString *beginStr = [kUserDefaults objectForKey:kBeginTimeKey];
    NSString *endStr = [kUserDefaults objectForKey:kEndTimeKey];
    NSString *detaStr = [kUserDefaults objectForKey:kDetaTimeKey];
    
    if (beginStr) {
        self.beginTimeLabel.text = beginStr;
    }
    
    if (endStr) {
        self.endTimeLabel.text = endStr;
    }
    
    if (detaStr) {
        self.detaTimeLabel.text = detaStr;
    }
    
//    self.beginTimeLabel.text = [kUserDefaults objectForKey:kBeginTimeKey];
//    self.endTimeLabel.text = [kUserDefaults objectForKey:kEndTimeKey];
//    self.detaTimeLabel.text = [kUserDefaults objectForKey:kDetaTimeKey];
    
    //默认是打开的
    self.isClockOpen = YES;
    
}

-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    [kUserDefaults setObject:self.beginTimeLabel.text forKey:kBeginTimeKey];
    [kUserDefaults setObject:self.endTimeLabel.text forKey:kEndTimeKey];
    [kUserDefaults setObject:self.detaTimeLabel.text forKey:kDetaTimeKey];
    [kUserDefaults synchronize];

}




-(void)setViewRadius:(CGFloat)radius borderWidth:(CGFloat )borderWith borderColor:(UIColor *)corlor ofView:(UIView *)view {
    
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = radius;
    view.layer.borderWidth = borderWith;
    view.layer.borderColor = corlor.CGColor;
    
}


#pragma mark - getter
-(UIView *)maskView{

    if (_maskView == nil) {
        _maskView = [[UIView alloc] initWithFrame:self.view.bounds];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.3;
//        [self.view addSubview:_maskView];
        [self.view insertSubview:_maskView belowSubview:self.timeView];
        _maskView.hidden = YES;
        [_maskView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            if (self.isSelectTime) {
                [self _timeSelctedViewDown];
            }
        }];
    }

    return _maskView;
}

-(NSMutableArray *)beginTimeHourArr{
    
    if (_beginTimeHourArr == nil) {
        _beginTimeHourArr = [NSMutableArray arrayWithCapacity:0];
        for (int i=0; i<24; i++) {
            NSString *hourStr = [NSString stringWithFormat:@"%02d",i];
            [_beginTimeHourArr addObject:hourStr];
        }
    }
    
    return _beginTimeHourArr;
}

-(NSMutableArray *)endTimeMinuteArr{

    if (_endTimeMinuteArr == nil) {
        _endTimeMinuteArr = [NSMutableArray arrayWithCapacity:0];
        for (int i=0; i<60; i++) {
            NSString *hourStr = [NSString stringWithFormat:@"%02d",i];
            [_endTimeMinuteArr addObject:hourStr];
        }
    }
    
    return _endTimeMinuteArr;
}


-(NSMutableArray *)detaTimeArr{

    if (_detaTimeArr == nil) {
        _detaTimeArr = [NSMutableArray arrayWithCapacity:0];
        for (int i=0; i<=125; i+=2) {
            NSString *hourStr = [NSString stringWithFormat:@"%02d",i];
            [_detaTimeArr addObject:hourStr];
        }
    }
    
    return _detaTimeArr;
}


@end
