//
//  AcceptOrdeController.m
//  WeimiSP
//
//  Created by 鹏 朱 on 16/2/19.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "AcceptOrdeController.h"
#import "AcceptOrdeCell.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "AcceptOrdeHeaderView.h"
#import "AcceptOrdeHeaderEntity.h"
#import "UIColor+UIImage.h"
#import "ChatViewController.h"
#import "PersonalCenterViewController.h"
#import "AppDelegate.h"
#import "AcceptOrdePromptView.h"
#import <WEMEStorecustomerservicecontrollerApi.h>
#import <WEMETaskcontrollerApi.h>
#import "DatabaseCache.h"
#import "AcceptOrdeEntity.h"
#import "NSDate+Addition.h"
#import "BaiduLocationManage.h"
#import "WEMEProgressHUD.h"
#import "NotDataView.h"
#import "PlayerHelper.h"
#import "UIApplication+Design.h"
#import "RemoteNotificationManage.h"

#define UploadLocationTime 10;

#define kColorOfTabSelectTextImage    [UIColor colorFromHexRGB:@"59C4F0"]   //#232222   选中时tab文字颜色
#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式
#define  PROGREESS_WIDTH 80 //圆直径
#define PROGRESS_LINE_WIDTH 4 //弧线的宽度
#define MAIN_SCREEN_ANIMATION_TIME 1.5

#define AcceptOrderStatusHeight 0 //订单状态高度

@interface AcceptOrdeController ()
{
    NSInteger _CountdownTime;
}

@property (nonatomic, strong) NotDataView *notDataView;
@property (nonatomic, strong) CAShapeLayer *trackLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, assign) NSInteger percent;
@property (nonatomic, strong) WEMETaskBO *acceptTaskBO;
@property (nonatomic, strong) WEMETaskBO *taskBO;
@property (nonatomic, strong) CADisplayLink *linkTime;

@end

@implementation AcceptOrdeController

static NSString *cellIdentifier = @"AcceptOrdeCell";

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_acceptOrderBtnBackImage.layer addAnimation:[self getAnimation] forKey:@"rotationAnimation"];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _acceptOrderBtnBackImage.hidden = NO;
    _acceptOrderBtn.hidden = NO;
    self.navigationController.navigationBar.translucent = NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _acceptOrderBtnBackImage.hidden = YES;
    _acceptOrderBtn.hidden = YES;
    
    if (_linkTime) {
        [_linkTime invalidate];
        _linkTime = nil;
    }
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initInfo];
    [self initDataSourse];
    [self initNavigationItem];
    [self creatUI];
    [self addNotificationCenter];
}
/**
 *  获取用户信息
 */
- (void)getUserInfoAPI
{
    __weak AppDelegate *weak_app = kAppDelegate;
    
    [[WEMEStorecustomerservicecontrollerApi sharedAPI] getProfileUsingGETWithCompletionBlock:^(WEMESingleObjectValueResponseOfStoreCustomerServiceBO *output, NSError *error) {
        if (IsEmpty(error) && [output.success integerValue])
        {
            weak_app.userInfo = output.item;
        }
        [NSError checkErrorFromServer:error response:output];
        [WEMEProgressHUD hideHUDForView:kCurrentKeyWindow];

    }];
}

- (void)initInfo {
    
    if (self.acceptOrdePromptView.isHidden) {
        [self WaitAcceptOrderAPI];
    }
    [self waitCompleteOrderAPI];

    [kAppDelegate uploadApnToken];
    [kAppDelegate uploadPhonesInfo];
    [kAppDelegate startBaiduLocation];
    [kAppDelegate connectToServer];
    [kAppDelegate initIMServerInfo];
}

- (void)initDataSourse {
    
    NSString *currentDate = [NSDate currentDateStringWithFormat:@"yyyy年MM月dd HH:mm"];
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:currentDate,@"message_time",@"0",@"message_type",@"接单侠今日上线了!",@"message_content", nil];
    
    AcceptOrdeEntity *acceptOrdeEntity = [[AcceptOrdeEntity alloc] initWithDictionary:dic];

    _dataList = [[DatabaseCache shareInstance] selectAcceptOrderInfo];
    if (!_dataList) {
        _dataList = [[NSMutableArray alloc] init];
        
        [[DatabaseCache shareInstance] insertAcceptOrderInfo:acceptOrdeEntity];
        [_dataList addObject:acceptOrdeEntity];
    }
    
    [self reFreshNodata];
}

- (void)reFreshNodata {
    
    if (self.dataList.count == 0)
    {
        self.notDataView.hidden = NO;
    }
}

- (void)addNotificationCenter {
    //应用程序的前台 后台切换
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appHasGoneInForeground:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    //注册网络改变的通知
    [kNotification addObserver:self selector:@selector(receiveNetworkChangedMessage:)
                          name:kNotificationNetworkChangedMessage
                        object:nil];
    
    [kNotification addObserver:self selector:@selector(receiveTaskStateChangedMessage:)
                          name:kNotificationTaskStateChangedMessage
                        object:nil];
    [kNotification addObserver:self selector:@selector(receiveMqttStateChangedMessage:)
                          name:kNotificationMqttStateChangedMessage
                        object:nil];

}
- (void)appHasGoneInForeground:(NSNotification *)notifacation
{
    //设置在线按钮背景旋转
    [_acceptOrderBtnBackImage.layer addAnimation:[self getAnimation] forKey:@"rotationAnimation"];
}

