//
//  FoundController.m
//  weimi
//
//  Created by 张康健 on 16/1/19.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "FoundController.h"
#import "WEMEFeedcontrollerApi.h"
#import "UIBarButtonItem+WNXBarButtonItem2.h"
#import "PersonalCenterViewController.h"
#import "AppDelegate.h"
#import "FoundCell.h"
#import "ChatViewController.h"
#import "FoundModel.h"
#import "PersonDistributeContentModel.h"
#import "WEMEUsercontrollerApi.h"
#import <MJRefresh.h>
#import "NSObject+MJExtension.h"
#import "UIViewController+SetProjectDefaultAttribute.h"
#import "SessonContentModel.h"
#import "WEMECache.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "BaseTabBarController.h"
#import "FoundDataBaseModel.h"
#import "DatabaseCache.h"
#define userInfoKeySuffix @"--userInfo"
#define foundLasteUpdateKey @"foundLasteUpdateKey"
#define noChatChannel @"nochatChannel"
#define kRequestPageSize 10

static NSString *foundCellID = @"foundCellID";
@interface FoundController ()

@property (nonatomic, strong)UITableView *foundTableView;

@property (nonatomic,strong)YYCache *userCache;

@property (nonatomic,strong)DatabaseCache *foundlistCache;

//数据源
@property (nonatomic,strong)NSMutableArray *dataArr;

//临时数据源
@property (nonatomic,strong)NSMutableArray *tempRequestArr;

//临时离线消息数组
@property (nonatomic,strong)NSMutableArray *tempOfflineMessageArr;


@property (nonatomic,assign)BOOL isAutoFresh;

//当前请求用户信息的请求到达个数
@property (assign)NSInteger requestUserInfoGetCount;

//总共需要请求用户信息个数,列表一级发现用户信息，二级最新消息用户信息，累加
@property (assign)NSInteger needRequestUserInfoCount;

//从第几行进入聊天页面
@property (nonatomic,assign)NSInteger comeToChatPateAtRow;

//聊天channel
@property (nonatomic,copy)NSString *chatChannel;


//请求某个时间戳之前或之后的标志,0表示某个时间戳之前，1表示某个时间戳之后
@property (nonatomic,strong)NSNumber *requestBackOrFrontForTheUpdateTime;

//每次的请求时间戳
@property (nonatomic,strong)NSNumber *requestTimeInterval;

//每次请求后得到的最新的时间戳，也是下次请求最新数据的请求时间戳
@property (nonatomic,strong)NSNumber *lastUpdateTime;

//上拉加载更多，从哪个时间戳开始
@property (nonatomic,strong)NSNumber *requestMoreFromUpdateTime;

//上拉请求更多，现在是第几页
//@property (nonatomic,assign)NSInteger requestMoreFromPage;

//当前从第几页开始请求
@property (nonatomic,assign)NSInteger requestPage;

@end

@implementation FoundController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [Util setNavigationTranslucentWithVC:self];
    
    [self _init];
    
    [self _initTableView];
    
    self.tempOfflineMessageArr = [NSMutableArray arrayWithCapacity:0];
//    [self _requestOffLineMessageRepyFromPage:@(0)];
//    [self performSelector:@selector(_requestOffLineMessageRepyFromPage:) withObject:@(0) afterDelay:10.0];
    
    //监听新消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNewMessage:) name:kNotificationReceiveNewMessage object:nil];
    
    [kNotification addObserver:self selector:@selector(receiveNewReplay:) name:kPullMyReplyNotification object:nil];
    [kNotification addObserver:self selector:@selector(receiveNewFeed:) name:kPullReciveFeedNotification object:nil];
    
    self.requestBackOrFrontForTheUpdateTime = @(0);
//    self.requestTimeInterval = @(0);
    _isAutoFresh = YES;
    [_foundTableView.header beginRefreshing];
    [self _requestData];
    _requestPage = 0;
    
    //先从缓存中取
    [self _getDataFromCache];

}

