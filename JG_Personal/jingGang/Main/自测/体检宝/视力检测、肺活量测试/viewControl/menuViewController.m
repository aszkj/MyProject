//
//  eyechartViewController.m
//  jingGang
//
//  Created by thinker on 15/7/20.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "menuViewController.h"
#import "PublicInfo.h"


@interface menuViewController ()<UIScrollViewDelegate>
{
    UIView * _menuView;//菜单的UIView
    NSMutableArray * _menuBtnArray;//保存菜单选项Button
    UIView * _menuLowBack;
    
    NSMutableArray *_isLoadArray;//判断是否加载过的内容
}

@property (nonatomic,strong) UIScrollView *contentScrollView;//显示内容

@end

@implementation menuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
//    实例化菜单选项
    [self initMenuUI];
//    实例化内容
    [self initContentScrollView];
    
}


- (void) initUI
{
    UIButton *button_na = [[UIButton alloc]initWithFrame:CGRectMake(20, 30, 35, __NavScreen_Height-15)];
    [button_na setImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    [button_na addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:button_na];
    self.navigationItem.leftBarButtonItem = bar;
    //设置背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
}
- (void) initMenuUI
{
    
    //设置菜单选项
    _menuView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __MainScreen_Width, __NavScreen_Height)];
    _menuView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_menuView];
    _menuBtnArray = [NSMutableArray array];
    _isLoadArray = [NSMutableArray array];
    WEAK_SELF
    [_menuContentArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(idx * __MainScreen_Width / _menuContentArray.count, 0, __MainScreen_Width / _menuContentArray.count, __NavScreen_Height);
        [btn setTitle:obj forState:UIControlStateNormal];
        btn.tag = idx;
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:status_color forState:UIControlStateSelected];
        [btn addTarget:weak_self action:@selector(selectMenuAction:) forControlEvents:UIControlEventTouchUpInside];
        [_menuView addSubview:btn];
        [_menuBtnArray addObject:btn];
        [_isLoadArray addObject:@"0"];
        if (idx == 0)
        {
            btn.selected = YES;
        }
    }];
    
    _menuLowBack = [[UIView alloc] initWithFrame:CGRectMake(0, _menuView.frame.size.height - 4, __MainScreen_Width / _menuContentArray.count, 4)];
    _menuLowBack.backgroundColor = status_color;
    [_menuView addSubview:_menuLowBack];
}

- (void) initContentScrollView
{
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_menuView.frame), __MainScreen_Width, __MainScreen_Height - 20 - __NavScreen_Height * 2)];
    self.contentScrollView.bounces = NO;
    self.contentScrollView.contentSize = CGSizeMake(_menuContentArray.count * __MainScreen_Width, self.contentScrollView.frame.size.height);
    self.contentScrollView.delegate = self;
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.contentScrollView];
    [self creatView:self.pageView];
    self.contentScrollView.contentOffset = CGPointMake(self.pageView * __MainScreen_Width, 1);
    [self selectMenuAction:_menuBtnArray[self.pageView]];
}
#pragma mark - 菜单选择事件
- (void) selectMenuAction:(UIButton *)btn
{
    for (UIButton *b in _menuBtnArray)
    {
        b.selected = NO;
    }
    btn.selected = YES;
    CGRect frame = _menuLowBack.frame;
    frame.origin.x = btn.tag * __MainScreen_Width / _menuContentArray.count;
    [UIView animateWithDuration:0.3 animations:^{
        _menuLowBack.frame = frame;
    }];
    _contentScrollView.contentOffset = CGPointMake(__MainScreen_Width * btn.tag, 0);
    
    [self creatView:btn.tag];
    
    switch (btn.tag)
    {
        case 1:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"backViewControllerStopVoice" object:nil];
            break;
        case 0:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeMenu" object:nil];
            break;
        default:
            break;
    }
    

}
- (void) btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(__MainScreen_Width/2 - 30, __StatusScreen_Height, 60, 40)];
    l.text = self.titleText;
    l.font = [UIFont systemFontOfSize:18];
    l.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = l;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"backViewControllerStopVoice" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{
    int page = scrollView.contentOffset.x / __MainScreen_Width;
    NSLog(@"cheshi ---- %g",scrollView.contentOffset.x);
    UIButton *b = _menuBtnArray[page];
    [self selectMenuAction:b];
    
    [self creatView:page];
    
}
//实例化内容的UI
- (void) creatView:(NSInteger)page
{
    for (NSInteger i = page - 1; i <= page + 1; i ++)
    {
        if (i >= 0  && i < self.contentView.count)
        {
            if ([_isLoadArray[i] integerValue] == 0)
            {
                id class = NSClassFromString(self.contentView[i]);
                id v = [[class alloc] init];
                [v setValue:self forKey:@"VC"];
                if ([v isKindOfClass:[UIView class]])
                {
                    UIView *view = (UIView *)v;
                    view.frame = CGRectMake(i * __MainScreen_Width, 0, __MainScreen_Width, self.contentScrollView.frame.size.height);
                    [self.contentScrollView addSubview:view];
                }
                else if ( [v isKindOfClass:[UIViewController class]])
                {
                    UIViewController *vc = (UIViewController *)v;
                    vc.view.frame = CGRectMake(i * __MainScreen_Width, 0, __MainScreen_Width, self.contentScrollView.frame.size.height);
                    [self.contentScrollView addSubview:vc.view];
                }
                _isLoadArray[i] = @"1";
            }
        }
        
    }
}


- (void) isScrollEnabled:(id)enabled
{
    _contentScrollView.scrollEnabled = [enabled boolValue];
}
- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
