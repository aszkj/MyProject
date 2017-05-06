//
//  WSJLungResultViewController.m
//  jingGang
//
//  Created by thinker on 15/7/29.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJLungResultViewController.h"
#import "PublicInfo.h"
#import "JGShareView.h"
#import "PhysicalSaveRequest.h"
#import "GlobeObject.h"
#import "VApiManager.h"
#import "UserCustomer.h"

@interface WSJLungResultViewController ()
{
    CGFloat _lung;
    CADisplayLink * _link;
    __weak IBOutlet UILabel *typeLabel1;
    __weak IBOutlet UILabel *typeLabel2;
    __weak IBOutlet UILabel *typeLabel3;
    __weak IBOutlet UILabel *typeLabel4;
}

////领取按钮
//@property (weak, nonatomic) IBOutlet UIButton *receiveBtn;
//最上面的Label
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
//中间Label
@property (weak, nonatomic) IBOutlet UILabel *centerLabel;
////健康币
//@property (weak, nonatomic) IBOutlet UILabel *healthyLabel;
//图片移动
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *resultLung;
//毫升Label
@property (weak, nonatomic) IBOutlet UILabel *MLLabel;


@property (weak, nonatomic) IBOutlet UILabel *saveDataLabel;
@end

@implementation WSJLungResultViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadViewLeftBarButton];
    [self initUI];
    [self initType];
    [self saveData];
}
#pragma mark - 数据保存到服务器
- (void) saveData
{
    self.saveDataLabel.layer.cornerRadius = 5;
    VApiManager * _manager = [[VApiManager alloc ]init];
    
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia"];
    NSDate *date = [NSDate date];
    
    PhysicalSaveRequest *saveRequest = [[PhysicalSaveRequest alloc] init:GetToken];
    switch (self.type)
    {
        case lungCapacityType://肺活量结果界面
        {
            saveRequest.api_type = @(8);
            saveRequest.api_maxValue = @(self.lungValue);
        }
            break;
        case bloodOxygenType: //血氧结果界面
        {
            saveRequest.api_type = @(9);
            saveRequest.api_maxValue = @(self.heartRateValue);
        }
            break;
        default:
            break;
    }
    WEAK_SELF
    saveRequest.api_time = [formatter stringFromDate:date];
    [_manager physicalSave:saveRequest success:^(AFHTTPRequestOperation *operation, PhysicalSaveResponse *response) {
        NSLog(@"succeed = %@",response);
        if (response.errorCode == nil)
        {
            [weak_self saveDataSuccessTishi:YES];
        }
        else
        {
            [weak_self saveDataSuccessTishi:NO];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure = %@",error);
        [weak_self saveDataSuccessTishi:NO];
    }];
}
//保存数据成功提示
- (void) saveDataSuccessTishi:(BOOL)b
{
    self.saveDataLabel.layer.cornerRadius = 5;
    if (!b)
    {
        self.saveDataLabel.text = @"数据保存失败";
    }
    WEAK_SELF
    [UIView animateWithDuration:1 animations:^{
        weak_self.saveDataLabel.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:3 animations:^{
            weak_self.saveDataLabel.alpha = 0;
        }];
    }];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    switch (self.type)
    {
        case lungCapacityType:
        {
            _lung = self.lungValue / 6000.0 * (__MainScreen_Width - 120) + 4;
            if (self.lungValue > 6000)
            {
                _lung = (__MainScreen_Width - 120) + 4;
            }
            _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(animationLung)];
            [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        }
            break;
        case bloodOxygenType:
        {
            if (self.heartRateValue <= 90)
            {
                _lung = self.heartRateValue / 90.0 *(__MainScreen_Width - 120) /4 + 4;
            }else if(self.heartRateValue <= 94)
            {
                _lung = (self.heartRateValue - 90) / 4.0 * (__MainScreen_Width - 120) /4 + 4 +(__MainScreen_Width - 120) /4;
            }
            else
            {
                _lung = (self.heartRateValue - 94) / 6.0 * (__MainScreen_Width - 120) / 2 + 4 + (__MainScreen_Width - 120) / 2;
            }
            if (self.heartRateValue > 100)
            {
                _lung = (__MainScreen_Width - 120) + 4;
            }
            _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(animationHeartRate)];
            [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        }
            break;
            
        default:
            break;
    }

}
-(void) animationHeartRate
{
    if (self.heartRateValue < 90)
    {
        self.resultLung.constant += 1;
    }
    else if (self.heartRateValue < 94)
    {
        self.resultLung.constant += 2;
    }
    else if (self.heartRateValue < 97)
    {
        self.resultLung.constant += 3;
    }
    else
    {
        self.resultLung.constant += 4;
    }
    if (self.resultLung.constant > _lung)
    {
        [_link invalidate];
    }
}
- (void) animationLung
{
    if (self.lungValue < 1500)
    {
        self.resultLung.constant += 1;
    }
    else if (self.lungValue < 3000)
    {
        self.resultLung.constant += 2;
    }
    else if (self.lungValue < 4500)
    {
        self.resultLung.constant += 3;
    }
    else
    {
        self.resultLung.constant += 4;
    }
    if (self.resultLung.constant > _lung)
    {
        [_link invalidate];
    }
}
#pragma mark - 肺活量结果
- (void) loadLungData
{
    self.resultLabel.text = [NSString stringWithFormat:@"%ld",self.lungValue];
    self.resultLabel.adjustsFontSizeToFitWidth = YES;
    
    NSDictionary *userDic = [kUserDefaults objectForKey:userInfoKey];
    
    int weight = [userDic[@"weight"] intValue];
    int sex = [userDic[@"sex"] intValue];
    if (!weight && !sex)
    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请您填写您的体重、性别信息！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alert show];