-(void)_getDataFromCache{

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.dataArr = [self _getFoundCacheList];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.foundTableView reloadData];
        });
    });
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.chatChannel = noChatChannel;
    self.tabBarController.tabBar.hidden = NO;
    self.comeToChatPateAtRow = -1000;
}




-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    NSNumber *lastUpdateTime = nil;
    if (self.dataArr.count > 0) {
        FoundModel *model = self.dataArr.firstObject;
        lastUpdateTime = model.disstributTime;
    }else {
        lastUpdateTime = @0;
    }
    [_userCache setObject:lastUpdateTime forKey:foundLasteUpdateKey];
    

    //缓存发现列表
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self _cacheFoundList];
    });
}

#pragma mark - //////////////////////////---发现列表缓存开始-----/////////////////
#pragma mark - 缓存发现列表
-(void)_cacheFoundList{

    NSMutableArray *cacheList = [NSMutableArray arrayWithCapacity:self.dataArr.count];
    for (FoundModel *foundModel in self.dataArr) {
        [cacheList addObject:[self transfertoDatabaseModelWithFoundModel:foundModel]];
    }
    [_foundlistCache addFoundContentInfoWithArray:cacheList];
}

#pragma mark - 将发现模型转数据库缓存发现模型
-(FoundDataBaseModel *)transfertoDatabaseModelWithFoundModel:(FoundModel *)foundModel {

    FoundDataBaseModel *model = [[FoundDataBaseModel alloc] init];
    model.found_poster_Uid = foundModel.distributePersonID;
    model.found_poster_avartUrl = foundModel.avartUrl;
    model.found_poster_nickName = foundModel.nickName;
    model.found_content_Type = foundModel.personDistributeContentModel.type;
    model.found_content_Text = foundModel.personDistributeContentModel.distributeText;
    model.found_content_ImgUrl = foundModel.personDistributeContentModel.distributePhotoUrl;
    model.found_content_AudioUrl = @"----";
    model.found_hasLatestMessage = foundModel.hasLatestMessage;
    model.found_repy_Type = foundModel.repyLatestMessageModel.typeStr;
    model.found_repy_Text = foundModel.repyLatestMessageModel.latesMessageText;
    model.found_repyer_NickName = foundModel.repyLatestMessageModel.latesMessageUserNickName;
    model.found_repyer_Uid = foundModel.repyLatestMessageModel.latesMessageUserUid;
    model.found_channnel = foundModel.channnel;
    model.found_distanceStr = foundModel.fromRecentDistance;
    model.found_fromWhereTypeStr = foundModel.fromWhereTypeStr;
    model.found_disstributTime = foundModel.disstributTime;
    model.found_hasUnreadMessage = foundModel.hasUnreadMessage;
    
    return model;
}

#pragma mark - 取发现缓存列表
-(NSMutableArray *)_getFoundCacheList{
    NSArray *foundCacheList = [_foundlistCache selectFoundPageSize:10];
    NSMutableArray *foundCacheArr = [NSMutableArray arrayWithCapacity:foundCacheList.count];
    for (FoundDataBaseModel *model in foundCacheList) {
        [foundCacheArr addObject:[self transferToFoundModelWithFoundDatabaseCacheModel:model]];
    }
    return foundCacheArr;
}



