//
//  WSJHeartRateResultViewController.m
//  jingGang
//
//  Created by thinker on 15/7/30.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJHeartRateResultViewController.h"
#import "PublicInfo.h"
#import "JGShareView.h"
#import "PhysicalSaveRequest.h"
#import "GlobeObject.h"
#import "VApiManager.h"

@interface WSJHeartRateResultViewController ()
{
    CGFloat _lung;
    CADisplayLink * _link;
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

@property (weak, nonatomic) IBOutlet UILabel *saveDataLabel;

@end

@implementation WSJHeartRateResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadViewLeftBarButton];
    [self initUI];
    [self setResultData];
    [self saveData];
}
- (void) setResultData
{
    self.centerLabel.adjustsFontSizeToFitWidth = YES;
    if (self.heartRateValue < 40)
    {
        self.centerLabel.text = @"心率的测量值结果为心率偏低，建议您应及早进行详细检查，以便针对病因进行治疗。";
    }
    else if (self.heartRateValue < 60)
    {
        self.centerLabel.text = @"测量低于正常心率值。建议您适当放松心情，适当休息，减轻长期从事重体力劳动与运动；口服药物像洋地黄、奎尼丁或心得安类药品不宜过多，否则容易造成甲状腺机能低下、颅内压增高、阻塞性黄疸等症状。";
    }
    else if (self.heartRateValue < 100)
    {
        self.centerLabel.text = @"测量属于正常心跳，请继续保持，天天都有好心情。";
    }
    else if (self.heartRateValue < 160)
    {
        self.centerLabel.text = @"测量超出正常心率值，建议您密切关注心率的变化，尽量不做剧烈运动、不吸烟、不饮酒和少喝浓茶。必要时，可使用药物控制心跳，例如阿托品、肾上腺素、麻黄素等。";
    }
    else if (self.heartRateValue < 220)
    {
        self.centerLabel.text = @"测量值结果为心率超高，建议您一定要重视整体体质的改善。不可长期从事重体力或紧张性工作，以及参与紧张刺激性活动。让机体生物钟顺应自然节律，规律性地进行详细检查，可以早日恢复正常值。";
    }
}
- (void) saveData
{
    self.saveDataLabel.layer.cornerRadius = 5;
    VApiManager * _manager = [[VApiManager alloc ]init];
    
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia"];
    NSDate *date = [NSDate date];
    
    PhysicalSaveRequest *saveRequest = [[PhysicalSaveRequest alloc] init:GetToken];
    saveRequest.api_type = @(7);
    saveRequest.api_maxValue = @(self.heartRateValue);
    saveRequest.api_time = [formatter stringFromDate:date];
    WEAK_SELF
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
    _lung = (self.heartRateValue - 30) / 90.0 * (__MainScreen_Width - 120) + 10;
    if (self.heartRateValue > 120)
    {
        _lung = (__MainScreen_Width - 120) + 10;
    }
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(detectionVoice)];
    [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}
- (void) detectionVoice
{
    if (self.heartRateValue < 60)
    {
        self.resultLung.constant += 1;
    }
    else if (self.heartRateValue < 90)
    {
        self.resultLung.constant += 2;
    }
    else
    {
        self.resultLung.constant += 3;
    }
    if (self.resultLung.constant > _lung)
    {
        [_link invalidate];
    }
}


- (void) initUI
{
    self.saveDataLabel.layer.cornerRadius = 5;
    self.resultLabel.text = [NSString stringWithFormat:@"%ld",self.heartRateValue];
    self.resultLabel.adjustsFontSizeToFitWidth = YES;
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
    [self.navigationController popToViewController:[self.navigationController.viewControllers xf_safeObjectAtIndex:2] animated:YES];
//    [self.navigationController popViewControllerAnimated:YES];

}
//分享事件
- (void) btnShared
{
    NSString *content = [NSString stringWithFormat:@"我在云e生APP上做了【心率测试】，大家一起来测试吧!下面放下载链接%@",k_ShareURL];
    JGShareView *shareView = [JGShareView shareViewWithTitle:@"心率测试" content:content imgUrlStr:k_ShareImage ulrStr:k_ShareURL contentView:self.view shareImagePath:nil];
    [shareView show];
}

#pragma mark - 标题
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(__MainScreen_Width/2 - 30, __StatusScreen_Height, 60, 40)];
    l.text = @"心率测量结果";
    l.font = [UIFont systemFontOfSize:18];
    l.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = l;
}



@end
