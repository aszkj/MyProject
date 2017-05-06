//
//  WSJKeySearchViewController.m
//  jingGang
//
//  Created by thinker on 15/8/12.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJKeySearchViewController.h"
#import "PublicInfo.h"
#import "GlobeObject.h"
#import "VApiManager.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "WSJSearchResultViewController.h"
#import "AppDelegate.h"
#import "MerchantListViewController.h"
#import "DownToUpAlertView.h"
#import "KJShoppingAlertView.h"




@interface WSJKeySearchViewController ()<UITextFieldDelegate>
{
    VApiManager *_vapManager;
}

@property (nonatomic, strong) UITextField    *SearchContentTextField;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation WSJKeySearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    switch (self.shopType) {
        case searchShopType:
        {
            [self requestShopData];
        }
            break;
        case searchO2Oype:
        {
            [self requestO2OData];
        }
            break;
        default:
            break;
    }
}
#pragma mark - 网络数据请求-----O2O服务-----
- (void)requestO2OData
{
    WEAK_SELF
    PersonalHotSearchRequest *searchRequest = [[PersonalHotSearchRequest alloc ]init:GetToken];
    [_vapManager personalHotSearch:searchRequest success:^(AFHTTPRequestOperation *operation, PersonalHotSearchResponse *response) {
        NSLog(@"cheshi ---- %@",response);
        for (NSString *str in response.hotSearch)
        {
            [weak_self.dataSource addObject:str];
        }
        [weak_self initButton];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"cheshi ---- %@",error);
    }];
}