#pragma mark - 将数据库缓存模型，转发现模型
-(FoundModel *)transferToFoundModelWithFoundDatabaseCacheModel:(FoundDataBaseModel *)foundDatabaseModel {
    
    FoundModel *foundModel = [[FoundModel alloc] init];
    foundModel.distributePersonID = foundDatabaseModel.found_poster_Uid;
    foundModel.avartUrl = foundDatabaseModel.found_poster_avartUrl;
    foundModel.nickName = foundDatabaseModel.found_poster_nickName;
    
    foundModel.disstributTime = foundDatabaseModel.found_disstributTime;
    foundModel.fromWhereTypeStr = foundDatabaseModel.found_fromWhereTypeStr;
    foundModel.fromRecentDistance =foundDatabaseModel.found_distanceStr;
    foundModel.channnel = foundDatabaseModel.found_channnel;
    foundModel.hasUnreadMessage = foundDatabaseModel.found_hasUnreadMessage;

    //发现自己发布的内容模型生成
    PersonDistributeContentModel *contentModel = [[PersonDistributeContentModel alloc] init];
    contentModel.distributeText = foundDatabaseModel.found_content_Text;
    contentModel.type = foundDatabaseModel.found_content_Type;
    contentModel.distributePhotoUrl = foundDatabaseModel.found_content_ImgUrl;
    if (contentModel.distributePhotoUrl.length > 5) {
        contentModel.distributePhotoUrlArr = @[contentModel.distributePhotoUrl];
    }
    foundModel.personDistributeContentModel = contentModel;
    
    CGFloat latestMessageContentHeight = 0.0;
    if (foundDatabaseModel.found_hasLatestMessage) {//有最新消息
        foundModel.hasLatestMessage = YES;
        //最新回复消息模型
        RepyLatestMessageModel *latestMessageModel = [[RepyLatestMessageModel alloc] init];
        latestMessageModel.typeStr = foundDatabaseModel.found_repy_Type;
        latestMessageModel.latesMessageText = foundDatabaseModel.found_repy_Text;
        latestMessageModel.latesMessageUserUid = foundDatabaseModel.found_repyer_Uid;
        latestMessageModel.latesMessageUserNickName = foundDatabaseModel.found_repyer_NickName;
        foundModel.repyLatestMessageModel = latestMessageModel;
        latestMessageContentHeight = latestMessageModel.totalSize.height;
        
    }else {
        foundModel.hasLatestMessage = NO;
    }
    
    
    foundModel.contentHeight = 64 + contentModel.contentHeight + 5 + latestMessageContentHeight + 5 + 10;

    return foundModel;
}
#pragma mark - //////////////////////////---发现列表缓存结束-----/////////////////



- (void)_initTableView {

    _foundTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    _foundTableView.delegate = self;
    _foundTableView.dataSource = self;
    _foundTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_foundTableView];
    [_foundTableView registerClass:[FoundCell class] forCellReuseIdentifier:foundCellID];
    
    //上下拉刷新
    _foundTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (!_isAutoFresh) {
            self.requestPage = 0;
            //下拉刷新
            [self _requestLatestDataConfigure];
            [self _requestData];
            [_foundTableView.footer resetNoMoreData];
        }
    }];
    
    _foundTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
    
        //上拉加载更多
        [self _requestMoreDataConfigure];
        [self _requestData];
        
    }];
    _foundTableView.backgroundColor = kGetColor(241, 243, 248);
}

#pragma mark - 请求最新数据配置
-(void)_requestLatestDataConfigure {
    
    if (!self.dataArr.count) {
        return;
    }
    
    FoundModel *model = self.dataArr.firstObject;
    self.requestTimeInterval = @(model.disstributTime.integerValue+2000);
    self.requestBackOrFrontForTheUpdateTime = @(0);
}

#pragma mark - 请求更多数据配置
-(void)_requestMoreDataConfigure {
    if (!self.dataArr.count) {
        return;
    }
    FoundModel *model = self.dataArr.lastObject;
    self.requestTimeInterval = model.disstributTime;
    self.requestBackOrFrontForTheUpdateTime = @(1);
}


- (void)_init {
    _requestUserInfoGetCount = 0;
    _requestPage = 0;
    _userCache = [WEMECache userCache];
    _foundlistCache = [DatabaseCache shareInstance];
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x65c577);
    [Util setWemiWhiteTitle:@"发现" ofVC:self];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithImage:IMAGE(@"foundAvatar_Main") style:UIBarButtonItemStylePlain target:self action:@selector(pushToPersoncenter)];
    rightButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    
    if (![_userCache containsObjectForKey:foundLasteUpdateKey]) {
        self.requestTimeInterval = @(0);
    }else {
//        self.requestTimeInterval = (NSNumber *)[_userCache objectForKey:foundLasteUpdateKey];
        self.requestTimeInterval = @(0);
    }
    
    [RACObserve(self, dataArr) subscribeNext:^(NSArray *foundArr) {
       
        [self _setRedNodeByMessageArr:foundArr];
        
    }];
}

