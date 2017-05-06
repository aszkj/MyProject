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
#import "WEMEMessagecontrollerApi.h"
#import "ChatViewModel.h"
#import <iflyMSC/iflyMSC.h>
#import "Reachability.h"
#import "HelpViewController.h"
#import "UIApplication+Design.h"
#import "UIView+BlockGesture.h"

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
@property (nonatomic) UIView *InfoErrorView;
@property (nonatomic) Reachability *reach;
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
    
    self.channel = @"";
    self.view.backgroundColor = UIColorFromRGB(0xf1f3f8);
    
    //调用查看最新消息
    [self _lookUnreadMessage];
    
    [self initUI];
    
    [self bindTableView];

    //初始化数据源
    [self initDataSource];
    [self setNavigationItem];

    [self initInfo];
    
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
        self.backDeliverMessageBlock(self.viewModel.dataList);
    }
    [self.chatBottomView.inputTextField resignFirstResponder];
    [[PlayerHelper shared] stop];
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [_behaviourTimer invalidate];
    [self removeKeyboardNotification];
}

- (void)setNavigationItem {
    
//    [Util setNavigationTranslucentWithVC:self];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithImage:IMAGE(@"foundAvatar_Main") style:UIBarButtonItemStylePlain target:self action:@selector(pushToPersoncenter)];
    rightButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:IMAGE(@"question") style:UIBarButtonItemStylePlain target:self action:@selector(helpAction)];
    self.title = @"唯秘";
}

#pragma mark - event action

- (void)helpAction {
    HelpViewController *helpVC = [[HelpViewController alloc] init];
    [self.navigationController pushViewController:helpVC animated:YES];
    [helpVC loadUrl:@"http://www.thinker.vc/wemeet.html"];
    helpVC.title = @"帮助";
}

- (void)pushToPersoncenter
{
    PersonalCenterViewController *personCenterVC = [[PersonalCenterViewController alloc] init];
    [self.navigationController pushViewController:personCenterVC animated:YES];
}

- (BOOL)prefersStatusBarHidden {
    return NO;
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
                [NSError checkErrorFromServer:error response:output];
            }
        }];
    }
}

#pragma mark 登陆后对服务端的初始化

- (void)initInfo {
    
    [kAppDelegate uploadApnToken];
    [kAppDelegate uploadPhonesInfo];
    [kAppDelegate initIMServerInfo];
    [kAppDelegate uploadLocationInfo];
    //登录成功
    [kAppDelegate connectToServer];

}

#pragma mark 数据和UI初始化

- (void)initDataSource {
    [self.viewModel.initializeDataSourceCommand execute:nil];
}

#pragma mark 设定聊天界面的UI和数据的逻辑

- (void)bindTableView {
    @weakify(self);
    [[[[self.viewModel.pullOfflineMessageCommand executing] skip:1] distinctUntilChanged] subscribeNext:^(NSNumber *x) {
        if (![x boolValue]) {
            [self.tableView reloadData];
            [self.tableView scrollToBottomAnimated:NO];
            if (!IsEmpty(self.viewModel.addMessages)) {
                
                if ([[UIApplication sharedApplication] applicationIconBadgeNumber] != 0) {
                    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
                }
                self.viewModel.addMessages = [NSArray array];
            }
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
            [self.tableView.header endRefreshing];

            [self.tableView reloadData];
            NSInteger rowIndex = [self.tableView numberOfRowsInSection:0] - self.viewModel.addMessages.count - 1;
            if (!IsEmpty(self.viewModel.addMessages) && rowIndex >= 0) {
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.viewModel.addMessages.count inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
                self.viewModel.addMessages = [NSArray array];
            }

            self.tableView.header.needAutomaticallyRefresh = YES;
        }
    }];
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        self.tableView.header.needAutomaticallyRefresh = NO;
        [self.viewModel.getHistoryCommand execute:nil];
    }];
    
    self.tableView.header.needAutomaticallyRefresh = YES;
}

- (void)initUI {
    
    self.firstupdate = @0;
    self.page = @0;
    self.datesearch = @0;
    self.title = self.userName;

    [self.view addSubview:self.tableView];
    [self.view addSubview:self.chatBottomView];
    [self.view addSubview:self.InfoErrorView];
    
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
    [kNotification addObserver:self selector:@selector(updateAvatar) name:KNotificationUpdateAvatar object:nil];
    [kNotification addObserver:self selector:@selector(DidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    [kNotification addObserver:self selector:@selector(WillResignActive) name:UIApplicationWillResignActiveNotification object:nil];

}

#pragma mark 应用将要进入后台

- (void)WillResignActive {
    [self removeKeyboardNotification];
}

#pragma mark 应用将要进入前台

- (void)DidBecomeActive {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addKeyboardNotification];
    });

    if ([UIApplication sharedApplication].applicationIconBadgeNumber > 0) {
        [self pullOfflineMessage];
    }
    [kAppDelegate uploadLocationInfo];

}

