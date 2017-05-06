//
//  DLLogisticsSubsidiesVC.m
//  YilidiSeller
//
//  Created by 曾勇兵 on 16/6/24.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLLogisticsSubsidiesVC.h"
#import "DLVipNumberCell.h"
#import "MycommonTableView.h"
#import "DLLogisticsModel.h"
#import "AFNHttpRequestOPManager+DLUnNomalApi.h"
#import "XYPopView.h"
#import "DLCustomCalendar.h"
#import "GlobleConst.h"
@interface DLLogisticsSubsidiesVC ()
@property (strong, nonatomic) IBOutlet MycommonTableView *logisticsTableView;
@property (nonatomic,strong)NSArray *dataArr;
@property (nonatomic,strong)DLCustomCalendar * calendar;
@property (nonatomic,strong)NSString *startTime;
@property (nonatomic,strong)NSString *endTime;
@property (nonatomic,strong)UIButton *btn;
@property (nonatomic,strong)XYPopView *popView;
@end

@implementation DLLogisticsSubsidiesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTitle = @"物流补贴";
    
    [self _init];
    [self _initRightItem];
    [self _initRefundTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [_popView showPopView:NO];
    
}
#pragma mark ------------------------Init---------------------------------
- (void)_init {
    
    NSDate * date = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //最近七天
    NSTimeInterval time = 6 * 24 * 60 * 60;
    NSDate * lastYear = [date dateByAddingTimeInterval:-time];
    //转化为字符串
    self.startTime =[NSString stringWithFormat:@"%@ 00:00:01",[dateFormatter stringFromDate:lastYear]];
    self.endTime = [NSString stringWithFormat:@"%@ 23:59:59",[dateFormatter stringFromDate:date]];
    [self _requestData:@{@"beginTime":self.startTime,@"endTime":self.endTime}];
    
}

- (void)_initRightItem {
    
    
    _btn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-90, 30, 75, 22)];
    [_btn addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    [_btn setTitle:@"最近七天" forState:UIControlStateNormal];
    [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_btn setBackgroundColor:KSelectedBgColor];
    _btn.layer.cornerRadius=2;
    UIImageView *arrow = [[UIImageView alloc]initWithFrame:CGRectMake(_btn.frame.size.width-18, 8, 12, 7)];
    _btn.contentEdgeInsets = UIEdgeInsetsMake(0,0, 0, 14);
    [arrow setImage:[UIImage imageNamed:@"downArrow"]];
    [_btn addSubview:arrow];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:_btn];
    NSArray *titles = @[@"最近一天", @"最近三天", @"最近七天",@"自定义"];
    _popView = [[XYPopView alloc] initWithSuperView:_btn items:titles];
    WEAK_SELF
    _popView.popviewBlock = ^(NSInteger index ,NSString *timer){
        
        [weak_self.btn setTitle:titles[index] forState:UIControlStateNormal];
        if (index==3) {
            [weak_self _customCalendar];
        }else{
            
            weak_self.logisticsTableView.dataLogicModule.requestFromPage  = 1;
            NSArray *array = [timer componentsSeparatedByString:@","];
            weak_self.startTime =[NSString stringWithFormat:@"%@ 00:00:01", array[0]];
            weak_self.endTime = [NSString stringWithFormat:@"%@ 23:59:59",array[1]];;
            [weak_self _requestData:@{kRequestPageNumKey:@(weak_self.logisticsTableView.dataLogicModule.requestFromPage),kRequestPageSizeKey:@(kRequestDefaultPageSize),@"beginTime":weak_self.startTime,@"endTime":weak_self.endTime}];
        }
        
    };
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
}


- (void)_initRefundTableView {
    
    
    NSArray *array = @[@{@"statisticDate":@"2016-08-08",@"saleOrderNo":@"2012314554",@"settleAmount":@8},@{@"statisticDate":@"2016-08-08",@"saleOrderNo":@"301465456",@"settleAmount":@18},@{@"statisticDate":@"2016-08-08",@"saleOrderNo":@"105456",@"settleAmount":@28}];
    
    
    _dataArr = [DLLogisticsModel objectWithLogisticsModelArray:array];
    
    [self.logisticsTableView configurecellNibName:@"DLVipNumberCell" configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell) {
        DLLogisticsModel *model = (DLLogisticsModel *)cellModel;
        DLVipNumberCell *vipCell = (DLVipNumberCell *)cell;
        vipCell.date.text = model.statisticDate;
        vipCell.registerCount.text = model.saleOrderNo;
        vipCell.vipCount.text = [NSString stringWithFormat:@"￥%@",model.settleAmount];
        
        
        
    }];
    
    self.logisticsTableView.dataLogicModule.currentDataModelArr = [_dataArr mutableCopy];
}
#pragma mark ------------------------Private-------------------------
- (void)_customCalendar {
    
    _calendar =[[DLCustomCalendar alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    _calendar.alpha = 0;
    WEAK_SELF
    _calendar.selectedDate = ^(NSArray *goDate, NSArray *backDate){
        [UIView animateWithDuration:1 animations:^{
            weak_self.calendar.alpha = 0;
        } completion:^(BOOL finished) {
            
        }];
        
        weak_self.startTime = [NSString stringWithFormat:@"%@ 00:00:01",[goDate componentsJoinedByString:@"-"]];
        weak_self.endTime = [NSString stringWithFormat:@"%@ 23:59:59",[backDate componentsJoinedByString:@"-"]];
       
        [weak_self _requestData:@{kRequestPageNumKey:@(weak_self.logisticsTableView.dataLogicModule.requestFromPage),kRequestPageSizeKey:@(kRequestDefaultPageSize),@"beginTime":weak_self.startTime,@"endTime":weak_self.endTime}];
    };
    
    
    [UIView animateWithDuration:1 animations:^{
        weak_self.calendar.alpha = 1;
        
    } completion:^(BOOL finished) {
        
    }];
    
    [self.view addSubview:_calendar];
}


#pragma mark ------------------------Api----------------------------------
- (void)_requestData:(NSDictionary *)dic {
    
    NSLog(@"dic%@",dic);
    //        [AFNHttpRequestOPManager getInfoWithSubUrl:kUrl_RebatesStatistical parameters:dic block:^(id result, NSError *error) {
    //
    //
    //        }];
    
}
#pragma mark ------------------------Page Navigate---------------------------


#pragma mark ------------------------View Event---------------------------
- (void)rightClick:(UIButton *)sender{
    
    [_popView showPopView:YES];
    
    [UIView animateWithDuration:1 animations:^{
        
        [self.calendar removeFromSuperview];
        
    } completion:^(BOOL finished) {
        
    }];
    
}


#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------

@end