- (void)receiveNetworkChangedMessage:(NSNotification *)notification
{
    NSDictionary *messageDic = notification.userInfo;
    NSNumber *hasNetwork = [messageDic objectForKey:KMessageParameter];

    [self changeNetworkState:[hasNetwork boolValue]];
}

- (void)receiveTaskStateChangedMessage:(NSNotification *)notification
{
    NSDictionary *messageDic = notification.userInfo;
    NSNumber *hasAcceptTask = [messageDic objectForKey:KMessageParameter];
    
    [self changeTaskState:[hasAcceptTask boolValue]];
}

- (void)receiveMqttStateChangedMessage:(NSNotification *)notification
{
    NSDictionary *messageDic = notification.userInfo;
    NSNumber *hasConnected = [messageDic objectForKey:KMessageParameter];
    
//    [self UserCurrentStatusAPI];
    [self changeMqttState:[hasConnected boolValue]];
}

- (void)enterPersonalCenter
{
    PersonalCenterViewController *personalCenter = [[PersonalCenterViewController alloc ]init];
    [self.navigationController pushViewController:personalCenter animated:YES];
}

- (void)changeNetworkState:(BOOL)hasNetwork {
    
    if (hasNetwork && !self.networkStateView.hidden) {
        
        [self.networkStateView setHidden:hasNetwork];
        
        if (self.taskStateView.hidden) {
            [self waitCompleteOrderAPIOfNoTip];
        }

        if (self.taskStateView.hidden && self.mqttStateView.hidden) {
            [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(AcceptOrderStatusHeight,0,0,0));
            }];
        } else {
            [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(AcceptOrderStatusHeight + 50,0,0,0));
            }];
        }

    } else if (!hasNetwork && self.networkStateView.hidden) {
        
        [self.networkStateView setHidden:hasNetwork];
        
        [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(AcceptOrderStatusHeight + 50,0,0,0));
        }];

    }
}

- (void)changeTaskState:(BOOL)hasAcceptTask {
    
    if (!hasAcceptTask && !self.taskStateView.hidden) {
        
        [self.taskStateView setHidden:YES];
        
        if (self.networkStateView.hidden && self.mqttStateView.hidden) {
            [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(AcceptOrderStatusHeight,0,0,0));
            }];
        } else {
            [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(AcceptOrderStatusHeight + 50,0,0,0));
            }];
        }
        
    } else if (hasAcceptTask && self.taskStateView.hidden) {
        
        [self.taskStateView setHidden:NO];
        
        [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(AcceptOrderStatusHeight + 50,0,0,0));
        }];
        
    }
}

- (void)changeMqttState:(BOOL)hasConnected {
    
    if (hasConnected && !self.mqttStateView.hidden) {
        
        [self.mqttStateView setHidden:hasConnected];
        if (self.taskStateView.hidden) {
            [self waitCompleteOrderAPIOfNoTip];
        }

        if (self.taskStateView.hidden && self.networkStateView.hidden) {
            [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(AcceptOrderStatusHeight,0,0,0));
            }];
        } else {
            [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(AcceptOrderStatusHeight + 50,0,0,0));
            }];
        }
        
    } else if (!hasConnected && self.mqttStateView.hidden) {
        
        [self.mqttStateView setHidden:hasConnected];
        
        [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(AcceptOrderStatusHeight + 50,0,0,0));
        }];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter

- (CABasicAnimation *)getAnimation
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 2.0;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = HUGE_VALF;
    //    [self.but.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    return rotationAnimation;
}

-(NotDataView *)notDataView
{
    if (!_notDataView) {
        _notDataView = [[NotDataView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - AcceptOrderStatusHeight)];
        _notDataView.hidden = YES;
    }
    return _notDataView;
}

-(UIImageView *)acceptOrderBtnBackImage
{
    if (!_acceptOrderBtnBackImage) {
        _acceptOrderBtnBackImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"status_shangxian"]];
        _acceptOrderBtnBackImage.bounds = CGRectMake(0, 0, AcceptOrderButtonHeight , AcceptOrderButtonHeight);
        //设置在线按钮背景旋转
        [_acceptOrderBtnBackImage.layer addAnimation:[self getAnimation] forKey:@"rotationAnimation"];
    }
    return _acceptOrderBtnBackImage;
}

