//
//  WeimiMainViewController.m
//  weimi
//
//  Created by ray on 16/1/18.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "WeimiMainViewController.h"
#import "WeimiMainTableViewCell.h"
#import "WemiMainViewModel.h"
#import "WEMEUsercontrollerApi.h"
#import "AppDelegate.h"
#import "PersonalCenterViewController.h"
#import <MJRefresh.h>
#import "ChatViewController.h"
#import "DatabaseCache.h"
#import "BaseTabBarController.h"

@interface WeimiMainViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) UITableView *tableView;
@property (nonatomic) WemiMainViewModel *viewModel;

@end

@implementation WeimiMainViewController

#define tableBackgroundColor UIColorFromRGB(0xf1f3f8)
#define tableViewSectionFooterHeight 13.0
static NSString *cellIdentifier = @"WeimiMainTableViewCell";

-(void)dealloc
{
    [kNotification removeObserver:self];
}
#pragma mark - life cycle
- (void)viewDidLoad {
    [self creatUI];
    [super viewDidLoad];
    [self registNotification];
    [Util setNavigationTranslucentWithVC:self];
    [self initDataSource];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    kAppDelegate.tabBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;

}

- (void)initDataSource {

    @weakify(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.viewModel.initializeDataSourceCommand execute:nil];
    });
    
    [[[self.viewModel.initializeDataSourceCommand executionSignals] switchToLatest] subscribeNext:^(id x) {
        @strongify(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self updateTableViewbackgroundView];
            BOOL shouldHidden = ![self tableView:_tableView numberOfRowsInSection:0] > 0;
            self.tableView.footer.hidden = shouldHidden;
            
            [self refreshWeimiRead];
        });
    }];
}

- (void)registNotification {
    [kNotification addObserver:self selector:@selector(sendNewFeed:) name:kNotificationSendNewMessage object:nil];
    [kNotification addObserver:self selector:@selector(UpadteMessage:) name:kNotificationReceiveNewMessage object:nil];
    [kNotification addObserver:self selector:@selector(UpadteMessage:) name:kNotificationUpdateMessage object:nil];
    [kNotification addObserver:self selector:@selector(receiveNewReplay:) name:kPullMyFeedReplayNotification object:nil];
    [kNotification addObserver:self selector:@selector(sendNewFeed:) name:kPullFeedNotification object:nil];
}

- (void)bindViewModel {
    [super bindViewModel];
    [self bindTableViewModel];
    
    @weakify(self);

//    [[RACObserve(self.viewModel, wemiArray) skip:1] subscribeNext:^(NSArray *data) {
//        
//        @strongify(self);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.tableView reloadData];
//            [self updateTableViewbackgroundView];
//        });
//    }];
    
    [[RACObserve(self.viewModel, addPathArray) skip:1] subscribeNext:^(NSArray *data) {
        if (self.viewModel.insertSection.count > 0) { return; }
        
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView beginUpdates];
            [self.tableView insertRowsAtIndexPaths:data withRowAnimation:UITableViewRowAnimationFade];
            [self updateTableViewbackgroundView];
            [self.tableView endUpdates];
        });
    }];
    
    [[RACObserve(self.viewModel, insertSection) skip:1] subscribeNext:^(id x) {
        
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView beginUpdates];
            [self.tableView insertSections:x withRowAnimation:UITableViewRowAnimationFade];
            if (self.viewModel.addPathArray.count > 0) {
                [self.tableView insertRowsAtIndexPaths:self.viewModel.addPathArray withRowAnimation:UITableViewRowAnimationFade];
            }
            [self updateTableViewbackgroundView];
            [self.tableView endUpdates];
        });
    }];
}

- (void)bindTableViewModel {
    @weakify(self);
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        @strongify(self)
        [self.viewModel.headerRefreshCommand execute:nil];
    }];
    NSMutableArray *pullingImages = [NSMutableArray array];
    for (int i = 0; i < 44; i++) {
        NSString *path = [NSString stringWithFormat:@"loading_000%.2d",i];
        [pullingImages addObject:IMAGE(path)];
    }
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏状态
    header.stateLabel.hidden = YES;
    // 设置普通状态的动画图片