////        return;
    }
    if (!weight) {
        weight = 55;
    }
    if (!sex) {
        sex = 1;
    }
    CGFloat value = (CGFloat)self.lungValue / (float)weight;
    self.centerLabel.adjustsFontSizeToFitWidth = YES;
    if (sex == 1)//男的
    {
        if (value < 54)
        {
            self.centerLabel.text = @"建议远离吸烟区，增强肺活量的体育锻炼，科学的调整自己的呼吸方式，多做扩胸运动，唱歌，常吃苹果";
        }
        else if (value < 64)
        {
            self.centerLabel.text = @"建议远离吸烟区，增加锻炼，注意肺部健康，减少感冒等疾病的发生，避免长期处于空调环境。";
        }
        else if (value < 75)
        {
            self.centerLabel.text = @"建议保持良好的生活习惯，远离吸烟环境";
        }
        else
        {
            self.centerLabel.text = @"建议继续保持良好的生活习惯";
        }
    }
    else //女的
    {
        if (value < 44)
        {
            self.centerLabel.text = @"建议远离吸烟区，增强肺活量的体育锻炼，科学的调整自己的呼吸方式，多做扩胸运动，唱歌，常吃苹果";
        }
        else if (value < 57)
        {
            self.centerLabel.text = @"建议远离吸烟区，增加锻炼，注意肺部健康，减少感冒等疾病的发生，避免长期处于空调环境。";
        }
        else if (value < 70)
        {
            self.centerLabel.text = @"建议保持良好的生活习惯，远离吸烟环境";
        }
        else
        {
            self.centerLabel.text = @"建议继续保持良好的生活习惯";
        }
    }
    
}
#pragma mark - 心率结果
- (void) loadheartRateData
{
    self.resultLabel.text = [NSString stringWithFormat:@"%ld%%",self.heartRateValue];
    self.resultLabel.adjustsFontSizeToFitWidth = YES;
    self.centerLabel.adjustsFontSizeToFitWidth = YES;
    self.MLLabel.hidden = YES;
    if (self.heartRateValue > 94)
    {
        self.centerLabel.text = @"属于动脉血样饱和度正常。";
    }
    else if (self.heartRateValue > 90)
    {
        self.centerLabel.text = @"为供氧不足，即组织细胞代谢处于乏氧状态，机体需要补充氧份。";
    }
    else
    {
        self.centerLabel.text = @"为低血氧，对机体有着巨大的影响，多出现于疾病状态，入院治疗。";
    }
}
- (void) initType
{
    switch (self.type)
    {
        case lungCapacityType:
        {
            [self loadLungData];
        }
            break;
        case bloodOxygenType:
        {
            typeLabel1.text = @"<90";
            typeLabel2.text = @"90 - 94";
            typeLabel3.text = @"94 - 97";
            typeLabel4.text = @">97";
            [self loadheartRateData];
        }
            break;
        default:
            break;
    }
}
- (void) initUI
{
    self.saveDataLabel.layer.cornerRadius = 5;
    //分享按钮
    UIButton *button_Shared = [[UIButton alloc]initWithFrame:CGRectMake(20, 30, 35, __NavScreen_Height)];
    [button_Shared setImage:[UIImage imageNamed:@"life_share"] forState:UIControlStateNormal];
    [button_Shared addTarget:self action:@selector(btnShared) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar_Shared = [[UIBarButtonItem alloc]initWithCustomView:button_Shared];
    self.navigationItem.rightBarButtonItem = bar_Shared;
    //设置背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
  
}
#pragma mark - 设置返回按钮
- (void) loadViewLeftBarButton
{
    //返回上一级控制器按钮
    UIButton *button_na = [[UIButton alloc]initWithFrame:CGRectMake(20, 30, 35, __NavScreen_Height-15)];
    [button_na setImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    [button_na addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:button_na];
    self.navigationItem.leftBarButtonItem = bar;
}


#pragma mark - 返回上一级界面
- (void) btnClick
{
    [self.navigationController popViewControllerAnimated:YES];

}
//分享事件
- (void) btnShared
{
    JGShareView *shareView ;
    NSString *content;
    switch (self.type) {
        case lungCapacityType:
        {
            content = [NSString stringWithFormat:@"我在云e生APP上做了【肺活量测试】，大家一起来测试吧!下面放下载链接%@",k_ShareURL];
            shareView = [JGShareView shareViewWithTitle:@"肺活量测试" content:content imgUrlStr:k_ShareImage ulrStr:k_ShareURL contentView:self.view shareImagePath:nil];
        }
            break;
        case bloodOxygenType:
        {
            content = [NSString stringWithFormat:@"我在云e生APP上做了【血氧测试】，大家一起来测试吧!下面放下载链接%@",k_ShareURL];
            shareView = [JGShareView shareViewWithTitle:@"血氧测试" content:content imgUrlStr:k_ShareImage ulrStr:k_ShareURL contentView:self.view shareImagePath:nil];
        }
            break;
        default:
            break;
    }
    [shareView show];
}

#pragma mark - 标题
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(__MainScreen_Width/2 - 30, __StatusScreen_Height, 60, 40)];
    switch (self.type) {
        case bloodOxygenType:
            l.text = @"血氧测试结果";
            break;
        case lungCapacityType:
            l.text = @"肺活量测试结果";
            break;
        default:
            break;
    }
    l.font = [UIFont systemFontOfSize:18];
    l.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = l;
}

@end