-(AcceptOrdePromptView *)acceptOrdePromptView
{
    if (!_acceptOrdePromptView) {
        _acceptOrdePromptView = [[AcceptOrdePromptView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _acceptOrdePromptView.hidden = YES;
        WEAK_SELF
        _acceptOrdePromptView.cancelOrderBlock = ^(){
            
            [weak_self hidePopverView];
            
        };
    }
    return _acceptOrdePromptView;
}

- (UIView *)networkStateView {
    
    if (!_networkStateView) {
        
        _networkStateView = [XKO_CreateUIViewHelper createUIViewWithFrame:CGRectMake(0, AcceptOrderStatusHeight, kScreenWidth, 50) backgroundColor:kGetColor(255, 250, 212)];
        _networkStateView.hidden = YES;

        UIImageView *noNetworkState = [XKO_CreateUIViewHelper createUIImageViewWithFrame:CGRectMake(0, 0, 16, 16) image:IMAGE(@"InfoError")];
        [_networkStateView addSubview:noNetworkState];
        
        UILabel *noNetworkText = [XKO_CreateUIViewHelper createLabelWithFrame:CGRectZero font:kFontSize14 fontColor:[UIColor blackColor] text:@"当前网络不可用,请检查你的网络设置"];
        [_networkStateView addSubview:noNetworkText];
        
        [noNetworkState mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_networkStateView).with.offset(10);
            make.centerY.mas_equalTo(_networkStateView);
            make.size.mas_equalTo(CGSizeMake(16, 16));
        }];

        [noNetworkText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(noNetworkState.mas_right).with.offset(10);
            make.right.equalTo(_networkStateView).with.offset(-10);
            make.centerY.mas_equalTo(_networkStateView);
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(enterIPhoneSet)];
        _networkStateView.userInteractionEnabled = YES;
        [_networkStateView addGestureRecognizer:tap];
    }
    
    return _networkStateView;
}
- (void)enterIPhoneSet
{
    [[UIApplication sharedApplication] rt_openSettingURL:UIApplicationSettingsURL];
}

- (UIView *)taskStateView {
    
    if (!_taskStateView) {
        
        _taskStateView = [XKO_CreateUIViewHelper createUIViewWithFrame:CGRectMake(0, AcceptOrderStatusHeight, kScreenWidth, 50) backgroundColor:kGetColor(255, 250, 212)];
        _taskStateView.hidden = YES;
        
        UIImageView *noNetworkState = [XKO_CreateUIViewHelper createUIImageViewWithFrame:CGRectMake(0, 0, 10, 10) image:IMAGE(@"order_tip")];
        [_taskStateView addSubview:noNetworkState];
        
//        UILabel *noNetworkText = [XKO_CreateUIViewHelper createLabelWithFrame:CGRectZero font:kFontSize14 fontColor:UIColorFromRGB(0xf85614) text:@"当前任务进行中,无法接新的任务,点击进入任务"];

        UIButton *noNetworkBtn = [XKO_CreateUIViewHelper createUIButtonWithTitle:@"当前任务进行中,无法接新的任务,点击进入任务" titleColor:UIColorFromRGB(0xf85614) titleFont:kFontSize14 backgroundColor:[UIColor clearColor] hasRadius:NO targetSelector:@selector(enterChatVC:) target:self];
        noNetworkBtn.titleLabel.numberOfLines = 2;
        
        UIButton *completeBtn = [XKO_CreateUIViewHelper createUIButtonWithFrame:CGRectZero title:@"完成" titleColor:[UIColor whiteColor] titleFont:kFontSize14 backgroundColor:kGetColor(248, 43, 20) hasRadius:YES targetSelector:@selector(completeTaskBtn:) target:self];
        [_taskStateView addSubview:completeBtn];

        [completeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_taskStateView).with.offset(-11);
            make.size.mas_equalTo(CGSizeMake(43, 25));
            make.centerY.mas_equalTo(_taskStateView);
        }];
        
        UIButton *backPlatformBtn = [XKO_CreateUIViewHelper createUIButtonWithFrame:CGRectZero title:@"转回" titleColor:[UIColor whiteColor] titleFont:kFontSize14 backgroundColor:kGetColor(248, 43, 20) hasRadius:YES targetSelector:@selector(backPlatformBtn:) target:self];
        
        [_taskStateView addSubview:backPlatformBtn];
        
        [backPlatformBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(completeBtn.mas_left).with.offset(-11);
            make.size.mas_equalTo(CGSizeMake(43, 25));
            make.centerY.mas_equalTo(_taskStateView);
        }];

        [_taskStateView addSubview:noNetworkBtn];
        [noNetworkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_taskStateView).with.offset(31);
            make.right.equalTo(backPlatformBtn.mas_left).with.offset(-20);
            make.centerY.mas_equalTo(_taskStateView);
        }];
        
        [noNetworkState mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_taskStateView).with.offset(11);
            make.top.equalTo(noNetworkBtn).offset(3);
            make.size.mas_equalTo(CGSizeMake(10, 10));
        }];

    }
    
    return _taskStateView;
}