#pragma mark - 请求离线回复
-(void)_requestOffLineMessageRepyFromPage:(NSNumber *)fromPage {

    [[WEMEFeedcontrollerApi sharedAPI] findUnPullMyReplyUsingGETWithCompletionBlock:@(0) page:fromPage completionHandler:^(WEMEPageResponseOfReply *output, NSError *error) {
        if (output.page.content.count > 0) {
            NSLog(@"离线回复 %@",output);
            [self _dealWithTheOfflineMessages:output.page.content];
            if (output.page.content.count == kRequestPageSize) {
                [self _requestOffLineMessageRepyFromPage:@(fromPage.integerValue+1)];
            }
        }
    
    }];
}

#pragma mark - 处理离线消息
-(void)_dealWithTheOfflineMessages:(NSArray *)tempOffLineMessages {
    
    if (tempOffLineMessages.count > 0) {
        [self.tempOfflineMessageArr addObjectsFromArray:tempOffLineMessages];
        if (tempOffLineMessages.count < kRequestPageSize) {//最后一页，开始处理
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                
                NSMutableArray *tempWillRefreshArr = [NSMutableArray arrayWithCapacity:self.tempOfflineMessageArr.count];
                for (WEMEReply *repyModel in self.tempOfflineMessageArr) {
                    WEMEReply *repModel = [[WEMEReply alloc] initWithString:repyModel.toJSONString error:nil];
                    
                    NSInteger hasOffmessageRow = [self chatRowByChannel:repModel._id];
                    if (hasOffmessageRow != -1000) {
                        //重新赋值foudModel
                        FoundModel *foundModel = self.dataArr[hasOffmessageRow];
                        foundModel.hasUnreadMessage = !repModel.readed.integerValue;
                        foundModel.hasLatestMessage = YES;
                        NSString *repyNickName = @"";
                        repyNickName = [repModel.snapshot.uid isEqualToString:repModel.fuid] ? foundModel.nickName : @"我";
                        foundModel.repyLatestMessageModel.latesMessageUserNickName = repyNickName;
                        
//                        foundModel.repyLatestMessageModel.typeStr = repModel.snapshot.content.type;
//                        foundModel.repyLatestMessageModel.latesMessageText = repModel.snapshot.content.text;
                        
                        foundModel.contentHeight = 64 + foundModel.personDistributeContentModel.contentHeight + 5 + foundModel.repyLatestMessageModel.totalSize.height + 5 + 10;
                        
                        NSIndexPath *hasMessageIndexPath = [NSIndexPath indexPathForRow:hasOffmessageRow inSection:0];
                        [tempWillRefreshArr addObject:hasMessageIndexPath];
                    }
                    
                }
                
                if (tempWillRefreshArr.count > 0) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{

                        [self.foundTableView reloadRowsAtIndexPaths:tempWillRefreshArr withRowAnimation:UITableViewRowAnimationNone];
                        
                    });
                }
                
            });
            
        }
    }
}