//    [header setImages:idleImages forState:MJRefreshStateIdle];
//    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [header setImages:pullingImages duration:2.0 forState:MJRefreshStatePulling];
//    // 设置正在刷新状态的动画图片
//    [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    // 设置header
    self.tableView.header = header;

    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
        @strongify(self)
        [self.viewModel.footerRefreshCommand execute:nil];
    }];
    // 设置普通状态的动画图片
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [footer setImages:pullingImages duration:2.0 forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    // 隐藏状态
    footer.stateLabel.hidden = YES;
    self.tableView.footer = footer;
    
    [[[self.viewModel.headerRefreshCommand executing] distinctUntilChanged]subscribeNext:^(NSNumber *isExcuting) {
        @strongify(self);
        if (![isExcuting boolValue])
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.tableView.header endRefreshing];
            });
        }
    }];

    [[[self.viewModel.footerRefreshCommand executing] distinctUntilChanged]subscribeNext:^(NSNumber *isExcuting) {
        @strongify(self);
        if (![isExcuting boolValue]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.tableView.footer endRefreshing];
            });
        }
    }];
    
}

#pragma mark - event response

- (void)sendNewFeed:(NSNotification *)aNotification
{
    if (self.viewModel.sendNewFeedCommand == nil) { return;  };
    [self.viewModel.sendNewFeedCommand execute:nil];

}

/**
 *  处理新的主题回复
 */
- (void)receiveNewReplay:(NSNotification *)aNotification
{
    if (self.viewModel.receiveNewReplayCommand == nil) { return;   };
    [self.viewModel.receiveNewReplayCommand execute:nil];
    
    @weakify(self)
    [[[self.viewModel.receiveNewReplayCommand executionSignals] switchToLatest] subscribeNext:^(id x) {
        @strongify(self);
        [self refreshWeimiRead];
    }];

}
/**
 *  处理新的聊天消息
 */
- (void)UpadteMessage:(NSNotification *)aNotification
{
    SessonContentModel *model = aNotification.userInfo[KMessageParameter];
    NSArray<NSIndexPath *> *updatePath = [self.viewModel updateData:model];
    if (updatePath != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadRowsAtIndexPaths:updatePath withRowAnimation:UITableViewRowAnimationNone];
        });
//        [updatePath enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            [self refreshRead:NO AtIndexPath:obj];
//        }];
    } else {
//        [self receiveNewReplay:nil];
    }

    [self refreshWeimiRead];
}

- (void)pushToPersoncenter {

    PersonalCenterViewController *personalCenterVC = [[PersonalCenterViewController alloc] init];
    [self.navigationController pushViewController:personalCenterVC animated:YES];
}

- (void)refreshRead:(BOOL)hasRead AtIndexPath:(NSIndexPath *)indexPath {
    if ([self.viewModel.wemiArray[indexPath.section][indexPath.row] isKindOfClass:[WEMEReply class]]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            WeimiMainTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            cell.hasReadLayer.hidden = hasRead;
        });
    }
}

- (void)refreshWeimiRead {
    dispatch_async(dispatch_get_main_queue(), ^{
        BaseTabBarController *tabBar = (BaseTabBarController *)self.tabBarController;
        tabBar.hiddenWeimiRed = [self.viewModel hasReadAllRepaly];
    });
}

#pragma mark - CustomDelegate


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = self.viewModel.wemiArray[indexPath.section][indexPath.row];
    if ([object isKindOfClass:[WEMEReply class]]) {
        WEMEReply *replay = object;
        replay.readed = [NSNumber numberWithBool:YES];
        ChatViewController *VC = [[ChatViewController alloc] init];
        VC.channel = replay._id;
        [WEMESimpleUser getWithUID:replay.uid completeBlock:^(WEMESimpleUser *user) {
            VC.userName = user.nickname;
        }];
        [self.navigationController pushViewController:VC animated:YES];
        [self refreshRead:YES AtIndexPath:indexPath];
    }
    [self refreshWeimiRead];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:cellIdentifier cacheByIndexPath:indexPath configuration:^(id cell) {
        [self loadCellContent:cell indexPath:indexPath];
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return [tableView fd_heightForCellWithIdentifier:cellIdentifier cacheByIndexPath:indexPath configuration:^(id cell) {
        [self loadCellContent:cell indexPath:indexPath];
        
    }];}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [self tableViewFooterView:section];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_viewModel.wemiArray.count > 0) {
        return ((NSArray *)self.viewModel.wemiArray[section]).count;
    } else {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.wemiArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             cellIdentifier];
    [self loadCellContent:cell indexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)loadCellContent:(UITableViewCell *)cell indexPath:(NSIndexPath*)indexPath
{
    id entity = ((NSArray *)self.viewModel.wemiArray[indexPath.section])[indexPath.row];
    if (cell.fd_isTemplateLayoutCell) {
        cell.fd_enforceFrameLayout = YES;
    }
    //这里把数据设置给Cell
    WeimiMainTableViewCell *weimiCell = (WeimiMainTableViewCell *)cell;
    [weimiCell setEntity:entity];
    weimiCell.deleteBlock = ^() {
        DDLogWarn(@"删除数据:%@",indexPath);
    };
}