- (UIView *)mqttStateView {
    
    if (!_mqttStateView) {
        
        _mqttStateView = [XKO_CreateUIViewHelper createUIViewWithFrame:CGRectMake(0, AcceptOrderStatusHeight, kScreenWidth, 50) backgroundColor:kGetColor(255, 250, 212)];
        _mqttStateView.hidden = YES;
        
        UIImageView *noNetworkState = [XKO_CreateUIViewHelper createUIImageViewWithFrame:CGRectMake(0, 0, 16, 16) image:IMAGE(@"InfoError")];
        [_mqttStateView addSubview:noNetworkState];
        
        UILabel *noNetworkText = [XKO_CreateUIViewHelper createLabelWithFrame:CGRectZero font:kFontSize14 fontColor:[UIColor blackColor] text:@"当前网络连接不上服务!"];
        [_mqttStateView addSubview:noNetworkText];
        
        [noNetworkState mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_mqttStateView).with.offset(10);
            make.centerY.mas_equalTo(_mqttStateView);
            make.size.mas_equalTo(CGSizeMake(16, 16));
        }];
        
        [noNetworkText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(noNetworkState.mas_right).with.offset(10);
            make.right.equalTo(_mqttStateView).with.offset(-10);
            make.centerY.mas_equalTo(_mqttStateView);
        }];
    }
    
    return _mqttStateView;
}

#pragma mark - private methord

- (void)initNavigationItem {
    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

    UILabel *dateLb = [XKO_CreateUIViewHelper createLabelWithFrame:CGRectMake(0, 0, kScreenWidth/2, 28) font:[UIFont CustomFontOfSize:20] fontColor:[UIColor whiteColor] text:[NSDate currentDateStringWithFormat:@"yyyy年MM月dd日"]];
    UIBarButtonItem *dateItem = [[UIBarButtonItem alloc] initWithCustomView:dateLb];
    
    UIView *space = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    space.backgroundColor = [UIColor clearColor];
//    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithCustomView:space];
    
    UILabel *orderCountLb = [XKO_CreateUIViewHelper createLabelWithFrame:CGRectMake(0, 0, 100, 20) font:[UIFont CustomFontOfSize:20] fontColor:[UIColor whiteColor] text:@"接单:18"];
    orderCountLb.textAlignment = NSTextAlignmentLeft;
//    UIBarButtonItem *orderCounItem = [[UIBarButtonItem alloc] initWithCustomView:orderCountLb];
    
    UIView *space2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    space2.backgroundColor = [UIColor clearColor];
    
//    UIBarButtonItem *spaceItem2 = [[UIBarButtonItem alloc] initWithCustomView:space2];
    self.navigationItem.leftBarButtonItems = @[dateItem];
    
    UIBarButtonItem *personalItem = [[UIBarButtonItem alloc ]initWithImage:[UIImage imageNamed:@"personalCenterLogo"] style:UIBarButtonItemStylePlain target:self action:@selector(enterPersonalCenter)];
    personalItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = personalItem;
    [Util setNavigationTranslucentWithVC:self];
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    UIImageView * navBarHairlineImageView = [self findHairlineImageViewUnder:navigationBar];
    navBarHairlineImageView.hidden = YES;
}

- (void)enterChatVC:(UIButton *)sender {
    
    ChatViewController *chatVC = [[ChatViewController alloc] init];
    
    if (IsEmpty(self.acceptTaskBO)) {
        
        chatVC.channel = [NSString stringWithFormat:@"%@",self.taskBO.channelId];
        chatVC.taskBO = self.taskBO;

    } else {
        
        chatVC.channel = [NSString stringWithFormat:@"%@",self.acceptTaskBO.channelId];
        chatVC.taskBO = self.acceptTaskBO;
    }
    
    _acceptOrderBtnBackImage.hidden = YES;
    _acceptOrderBtn.hidden = YES;

    [self.navigationController pushViewController:chatVC animated:YES];
    
}

- (void)hidePopverView {
    
    if (!self.acceptOrdePromptView.hidden) {
        
        if (self.navigationController.viewControllers.count > 1) {
            self.acceptOrderBtnBackImage.hidden = YES;
            self.acceptOrderBtn.hidden = YES;
        }
        
        self.acceptOrdePromptView.hidden = YES;
        [self.linkTime invalidate];
        self.linkTime  = nil;
        [self.acceptOrderBtn setTitle:@"在线" forState:UIControlStateNormal];
        self.acceptOrderBtnBackImage.image = [UIImage imageNamed:@"status_zaixian"];
        
        [[PlayerHelper shared] stop];
    }
}

- (void)showPopverView {
    if ([UIApplication sharedApplication].applicationState != UIApplicationStateActive) {
        [RemoteNotificationManage sendLocalNotification:@"您有一个新的待接单任务" soundName:@"new_task_tone.mp3" repeat:0];
    } else {
        [[PlayerHelper shared] playVoiceOfFileName:@"" finishBlock:^{}];
    }
    
    self.acceptOrderBtnBackImage.hidden = NO;
    self.acceptOrderBtn.hidden = NO;
    self.acceptOrdePromptView.hidden = NO;
    self.acceptOrdePromptView.contentView.contentOffset = CGPointMake(0, 0);
    NSTimeInterval startTime = [self.acceptTaskBO.createTime timeIntervalSince1970];
    startTime /= 1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:startTime];
    
    self.acceptOrdePromptView.orderDate = [date dateWithFormat:@"yyyy年MM月dd日 hh:mm"];
    self.acceptOrdePromptView.orderContent = self.acceptTaskBO.taskDescription;
    self.acceptOrdePromptView.shangmenTitle = self.acceptTaskBO.serviceClassName;

    if (IsEmpty(self.acceptTaskBO.address)) {
        
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([self.acceptTaskBO.lat floatValue], [self.acceptTaskBO.lon floatValue]);
        WEAK_SELF
        [[BaiduLocationManage shareManage] setWithCoordinate2D:coordinate withAddress:^(NSString *address) {

            weak_self.acceptOrdePromptView.orderAddress = address;
        }];
        
    } else {
        self.acceptOrdePromptView.orderAddress = self.acceptTaskBO.address;
    }
    self.acceptOrdePromptView.orderLocation = CLLocationCoordinate2DMake([self.acceptTaskBO.lat floatValue], [self.acceptTaskBO.lon floatValue]);

}