- (void)_requestData {
    
    [[WEMEFeedcontrollerApi sharedAPI] reciveFeedUsingGETWithCompletionBlock:self.requestTimeInterval page:@(0) datesearch:self.requestBackOrFrontForTheUpdateTime completionHandler:^(WEMEPageResponseOfSimpleFeed *output, NSError *error) {
        
        NSLog(@"content %@",output);
        //处理错误
        [self dealWeimiError:error];
        
        //处理上下拉刷新结束
        [self _dealTableFreshEndWithArr:output.page.content];
        
        if (!output.page.content.count) {
            return ;
        }
        
        self.tempRequestArr = [NSMutableArray arrayWithCapacity:output.page.content.count];
        for (WEMESimpleFeed *model in output.page.content) {
            WEMESimpleFeed *feedModel = [[WEMESimpleFeed alloc] initWithString:model.toJSONString error:nil];
            //发现cell模型生成
            FoundModel *foundModel = [[FoundModel alloc] init];
            foundModel.distributePersonID = feedModel.uid;
            foundModel.disstributTime = feedModel.timestamp;
            foundModel.fromWhereTypeStr = feedModel.relationship.nodeType;

//            foundModel.fromRecentDistance =[Util transferDistanceStrWithDistance:@(feedModel.relationship.text.floatValue)];
            foundModel.fromRecentDistance =feedModel.relationship.text;
            foundModel.channnel = feedModel.channel;
            foundModel.hasUnreadMessage = !feedModel.readed.integerValue;
            
            //发现自己发布的内容模型生成
            PersonDistributeContentModel *contentModel = [[PersonDistributeContentModel alloc] init];
//            contentModel.distributeText = feedModel.content.text;
//            contentModel.type = feedModel.content.type;
            contentModel.distributePhotoUrl = feedModel.content.url;
            if (contentModel.distributePhotoUrl) {
                if ([contentModel.distributePhotoUrl rangeOfString:@"fid"].length > 0) {
                    NSDictionary *urlDic = (NSDictionary *)[contentModel.distributePhotoUrl JSONObject];
                    contentModel.distributePhotoUrl = urlDic[@"url"];
                }
                
                contentModel.distributePhotoUrlArr = @[contentModel.distributePhotoUrl];
            }
            foundModel.personDistributeContentModel = contentModel;
            
            CGFloat latestMessageContentHeight = 0.0;
            if (feedModel.snapshot) {//有最新消息
                foundModel.hasLatestMessage = YES;
                //最新回复消息模型
                RepyLatestMessageModel *latestMessageModel = [[RepyLatestMessageModel alloc] init];
//                latestMessageModel.typeStr = feedModel.snapshot.content.type;
//                latestMessageModel.latesMessageText = feedModel.snapshot.content.text;
                latestMessageModel.latesMessageUserUid = feedModel.snapshot.uid;
                foundModel.repyLatestMessageModel = latestMessageModel;
                latestMessageContentHeight = latestMessageModel.totalSize.height;

            }else {
                foundModel.hasLatestMessage = NO;
            }
            
            
            foundModel.contentHeight = 64 + contentModel.contentHeight + 5 + latestMessageContentHeight + 5 + 10;
        
            [_tempRequestArr addObject:foundModel];
        }
        
//        if (!_requestPage) {//下拉
//            self.dataArr = _tempRequestArr;
//        }else{
//            [self.dataArr addObjectsFromArray:_tempRequestArr];
//        }
        if (_isAutoFresh) {
//            [self.dataArr addObjectsFromArray:_tempRequestArr];
            self.dataArr = _tempRequestArr;
            _isAutoFresh = NO;
        }else {
            if (self.requestBackOrFrontForTheUpdateTime.integerValue) {
                [self.dataArr addObjectsFromArray:_tempRequestArr];
                
            }else {
                [self.dataArr insertObjects:_tempRequestArr atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, _tempRequestArr.count)]];
            }
        }
        
        
//        FoundModel *firstModel = self.dataArr.firstObject;
//        self.lastUpdateTime = firstModel.disstributTime;
        
        _requestPage ++;
        
        NSInteger latesteMessageNeedRequestUserInfoCount = 0;
        NSInteger foundTopicNeedRequestUserInfoCount = 0;
        //请求每个cell里面的用户信息
        for (int i=0; i<_tempRequestArr.count; i++) {
            FoundModel *model = _tempRequestArr[i];
            if (model.hasLatestMessage) {
                if (![self _hasUserCacheWithUserId:model.repyLatestMessageModel.latesMessageUserUid foundModel:model isLatestRepy:YES]) {//没有有缓存
                    latesteMessageNeedRequestUserInfoCount ++;
                    [self _requestUserInfoWithID:@(model.repyLatestMessageModel.latesMessageUserUid.integerValue) atIndex:i isLatestMessageRequestUserInfo:YES];
                }
            
            }
            if (![self _hasUserCacheWithUserId:model.distributePersonID foundModel:model isLatestRepy:NO]) {
                [self _requestUserInfoWithID:@(model.distributePersonID.integerValue) atIndex:i isLatestMessageRequestUserInfo:NO];
                foundTopicNeedRequestUserInfoCount ++;
            }
        }
        
//        self.needRequestUserInfoCount = _tempRequestArr.count + latesteMessageNeedRequestUserInfoCount;
        self.needRequestUserInfoCount = latesteMessageNeedRequestUserInfoCount + foundTopicNeedRequestUserInfoCount;
        if (!self.needRequestUserInfoCount) {//不需再请求用户信息
            [self.foundTableView reloadData];
        }
    }];
}