- (void)updateAvatar {
    
    [self.tableView reloadData];
}

- (void)receiveBehaviorMessage:(NSNotification *)notification {
    NSDictionary *chatStatus = notification.userInfo;
    self.title = chatStatus[@"chatStatus"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.title = @"唯秘";
    });
}

- (void)receivewemiNewMessage:(NSNotification *)notification {
    
    [self _lookUnreadMessage];
    NSDictionary *messageDic = notification.userInfo;
    SessonContentModel *message = [messageDic objectForKey:KMessageParameter];
    
    [self addNewMessageWithMessage:message];
}

/**
 *  发送消息是否成功回调
 *
 *  @param aNotifacation
 */
- (void)messageIsReached:(NSNotification *)aNotifacation
{
    NSDictionary *reachedDict = aNotifacation.userInfo;
//    NSString *channel = reachedDict[@"channel"];
    NSString *localId = reachedDict[@"localId"];//找到对应消息
    NSString *key_id = reachedDict[@"key_id"];//保存id
    NSNumber *time = reachedDict[@"time"];
    [self _lookUnreadMessage];
    [[DatabaseCache shareInstance] updateKeyidWithKeyid:key_id Timestamp:[time stringValue] Channel:self.channel localid:localId];
    
    WEAK_SELF
    [self.viewModel.dataList enumerateObjectsUsingBlock:^(SessonContentModel * _Nonnull message, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([message.localId isEqualToString:localId])
        {
            message.key_id = key_id;
            message.contentTimestamp = [time longValue];
            ChatViewCell *cell = [weak_self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]];
            [cell sendSucceedChangeStatus:YES];
            
            //自己发的消息mqtt不发送topic
            if (message.isMyself ) {
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
            if (self.viewModel.dataList.count > 0 && kScreenHeight - kbRect.size.height - KTextBottomHeight - 64 < tableContentHeight && kbRect.origin.y > 0) {
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
    if (self.tableView.contentSize.height - endFrame.origin.y <= 0) return;
    
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


#pragma mark 构造mqtt消息
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
//    if (!IsEmpty(message.channel)) {
//        [protoMessageMessageBuilder setChannel:message.channel];
//    }
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

    [protoMessage setMessage:[protoMessageMessageBuilder build]];
    
    if (!IsEmpty(message.channel)) {
        [protoMessage setBroadcastId:message.channel];
//        [protoMessage setchannel];
    }
    
    WEMEConfiguration *config = [WEMEConfiguration sharedConfig];
    [protoMessage setAccessToken:config.credential.accessToken];
    
    return [protoMessage build];
    
}

//添加新消息
- (void)addNewMessageWithMessage:(SessonContentModel *)message {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if ((message.contentTimestamp - self.viewModel.lastTimeInterval) > (kChatSpacingTime*1000))
            message.isHiddenTime = YES;
        else
            message.isHiddenTime = NO;

        self.viewModel.lastTimeInterval = message.contentTimestamp;
        [self.viewModel.dataList addObject:message];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.viewModel.dataList.count - 1 inSection:0];
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


#pragma mark 显示网络状态异常视图
- (void)showNetNotReachableView {
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground) return;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.InfoErrorView.hidden = NO;
    });
}

#pragma mark 隐藏网络状态异常视图
- (void)hiddenNetNotReachableView {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.InfoErrorView.hidden = YES;
//        [UIView animateWithDuration:0.25 animations:^{
//            self.tableView.frame = _tableOrignalFrame;
//        }];
    });
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

//show message error status and synchronize in database
- (void)sendErrorWithMessageModel:(SessonContentModel *)model {
    model.isSendError = YES;
    ChatViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[self.viewModel.dataList indexOfObject:model] inSection:0]];
    [cell sendSucceedChangeStatus:NO];
    [[DatabaseCache shareInstance] updateInfoErrorWithChannel:model.channel localid:model.localId isSendError:@"1"];
}