//转回平台
- (void)backPlatformBtn:(UIButton *)sender {

    UIAlertView *alerView = [[UIAlertView alloc ]initWithTitle:@"提示" message:@"您是否要转回平台？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"转回", nil];
    
    [[alerView rac_buttonClickedSignal] subscribeNext:^(NSNumber *indexNumber) {
        NSInteger index = indexNumber.integerValue;
        if (index == 0) {  return; }
        [self switchThirdParty];
    }];
    
    [alerView show];

}

- (void)completeTaskBtn:(UIButton *)sender {
    
    UIAlertView *alerView = [[UIAlertView alloc ]initWithTitle:@"提示" message:@"您是否要完成任务？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"完成", nil];
    
    [[alerView rac_buttonClickedSignal] subscribeNext:^(NSNumber *indexNumber) {
        NSInteger index = indexNumber.integerValue;
        if (index == 0) {  return; }
        [self completeAcceptOrderAPI];
    }];
    
    [alerView show];
}

- (void)changeOnLineState:(UIButton *)sender {

    if ([[sender titleForState:UIControlStateNormal] isEqualToString:@"上线"]) {
        
        [self onLine];

    } else if ([[sender titleForState:UIControlStateNormal] isEqualToString:@"在线"]) {

        [self offLine];
        
    } else if ([[sender titleForState:UIControlStateNormal] isEqualToString:@"接单"]) {
        
        [self AcceptOrderAPI];
        
    } else if ([[sender titleForState:UIControlStateNormal] isEqualToString:@"服务中"]) {
        
    } else if ([[sender titleForState:UIControlStateNormal] rangeOfString:@"s"].length > 0) {
        
        [self AcceptOrderAPI];

    }
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)creatAnimator {
    
    _trackLayer = [CAShapeLayer layer];//创建一个track shape layer
    _trackLayer.frame = CGRectMake(100, 200, 100, 100);
    [self.view.layer addSublayer:_trackLayer];
    _trackLayer.fillColor = [[UIColor clearColor] CGColor];
    _trackLayer.strokeColor = [[UIColor redColor] CGColor];//指定path的渲染颜色
    _trackLayer.opacity = 0.25; //背景
    _trackLayer.lineCap = kCALineCapRound;//指定线的边缘是圆的
    _trackLayer.lineWidth = PROGRESS_LINE_WIDTH;//线的宽度
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(40, 40) radius:(PROGREESS_WIDTH-PROGRESS_LINE_WIDTH)/2 startAngle:degreesToRadians(0) endAngle:degreesToRadians(360) clockwise:YES];//上面说明过了用来构建圆形
    _trackLayer.path =[path CGPath]; //把path传递給layer，然后layer会处理相应的渲染，整个逻辑和CoreGraph是一致的。
    
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.frame = CGRectMake(100, 200, 100, 100);
    _progressLayer.fillColor =  [[UIColor clearColor] CGColor];
    _progressLayer.strokeColor  = [[UIColor yellowColor] CGColor];
    _progressLayer.lineCap = kCALineCapRound;
    _progressLayer.lineWidth = PROGRESS_LINE_WIDTH;
    _progressLayer.path = [path CGPath];
    _progressLayer.strokeEnd = 0;
    
    CALayer *gradientLayer = [CALayer layer];
    CAGradientLayer *gradientLayer1 =  [CAGradientLayer layer];
    gradientLayer1.frame = CGRectMake(100, 200, 100, 100);
    [gradientLayer1 setColors:[NSArray arrayWithObjects:(id)[[UIColor redColor] CGColor],(id)[UIColorFromRGB(0xfde802) CGColor], nil]];
    [gradientLayer1 setLocations:@[@0.2,@0.5 ]];
    [gradientLayer1 setStartPoint:CGPointMake(0.5, 1)];
    [gradientLayer1 setEndPoint:CGPointMake(0.5, 0)];
    [gradientLayer addSublayer:gradientLayer1];
    
    [gradientLayer setMask:_progressLayer]; //用progressLayer来截取渐变层
    [self.view.layer addSublayer:gradientLayer];

}

- (void)creatUI {
    
    [self.navigationController.view addSubview:self.acceptOrdePromptView];
    
    AcceptOrdeHeaderView *acceptOrdeHeaderView = [[AcceptOrdeHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, AcceptOrderStatusHeight)];
    acceptOrdeHeaderView.backgroundColor = kGetColor(18, 183, 245);

    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"2016年2月16日",@"time",@"接单：5",@"acceptOrderNum",@"收入:0.00元",@"income",@"成单数:0",@"completeOrderNum",@"成单率:0%",@"completeOrderPercentage", nil];
    AcceptOrdeHeaderEntity *acceptOrdeHeaderEntity = [[AcceptOrdeHeaderEntity alloc] initWithDictionary:dic];
    [acceptOrdeHeaderView setEntity:acceptOrdeHeaderEntity];
    [self.view addSubview:acceptOrdeHeaderView];

    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    //    self.tableView.fd_debugLogEnabled = YES;
    [_tableView registerClass:[AcceptOrdeCell class] forCellReuseIdentifier:cellIdentifier];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = kGetColor(243, 245, 249);

    [self.view addSubview:_tableView];

    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(AcceptOrderStatusHeight,0,0,0));
    }];
    
    UIButton *onlineStateBtn = [XKO_CreateUIViewHelper createUIButtonWithFrame:CGRectMake(0, 0, AcceptOrderButtonHeight, AcceptOrderButtonHeight) title:@"上线" titleColor:[UIColor whiteColor] titleFont:kFontSize16 backgroundColor:[UIColor clearColor] hasRadius:YES targetSelector:@selector(changeOnLineState:) target:self];
    onlineStateBtn.layer.cornerRadius = AcceptOrderButtonHeight / 2;
    self.acceptOrderBtn = onlineStateBtn;
    [self.navigationController.view addSubview:self.acceptOrderBtnBackImage];
    [self.navigationController.view addSubview:onlineStateBtn];
    onlineStateBtn.center = CGPointMake(kScreenWidth/2, kScreenHeight - AcceptOrderButtonHeight / 2 - 20);
    _acceptOrderBtnBackImage.center = onlineStateBtn.center;
    