#pragma mark - 根据当前发现数组未读主题或消息设置底部红点
-(void)_setRedNodeByMessageArr:(NSArray *)messageArr {
    
    NSInteger unReadMessageOrTopicCount = [self _backUnreadMessageOrTopicCountOfMessageArr:messageArr];
    BaseTabBarController *tabBar = (BaseTabBarController *)self.tabBarController;
    tabBar.hiddenFindRed = unReadMessageOrTopicCount ? NO : YES;
}


-(BOOL)_hasUserCacheWithUserId:(NSString *)userId foundModel:(FoundModel *)model isLatestRepy:(BOOL)islatestRepy {
    
    userId = [userId stringByAppendingString:userInfoKeySuffix];
    if ([_userCache containsObjectForKey:userId]) {
        WEMESingleObjectValueResponseOfSimpleUser *user = (WEMESingleObjectValueResponseOfSimpleUser *)[_userCache objectForKey:userId];
        if (islatestRepy) {//最新消息里面的回复用户
//            model.repyLatestMessageModel.latesMessageUserNickName = user.item.nickname;
            [self _assignLatestMessageNickName:user.item.nickname forFoundModel:model];
        }else {//发话题的用户
            model.nickName = user.item.nickname;
            model.avartUrl = user.item.avatar;
        }
        return YES;
    }else {
        return NO;
    }
}

#pragma mark - 给最新消息的昵称赋值,可能是自己，可能是发话题的人
-(void)_assignLatestMessageNickName:(NSString *)nickName forFoundModel:(FoundModel *)model {

    if ([model.repyLatestMessageModel.latesMessageUserUid isEqualToString:model.distributePersonID]) {//发话题的人回复的
        model.repyLatestMessageModel.latesMessageUserNickName = nickName;
    }else{
        model.repyLatestMessageModel.latesMessageUserNickName = @"我";
    }
}


#pragma mark - 处理表的上下拉刷新结束
-(void)_dealTableFreshEndWithArr:(NSArray *)dataArr {
    if (_isAutoFresh) {
        [_foundTableView.header endRefreshing];
//        _isAutoFresh = NO;
    }else{
        if (self.requestBackOrFrontForTheUpdateTime.integerValue) {
            if (!dataArr.count) {
                [_foundTableView.footer endRefreshingWithNoMoreData];
            }else{
                [_foundTableView.footer endRefreshing];
            }
        }else{
            [_foundTableView.header endRefreshing];
        }
    }
}




