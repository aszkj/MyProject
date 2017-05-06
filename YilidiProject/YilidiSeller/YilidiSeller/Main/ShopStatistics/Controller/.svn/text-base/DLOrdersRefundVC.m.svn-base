//
//  DLOrdersRefundVC.m
//  YilidiSeller
//
//  Created by yld on 16/6/1.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLOrdersRefundVC.h"
#import "DLVipNumberCell.h"
#import "MycommonTableView.h"
#import "DLRebatesModel.h"
#import "AFNHttpRequestOPManager+DLUnNomalApi.h"
#import "XYPopView.h"
#import "DLCustomCalendar.h"
#import "DLRequestUrl.h"
#import "GlobleConst.h"
#import "DLNoOrderDataView.h"
@interface DLOrdersRefundVC ()
@property (nonatomic,strong)DLNoOrderDataView *noOrderDataView;
@property (weak, nonatomic) IBOutlet MycommonTableView *refundTableView;
@property (nonatomic,strong)NSArray *dataArr;
@property (nonatomic,strong)DLCustomCalendar * calendar;
@property (nonatomic,strong)NSString *startTime;
@property (nonatomic,strong)NSString *endTime;
@property (nonatomic,strong)UIButton *btn;
@property (nonatomic,strong)XYPopView *popView;

@end

@implementation DLOrdersRefundVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.pageTitle =@"订单返款";
    
    [self _init];
    [self _initRightItem];
    [self _initRefundTableView];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
    [self _requestData:@{kRequestPageNumKey:@(self.refundTableView.dataLogicModule.requestFromPage),kRequestPageSizeKey:@(12),@"beginTime":self.startTime,@"endTime":self.endTime}];
   
    
}



- (void)_initRightItem {
    
    
    _btn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-90, 0, 75, 22)];
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
            weak_self.refundTableView.dataLogicModule.requestFromPage  = 1;
            NSArray *array = [timer componentsSeparatedByString:@","];
            weak_self.startTime =[NSString stringWithFormat:@"%@ 00:00:01", array[0]];
            weak_self.endTime = [NSString stringWithFormat:@"%@ 23:59:59",array[1]];;
            [weak_self _requestData:@{kRequestPageNumKey:@(weak_self.refundTableView.dataLogicModule.requestFromPage),kRequestPageSizeKey:@(12),@"beginTime":weak_self.startTime,@"endTime":weak_self.endTime}];
        }
        
    };
    
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
}


- (void)_initRefundTableView {


    [self.refundTableView configurecellNibName:@"DLVipNumberCell" configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell) {
        DLRebatesModel *model = (DLRebatesModel *)cellModel;
        DLVipNumberCell *vipCell = (DLVipNumberCell *)cell;
        vipCell.date.text = model.statisticDate;
        vipCell.registerCount.text = model.saleOrderNo;
        vipCell.vipCount.text = [NSString stringWithFormat:@"￥%.2f",[model.settleAmount floatValue]/1000];
        
    }];
    
    WEAK_SELF
    [self.refundTableView headerRreshRequestBlock:^{
        [weak_self  _requestData:@{kRequestPageNumKey:@(self.refundTableView.dataLogicModule.requestFromPage),kRequestPageSizeKey:@(12),@"beginTime":self.startTime,@"endTime":self.endTime}];
    }];
    
    [self.refundTableView footerRreshRequestBlock:^{
        [weak_self _requestData:@{kRequestPageNumKey:@(self.refundTableView.dataLogicModule.requestFromPage),kRequestPageSizeKey:@(12),@"beginTime":self.startTime,@"endTime":self.endTime}];
    }];

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
        weak_self.refundTableView.dataLogicModule.requestFromPage  = 1;
        [weak_self _requestData:@{kRequestPageNumKey:@(weak_self.refundTableView.dataLogicModule.requestFromPage),kRequestPageSizeKey:@(12),@"beginTime":weak_self.startTime,@"endTime":weak_self.endTime}];
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
    
        [self showLoadingHub];
        self.refundTableView.dataLogicModule.requestPageSize = 12;
        [AFNHttpRequestOPManager postWithParameters:dic subUrl:kUrl_RebatesStatistical block:^(NSDictionary *resultDic, NSError *error) {
            [self hideLoadingHub];
            NSLog(@"resultDic%@",resultDic);
            _dataArr = [DLRebatesModel objectWithrebatesModelArray:resultDic[@"entity"][@"list"]];
            
//            //没有数据
//            if (self.refundTableView.dataLogicModule.currentDataModelArr.count==0) {
//                
//                self.refundTableView.hidden=YES;
//                self.noOrderDataView.hidden=NO;
//                [self.view  addSubview:self.noOrderDataView];
//            }else{
//                self.refundTableView.hidden=NO;
//                self.noOrderDataView.hidden=YES;
//            }
            
            [self.refundTableView configureTableAfterRequestPagingData:_dataArr];
            [self.refundTableView reloadData];

        }];
    
    
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
- (DLNoOrderDataView *)noOrderDataView {
    
    if (!_noOrderDataView) {
        _noOrderDataView = BoundNibView(@"DLNoOrderDataView", DLNoOrderDataView);
        _noOrderDataView.center=self.view.center;
        _noOrderDataView.backgroundColor = [UIColor whiteColor];
    }
    
    return _noOrderDataView;
}


@end
