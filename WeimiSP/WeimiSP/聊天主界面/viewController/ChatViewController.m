//
//  ChatViewController.m
//  weimi
//
//  Created by 鹏 朱 on 16/1/19.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "ChatViewController.h"
#import "AppDelegate.h"
#import "DatabaseCache.h"
#import "ChatViewCell.h"
#import <WEMEFeedcontrollerApi.h>
#import <WEMESimpleMyFeed.h>
#import <IQKeyboardManager.h>
#import <MJRefresh.h>
#import "Message.pb.h"
#import "BaiduLocationManage.h"
#import "SessonContentModel.h"
#import "UIView+Design.h"
#import "UploadFile.h"
#import "PlayerHelper.h"
#import "NSDate+Addition.h"
#import "UITableView+Design.h"
#import "PersonalCenterViewController.h"
#import "PluginComponentTableViewCell.h"
#import "MJRefreshHeader+TriggerAutomaticallyRefresh.h"
#import "ChatViewModel.h"
#import <iflyMSC/iflyMSC.h>
#import "Reachability.h"
#import <WEMETaskcontrollerApi.h>
#import "PopPluginView.h"
#import "VerticallyAlignedLabel.h"
#import "BaiduMapViewController.h"
#import "WEMEProgressHUD.h"
#import "XKO_CreateUIViewHelper.h"
#import "UIApplication+Design.h"

@interface ChatViewController ()
{
    BOOL *_isFrist;
    NSInteger _DelayCount;
    CGFloat   _tableHeight;
    CGFloat   _MaxtableHeight;
    CGRect    _tableOrignalFrame;
    CGRect    _upKearBoardRect;

}

@property (nonatomic, assign) NSTimeInterval lastTimeInterval; //保存最后时间
@property (nonatomic) ChatViewModel *viewModel;
@property (nonatomic) NSTimer *behaviourTimer;
@property (nonatomic,strong) UIView *taskView;
@property (nonatomic,strong) PopPluginView *popPluginView;
@property (nonatomic,strong) UIButton *topBtn;
@property (nonatomic,strong) UIImageView *headerImg;
@property (nonatomic,strong) UILabel *popTitle;
@property (nonatomic,strong) UILabel *popAddress;
@property (nonatomic,strong) UILabel *popContent;
@property (nonatomic,strong) UILabel *address;
@property (strong, nonatomic) UIView *networkStateView;
@property (strong, nonatomic) UIView *mqttStateView;

@end

@implementation ChatViewController

static const NSString *receivingMesaage = @"正在接受消息...";


- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_behaviourTimer invalidate];
    _behaviourTimer = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation !=UIInterfaceOrientationPortraitUpsideDown);
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self addNotification];
    
    self.view.backgroundColor = UIColorFromRGB(0xf1f3f8);
    
    if (IsEmpty(self.taskBO)) {
        [self waitCompleteOrderAPI];
    } else {
        self.channel = [self.taskBO.channelId stringValue];
    }
    
    //调用查看最新消息
    [self _lookUnreadMessage];
    
    [self initUI];
    
    [self bindTableView];

    //初始化数据源
    [self initDataSource];
    [self setNavigationItem];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    _tableHeight = self.tableView.frame.size.height;
    _MaxtableHeight = self.tableView.frame.size.height;
    _tableOrignalFrame = self.tableView.frame;
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.chatBottomView.inputTextField resignFirstResponder];
    kAppDelegate.currentChannel = self.channel;
    [self addKeyboardNotification];
    
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, kScreenHeight - KTextBottomHeight - kNavBarAndStatusBarHeight);
    
    self.behaviourTimer = [NSTimer scheduledTimerWithTimeInterval:30.0 target:self selector:@selector(sendBehaviourMessage) userInfo:nil repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    kAppDelegate.currentChannel = nil;
    if (self.backDeliverMessageBlock) {
        self.backDeliverMessageBlock(self.dataList);
    }
    [self.chatBottomView.inputTextField resignFirstResponder];
    [[PlayerHelper shared] stop];
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [_behaviourTimer invalidate];
    [self removeKeyboardNotification];
}

- (void)setNavigationItem {
    
    [Util setNavigationTranslucentWithVC:self];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithImage:IMAGE(@"chat_message") style:UIBarButtonItemStylePlain target:self action:@selector(pushToPersoncenter)];
    rightButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.title = @"任务进行中";
}

#pragma mark - event action

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (void)pushToPersoncenter
{
    [self.chatBottomView endEditing:YES];
    PopPluginView *popPluginView = [[PopPluginView alloc] initWithPopverView:self.taskView height:kScreenHeight/3];
    self.popPluginView = popPluginView;
    [self.popPluginView show];
    
    [self showPopViewData];
}