#pragma mark - 请求用户信息,两种方式，列表一级发现，列表二级最新消息
-(void)_requestUserInfoWithID:(NSNumber *)userID atIndex:(NSInteger)index isLatestMessageRequestUserInfo:(BOOL)isLatestMessageRequestUserInfo{

    [[WEMEUsercontrollerApi sharedAPI] getUserProfileUsingGETWithCompletionBlock:userID completionHandler:^(WEMESingleObjectValueResponseOfSimpleUser *output, NSError *error) {
        FoundModel *model = _tempRequestArr[index];
        if (isLatestMessageRequestUserInfo) {//最新消息请求
//            model.repyLatestMessageModel.latesMessageUserNickName = output.item.nickname;
            [self _assignLatestMessageNickName:output.item.nickname forFoundModel:model];
        }else {//列表一级发现请求
            model.avartUrl = output.item.avatar;
            model.nickName = output.item.nickname;
            [self _cacheUserInfo:output byUserId:userID.stringValue];
        }
        _requestUserInfoGetCount ++;
        //缓存用户信息
//        [self _cacheUserInfo:output byUserId:userID.stringValue];
        if (_requestUserInfoGetCount == self.needRequestUserInfoCount) {//所有用户信息请求完
            _requestUserInfoGetCount = 0;
            [self.foundTableView reloadData];
        }
    }];
}

#pragma mark - 缓存用户信息
- (void)_cacheUserInfo:(WEMESingleObjectValueResponseOfSimpleUser *)userInfo byUserId:(NSString *)userId{
    
    //加后缀防止其他地方根据这个id缓存了对象
    userId = [userId stringByAppendingString:userInfoKeySuffix];
   [_userCache containsObjectForKey:userId withBlock:^(NSString *key, BOOL contains) {
       if (!contains) {
           [_userCache setObject:userInfo forKey:userId];
       }
   }];
    
}


#pragma mark - 进入聊天页面
-(void)_comtotoChatPageAtIndexPath:(NSIndexPath *)indexPath {

    FoundModel *model = self.dataArr[indexPath.row];
    ChatViewController *chatVC = [[ChatViewController alloc] init];
    WEAK_SELF;
    chatVC.backDeliverMessageBlock = ^(NSArray *messageArr){
        
        [weak_self _chatPageBackDealtheMessage:messageArr];
        [weak_self _setRedNodeByMessageArr:self.dataArr];
    };
    chatVC.hidesBottomBarWhenPushed = YES;
    self.chatChannel = model.channnel;
    chatVC.channel = model.channnel;
    chatVC.userName = model.nickName;
    [self.navigationController pushViewController:chatVC animated:YES];
    
}

#pragma mark - 返回发现数组中未读消息
-(NSInteger)_backUnreadMessageOrTopicCountOfMessageArr:(NSArray *)foundMessageArr {
    
    NSInteger unreadMessageOrFoundCount = 0;
    for (FoundModel *foundModel in foundMessageArr) {
        if (foundModel.hasUnreadMessage) {
            unreadMessageOrFoundCount ++;
        }
    }
    return unreadMessageOrFoundCount;
}


-(void)_chatPageBackDealtheMessage:(NSArray *)messageArr {

    NSInteger chatRow = [self chatRowByChannel:self.chatChannel];
    if (chatRow == -1000) {
        return;
    }
    FoundModel *foundModel = self.dataArr[chatRow];
    foundModel.hasUnreadMessage = NO;
    if (messageArr.count > 0) {
        foundModel.hasLatestMessage = YES;
        SessonContentModel *messageModel = (SessonContentModel *)messageArr.lastObject;
        //最新回复消息模型
        RepyLatestMessageModel *latestMessageModel = [[RepyLatestMessageModel alloc] init];
        latestMessageModel.typeStr = messageModel.contentType;
        latestMessageModel.latesMessageText = messageModel.contentText;
        if ([messageModel.msgType isEqualToString:@"SEND"]) {//我自己的消息
            latestMessageModel.latesMessageUserNickName = @"我";
        }else{
            latestMessageModel.latesMessageUserNickName = foundModel.nickName;
        }

        foundModel.repyLatestMessageModel = latestMessageModel;
        foundModel.contentHeight = 64 + foundModel.personDistributeContentModel.contentHeight + 5 + latestMessageModel.totalSize.height + 5 + 10;
    }
    NSIndexPath *chatBackIndexPath = [NSIndexPath indexPathForRow:chatRow inSection:0];
    [self.foundTableView reloadRowsAtIndexPaths:@[chatBackIndexPath] withRowAnimation:UITableViewRowAnimationFade];
}