//    [onlineStateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.view).with.offset(-10);
//        make.centerX.mas_equalTo(self.view);
//        make.size.mas_equalTo(CGSizeMake(60, 60));
//    }];
//    [_acceptOrderBtnBackImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(onlineStateBtn.mas_centerX);
//        make.centerY.equalTo(onlineStateBtn.mas_centerY);
//        make.size.mas_equalTo(CGSizeMake(64, 64));
//    }];
    
    
    
    [self.view addSubview:self.taskStateView];
    [self.taskStateView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(acceptOrdeHeaderView.mas_bottom);
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 50));
    }];
    
    [self.view addSubview:self.mqttStateView];
    [self.mqttStateView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(acceptOrdeHeaderView.mas_bottom);
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 50));
    }];

    [self.view addSubview:self.networkStateView];
    [self.networkStateView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(acceptOrdeHeaderView.mas_bottom);
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 50));
    }];
    [_tableView addSubview:self.notDataView];
}

-(void)setPercent:(NSInteger)percent animated:(BOOL)animated
{
    [CATransaction begin];
    [CATransaction setDisableActions:!animated];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [CATransaction setAnimationDuration:MAIN_SCREEN_ANIMATION_TIME];
    _progressLayer.strokeEnd = percent/100.0;
    [CATransaction commit];
    
    _percent = percent;
}

- (void)onLine {
    
    WEAK_SELF
    [[WEMEStorecustomerservicecontrollerApi sharedAPI] workStartUsingGETWithCompletionBlock:^(WEMESimpleResponse *output, NSError *error) {
        
        if (!IsEmpty(error)) {
            [NSError checkErrorFromServer:error response:output];
        } else if (![output.success isEqual:@1]) {
            
            [self showHudTextWithErrorMessage:@"服务器错误,上线失败!"];
            
        } else {
            
            if (weak_self.taskStateView.hidden) {
                [weak_self.acceptOrderBtn setTitle:@"在线" forState:UIControlStateNormal];
                weak_self.acceptOrderBtnBackImage.image = [UIImage imageNamed:@"status_zaixian"];
                [weak_self.acceptOrderBtnBackImage.layer addAnimation:[weak_self getAnimation] forKey:@"rotationAnimation"];

            } else {
                [weak_self.acceptOrderBtn setTitle:@"服务中" forState:UIControlStateNormal];
                weak_self.acceptOrderBtnBackImage.image = [UIImage imageNamed:@"over_service"];            }
        }
    }];
}

- (void)offLine {
    
    WEAK_SELF
    [[WEMEStorecustomerservicecontrollerApi sharedAPI] workStopUsingGETWithCompletionBlock:^(WEMESimpleResponse *output, NSError *error) {
        
        if (IsEmpty(error) && ([output.success isEqual:@1] || [output.error integerValue] == 452) ) {

            [weak_self changeTaskState:NO];
            [weak_self.acceptOrderBtn setTitle:@"上线" forState:UIControlStateNormal];
            weak_self.acceptOrderBtnBackImage.image = [UIImage imageNamed:@"status_shangxian"];
        } else {
            if (!IsEmpty(error))
            {
                [NSError checkErrorFromServer:error response:output];
            }else
            {
                [self showHudTextWithErrorMessage:@"下线失败!"];
            }
        }
    }];
}

