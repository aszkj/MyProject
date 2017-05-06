//
//  WSJSearchListSiftViewController.m
//  jingGang
//
//  Created by thinker on 15/8/4.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJSearchListSiftViewController.h"
#import "PublicInfo.h"
#import "GlobeObject.h"
#import "VApiManager.h"
#import "WSJSiftHeader.h"
#import "WSJSiftRowTableViewCell.h"
#import "WSJSiftListModel.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "WSJEvaluateListViewController.h"

@interface WSJSearchListSiftViewController ()<UITableViewDataSource,UITableViewDelegate>
{
//包邮按钮
    __weak IBOutlet UIButton *_freeShippingBtn;
//有库存按钮
    __weak IBOutlet UIButton *_InventoryBtn;
}
@property (weak, nonatomic  ) IBOutlet UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation WSJSearchListSiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self requestData];
}

- (void)requestData
{
    if (!self.data.count)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestData:) name:@"siftData" object:nil];
    }
    else
    {
        [self.dataSource addObjectsFromArray:self.data];
        _freeShippingBtn.selected = [[self.dataSource lastObject] boolValue];
        _InventoryBtn.selected = [self.dataSource[self.dataSource.count - 2] boolValue];
        [self.tableView reloadData];
    }
}
- (void)requestData:(NSNotification *)noti
{
    self.data = noti.object;
    [self.dataSource addObjectsFromArray:self.data];
    [self.tableView reloadData];
}

- (void) initUI
{
    self.dataSource = [NSMutableArray array];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.sectionHeaderHeight = 44;
    self.tableView.rowHeight = 50;
    [self.tableView registerNib:[UINib nibWithNibName:@"WSJSiftRowTableViewCell" bundle:nil] forCellReuseIdentifier:@"siftCell"];

    //返回上一级控制器按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(btnClick) target:self];

    //进入购物车
    UIButton *button_go = [[UIButton alloc]initWithFrame:CGRectMake(20, 30, 35, __NavScreen_Height-25)];
    [button_go setTitle:@"确定" forState:UIControlStateNormal];
    button_go.titleLabel.font = [UIFont systemFontOfSize:16];
    [button_go setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button_go addTarget:self action:@selector(certainAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barRight = [[UIBarButtonItem alloc]initWithCustomView:button_go];
    self.navigationItem.rightBarButtonItem = barRight;
    //设置背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.dataSource.count > 0)
    {
        return self.dataSource.count - 2;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    WSJSiftListModel *model = self.dataSource[section];
    if (model.isSelectSection)
    {
        return model.data.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSJSiftListModel *model = self.dataSource[indexPath.section];
    WSJSiftRowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"siftCell"];
    cell.nameLabel.text = model.data[indexPath.row];
    if (model.selectRow == indexPath.row)
    {
        [cell selectCellWith:YES];
    }
    else
    {
        [cell selectCellWith:NO];
    }
    return cell;
}
#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    WSJSiftHeader *header = [[NSBundle mainBundle] loadNibNamed:@"WSJSiftHeader" owner:nil options:nil][0];
    header.section = section;
    WSJSiftListModel *model = self.dataSource[section];
    header.titleLabel.text = model.titleName;
    header.selectSection = ^(NSInteger s){
        NSLog(@"%ld",s);
        model.isSelectSection = !model.isSelectSection;
        [tableView reloadData];
    };
    return header;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSJSiftListModel *model = self.dataSource[indexPath.section];
    if (model.selectRow == indexPath.row)
    {
        model.selectRow = -1;
    }
    else
    {
        model.selectRow = indexPath.row;
    }
    NSIndexSet *set = [[NSIndexSet alloc] initWithIndex:indexPath.section];
    [tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
}
//确定事件
- (void) certainAction
{
    NSMutableString *resutStr = [NSMutableString string];
    for (WSJSiftListModel *model in self.dataSource)
    {
        if ([model isKindOfClass:[WSJSiftListModel class]])
        {
            if (model.selectRow != -1)
            {
                [resutStr appendFormat:@"|%@,%@",model.ID,model.data[model.selectRow]];
            }

        }
    }
    NSLog(@"resultData ---- %@",resutStr);
    if (self.siftBlock)
    {
        self.siftBlock(resutStr,_freeShippingBtn.selected,_InventoryBtn.selected,self.dataSource);
        [self.navigationController popViewControllerAnimated:YES];
    }
}
//返回上一级界面
- (void) btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(__MainScreen_Width/2 - 30, __StatusScreen_Height, 60, 40)];
    l.text = @"筛选";
    l.font = [UIFont systemFontOfSize:18];
    l.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = l;
    self.navigationController.navigationBar.translucent = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

//Label单选手势
- (IBAction)RadioTap:(UITapGestureRecognizer *)sender {
    switch (sender.view.tag) {
        case 1000:
            [self RadioAction:_InventoryBtn];
            break;
        case 1001:
            [self RadioAction:_freeShippingBtn];
            break;
        default:
            break;
    }
}
//单选按钮
- (IBAction)RadioAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.dataSource removeLastObject];
    [self.dataSource removeLastObject];
    [self.dataSource addObject:@(_InventoryBtn.selected)];
    [self.dataSource addObject:@(_freeShippingBtn.selected)];
}

@end
