//
//  DLDataStatisticsVC.m
//  YilidiSeller
//
//  Created by yld on 16/6/1.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLDataStatisticsVC.h"
#import "DLVipNumberVC.h"
#import "DLOrdersRefundVC.h"
#import "XYPopView.h"
#import "MyCommonCollectionView.h"
#import "DLStatisticsCollectionCell.h"
#import "DLHomeSpecialItemModel.h"
#import "ProjectRelativeMaco.h"
#import "GlobeMaco.h"
#import "DLCustomCalendar.h"
#import "AFNHttpRequestOPManager+DLUnNomalApi.h"
#import "DLLogisticsSubsidiesVC.h"
#import "DLRequestUrl.h"
#import "ProjectStandardUIDefineConst.h"
@interface DLDataStatisticsVC ()
{

    XYPopView *popView;

}
@property (nonatomic,strong)NSArray *array;
@property (weak, nonatomic) IBOutlet MyCommonCollectionView *statisticsView;


@property (strong, nonatomic) IBOutlet UILabel *vipCount;

@property (strong, nonatomic) IBOutlet UILabel *orderSettleAmount;


@property (strong, nonatomic) IBOutlet UILabel *finishOrderCount;

@property (nonatomic,strong)DLCustomCalendar * calendar;
@property (nonatomic,strong)NSString *startTime;
@property (nonatomic,strong)NSString *endTime;
@property (nonatomic,strong)UIButton *btn;
@end

@implementation DLDataStatisticsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _init];
    [self _initRightItem];
//    [self _initStatisticsView];
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [popView showPopView:NO];
    
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
    

    self.pageTitle = @"数据统计";
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
    popView = [[XYPopView alloc] initWithSuperView:_btn items:titles];
    
    
    WEAK_SELF
    popView.popviewBlock = ^(NSInteger index ,NSString *timer){
    
        [weak_self.btn setTitle:titles[index] forState:UIControlStateNormal];
        if (index==3) {
            [weak_self _customCalendar];
        }else{
            
            NSArray *array = [timer componentsSeparatedByString:@","];
            weak_self.startTime =[NSString stringWithFormat:@"%@ 00:00:01", array[0]];
            weak_self.endTime = [NSString stringWithFormat:@"%@ 23:59:59",array[1]];
            [weak_self _requestData:@{@"beginTime":weak_self.startTime,@"endTime":weak_self.endTime}];
        }
        
    };
    
    
    self.navigationItem.rightBarButtonItem = rightItem;
    NSLog(@"frame:%@",NSStringFromCGRect(_btn.frame));
    
    
}

- (void)_initStatisticsView {

   
    
    [self.statisticsView configureCollectionCellNibName:@"DLStatisticsCollectionCell" configureCollectionCellData:^(UICollectionView *collectionView, id collectionModel, UICollectionViewCell *collectionCell,NSIndexPath *indexPath) {
        DLHomeSpecialItemModel *model = (DLHomeSpecialItemModel *)collectionModel;
        DLStatisticsCollectionCell *cell = (DLStatisticsCollectionCell *)collectionCell;
        cell.contentLabel.text = model.content;
        cell.titleLabel.text = model.title;
        
    } clickCell:^(UICollectionView *collectionView, id collectionModel, UICollectionViewCell *collectionCell, NSIndexPath *clickIndexPath) {
        if (clickIndexPath.row==0) {
           
        }else if (clickIndexPath.row==1){

        }else if(clickIndexPath.row==2){
        
            
        }else {
        
         
        }
    }];

    self.statisticsView.dataLogicModule.currentDataModelArr = [self.array mutableCopy];
    
    self.statisticsView.commonFlowLayout.itemSize = CGSizeMake(kScreenWidth / 2.0-20, kScreenHeight/3);
    self.statisticsView.commonFlowLayout.sectionInset = MakeUIEdgeInset(20, 10, 20, 10);
    self.statisticsView.commonFlowLayout.minimumInteritemSpacing = 0;
    self.statisticsView.commonFlowLayout.minimumLineSpacing = 20;
    self.statisticsView.commonFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    [self.statisticsView reloadData];

}
#pragma mark ------------------------Private-------------------------
- (void)_customCalendar {

    self.calendar =[[DLCustomCalendar alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    self.calendar.alpha = 0;
    WEAK_SELF
    self.calendar.selectedDate = ^(NSArray *goDate, NSArray *backDate){
        [UIView animateWithDuration:1 animations:^{
            weak_self.calendar.alpha = 0;
        } completion:^(BOOL finished) {
            
        }];
        
        weak_self.startTime = [NSString stringWithFormat:@"%@ 00:00:01",[goDate componentsJoinedByString:@"-"]];
        weak_self.endTime = [NSString stringWithFormat:@"%@ 23:59:59",[backDate componentsJoinedByString:@"-"]];

        
        [weak_self _requestData:@{@"beginTime":weak_self.startTime,@"endTime":weak_self.endTime}];
    };

    
    [UIView animateWithDuration:1 animations:^{
        weak_self.calendar.alpha = 1;
        
    } completion:^(BOOL finished) {
        
    }];
    
    [self.view addSubview:self.calendar];

}

#pragma mark ------------------------Api----------------------------------
- (void)_requestData:(NSDictionary *)dic {
    
    [self showLoadingHub];
    [AFNHttpRequestOPManager postWithParameters:dic subUrl:kUrl_SummaryStatistical block:^(NSDictionary *resultDic, NSError *error) {
       
        [self hideLoadingHub];
        _vipCount.text  = [NSString stringWithFormat:@"%@",resultDic[@"entity"][@"vipUserCount"]];
        _orderSettleAmount.text = [NSString stringWithFormat:@"%.2f",[resultDic[@"entity"][@"orderSettleAmount"]floatValue]/1000];
        _finishOrderCount.text = [NSString stringWithFormat:@"%@",resultDic[@"entity"][@"finishOrderCount"]];
       
        NSLog(@"dididi%@",resultDic[@"entity"]);
        
    }];
    
    
    
}
#pragma mark ------------------------Page Navigate---------------------------


#pragma mark ------------------------View Event---------------------------

- (IBAction)vipButtonClick:(id)sender {
    DLVipNumberVC *vipVC = [[DLVipNumberVC alloc]init];
    [self navigatePushViewController:vipVC animate:YES];
}

- (IBAction)rebatesButtonClick:(id)sender {
    DLOrdersRefundVC *refundVC = [[DLOrdersRefundVC alloc]init];
    [self navigatePushViewController:refundVC animate:YES];
}


- (IBAction)completeButtonClick:(id)sender {
    
}

- (IBAction)logisticsButtonClick:(id)sender {
    DLLogisticsSubsidiesVC *logisticsVC = [[DLLogisticsSubsidiesVC alloc]init];
    [self navigatePushViewController:logisticsVC animate:YES];
}


#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------



- (void)rightClick:(UIButton *)sender{

    [popView showPopView:YES];
    
    [UIView animateWithDuration:1 animations:^{
        [self.calendar removeFromSuperview];
        
    } completion:^(BOOL finished) {
        
    }];
   


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