-(NSInteger)chatRowByChannel:(NSString *)chatChannel {

    for (NSInteger row=0; row<self.dataArr.count; row ++) {
        FoundModel *model = self.dataArr[row];
        if ([model.channnel isEqualToString:chatChannel]) {
            return row;
            break;
        }
    }
    return -1000;
}

#pragma mark ----------------------- tableView delegate&datasource Method -----------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataArr.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FoundCell *cell = [tableView dequeueReusableCellWithIdentifier:foundCellID forIndexPath:indexPath];
    
    FoundModel *model = self.dataArr[indexPath.row];
    cell.foundModel = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FoundModel *model = self.dataArr[indexPath.row];
    return model.contentHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
      self.comeToChatPateAtRow = indexPath.row;
      [self _comtotoChatPageAtIndexPath:indexPath];
      [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark ----------------------- 监听消息 Method -----------------------
- (void)didReceiveNewMessage:(NSNotification *)notification {
    
    NSDictionary *messageDic = notification.userInfo;
    //KMessageParameter
    SessonContentModel *messageModel = messageDic[KMessageParameter];
    
    [self _refreshTableWithMessageModel:messageModel];
}

- (void)receiveNewFeed:(NSNotification *)notification {
//    _requestPage = 0;
    [self _requestLatestDataConfigure];
    [self _requestData];
}

- (void)receiveNewReplay:(NSNotification *)notification {

    [[WEMEFeedcontrollerApi sharedAPI] findUnPullMyReplyUsingGETWithCompletionBlock:@(0) page:@(0) completionHandler:^(WEMEPageResponseOfReply *output, NSError *error) {
        
        NSLog(@"发现回复 %@",output);
        
    }];
}

#pragma mark - 处理消息
-(void)_refreshTableWithMessageModel:(SessonContentModel *)messageModel {
    if (!messageModel) {
        return;
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSIndexPath *receiveMessageIndexPath = nil;
        for (NSInteger i=0; i<self.dataArr.count; i++) {
            FoundModel *foundModel = self.dataArr[i];
            if ([foundModel.channnel isEqualToString:messageModel.channel]) {
                receiveMessageIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
                foundModel.hasUnreadMessage = YES;
                foundModel.hasLatestMessage = YES;
                foundModel.repyLatestMessageModel.latesMessageUserNickName = foundModel.nickName;
                foundModel.repyLatestMessageModel.typeStr = messageModel.contentType;
                foundModel.repyLatestMessageModel.latesMessageText = messageModel.contentText;
                
                foundModel.contentHeight = 64 + foundModel.personDistributeContentModel.contentHeight + 5 + foundModel.repyLatestMessageModel.totalSize.height + 5 + 10;
                
                break;
            }
        }
        
        if (receiveMessageIndexPath == nil) return;
        dispatch_async(dispatch_get_main_queue(), ^{
            FoundModel *model = self.dataArr[receiveMessageIndexPath.row];
            if (![self.chatChannel isEqualToString:model.channnel] && receiveMessageIndexPath != nil) {
                [self.foundTableView beginUpdates];
                [self.foundTableView reloadRowsAtIndexPaths:@[receiveMessageIndexPath] withRowAnimation:UITableViewRowAnimationFade];
                [self.foundTableView endUpdates];
                [self _setRedNodeByMessageArr:self.dataArr];
            }
        });

    });
}

#pragma mark ----------------------- Action Method -----------------------
- (void)pushToPersoncenter {
    
    PersonalCenterViewController *personCenterVC = [[PersonalCenterViewController alloc] init];
    [self.navigationController pushViewController:personCenterVC animated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
