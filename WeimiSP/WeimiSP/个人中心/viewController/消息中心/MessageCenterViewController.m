//
//  MessageCenterViewController.m
//  WeimiSP
//
//  Created by thinker on 16/2/23.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "MessageCenterViewController.h"
#import "MessageCenterTableViewCell.h"


@interface MessageCenterModel : NSObject

@property (nonatomic, assign) MessageCenterType type;
@property (nonatomic, strong) NSString *content;

@property (nonatomic, assign) CGFloat height;

@end

@implementation MessageCenterModel

-(CGFloat)height
{
    if (!_height) {
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont CustomFontOfSize:14]};
        CGRect rect = [_content boundingRectWithSize:CGSizeMake(kScreenWidth - 60, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        _height = 75 + rect.size.height;
        if (_type == MessageCenterTypeCompany)
        {
            _height += 40;
        }
    }
    return _height;
}


@end


@interface MessageCenterViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;


@end

NSString * const messageCenterCell = @"MessageCenterViewController";

@implementation MessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

#pragma mark - 实例化UI
- (void)initUI
{
    self.view.backgroundColor = VCBackgroundColor;
    [self setNavigationItem];
    
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.top.equalTo(@0);
    }];
    
}

- (void)setNavigationItem {
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"清空" style:UIBarButtonItemStylePlain target:self action:@selector(clearMessageAction)];
    rightButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    self.title = @"消息";
}


#pragma mark - getter

-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        
        MessageCenterModel *model = [[MessageCenterModel alloc ]init];
        model.type = MessageCenterTyepPlatform;
        model.content = @"平台消息：对于复杂表达式的宏，可以用全局的func函数代替，比如上面的两个系统判断，可以修改成下面的func对于复杂表达式的宏，可以用全局的func函数代替，比如上面的两个系统判断，可以修改成下面的func杂表达式的宏，可以用全局的func函数代替，比如上面的两个系统判断，可以修改成下面的func";
        MessageCenterModel *model1 = [[MessageCenterModel alloc ]init];
        model1.type = MessageCenterTypeCompany;
        model1.content = @"公司指令：对于复杂表达式的宏，可以用全局的func函数代替，比如上面的两个系统判断，可以修改成下面的func对于复";
        [_dataSource addObject:model1];
        [_dataSource addObject:model];
    }
    return _dataSource;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.bounces = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionHeaderHeight = KLeftMargin;
        _tableView.tableFooterView = [UIView new];
        [_tableView setSeparatorColor:UIColorFromRGB(0xe5e5e5)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[MessageCenterTableViewCell class] forCellReuseIdentifier:messageCenterCell];
    }
    return _tableView;
}


#pragma mark - private methord

-(void)clearMessageAction
{
    NSLog(@"清除消息");
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:messageCenterCell];
    if (indexPath.row < self.dataSource.count)
    {
        MessageCenterModel *model = self.dataSource[indexPath.row];
        [cell CellCustomWithType:model.type WithData:model.content];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.dataSource.count)
    {
        MessageCenterModel *model = self.dataSource[indexPath.row];
        return model.height;
    }
    return 120;
}






@end