- (void)showPopViewData {
    
    [_topBtn setTitle:_taskBO.serviceClassName forState:UIControlStateNormal];
    [_headerImg sd_setImageWithURL:[NSURL URLWithString:_taskBO.member.headImgPath] placeholderImage:IMAGE(@"default_head")];
    _popTitle.text = _taskBO.member.nickname;
    _popContent.text = _taskBO.taskDescription;

    if (IsEmpty(self.taskBO.address)) {
        
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([self.taskBO.lat floatValue], [self.taskBO.lon floatValue]);
        WEAK_SELF
        [[BaiduLocationManage shareManage] setWithCoordinate2D:coordinate withAddress:^(NSString *address) {
            
            weak_self.popAddress.text = address;
        }];
        
    } else {
        _popAddress.text = _taskBO.address;
    }
}

- (void)dismissPluginView {
    
    [self.popPluginView dismiss];
    
}

- (void)waitCompleteOrderAPI
{
    [WEMEProgressHUD showHUDAddedTo:self.view];
    [self.view endEditing:YES];
    
    WEAK_SELF
    [[WEMETaskcontrollerApi sharedAPI] waitCompleteTaskUsingGETWithCompletionBlock:^(WEMESingleResponseOfTaskBO *output, NSError *error) {
        
        if (IsEmpty(error) && output.success.integerValue == YES) {
            
            if (!IsEmpty(output.item)) {
                weak_self.taskBO = output.item;
                weak_self.channel = [weak_self.taskBO.channelId stringValue];
            }
        }
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

/**
 *  IOS7隐藏状态栏
 *
 *  @return 状态栏属性
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

#pragma mark - 调查看新消息接口
-(void)_lookUnreadMessage{
    
    if (!IsEmpty(self.channel)) {
        
        [[WEMEFeedcontrollerApi sharedAPI] updateViewTimeUsingGETWithCompletionBlock:self.channel completionHandler:^(WEMESimpleResponse *output, NSError *error) {
            if (output.success.integerValue == 1 && !output.error) {
                
            }
        }];
    }
}

#pragma mark - private methord

- (void)initDataSource {
    [self.viewModel.initializeDataSourceCommand execute:nil];
}

- (UIView *)taskView {
    
    if (!_taskView) {
        
        _taskView = [XKO_CreateUIViewHelper createUIViewWithFrame:CGRectMake(0, 0, kScreenWidth - 60, 282) backgroundColor:[UIColor whiteColor]];
        _taskView.layer.cornerRadius = 5;
        _taskView.layer.masksToBounds = YES;
        
        UIButton *topBtn = [XKO_CreateUIViewHelper createUIButtonWithFrame:CGRectZero title:@"跑腿" titleColor:[UIColor whiteColor] titleFont:[UIFont CustomFontOfSize:9] backgroundColor:[UIColor clearColor] hasRadius:NO targetSelector:nil target:nil];
        [topBtn setBackgroundImage:IMAGE(@"pao_tui_bg") forState:UIControlStateNormal];
        _topBtn = topBtn;
        [_taskView addSubview:_topBtn];
        
        [_topBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_taskView).with.offset(KTopMargin);
            make.left.equalTo(_taskView);
            make.size.mas_equalTo(CGSizeMake(27, 15));
        }];
        
        UIImageView *headerImg = [XKO_CreateUIViewHelper createUIImageViewWithImage:IMAGE(@"personalCenter_Default")];
        headerImg.layer.cornerRadius = 20.5;
        headerImg.layer.masksToBounds = YES;
        _headerImg = headerImg;
        [_taskView addSubview:_headerImg];
        
        [_headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_topBtn.mas_bottom).with.offset(5);
            make.left.equalTo(_taskView).with.offset(15);
            make.size.mas_equalTo(CGSizeMake(41, 41));
        }];
        
        UILabel *title = [XKO_CreateUIViewHelper createLabelWithFont:kFontSize16 fontColor:[UIColor blackColor] text:@"明天会更好"];
        _popTitle = title;
        [_taskView addSubview:_popTitle];
        
        [_popTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headerImg);
            make.left.equalTo(headerImg.mas_right).with.offset(12);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth/4, 18));
        }];
        
        UIButton *callBtn = [XKO_CreateUIViewHelper createUIButtonWithImageName:@"phone_call"];
        [callBtn addTarget:self action:@selector(phoneCall) forControlEvents:UIControlEventTouchUpInside];
        [_taskView addSubview:callBtn];
        
        [callBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(title.mas_right).with.offset(10);
            make.centerY.equalTo(title);
            make.size.mas_equalTo(CGSizeMake(33, 21));
        }];
        
        UIButton *locationBtn = [XKO_CreateUIViewHelper createUIButtonWithImageName:@"order_location"];
        [locationBtn addTarget:self action:@selector(gotoBaiduMap) forControlEvents:UIControlEventTouchUpInside];
        [_taskView addSubview:locationBtn];
        
        [locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_taskView).with.offset(-15);
            make.centerY.equalTo(headerImg.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(33, 21));
        }];
        
        _address = [XKO_CreateUIViewHelper createLabelWithFont:kFontSize12 fontColor:UIColorFromRGB(0x0c9bdd) text:@"深圳市 南山区 科兴科学园a栋503"];
        _popAddress = _address;
        [_taskView addSubview:_popAddress];
        
        [_popAddress mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(title);
            make.right.equalTo(locationBtn.mas_left).offset(-5);
            make.centerY.equalTo(locationBtn);
        }];
        
        UIView *line = [XKO_CreateUIViewHelper createUIViewWithBackgroundColor:UIColorFromRGB(0xd5d5d5)];
        [_taskView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headerImg.mas_bottom).offset(15);
            make.left.equalTo(headerImg);
            make.right.equalTo(locationBtn);
            make.height.equalTo(@0.5);
        }];
        
        UIButton *slipeBtn = [XKO_CreateUIViewHelper createUIButtonWithImageName:@"order_slipe"];
        [slipeBtn addTarget:self action:@selector(dismissPluginView) forControlEvents:UIControlEventTouchUpInside];
        [_taskView addSubview:slipeBtn];
        
        [slipeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(26, 26));
            make.bottom.equalTo(_taskView).offset(-15);
            make.centerX.equalTo(_taskView);
        }];
        
        VerticallyAlignedLabel *content = [[VerticallyAlignedLabel alloc] initWithFrame:CGRectZero];
        content.textAlignment = NSTextAlignmentLeft;
        content.verticalAlignment = VerticalAlignmentTop;
        content.font = kFontSize14;
        content.textColor = [UIColor blackColor];
        content.text = @"";
        content.numberOfLines = 0;
        
        _popContent = content;
        [_taskView addSubview:_popContent];
        
        [_popContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerImg);
            make.right.equalTo(locationBtn);
            make.top.equalTo(line.mas_bottom).offset(13);
            make.bottom.equalTo(slipeBtn.mas_top).offset(-14.5);
        }];
    }
    
    return _taskView;
}

- (UIView *)networkStateView {
    
    if (!_networkStateView) {
        
        _networkStateView = [XKO_CreateUIViewHelper createUIViewWithFrame:CGRectMake(0, 0, kScreenWidth, 50) backgroundColor:kGetColor(255, 250, 212)];
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
        _networkStateView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(enterIPhoneSetting)];
        [_networkStateView addGestureRecognizer:tap];
    }
    
    return _networkStateView;
}
- (void)enterIPhoneSetting
{
    [[UIApplication sharedApplication] rt_openSettingURL:UIApplicationSettingsURL];
}

- (UIView *)mqttStateView {
    
    if (!_mqttStateView) {
        
        _mqttStateView = [XKO_CreateUIViewHelper createUIViewWithFrame:CGRectMake(0, 0, kScreenWidth, 50) backgroundColor:kGetColor(255, 250, 212)];
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

- (void)bindTableView {
    @weakify(self);
   
    //refactor use RAC
    //command end and refresh UI
//    [[[self.viewModel.initializeDataSourceCommand executionSignals] switchToLatest] subscribeNext:^(id x) {
//        @"";
//    }];
    
    [[[[self.viewModel.pullOfflineMessageCommand executing] skip:1] distinctUntilChanged] subscribeNext:^(NSNumber *x) {
        if (![x boolValue]) {
            [self.tableView reloadData];
            [self.tableView scrollToBottomAnimated:NO];
        }
    }];
    
    [[[[self.viewModel.initializeDataSourceCommand executing] skip:1] distinctUntilChanged] subscribeNext:^(NSNumber *x) {
        if (![x boolValue]) {
            [self.tableView reloadData];
            [self.tableView scrollToBottomAnimated:NO];
            self.tableView.hidden = NO;
        }
    }];
    [[[[self.viewModel.getHistoryCommand executing] skip:1] distinctUntilChanged] subscribeNext:^(NSNumber *x) {
        if (![x boolValue]) {
            @strongify(self);
            self.tableView.header.needAutomaticallyRefresh = NO;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.tableView.header endRefreshing];
            });
            [self.tableView reloadData];
            if (self.viewModel.addMessages.count > 0) {
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.viewModel.addMessages.count inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
                self.viewModel.addMessages = [NSArray array];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.tableView.header.needAutomaticallyRefresh = YES;
            });
        }
    }];
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        [self.viewModel.getHistoryCommand execute:nil];
    }];
    
    self.tableView.header.needAutomaticallyRefresh = YES;
}

- (void)initUI {
    
    self.firstupdate = @0;
    self.page = @0;
    self.datesearch = @0;
    self.dataList = [[NSMutableArray alloc] init];
    self.title = self.userName;

    [self.view addSubview:self.tableView];
    [self.view addSubview:self.chatBottomView];
    [self.view addSubview:self.mqttStateView];
    [self.view addSubview:self.networkStateView];
    
    WEAK_SELF;
    self.chatBottomView.checkChatbottomPosionBlock = ^{
        CGFloat orginalChatBottom = kScreenHeight-kNavBarAndStatusBarHeight-KTextBottomHeight;
        if (weak_self.chatBottomView.y != orginalChatBottom) {
            [UIView animateWithDuration:0.25 animations:^{
                weak_self.tableView.maxY = orginalChatBottom;
            }];
        }
    };

    self.view.backgroundColor = UIColorFromRGB(0xf1f3f8);
    self.tableView.backgroundColor = UIColorFromRGB(0xf1f3f8);
    self.chatBottomView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[ChatViewCell class] forCellReuseIdentifier:@"cellId"];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)removeKeyboardNotification
{
    //注册键盘改变Frame的通知
    [kNotification removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [kNotification removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [kNotification removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)addKeyboardNotification
{
    //注册键盘改变Frame的通知
    [kNotification addObserver:self
                      selector:@selector(keyboardFrameWillChange:)
                          name:UIKeyboardWillChangeFrameNotification object:nil];
    //注册键盘即将弹出的通知
    [kNotification addObserver:self
                      selector:@selector(keyboardDidShowNotification:)
                          name:UIKeyboardWillShowNotification object:nil];
    //注册键盘即将消失的通知
    [kNotification addObserver:self
                      selector:@selector(keyboardWillHideNotification:)
                          name:UIKeyboardWillHideNotification object:nil];
}

- (void)addNotification
{
    //注册消息已经成功接收的通知
    [kNotification addObserver:self selector:@selector(messageIsReached:)
                   name:kNotificationMessageIsReached
                 object:nil];
    //注册收到新消息的通知
    [kNotification addObserver:self selector:@selector(receivewemiNewMessage:)
                   name:kNotificationReceiveNewMessage
                 object:nil];
    [kNotification addObserver:self selector:@selector(receiveBehaviorMessage:) name:kNotificationStatusChanged object:nil];
    [kNotification addObserver:self selector:@selector(DidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    [kNotification addObserver:self selector:@selector(WillResignActive) name:UIApplicationWillResignActiveNotification object:nil];

    //注册网络改变的通知
    [kNotification addObserver:self selector:@selector(receiveNetworkChangedMessage:)
                          name:kNotificationNetworkChangedMessage
                        object:nil];
    [kNotification addObserver:self selector:@selector(receiveMqttStateChangedMessage:)
                          name:kNotificationMqttStateChangedMessage
                        object:nil];
}

- (void)WillResignActive {
    [self removeKeyboardNotification];
}

- (void)DidBecomeActive {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self addKeyboardNotification];
    });
    
    if ([UIApplication sharedApplication].applicationIconBadgeNumber > 0) {
        [self pullOfflineMessage];
    }

}

- (void)updateAvatar {
    
    [self.tableView reloadData];
}

//正在输入状态
- (void)receiveBehaviorMessage:(NSNotification *)notification {
    NSDictionary *chatStatus = notification.userInfo;
    self.title = chatStatus[@"chatStatus"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.title = @"任务进行中";
    });
}

- (void)receivewemiNewMessage:(NSNotification *)notification {
    
    [self _lookUnreadMessage];
    NSDictionary *messageDic = notification.userInfo;
    SessonContentModel *message = [messageDic objectForKey:KMessageParameter];
    
    [self addNewMessageWithMessage:message];
}

- (void)receiveNetworkChangedMessage:(NSNotification *)notification
{
    NSDictionary *messageDic = notification.userInfo;
    NSNumber *hasNetwork = [messageDic objectForKey:KMessageParameter];
    
    [self changeNetworkState:[hasNetwork boolValue]];
}

- (void)receiveMqttStateChangedMessage:(NSNotification *)notification
{
    NSDictionary *messageDic = notification.userInfo;
    NSNumber *hasConnected = [messageDic objectForKey:KMessageParameter];
    
    [self changeMqttState:[hasConnected boolValue]];
}

- (void)changeNetworkState:(BOOL)hasNetwork {
    
    if (hasNetwork && !self.networkStateView.hidden) {
        
        [self.networkStateView setHidden:hasNetwork];
                
    } else if (!hasNetwork && self.networkStateView.hidden) {
        
        [self.networkStateView setHidden:hasNetwork];
        
    }
}

- (void)changeMqttState:(BOOL)hasConnected {
    
    if (hasConnected && !self.mqttStateView.hidden) {
        
        [self.mqttStateView setHidden:hasConnected];
        
    } else if (!hasConnected && self.mqttStateView.hidden) {
        
        [self.mqttStateView setHidden:hasConnected];
        
    }
}

/**
 *  发送消息是否成功回调
 *
 *  @param aNotifacation
 */
- (void)messageIsReached:(NSNotification *)aNotifacation
{
    NSDictionary *reachedDict = aNotifacation.userInfo;
    NSString *channel = reachedDict[@"channel"];
    NSString *localId = reachedDict[@"localId"];//找到对应消息
    NSString *key_id = reachedDict[@"key_id"];//保存id
    NSNumber *time = reachedDict[@"time"];
    [self _lookUnreadMessage];
    [[DatabaseCache shareInstance] updateKeyidWithKeyid:key_id Timestamp:[time stringValue] Channel:channel localid:localId];
    
    WEAK_SELF
    [self.dataList enumerateObjectsUsingBlock:^(SessonContentModel * _Nonnull message, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([message.localId isEqualToString:localId])
        {
            message.key_id = key_id;
            message.contentTimestamp = [time longValue];
            ChatViewCell *cell = [weak_self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]];
            [cell sendSucceedChangeStatus:YES];
            
            //自己发的消息mqtt不发送topic
            if (message.isMyself) {
                message.hasRead = YES;
                NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                NSDictionary *parameterDic = [[NSDictionary alloc] initWithObjectsAndKeys:message,KMessageParameter, nil];
                [center postNotificationName: kNotificationUpdateMessage object:nil userInfo:parameterDic];
            }
            
            *stop = YES;
        }
    }];
}

- (void)keyboardDidShowNotification:(NSNotification *)aNotification
{
    NSDictionary *userInfo = [aNotification userInfo];
    CGRect kbRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]
                     CGRectValue];
    NSString *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    self.chatBottomView.contentBackgroundView.hidden = YES;
    if (kbRect.origin.y < kScreenHeight) {
        CGFloat animationDuration =  duration.doubleValue;
        if (!animationDuration) {
            animationDuration = 0.25;
        }
        [UIView animateWithDuration:animationDuration animations:^{
            CGFloat tableContentHeight = self.tableView.contentSize.height;
            if (self.dataList.count > 0 && kScreenHeight - kbRect.size.height - KTextBottomHeight - 64 < tableContentHeight && kbRect.origin.y > 0) {
                CGFloat tableNewY = 0;
                if (tableContentHeight > _MaxtableHeight) {
                    tableNewY = -kbRect.size.height;
                }else {
                    tableNewY = self.chatBottomView.y - tableContentHeight;
                }
                self.tableView.y = tableNewY;
            }
        }];
    }
}

