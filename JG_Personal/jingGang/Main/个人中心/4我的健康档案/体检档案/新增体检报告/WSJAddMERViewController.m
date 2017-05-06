//
//  WSJAddMERViewController.m
//  jingGang
//
//  Created by thinker on 15/10/21.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "WSJAddMERViewController.h"
#import "PublicInfo.h"
#import "Util.h"
#import "MJExtension.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "IQKeyboardManager.h"
#import "WMERSearchViewController.h"
#import "MBProgressHUD.h"
#import "MERMenusViewController.h"

@interface WSJAddMERViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSInteger _year;
    NSInteger _month;
    NSInteger _day;
}

//报告名称
@property (weak, nonatomic) IBOutlet UITextField *reportNameTextField;
//体检医院机构
@property (weak, nonatomic) IBOutlet UITextField *hospitalTextField;

@property (weak, nonatomic) IBOutlet UIPickerView *yearView;
@property (weak, nonatomic) IBOutlet UIPickerView *moonView;
@property (weak, nonatomic) IBOutlet UIPickerView *dayView;
@property (nonatomic, strong) NSMutableArray *yearData;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@end

@implementation WSJAddMERViewController
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView.subviews.count > 1)  //去除滚筒的两根横线
    {
        [pickerView.subviews[1] setHidden:YES];
        [pickerView.subviews[2] setHidden:YES];
    }
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView == self.moonView) //月份
    {
        return 12;
    }
    else if(pickerView == self.dayView) //日期
    {
        return 31;
    }
    return self.yearData.count;   //年份
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    UILabel *l = [[UILabel alloc ]initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 30)];
    l.textAlignment = NSTextAlignmentCenter;
    if (pickerView == self.moonView || pickerView == self.dayView)
    {
        l.text = [@(row + 1) stringValue];
    }
    else
    {
        l.text = self.yearData[row];
    }
    return l;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    UIView *view = [pickerView viewForRow:row forComponent:component];
    UILabel *label = (UILabel *)view;
    label.textColor = status_color;
    if (pickerView == self.moonView)
    {
        _month = row + 1;
        NSLog(@"moon ---- %@",@(row + 1));
        
    }
    else if(pickerView == self.dayView)
    {
        _day = row + 1;
        NSLog(@"day ---- %ld",row+1);
    }
    else
    {
        _year = [self.yearData[row] integerValue];
        NSLog(@"year ---- %@",self.yearData[row]);
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
#pragma mark - 实例化UI
- (void)initUI
{
    switch (self.type) {
        case kAddMERType:
        {
            [self.saveBtn setTitle:@"保存并登入体检项" forState:UIControlStateNormal];
            [Util setNavTitleWithTitle:@"新增体检报告" ofVC:self];
        }
            break;
        case kEditMERType:
        {
            [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
            [Util setNavTitleWithTitle:@"编辑体检报告" ofVC:self];
        }
            break;
        default:
            break;
    }
    self.reportNameTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 1)];
    self.reportNameTextField.leftViewMode = UITextFieldViewModeAlways;
    self.hospitalTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 1)];
    self.hospitalTextField.leftViewMode = UITextFieldViewModeAlways;
    self.view.backgroundColor = background_Color;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(btnClick) target:self];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.yearData = [NSMutableArray array];
    for (NSInteger i = 1970; i < 2100; i++)
    {
        [self.yearData addObject:[@(i) stringValue]];
    }
    /**
     *  如果是从体检详情来，把资料自动填上
     */
    if (_isComePhysicalReportDetailVc) {
        self.reportNameTextField.text = self.strReportName;
        self.hospitalTextField.text = self.strCheckHospital;
        
        //字符串转换NSInteger
        _year = [self.strYear integerValue];
        _month = [self.strMonth integerValue];
        _day = [self.strDay integerValue];
        [self.yearView selectRow:_year - [self.yearData[0] intValue] inComponent:0 animated:YES];
        [self.moonView selectRow:_month - 1 inComponent:0 animated:YES];
        [self.dayView selectRow:_day - 1 inComponent:0 animated:YES];
    }else{
        //TODO:获取当前日期
        NSDate *now = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit ;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
        NSLog(@"date ---- %ld   %ld   %ld",dateComponent.year,dateComponent.month,dateComponent.day);
        _year = dateComponent.year;
        _month = dateComponent.month;
        _day = dateComponent.day;
        [self.yearView selectRow:dateComponent.year - [self.yearData[0] intValue] inComponent:0 animated:YES];
        [self.moonView selectRow:dateComponent.month - 1 inComponent:0 animated:YES];
        [self.dayView selectRow:dateComponent.day - 1 inComponent:0 animated:YES];

    }
    
    
    
    }
#pragma mark - 保存并录入体检项
- (IBAction)saveMER:(UIButton *)sender
{
    if (![Util varifyValidOfStr:self.hospitalTextField.text] || ! [Util varifyValidOfStr:self.reportNameTextField.text]) {
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"新增体检报告...";
    [hud show:YES];
    ReportAddRequest *request = [[ReportAddRequest alloc] init:GetToken];
    request.api_replyId = self.api_id;
    request.api_hospital = self.hospitalTextField.text;
    request.api_reportName = self.reportNameTextField.text;
    request.api_time = [NSString stringWithFormat:@"%04ld-%02ld-%02ld",_year,_month,_day];
    WEAK_SELF
    [self.vapiManager reportAdd:request success:^(AFHTTPRequestOperation *operation, ReportAddResponse *response) {
        NSLog(@"新增体检报告 succes ---- %@ ++ %@",response,response.subMsg);
        if (!response.errorCode) {
            NSDictionary *dict = (NSDictionary *)response.report;
            [kUserDefaults setObject:dict[@"createtime"] forKey:kMERTime];
            [kUserDefaults setObject:dict[@"id"] forKey:kMERID];
            switch (weak_self.type) {
                case kAddMERType:
                {
                    MERMenusViewController *menusVC = [[MERMenusViewController alloc ]init];
                    [weak_self.navigationController pushViewController:menusVC  animated:YES];
                }
                    break;
                case kEditMERType:
                {
                    [weak_self.navigationController popViewControllerAnimated:YES];
                }
                    break;
                default:
                    break;
            }
        }
        else
        {
            [Util ShowAlertWithOnlyMessage:response.subMsg];
        }
        [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"新增体检报告 error ---- %@",error);
        [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
        [weak_self errorHandle:error];
    }];
}
- (void) hiddenKey
{
    [self.view endEditing:YES];
}

//返回上一级界面
- (void) btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:NO];
}

@end