#pragma mark - private methods

- (void)setUIAppearance {
    [super setUIAppearance];
    
    [self setNavigationBar];
    [self setNavigationItem];
    [DebugSet setLogger];
    
}

- (void)setNavigationBar {
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    navigationBar.barTintColor = UIColorFromRGB(0x65c577);
}

- (void)setNavigationItem {
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithImage:IMAGE(@"foundAvatar_Main") style:UIBarButtonItemStylePlain target:self action:@selector(pushToPersoncenter)];
    rightButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    self.navigationItem.title = @"唯秘";
}

- (void)creatUI {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.sectionHeaderHeight = 0.1;
    _tableView.estimatedRowHeight = 95.5;
    _tableView.rowHeight = 95.5;
//    self.tableView.fd_debugLogEnabled = YES;
    _tableView.sectionFooterHeight = tableViewSectionFooterHeight;
    _tableView.backgroundView = [self tableViewbackgroundView];
    [_tableView registerClass:[WeimiMainTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)updateTableViewbackgroundView {
    UIView *tableViewbackgroundView = _tableView.backgroundView;
    BOOL shouldHidden = [self tableView:_tableView numberOfRowsInSection:0] > 0;
    [tableViewbackgroundView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.hidden = shouldHidden;
    }];
}

#pragma mark - getters and settters

- (UIView *)tableViewFooterView:(NSInteger)section {
    UIView *footerView = [UIView new];
    footerView.backgroundColor = [UIColor clearColor];

    CALayer *topLine = [CALayer layer];
    CGFloat height = 1.0/([UIScreen mainScreen].scale);
    topLine.frame = CGRectMake(0, -height, kScreenWidth, height);
    topLine.backgroundColor = [[UITableView appearance] separatorColor].CGColor;
    [footerView.layer addSublayer:topLine];
    
    if (section+1 < self.viewModel.wemiArray.count ) {
        CALayer *bottomLine = [CALayer layer];
        bottomLine.frame = CGRectMake(0, tableViewSectionFooterHeight, kScreenWidth, height);
        bottomLine.backgroundColor = [[UITableView appearance] separatorColor].CGColor;
        [footerView.layer addSublayer:bottomLine];
    }

    return footerView;
}

- (WemiMainViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[WemiMainViewModel alloc] init];
    }
    return _viewModel;
}

- (UIView *)tableViewbackgroundView {
    UIView *informView = [UIView new];
    informView.backgroundColor = tableBackgroundColor;
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.numberOfLines = 2;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    NSString *titletext = @"您还没有发布任何话题 \n 请点击屏幕下方按钮发布新话题";
    NSAttributedString *result = [titletext bos_makeString:^(BOStringMaker *make) {
        make.first.substring(@"您还没有发布任何话题", ^{
            make.foregroundColor(UIColorFromRGB(0x969696));
            make.font([UIFont customFontOfSize:16.5]);
        });
        make.first.substring(@"请点击屏幕下方按钮发布新话题", ^{
            make.foregroundColor(UIColorFromRGB(0xcbccce));
            make.font([UIFont customFontOfSize:13.5]);
        });
    }];
    titleLabel.attributedText = result;
    [informView addSubview:titleLabel];
    
    UIImageView *informImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"noData_Main"]];
    [informView addSubview:informImage];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(informView);
    }];
    
    [informImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(informView);
        make.bottom.equalTo(titleLabel.mas_top).with.offset(-12);
    }];
    
    [informView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.hidden = YES;
    }];
    
    return informView;
}

#pragma mark - debug operation
- (void)updateOnClassInjection {
//    [DebugSet showExplor];
    
//    @weakify(self);
//    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        @strongify(self)
//        [self.viewModel.footerRefreshCommand execute:nil];
//    }];
//    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [obj removeFromSuperview];
//    }];
//
//    [self creatUI];
//
    self.tableView.fd_debugLogEnabled = YES;
    [self.tableView reloadData];
//    [[DatabaseCache shareInstance] dropDataBaseWithName:KTableNameOfMyFeedContent];
}

@end