#pragma mark - 网络数据请求-----商城-----
-(void)requestShopData
{
    
    SearchGoodsHotKeywordRequest *hotKeywordRequest = [[SearchGoodsHotKeywordRequest alloc] init:GetToken];
    WEAK_SELF
    [_vapManager searchGoodsHotKeyword:hotKeywordRequest success:^(AFHTTPRequestOperation *operation, SearchGoodsHotKeywordResponse *response) {
        for (NSString *str in response.hotKey)
        {
            [weak_self.dataSource addObject:str];
        }
        [weak_self initButton];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
}
#pragma mark - 实例化按钮控件
- (void)initButton
{
    NSInteger rowNum = self.dataSource.count / 3 + ((self.dataSource.count % 3 == 0) ? 0 : 1);
    for (NSInteger row = 0 ; row < rowNum; row ++)
    {
        for (NSInteger list = 0 ; list < 3; list ++)
        {
            if (self.dataSource.count > row * 3 + list)
            {
                UIButton *btn = [UIButton buttonWithType: UIButtonTypeSystem];
                btn.frame = CGRectMake(((__MainScreen_Width - 40) / 3 + 10) *list + 10, 115 + row * 45, (__MainScreen_Width - 40) / 3, 35);
                [btn setTitleColor:UIColorFromRGB(0X666666) forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:15];
                btn.backgroundColor = [UIColor whiteColor];
                [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
                btn.tag = row * 3 + list;
                [btn setTitle:self.dataSource[row *3 + list] forState:UIControlStateNormal];
                [self.view addSubview:btn];
            }
        }
    }
}
#pragma mark - 按钮控件点击触发事件
- (void)buttonAction:(UIButton *)btn
{
    if (self.searchKey)
    {
        self.searchKey(self.dataSource[btn.tag]);
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        switch (self.shopType)
        {
            case searchShopType:
            {
                WSJSearchResultViewController *searchRVC = [[WSJSearchResultViewController alloc] initWithNibName:@"WSJSearchResultViewController" bundle:nil];
                searchRVC.type = keywordSearch;
                searchRVC.keyword = self.dataSource[btn.tag];
                [self.navigationController pushViewController:searchRVC animated:YES];
            }
                break;
            case searchO2Oype:
            {
                MerchantListViewController *merchantVC = [[MerchantListViewController alloc] initWithNibName:@"MerchantListViewController" bundle:nil];
                merchantVC.keyword = self.dataSource[btn.tag];
                merchantVC.searchType = SearchKeyword;
                [self.navigationController pushViewController:merchantVC animated:YES];
            }
                break;
            default:
                break;
        }
    }
}
#pragma mark - 实例化UI
- (void)initUI
{
    self.dataSource = [NSMutableArray array];
    _vapManager = [[VApiManager alloc] init];
    //返回上一级控制器按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(btnClick) target:self];
    self.navigationController.navigationBar.barTintColor = COMMONTOPICCOLOR;
    //点击搜索按钮
    UIButton *button_search = [[UIButton alloc]initWithFrame:CGRectMake(20, 30, 40, __NavScreen_Height-15)];
    [button_search setTitle:@"搜索" forState:UIControlStateNormal];
    [button_search addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithCustomView:button_search];
    self.navigationItem.rightBarButtonItem = rightBar;
    //设置背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.SearchContentTextField = [[UITextField alloc]initWithFrame:CGRectMake(__MainScreen_Width/2 - 100, __StatusScreen_Height + 5 , 200, 30)];
    switch (self.shopType) {
        case searchO2Oype:
        {
            self.SearchContentTextField.placeholder = @"请输入您感兴趣的服务";
        }
            break;
        case searchShopType:
        {
            self.SearchContentTextField.placeholder = @"请输入您感兴趣的商品";
        }
            break;
        default:
            break;
    }
    
    self.SearchContentTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.SearchContentTextField.delegate = self;
    self.SearchContentTextField.font = [UIFont systemFontOfSize:15];
    self.SearchContentTextField.returnKeyType = UIReturnKeySearch;
    self.SearchContentTextField.textColor = [UIColor whiteColor];
    self.SearchContentTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.SearchContentTextField.backgroundColor = UIColorFromRGB(0X42aad6);
    self.navigationItem.titleView = self.SearchContentTextField;
    self.navigationController.navigationBar.translucent = YES;
    AppDelegate *app = kAppDelegate;
    [app.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [app.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.SearchContentTextField becomeFirstResponder];
}
//返回上一级界面
- (void) btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
//点击搜索事件
- (void) searchClick
{

    if (self.SearchContentTextField.text.length == 0) {
        switch (self.shopType)
        {
            case searchShopType:
                [KJShoppingAlertView showAlertTitle:@"请输入您感兴趣的商品" inContentView:self.view];
                break;
            case searchO2Oype:
                [KJShoppingAlertView showAlertTitle:@"请输入您感兴趣的服务" inContentView:self.view];
                break;
            default:
                break;
        }
        return;
    }
    if (self.searchKey)
    {
        self.searchKey(self.SearchContentTextField.text);
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        switch (self.shopType)
        {
            case searchShopType:
            {
                WSJSearchResultViewController *searchRVC = [[WSJSearchResultViewController alloc] initWithNibName:@"WSJSearchResultViewController" bundle:nil];
                searchRVC.type = keywordSearch;
                searchRVC.keyword = self.SearchContentTextField.text;
                [self.navigationController pushViewController:searchRVC animated:YES];
            }
                break;
            case searchO2Oype:
            {
                MerchantListViewController *merchantVC = [[MerchantListViewController alloc] initWithNibName:@"MerchantListViewController" bundle:nil];
                merchantVC.keyword = self.SearchContentTextField.text;
                merchantVC.searchType = SearchKeyword;
                [self.navigationController pushViewController:merchantVC animated:YES];
            }
                break;
            default:
                break;
        }
    }
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"搜索结果：%@",textField.text);
    [self searchClick];
    return YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self hiddenKey];
    self.navigationController.navigationBar.translucent =NO;
}
- (void) hiddenKey
{
    [self.SearchContentTextField resignFirstResponder];
}
- (IBAction)hiddenKey:(id)sender
{
    [self hiddenKey];
}

@end