/**
 *  接单倒计时
 *
 *  @param time 倒计时时间
 */
- (void)AcceptOrderDountdownWithTime:(NSInteger)time
{
    [_linkTime invalidate];
    _linkTime = nil;
    _CountdownTime = time;
    self.linkTime.frameInterval = 60;
}
- (CADisplayLink *)linkTime
{
    if (!_linkTime) {
        _linkTime = [CADisplayLink displayLinkWithTarget:self selector:@selector(detectionVoice)];
        [_linkTime addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _linkTime;
}
- (void)detectionVoice
{
    if (_CountdownTime > 60)
    {
        [self.acceptOrderBtn setTitle:@"接单" forState:UIControlStateNormal];
        self.acceptOrderBtnBackImage.image = [UIImage imageNamed:@"status_jiedan"];
        _CountdownTime --;
    }
    else if (_CountdownTime > 0)
    {
        [self.acceptOrderBtn setTitle:[NSString stringWithFormat:@"%lds",_CountdownTime] forState:UIControlStateNormal];
        self.acceptOrderBtnBackImage.image = [UIImage imageNamed:@"status_jiedan"];
        _CountdownTime --;
    }
    else
    {
        [self hidePopverView];
    }
}

#pragma mark - 接收任务接口API

- (void)WaitAcceptOrderAPI
{
    if (self.taskStateView.hidden) {
        
        WEAK_SELF
        [[WEMETaskcontrollerApi sharedAPI] findWaitAcceptUsingGETWithCompletionBlock:^(WEMESingleResponseOfTaskBO *output, NSError *error) {
            
            if (IsEmpty(error) && output.success.integerValue == YES) {
                
                if (!IsEmpty(output.item)) {
                    
                    NSTimeInterval startTime = [output.item.lastStartWaitTime timeIntervalSince1970];
                    startTime /= 1000;
                    
                    NSTimeInterval endTime = [[NSDate date] timeIntervalSince1970];
                    
                    int time = (endTime - startTime);
                    weak_self.acceptTaskBO = output.item;
                    if (time < 120) {
                        time = 120 - time;
                        [weak_self showPopverView];
                        [weak_self AcceptOrderDountdownWithTime:time];
                    }
                    
                }
                else {
//                    [weak_self showPopverView];
//                    [weak_self AcceptOrderDountdownWithTime:60];
                }
            }
            else
            {
                [NSError checkErrorFromServer:error response:output];
            }
            
            if ([[UIApplication sharedApplication] applicationIconBadgeNumber] != 0) {
                [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
            }
        }];
    }
}

#pragma mark - 完成任务接口API

- (void)waitCompleteOrderAPI
{
    [WEMEProgressHUD showHUDAddedTo:kCurrentKeyWindow];
    [self.view endEditing:YES];

    WEAK_SELF
    [[WEMETaskcontrollerApi sharedAPI] waitCompleteTaskUsingGETWithCompletionBlock:^(WEMESingleResponseOfTaskBO *output, NSError *error) {
        
        if (IsEmpty(error) && output.success.integerValue == YES) {
            
            if (!IsEmpty(output.item)) {
                weak_self.taskBO = output.item;
                [weak_self changeTaskState:YES];
                
                [weak_self.acceptOrderBtn setTitle:@"服务中" forState:UIControlStateNormal];
                weak_self.acceptOrderBtnBackImage.image = [UIImage imageNamed:@"over_service"];
            }
            else
            {
                [weak_self UserCurrentStatusAPI];
            }
        }
        [NSError checkErrorFromServer:error response:output];
        [weak_self getUserInfoAPI];
    }];
}

- (void)waitCompleteOrderAPIOfNoTip
{
    WEAK_SELF
    [[WEMETaskcontrollerApi sharedAPI] waitCompleteTaskUsingGETWithCompletionBlock:^(WEMESingleResponseOfTaskBO *output, NSError *error) {
        
        if (IsEmpty(error) && output.success.integerValue == YES) {
            
            if (!IsEmpty(output.item)) {
                weak_self.taskBO = output.item;
                [weak_self changeTaskState:YES];
                
                [weak_self.acceptOrderBtn setTitle:@"服务中" forState:UIControlStateNormal];
                weak_self.acceptOrderBtnBackImage.image = [UIImage imageNamed:@"over_service"];
            }
        }
        [NSError checkErrorFromServer:error response:output];
    }];
}

- (void)AcceptOrderAPI
{
    WEAK_SELF
    [[WEMETaskcontrollerApi sharedAPI] acceptUsingGETWithCompletionBlock:^(WEMESingleResponseOfTaskBO *output, NSError *error) {
        
        if (IsEmpty(error) && output.success.integerValue == YES)
        {
            [[PlayerHelper shared] stop];

            [weak_self changeTaskState:YES];

            [weak_self.linkTime invalidate];
            weak_self.linkTime = nil;
            weak_self.acceptOrdePromptView.hidden = YES;
            [weak_self.acceptOrderBtn setTitle:@"服务中" forState:UIControlStateNormal];
            weak_self.acceptOrderBtnBackImage.image = [UIImage imageNamed:@"over_service"];
            
            [weak_self enterChatVC:nil];

        } else {
            
            [self hidePopverView];
            if (!IsEmpty(error)) {
                [NSError checkErrorFromServer:error response:output];
            }
            else
            {
                [self showHudTextWithErrorMessage:@"接单失败!"];
            }
        }
    }];
}
//判断用户当前状态
- (void)UserCurrentStatusAPI
{
    WEAK_SELF
    [[WEMEStorecustomerservicecontrollerApi sharedAPI] isWorkUsingGETWithCompletionBlock:^(WEMESingleResponseOfboolean *output, NSError *error) {
        if (IsEmpty(error) && [output.success integerValue])
        {
            if ([output.item integerValue]) //在线状态
            {
                [weak_self.acceptOrderBtn setTitle:@"在线" forState:UIControlStateNormal];
                weak_self.acceptOrderBtnBackImage.image = [UIImage imageNamed:@"status_zaixian"];
            }
            else
            {
                [weak_self.acceptOrderBtn setTitle:@"上线" forState:UIControlStateNormal];
                weak_self.acceptOrderBtnBackImage.image = [UIImage imageNamed:@"status_shangxian"];
            }
        }
    }];
}

- (void)completeAcceptOrderAPI {
    
    WEAK_SELF
    [[WEMETaskcontrollerApi sharedAPI] thirdPartyCompleteUsingGETWithCompletionBlock:^(WEMESimpleResponse *output, NSError *error) {
        
        if (IsEmpty(error) && output.success.integerValue == YES) {

            [weak_self changeTaskState:NO];
            
            [weak_self.acceptOrderBtn setTitle:@"在线" forState:UIControlStateNormal];
            weak_self.acceptOrderBtnBackImage.image = [UIImage imageNamed:@"status_zaixian"];
        } else {
            
            [self hidePopverView];
            if (!IsEmpty(error)) {
                [NSError checkErrorFromServer:error response:nil];
            }
            else
            {
                [self showHudTextWithErrorMessage:@"完成失败!"];
            }
        }
    }];
    
}

- (void)switchThirdParty {
    
    WEAK_SELF
    [[WEMETaskcontrollerApi sharedAPI] thirdPartySwitchUsingGETWithCompletionBlock:^(WEMESimpleResponse *output, NSError *error) {
        
        if (IsEmpty(error) && output.success.integerValue == YES) {

            [weak_self changeTaskState:NO];
            
            [weak_self.acceptOrderBtn setTitle:@"在线" forState:UIControlStateNormal];
            weak_self.acceptOrderBtnBackImage.image = [UIImage imageNamed:@"status_zaixian"];
        } else {
            
            [self hidePopverView];
            if (!IsEmpty(error)) {
                [NSError checkErrorFromServer:error response:nil];
            }
            else
            {
                [self showHudTextWithErrorMessage:@"转回平台失败!"];
            }
        }
    }];
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AcceptOrdeEntity *entity = [self.dataList objectAtIndex:indexPath.row];

    return [tableView fd_heightForCellWithIdentifier:cellIdentifier cacheByIndexPath:indexPath configuration:^(id cell) {
        [self loadCellContent:cell indexPath:indexPath entity:entity];
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AcceptOrdeEntity *entity = [self.dataList objectAtIndex:indexPath.row];

    return [tableView fd_heightForCellWithIdentifier:cellIdentifier cacheByIndexPath:indexPath configuration:^(id cell) {
        [self loadCellContent:cell indexPath:indexPath entity:entity];
        
    }];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [XKO_CreateUIViewHelper createUIViewWithFrame:CGRectMake(0, 0, kScreenWidth, 11) backgroundColor:kGetColor(243, 245, 249)];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 10.5, kScreenWidth, 0.3)];
    lineView.backgroundColor = UIColorFromRGB(0Xd3d3d3);
    [headerView addSubview:lineView];
    return headerView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 11.;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AcceptOrdeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[AcceptOrdeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    AcceptOrdeEntity *entity = [self.dataList objectAtIndex:indexPath.row];
    
    [self loadCellContent:cell indexPath:indexPath entity:entity];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    WEAK_SELF
    cell.deleteBlock = ^(void) {
        
        if (indexPath.row < weak_self.dataList.count) {
            
            [weak_self.dataList removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
            
            [[DatabaseCache shareInstance] deleteAcceptOrderInfoWithMessageId:entity.message_id];
            [weak_self reFreshNodata];
        }
    };

    return cell;
}

#pragma mark - private methods

- (void)loadCellContent:(UITableViewCell *)cell indexPath:(NSIndexPath*)indexPath entity:(AcceptOrdeEntity *)entity
{
    
    //这里把数据设置给Cell
    if (cell.fd_isTemplateLayoutCell) {
        cell.fd_enforceFrameLayout = YES;
    }
    
    AcceptOrdeCell *weimiCell = (AcceptOrdeCell *)cell;
    [weimiCell setEntity:entity];
    
}


@end