- (void)keyboardWillHideNotification:(NSNotification *)aNotification {
    
    self.chatBottomView.contentBackgroundView.hidden = NO;
    CGRect endFrame = [[aNotification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (endFrame.origin.y == kScreenHeight) {
        [UIView animateWithDuration:0.25 animations:^{
            self.tableView.frame = _tableOrignalFrame;
        }];
    }

}

- (void)textChangeWillFrame:(CGRect)endFrame animateWithDuration:(CGFloat)duration
{
    CGFloat offsetY = self.tableView.maxY - endFrame.origin.y;
    if (offsetY == 0.0) return;
    [UIView animateWithDuration:duration animations:^{
        self.tableView.y -= offsetY;
    }];
}

- (void)keyboardFrameWillChange:(NSNotification *)aNotification
{
    
    NSDictionary* info = [aNotification userInfo];
    NSString *duration = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    CGRect endFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat bottomViewMinY = endFrame.origin.y - KBottomHeight;
    CGFloat x = (bottomViewMinY - CGRectGetMinY([self.chatBottomView.window convertRect:self.chatBottomView.frame fromView:self.chatBottomView.superview]));
    _upKearBoardRect = endFrame;
    
//    CGFloat tableViewVisibleMaxY = CGRectGetMaxY([self.chatBottomView.window convertRect:[self.tableView cellForRowAtIndexPath:self.tableView.indexPathsForVisibleRows.lastObject].frame fromView:self.tableView]);
//    CGFloat tableViewOffsetY = tableViewVisibleMaxY - bottomViewMinY;
    
    if (x != 0) {
        [UIView animateWithDuration:duration.floatValue animations:^{
            if (x < 0) {
                self.chatBottomView.textBackgroundView.hidden = NO;
                self.chatBottomView.voiceBackgroundView.hidden = YES;
            }
            self.chatBottomView.center = CGPointMake(self.chatBottomView.center.x, self.chatBottomView.center.y + x);
            
//            if (tableViewOffsetY > 0 || (tableViewOffsetY < 0 && self.tableView.y != 0)) {
//                self.tableView.y -= tableViewOffsetY;
//            }
        } completion:^(BOOL finished) {
        }];
    }
}

-(void)tapTabelViewAction
{
    [self.chatBottomView.inputTextField resignFirstResponder];
    [self.chatBottomView initAddBtnHeight];
}

- (void)sendBehaviourMessage {

    BOOL isEditing = self.chatBottomView.inputTextField.isEditing ||
    ((IFlySpeechRecognizer *)[IFlySpeechRecognizer sharedInstance]).isListening;
    if (isEditing) {
//        [kAppDelegate sendMessage:[self createBehaviour]];
    }
}

//打电话
- (void)phoneCall {
    
    if (IsEmpty(_taskBO.member.mobile)) {
        
        UIAlertView *alerView = [[UIAlertView alloc ]initWithTitle:@"提示" message:@"手机号为空!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alerView show];
        
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", _taskBO.member.mobile]]];
    }
    
}

//根据经纬度定位百度地图
- (void)gotoBaiduMap {
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([_taskBO.lat floatValue], [_taskBO.lon floatValue]);
    [self setMapRegionWithCoordinate:coordinate];
    
}

#pragma mark - 传入经纬度,将baiduMapView 锁定到以当前经纬度为中心点的显示区域和合适的显示范围
- (void)setMapRegionWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    [_popPluginView dismiss];
    BaiduMapViewController *mapVC = [[BaiduMapViewController alloc] init];
    mapVC.currentCoordinate = coordinate;
    mapVC.annotationTitle = _address.text;
    [self.navigationController pushViewController:mapVC animated:YES];
}

- (ProtoMessage *)createBehaviour {
    ProtoMessageBuilder *protoMessage = [ProtoMessage builder];
    ProtoMessageContentBuilder *protoMessageContent = [ProtoMessageContent builder];
    [protoMessageContent setContent:@"正在输入中..."];
    [protoMessageContent setCode:@"30001"];
    
    ProtoMessageMessageBuilder *protoMessageMessageBuilder = [ProtoMessageMessage builder];
    [protoMessageMessageBuilder setContent:[protoMessageContent build]];
    [protoMessageMessageBuilder setModel:ProtoMessageModelBehaviour];
    [protoMessage setMessage:[protoMessageMessageBuilder build]];
    
    WEMEConfiguration *config = [WEMEConfiguration sharedConfig];
    [protoMessage setAccessToken:config.credential.accessToken];
    
    return [protoMessage build];
}


// 构造mqtt消息
- (ProtoMessage *)createMessageWithMessageContent:(SessonContentModel *)message
{
    if (message.mqttType == ProtoMessageContentTypeImage || message.mqttType == ProtoMessageContentTypeVoice)
    {
        if (IsEmpty(message.contentUrl)) {
            message.contentUrl = @"http";
        }
    }
    
    ProtoMessageBuilder *protoMessage = [ProtoMessage builder];
    ProtoMessagePointBuilder *point = [ProtoMessagePoint builder];
    CLLocationCoordinate2D location = [[BaiduLocationManage shareManage] currentLocation].location.coordinate;
    [point setX:location.longitude];
    [point setY:location.latitude];
    
    [protoMessage setGeo:[point build]];
    
    ProtoMessageContentBuilder *protoMessageContent = [ProtoMessageContent builder];
    [protoMessageContent setWidth:(int)message.contentWidth];
    [protoMessageContent setHeight:(int)message.contentHeight];
    if (!IsEmpty(message.contentText)) {
        [protoMessageContent setContent:message.contentText];
    }
    if (!IsEmpty(message.contentUrl)) {
        [protoMessageContent setUrl:message.contentUrl];
    }
    if (!IsEmpty(message.contentCode)) {
        [protoMessageContent setCode:message.contentCode];
    }
    if (message.contentDuration > 0) {
        [protoMessageContent setDuration:message.contentDuration];
    }
    [protoMessageContent setMsgtype:message.mqttType];
    
    ProtoMessageMessageBuilder *protoMessageMessageBuilder = [ProtoMessageMessage builder];
    if (!IsEmpty(message.channel)) {
        [protoMessageMessageBuilder setChannel:message.channel];
    }
    if (!IsEmpty(message.key_id)) {
        [protoMessageMessageBuilder setId:message.key_id];
    }
    [protoMessageMessageBuilder setLocalId:[Util createTimeIntervalWithDate:[NSDate date]]];
    if (!IsEmpty(message.uid)) {
        [protoMessageMessageBuilder setUid:message.uid];
    }
    [protoMessageMessageBuilder setContent:[protoMessageContent build]];
    [protoMessageMessageBuilder setModel:(ProtoMessageModel)message.model];
    [protoMessageMessageBuilder setChannel:message.channel];
//    if ([message.msgType isEqualToString:@"SEND"]) {
//        [protoMessageMessageBuilder setMsgType:ProtoMessageMessageTypeSend];
//    } else {
//        [protoMessageMessageBuilder setMsgType:ProtoMessageMessageTypeReceive];
//    }

    [protoMessage setMessage:[protoMessageMessageBuilder build]];
    
    if (!IsEmpty(message.channel)) {
        [protoMessage setBroadcastId:message.channel];
    }
    
    WEMEConfiguration *config = [WEMEConfiguration sharedConfig];
    [protoMessage setAccessToken:config.credential.accessToken];
    
    return [protoMessage build];
    
}

//添加新消息
- (void)addNewMessageWithMessage:(SessonContentModel *)message {
    
    dispatch_async(dispatch_get_main_queue(), ^{
//        self.viewModel.lastTimeInterval = [(SessonContentModel *)[self.dataList lastObject] contentTimestamp];
        if ((message.contentTimestamp - self.viewModel.lastTimeInterval) > (kChatSpacingTime*1000))
            message.isHiddenTime = YES;
        else
            message.isHiddenTime = NO;

        self.viewModel.lastTimeInterval = message.contentTimestamp;
        [self.dataList addObject:message];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataList.count - 1 inSection:0];
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        [self.tableView endUpdates];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        [self _updateTableNewPosionWhileHasNewMessage:message];
    });
}

- (void)pullOfflineMessage {
    [[self.viewModel.initializeDataSourceCommand.executing take:1]subscribeNext:^(NSNumber *x) {
        if (![x boolValue]) {
            [self.viewModel.pullOfflineMessageCommand execute:nil];
        }
    }];
}

#pragma mark - 当发消息或收到消息更新表的位置
-(void)_updateTableNewPosionWhileHasNewMessage:(SessonContentModel *)message{
    
    ChatViewCellFrame *frame = [[ChatViewCellFrame alloc] initWithDateModel:message];
    frame.dataModelType = message.mqttType;
    CGFloat tableContentHeight = self.tableView.contentSize.height + frame.cellHeight;
    if (self.chatBottomView.y < tableContentHeight) {
        if (tableContentHeight > _MaxtableHeight) {
            [UIView animateWithDuration:0.25 animations:^{
                self.tableView.maxY = self.chatBottomView.y;
            }];
        }else {
            CGFloat inputBottonViewY = self.chatBottomView.origin.y;
            if (inputBottonViewY < tableContentHeight) {
                CGFloat detaOfset = inputBottonViewY - tableContentHeight;
                [UIView animateWithDuration:0.25 animations:^{
                    self.tableView.y = detaOfset;
                }];
            }
        }
    }
    
}


- (void)sendMessageWithMessageModel:(SessonContentModel *)model {
    self.tableView.hidden = NO;
    model.channel = self.channel;
    model.contentDuration = model.contentDuration == 0 ? 1 : model.contentDuration;
    model.model = ProtoMessageModelChat;
    model.uid = [kAppDelegate.userInfo.uid stringValue];
    
    ProtoMessage *message = [self createMessageWithMessageContent:model];
    model.localId = message.message.localId;
    model.contentTimestamp = [message.message.localId longLongValue];
    
    if ([model.contentType isEqualToString:@"VOICE"] || [model.contentType isEqualToString:@"IMAGE"]) {
        [self addNewMessageWithMessage:model];
        if ([model.contentUrl isEqualToString:@"http"])
        {
            NSString *messageType = model.contentType;
            if ([model.contentType isEqualToString:@"VOICE"]) {
                messageType = @"AUDIO";
            }
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [[UploadFile shareInstance] uploadImageWithFileName:model.localFileName withType:messageType succeedBlock:^(NSString *url) {
                    model.contentUrl = url;
                    [message.message.content setValue:url forKeyPath:@"url"];
                    [kAppDelegate sendMessage:message];
                    [[DatabaseCache shareInstance] updateInfoErrorWithChannel:model.channel localid:model.localId contentURL:url];
                } failure:^(NSString *failure) { //图片、音频上次失败处理
                    WEAK_SELF
                    [self.dataList enumerateObjectsUsingBlock:^(SessonContentModel * _Nonnull message, NSUInteger idx, BOOL * _Nonnull stop) {
                        if ([message.localId isEqualToString:model.localId])
                        {
                            message.isSendError = YES;
                            ChatViewCell *cell = [weak_self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]];
                            [cell sendSucceedChangeStatus:NO];
                            [[DatabaseCache shareInstance] updateInfoErrorWithChannel:model.channel localid:model.localId isSendError:@"1"];
                            *stop = YES;
                        }
                    }];
                }];
            });
        } else {
            [kAppDelegate sendMessage:message];

        }
    } else {
    
        [self addNewMessageWithMessage:model];
        [kAppDelegate sendMessage:message];
        
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[DatabaseCache shareInstance] addSessonContentInfo:model];
    });
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SessonContentModel *messageItem = [self.dataList objectAtIndex:indexPath.row];
    NSString *type = messageItem.contentType;
    
    static NSString *cellId;

    if ([type isEqualToString:@"TEXT"] || [type isEqualToString:@"IMAGE"] || [type isEqualToString:@"VOICE"]) {
        
        cellId = @"ChatDataModelTypeIdentifier";
        
        ChatViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[ChatViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        cell.dataModelType = messageItem.mqttType;
        cell.messageModel = messageItem;
        cell.indexPath = indexPath;
        
        WEAK_SELF
        cell.resendContentBlock = ^(NSIndexPath *index) {
            [[DatabaseCache shareInstance] deleteInfoWithChannel:messageItem.channel localid:messageItem.localId];
            [weak_self deleteCellWithIndex:index];
            messageItem.isSendError = NO;
            [weak_self sendMessageWithMessageModel:messageItem];
        };
        
        return cell;
    } else if ([type isEqualToString:@"Component"]){
        
        cellId = @"ComponentDataModelTypeIdentifier";
        
        PluginComponentTableViewCell *webCell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!webCell) {
            webCell = [[PluginComponentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            [tableView registerClass:[PluginComponentTableViewCell class] forCellReuseIdentifier:cellId];
        }
        
        [webCell setMessage:messageItem];
        webCell.webFinishLoadBlock = ^(NSString *sizeString, NSString *contentId){
            if (contentId) {
                [tableView updateHeightWithoutReload];
            }
        };
        return webCell;
    } else {
        cellId = @"ChatDataModelTypeIdentifier";
        
        ChatViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[ChatViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        messageItem.contentText = @"当前版本不支持查看此消息，请升级唯秘后查看。";
        cell.dataModelType = ProtoMessageContentTypeText;
        cell.messageModel = messageItem;
        cell.indexPath = indexPath;
        return cell;
    }
}
- (void)deleteCellWithIndex:(NSIndexPath *)index
{
    //删除UI上的cell
    for (NSInteger i = 1; i < self.dataList.count - index.row; i++) {
        NSIndexPath *loopIndex = [NSIndexPath indexPathForRow:index.row+i inSection:index.section];
        ChatViewCell *shopCell = (ChatViewCell *)[self.tableView cellForRowAtIndexPath:loopIndex];
        NSIndexPath *newIndex = [NSIndexPath indexPathForRow:index.row+i-1 inSection:index.section];
        shopCell.indexPath = newIndex;
    }
    [self.dataList removeObjectAtIndex:index.row];
    [self.tableView deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SessonContentModel *message = self.dataList[indexPath.row];
    ChatViewCellFrame *frame = [[ChatViewCellFrame alloc] initWithDateModel:message];
    frame.dataModelType = message.mqttType;
    return frame.cellHeight;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.chatBottomView endEditing:YES];
    [self.chatBottomView initAddBtnHeight];
}

#pragma mark - getter

- (ChatViewModel *)viewModel {
    if (_viewModel != nil) { return _viewModel; }
    _viewModel = [[ChatViewModel alloc] init];
    _viewModel.channel = _channel;
    return _viewModel;
}

- (NSNumber *)firstupdate {
    return self.viewModel.firstupdate;
}

- (NSTimeInterval)lastTimeInterval {
    return self.viewModel.lastTimeInterval;
}

- (NSMutableArray<SessonContentModel *> *)dataList {
    return self.viewModel.dataList;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kScreenHeight - KTextBottomHeight - kNavBarAndStatusBarHeight) style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.hidden = YES;
        tableView.delaysContentTouches = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView setSeparatorInset:UIEdgeInsetsZero];
        tableView.contentOffset = CGPointMake(0, 0);
        tableView.showsVerticalScrollIndicator = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.tableHeaderView = [[UIView alloc ]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        [tableView registerClass:[ChatViewCell class] forCellReuseIdentifier:@"cellId"];
        _tableView = tableView;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTabelViewAction)];
        _tableView.userInteractionEnabled = YES;
        [_tableView addGestureRecognizer:tap];
    }
    
    return _tableView;
}