- (void)sendMessageWithMessageModel:(SessonContentModel *)model {
    self.tableView.hidden = NO;
    model.channel = self.channel;
    model.contentDuration = model.contentDuration == 0 ? 1 : model.contentDuration;
    model.model = ProtoMessageModelChat;
    
    ProtoMessage *message = [self createMessageWithMessageContent:model];
    model.localId = message.message.localId;
    model.contentTimestamp = [message.message.localId longLongValue];
    //add new message in tableView
    [self addNewMessageWithMessage:model];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[DatabaseCache shareInstance] addSessonContentInfo:model];
    });
    if (!kAppDelegate.hasConnectToIMserver) {
        [self sendErrorWithMessageModel:model];
        return;
    }
    
    if ([model.contentType isEqualToString:@"VOICE"] || [model.contentType isEqualToString:@"IMAGE"]) {
        
        if ([model.contentUrl isEqualToString:@"http"])
        {
            WEAK_SELF;
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [[UploadFile shareInstance] uploadImageWithFileName:model.localFileName withType:model.contentType CompleteBlock:^(NSString *url,NSString *errorDescrition) {
                    if (errorDescrition == nil) {
                        model.contentUrl = url;
                        [message.message.content setValue:url forKeyPath:@"url"];
                        [kAppDelegate sendMessage:message];
                        [[DatabaseCache shareInstance] updateInfoErrorWithChannel:model.channel localid:model.localId contentURL:url];
                    } else {
                        [weak_self sendErrorWithMessageModel:model];
                    }
                }];
            });
        } else {
            [kAppDelegate sendMessage:message];

        }
    } else {
    
        [kAppDelegate sendMessage:message];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel.dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SessonContentModel *messageItem = [self.viewModel.dataList objectAtIndex:indexPath.row];
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
    for (NSInteger i = 1; i < self.viewModel.dataList.count - index.row; i++) {
        NSIndexPath *loopIndex = [NSIndexPath indexPathForRow:index.row+i inSection:index.section];
        ChatViewCell *shopCell = (ChatViewCell *)[self.tableView cellForRowAtIndexPath:loopIndex];
        NSIndexPath *newIndex = [NSIndexPath indexPathForRow:index.row+i-1 inSection:index.section];
        shopCell.indexPath = newIndex;
    }
    [self.viewModel.dataList removeObjectAtIndex:index.row];
    [self.tableView deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SessonContentModel *message = self.viewModel.dataList[indexPath.row];
    ChatViewCellFrame *frame = [[ChatViewCellFrame alloc] initWithDateModel:message];
    frame.dataModelType = message.mqttType;
    return frame.cellHeight;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.chatBottomView.inputTextField resignFirstResponder];
    [self.chatBottomView initAddBtnHeight];
}

#pragma mark - getter

- (ChatViewModel *)viewModel {
    if (_viewModel != nil) { return _viewModel; }
    _viewModel = [[ChatViewModel alloc] init];
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

- (UIView *)InfoErrorView {
    if (_InfoErrorView != nil) { return _InfoErrorView; }
    UIView *informView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 45.0)];
    informView.backgroundColor = UIColorFromRGB(0xFEFAD8);
    NSString *inform = @"当前网络不可用，请检查你的网络设置";
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = inform;
    label.font = [UIFont customFontOfSize:13.0];
    label.textColor = UIColorFromRGB(0x333333);
    
    Reachability *reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    WEAK_SELF;
    reach.reachableBlock = ^(Reachability*reach) {
        [weak_self hiddenNetNotReachableView];
    };
    reach.unreachableBlock = ^(Reachability*reach) {
        label.text = @"当前网络不可用，请检查你的网络设置";
        [weak_self showNetNotReachableView];
    };
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [reach startNotifier];
    });
    
    [informView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [[UIApplication sharedApplication] rt_openSettingURL:UIApplicationSettingsURL];
    }];
    
    [[kAppDelegate rac_signalForSelector:@selector(session:handleEvent:)] subscribeNext:^(RACTuple *tuple) {
        MQTTSessionEvent eventCode = (MQTTSessionEvent)[tuple.second integerValue];
        if (![reach isReachable]) return;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (eventCode != MQTTSessionEventConnected) {
                label.text = @"无法连接到服务器,请检测您的网络";
                [weak_self showNetNotReachableView];
            } else {
                [weak_self hiddenNetNotReachableView];
            }
        });
    }];
    
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"InfoError"]];
    [informView addSubview:image];
    [informView addSubview:label];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(informView).with.offset(12);
        make.centerY.equalTo(informView);
        make.size.mas_equalTo(CGSizeMake(27, 27));
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image.mas_right).with.offset(15);
        make.centerY.equalTo(informView);
    }];
    
    informView.hidden = [reach isReachable];
    _InfoErrorView = informView;
    return _InfoErrorView;
}

- (ChatBottomView *)chatBottomView {
    if (!_chatBottomView) {
        
        WEAK_SELF
        _chatBottomView = [[ChatBottomView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - KBottomHeight - kNavBarAndStatusBarHeight, kScreenWidth, KContentBottomHeight) sendMessageBlock:^(NSString *messageText, UploadFileType sendType) {
            
            if (!IsEmpty(messageText)) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    SessonContentModel *model = [[SessonContentModel alloc] init];
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
//    [self.tableView reloadData];
//    [kAppDelegate disConnect];
    NSURL*url=[NSURL URLWithString:@"prefs:root=FACETIME"];
    url = [NSURL  URLWithString:UIApplicationOpenSettingsURLString];
    if([[UIApplication sharedApplication] canOpenURL:url]){
        [[UIApplication sharedApplication] openURL:url];
    }
}


@end
