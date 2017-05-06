//
//  DLVipNumberVC.m
//  YilidiSeller
//
//  Created by yld on 16/6/1.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLVipNumberVC.h"
#import "MycommonTableView.h"
#import "DLVipNumberCell.h"
#import "DLVipNumberModel.h"
#import "AFNHttpRequestOPManager+DLUnNomalApi.h"
#import "XYPopView.h"
#import "DLCustomCalendar.h"
#import "DLRequestUrl.h"
#import "GlobleConst.h"
#import "DLNoOrderDataView.h"
@interface DLVipNumberVC ()
@property (nonatomic,strong)DLNoOrderDataView *noOrderDataView;
@property (weak, nonatomic) IBOutlet MycommonTableView *vipTableView;
@property (nonatomic,strong)XYPopView *popView;
@property (nonatomic,strong)UIButton *btn;
@property (nonatomic,strong)NSArray *dataArr;
@property (nonatomic,strong)DLCustomCalendar * calendar;
@property (nonatomic,strong)NSString *startTime;
@property (nonatomic,strong)NSString *endTime;

@end

@implementation DLVipNumberVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTitle = @"铂金会员数";

    [self _init];
    [self _initVipTableView];
    [self _initRightItem];
    
    

    
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
    int days;
    if (self.isHomePage) {
        days=0;
    }else{
        days=6;
    }
    //最近七天
    NSTimeInterval time = days * 24 * 60 * 60;
    NSDate * lastYear = [date dateByAddingTimeInterval:-time];
    //转化为字符串
    self.startTime =[NSString stringWithFormat:@"%@ 00:00:01",[dateFormatter stringFromDate:lastYear]];
    self.endTime = [NSString stringWithFormat:@"%@ 23:59:59",[dateFormatter stringFromDate:date]];
    [self _requestData:@{kRequestPageNumKey:@(self.vipTableView.dataLogicModule.requestFromPage),kRequestPageSizeKey:@(12),@"beginTime":self.startTime,@"endTime":self.endTime}];
    
}


- (void)_initRightItem {
    

     _btn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-90, 0, 75, 22)];
    [_btn addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    if (self.isHomePage) {
         [_btn setTitle:@"最近一天" forState:UIControlStateNormal];
    }else{
         [_btn setTitle:@"最近七天" forState:UIControlStateNormal];
    }
    
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
            weak_self.vipTableView.dataLogicModule.requestFromPage  = 1;
            NSArray *array = [timer componentsSeparatedByString:@","];
            weak_self.startTime =[NSString stringWithFormat:@"%@ 00:00:01", array[0]];
            weak_self.endTime = [NSString stringWithFormat:@"%@ 23:59:59",array[1]];;
            [weak_self _requestData:@{kRequestPageNumKey:@(weak_self.vipTableView.dataLogicModule.requestFromPage),kRequestPageSizeKey:@(12),@"beginTime":weak_self.startTime,@"endTime":weak_self.endTime}];
        }
        
    };
    
     self.navigationItem.rightBarButtonItem = rightItem;
    
}


- (void)_initVipTableView {
   

    [self.vipTableView configurecellNibName:@"DLVipNumberCell" configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell) {
        DLVipNumberModel *model = (DLVipNumberModel *)cellModel;
        DLVipNumberCell *vipCell = (DLVipNumberCell *)cell;
        [vipCell.vipCount setTextColor:UIColorFromRGB(0xf66200)];
        [vipCell setVipModel:model];
        
    }];
    
    
    WEAK_SELF
    [self.vipTableView headerRreshRequestBlock:^{
        [weak_self  _requestData:@{kRequestPageNumKey:@(self.vipTableView.dataLogicModule.requestFromPage),kRequestPageSizeKey:@(12),@"beginTime":self.startTime,@"endTime":self.endTime}];
    }];
    
    [self.vipTableView footerRreshRequestBlock:^{
        [weak_self _requestData:@{kRequestPageNumKey:@(self.vipTableView.dataLogicModule.requestFromPage),kRequestPageSizeKey:@(12),@"beginTime":self.startTime,@"endTime":self.endTime}];
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
        weak_self.vipTableView.dataLogicModule.requestFromPage  = 1;
       [weak_self _requestData:@{kRequestPageNumKey:@(weak_self.vipTableView.dataLogicModule.requestFromPage),kRequestPageSizeKey:@(12),@"beginTime":weak_self.startTime,@"endTime":weak_self.endTime}];
    };
    
    
    [UIView animateWithDuration:1 animations:^{
        weak_self.calendar.alpha = 1;
        
    } completion:^(BOOL finished) {
        
    }];
    
    [self.view addSubview:_calendar];
}


#pragma mark ------------------------Api----------------------------------
- (void)_requestData:(NSDictionary *)dic {
    
        [self showLoadingHub];
        self.vipTableView.dataLogicModule.requestPageSize = 12;
        [AFNHttpRequestOPManager getInfoWithSubUrl:kUrl_VipStatistical parameters:dic block:^(id result, NSError *error) {
            [self hideLoadingHub];
            _dataArr = [DLVipNumberModel objectWithVipNumberModelArray:result[@"entity"][@"list"]];
             
            
//            //没有数据
//            if (self.vipTableView.dataLogicModule.currentDataModelArr.count==0) {
//                
//                self.vipTableView.hidden=YES;
//                self.noOrderDataView.hidden=NO;
//                [self.view  addSubview:self.noOrderDataView];
//            }else{
//                self.vipTableView.hidden=NO;
//                self.noOrderDataView.hidden=YES;
//            }
            
            //有上下拉刷新就用这个数据源承载方法
            [self.vipTableView configureTableAfterRequestPagingData:_dataArr];
            [self.vipTableView reloadData];
            NSLog(@"result:%@",result[@"entity"][@"list"]);
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
        _noOrderDataView.contentLabel.text = @"你还没有相关数据";
        _noOrderDataView.backgroundColor = [UIColor whiteColor];
    }
    
    return _noOrderDataView;
}


@end