- (ChatBottomView *)chatBottomView {
    if (!_chatBottomView) {
        
        WEAK_SELF
        _chatBottomView = [[ChatBottomView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - KBottomHeight - kNavBarAndStatusBarHeight, kScreenWidth, KContentBottomHeight) sendMessageBlock:^(NSString *messageText, UploadFileType sendType) {
            
            if (!IsEmpty(messageText)) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    SessonContentModel *model = [[SessonContentModel alloc] init];
                    model.isSendError = !weak_self.networkStateView.isHidden;
                    model.contentText = messageText;
                    model.contentType = @"TEXT";
                    model.msgType = @"SEND";
                    [weak_self sendMessageWithMessageModel:model];
                    
                });
            }
            
        } recordFinishBlock:^(NSTimeInterval time) {
            
            //            [self recordFinishWithTime:time];
            
        } sartIFlySpeechBlock:^(NSString *messageText, NSInteger duration, UploadFileType sendType, NSString *fileUrl, NSString *localFileName, CGSize imageSize) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                SessonContentModel *model = [[SessonContentModel alloc] init];
                model.isSendError = !weak_self.networkStateView.isHidden;
                model.contentDuration = duration;
                model.contentText = messageText;
                model.contentUrl = @"http";
                model.contentWidth = imageSize.width;
                model.contentHeight = imageSize.height;
                model.contentDuration = duration;
                model.localFileName = localFileName;
                model.msgType = @"SEND";
                
                if (sendType == AudioNormalType) {
                    model.contentType = @"TEXT";
                } else if (sendType == UploadFileImageType) {
                    model.contentType = @"IMAGE";
                } else if (sendType == UploadFileAudioType) {
                    model.contentType = @"VOICE";
                } else {
                    model.contentType = @"TEXT";
                }
                [weak_self sendMessageWithMessageModel:model];
                
            });
            
        } addPictureBlock:^(UIImage *selectedImg){
            
        } getChannelBlock:^NSString *{
            
            return weak_self.channel;
        }];
        _chatBottomView.VC = self;
        _chatBottomView.bottomViewHeightChangeBlock = ^(CGRect endFrame, CGFloat duration) {
            [weak_self textChangeWillFrame:endFrame animateWithDuration:duration];
        };
    }
    
    return _chatBottomView;
}

#pragma mark - dyci debug operation
- (void)updateOnClassInjection {
//    self.viewModel.dataList = [NSMutableArray arrayWithObject:self.viewModel.dataList[0]];
    [self.tableView reloadData];
}


@end
