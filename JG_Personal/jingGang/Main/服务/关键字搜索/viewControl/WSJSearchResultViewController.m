//
//  WSJSearchResultViewController.m
//  jingGang
//
//  Created by thinker on 15/8/4.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJSearchResultViewController.h"
#import "PublicInfo.h"
#import "Masonry.h"
#import "VApiManager.h"
#import "WSJSearchListSiftViewController.h"
#import "GlobeObject.h"
#import "WSJManagerAddressViewController.h"
#import "WSJKeySearchViewController.h"
#import "CollectionShopsViewController.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "KJGoodsDetailViewController.h"
#import "KJShoppingAlertView.h"

@interface WSJSearchResultViewController ()<UITextFieldDelegate>
{
    VApiManager *_vapManager;
}
@property (nonatomic, strong) commodityListView *listView;
@property (weak, nonatomic  ) IBOutlet UIView   *contentView;
@property (nonatomic, strong) UITextField       *SearchContentTextField;

@end

@implementation WSJSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
//初始化UI
- (void) initUI
{
    _vapManager = [[VApiManager alloc] init];
    self.SearchContentTextField = [[UITextField alloc]initWithFrame:CGRectMake(__MainScreen_Width/2 - 100, __StatusScreen_Height + 5 , 200, 30)];
    self.SearchContentTextField.placeholder = @"请输入您感兴趣的商品";
    self.SearchContentTextField.delegate = self;
    self.SearchContentTextField.font = [UIFont systemFontOfSize:15];
    self.SearchContentTextField.text = self.keyword;
    self.SearchContentTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.SearchContentTextField.returnKeyType = UIReturnKeySearch;
    self.SearchContentTextField.textColor = [UIColor whiteColor];
    self.SearchContentTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.SearchContentTextField.backgroundColor = UIColorFromRGB(0X42aad6);
    if (self.type == classSearch)
    {
        UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(__MainScreen_Width/2 - 30, __StatusScreen_Height, 60, 40)];
        l.text = @"商品列表";
        l.font = [UIFont systemFontOfSize:18];
        l.textColor = [UIColor whiteColor];
        self.navigationItem.titleView = l;
    }
    else
    {
        self.navigationItem.titleView = self.SearchContentTextField;
        //点击搜索按钮
        UIButton *button_search = [[UIButton alloc]initWithFrame:CGRectMake(20, 30, 40, __NavScreen_Height-15)];
        [button_search setTitle:@"搜索" forState:UIControlStateNormal];
        [button_search addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithCustomView:button_search];
        self.navigationItem.rightBarButtonItem = rightBar;
    }
    //返回上一级控制器按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(btnClick) target:self];

    //设置背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    _listView = [[NSBundle mainBundle] loadNibNamed:@"commodityListView" owner:nil options:nil][0];
    _listView.type = self.type;
    _listView.ID = self.ID;
    _listView.keyword = self.keyword;
    [_listView reloadData];
    [self.contentView addSubview:_listView];
    WEAK_SELF
    [_listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weak_self.contentView);
        make.width.equalTo(weak_self.contentView);
        make.height.equalTo(weak_self.contentView);
    }];
// 点击筛选按钮
    _listView.siftAction  = ^(NSArray *data){
        [weak_self hiddenKey];
        WSJSearchListSiftViewController *siftVC = [[WSJSearchListSiftViewController alloc] initWithNibName:@"WSJSearchListSiftViewController" bundle:nil];
        siftVC.data = data;
        siftVC.siftBlock = ^(NSString *result,BOOL free,BOOL Inventory,NSArray *data){
            weak_self.listView.transfee = free ? @"1":nil;
            weak_self.listView.inventory = @(Inventory);
            weak_self.listView.properties = result;
            [weak_self.listView.shopgoodsProperty removeAllObjects];
            [weak_self.listView.shopgoodsProperty addObjectsFromArray:data];
            [weak_self.listView reloadData];
        };
        [weak_self.navigationController pushViewController:siftVC animated:YES];
    };
    _listView.selectRowBlock = ^(NSDictionary *dict){
        NSLog(@"选中商品的id ---- %@",dict[@"id"]);
        KJGoodsDetailViewController *goodsDetailVC = [[KJGoodsDetailViewController alloc] initWithNibName:@"KJGoodsDetailViewController" bundle:nil];
        goodsDetailVC.goodsID = dict[@"id"];
        [weak_self.navigationController pushViewController:goodsDetailVC animated:YES];
    };
    _listView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenKey) name:@"WHiddenKey" object:nil];

}
- (void) hiddenKey
{
    [self.SearchContentTextField resignFirstResponder];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self hiddenKey];
}
//返回上一级界面
- (void) btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UITextFieldDelegate
- (void)searchClick
{
    if (self.SearchContentTextField.text.length == 0) {
        [KJShoppingAlertView showAlertTitle:@"请输入您感兴趣的商品" inContentView:self.view];
        return;
    }
    [self hiddenKey];
    _listView.keyword = self.SearchContentTextField.text;
    [_listView reloadData];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"搜索结果：%@",textField.text);
    [self hiddenKey];
    _listView.keyword = self.SearchContentTextField.text;
    [_listView reloadData];
    return YES;
}


@end
