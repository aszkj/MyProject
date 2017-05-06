//
//  DLMyWalletVC.m
//  YilidiBuyer
//
//  Created by yld on 16/5/17.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLMyWalletVC.h"
#import "GlobleConst.h"
#import "DLCouponsVC.h"
#import "SGTopTitleView.h"
#import "DLAccountBalanceVC.h"
#import "AFNHttpRequestOPManager+DLUnNomalApi.h"
#import "AFNHttpRequestOPManager+checkNetworkStatus.h"
@interface DLMyWalletVC ()<SGTopTitleViewDelegate, UIScrollViewDelegate>
{
    
    BOOL isPush;
    
}
@property (nonatomic, strong) SGTopTitleView *topTitleView;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSMutableArray *topTitles;
@property (nonatomic, strong) NSMutableArray *effectivesName;
@property (nonatomic,strong)  NSMutableArray *types;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UILabel *accountName;
@property (strong, nonatomic) IBOutlet UILabel *accountMoney;
@property (strong, nonatomic) IBOutlet UILabel *limiName;
@property (strong, nonatomic) IBOutlet UILabel *accountLimi;

@end

@implementation DLMyWalletVC




- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTitle = @"我的钱包";

    [self _getWalletData];
    isPush =YES;
 
}
 

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];

    if (isPush==YES) {
        [_topTitleView seletedIndex:_index];
        [self setVCToIndex:_index];
        isPush=NO;
    }

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ------------------------Init---------------------------------
- (void)_initTopTitleView {
    // 1.添加所有子控制器
    [self setupChildViewController];
    self.topTitleView = [SGTopTitleView topTitleViewWithFrame:CGRectMake(0, 72, kScreenWidth, 44)];
    _topTitleView.staticTitleArr = [NSArray arrayWithArray:_topTitles];
    //    _topTitleView.isHiddenIndicator = YES;
    _topTitleView.titleAndIndicatorColor = [UIColor redColor];
    _topTitleView.delegate_SG = self;

    
    [self.view addSubview:_topTitleView];
    
    // 创建底部滚动视图
    self.mainScrollView = [[UIScrollView alloc] init];
    _mainScrollView.frame = CGRectMake(0, 116, kScreenWidth, kScreenHeight-116);
    _mainScrollView.contentSize = CGSizeMake(kScreenWidth * _topTitles.count, 0);
//    _mainScrollView.backgroundColor = [UIColor clearColor];
    // 开启分页
    _mainScrollView.pagingEnabled = YES;
//    _mainScrollView.scrollEnabled=NO;
    // 没有弹簧效果
    _mainScrollView.bounces = NO;
    // 隐藏水平滚动条
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    // 设置代理
    _mainScrollView.delegate = self;
    [self.view addSubview:_mainScrollView];
    
}

#pragma mark ------------------------Private-------------------------
- (void)_seletedPage {
}
#pragma mark ------------------------Api----------------------------------
- (void)_getWalletData{
    
    [self showLoadingHub];
    
    WEAK_SELF
    [AFNHttpRequestOPManager postWithParameters:nil subUrl:kUrl_AccountInfoUrl block:^(NSDictionary *resultDic, NSError *error) {
        [weak_self hideLoadingHub];
        
        if (isEmpty(resultDic[EntityKey])) {
            return ;
        }
        
        
    
        NSArray *accountInfoListArr =resultDic[EntityKey][@"accountInfoList"];
        weak_self.accountName.text = [accountInfoListArr objectAtIndex:0][@"accountName"];
        weak_self.accountMoney.text = [NSString stringWithFormat:@"%.2f",[[accountInfoListArr objectAtIndex:0][@"accountNum"]floatValue]/1000];
        
        weak_self.limiName.text = [accountInfoListArr objectAtIndex:1][@"accountName"];
        weak_self.accountLimi.text = [NSString stringWithFormat:@"%d",[[accountInfoListArr objectAtIndex:1][@"accountNum"]intValue]];
        
        NSArray *ticketInfoListArr = resultDic[EntityKey][@"ticketInfoList"];
        self.types=[[NSMutableArray alloc]initWithCapacity:ticketInfoListArr.count];
        self.topTitles=[[NSMutableArray alloc]initWithCapacity:ticketInfoListArr.count];
        self.effectivesName = [[NSMutableArray alloc]initWithCapacity:ticketInfoListArr.count];
        for (int count=0; count<ticketInfoListArr.count; count++) {
            NSNumber *num = [NSNumber numberWithInteger:[[ticketInfoListArr objectAtIndex:count][@"ticketType"]integerValue]];
            [weak_self.types addObject:num];
            NSString *topTitleName = [NSString stringWithFormat:@"%@(%ld)",[ticketInfoListArr objectAtIndex:count][@"ticketTypeName"],[[ticketInfoListArr objectAtIndex:count][@"ticketCount"]integerValue]];
            [weak_self.topTitles addObject:topTitleName];
            
            NSString *effectiveName = [NSString stringWithFormat:@"%@",[ticketInfoListArr objectAtIndex:count][@"ticketTypeName"]];
            [weak_self.effectivesName addObject:effectiveName];
        }
        
        
        [weak_self _initTopTitleView];
        
        
    }];
    
}


#pragma mark ------------------------Page Navigate---------------------------


#pragma mark ------------------------View Event---------------------------
- (IBAction)balanceButtonClick:(id)sender {
    DLAccountBalanceVC *balanceVC = [[DLAccountBalanceVC alloc]init];
    balanceVC.pageTitle = @"账户余额";
    balanceVC.balanceStr = @"余额(元)";
    balanceVC.balanceDetailStr = @"余额明细";
    [self navigatePushViewController:balanceVC animate:YES];
}
- (IBAction)myLimiButtonClick:(id)sender {
    DLAccountBalanceVC *balanceVC = [[DLAccountBalanceVC alloc]init];
    balanceVC.pageTitle = @"里米明细";
    balanceVC.balanceStr = @"里米(积分)";
    balanceVC.balanceDetailStr = @"里米明细";
    [self navigatePushViewController:balanceVC animate:YES];
}

#pragma mark ------------------------Delegate-----------------------------
#pragma mark - - - SGTopScrollMenu代理方法
- (void)SGTopTitleView:(SGTopTitleView *)topTitleView didSelectTitleAtIndex:(NSInteger)index{
    
    [self setVCToIndex:index];
    
}

- (void)setVCToIndex:(NSInteger)vcIndex {
    // 1 计算滚动的位置
    CGFloat offsetX = vcIndex * self.view.frame.size.width;
    self.mainScrollView.contentOffset = CGPointMake(offsetX, 0);
   
    
    // 2.给对应位置添加对应子控制器
    [self showVc:vcIndex];
    
}

// 添加所有子控制器
- (void)setupChildViewController {
       
    for (NSNumber *type in self.types) {
            DLCouponsVC *couponsVC = [[DLCouponsVC alloc] init];
            [couponsVC setTicketType:type];
            [couponsVC setTicketTitles:self.effectivesName];
            [self addChildViewController:couponsVC];
    
    }
    
}

// 显示控制器的view
- (void)showVc:(NSInteger)index {
    
    CGFloat offsetX = index * self.view.frame.size.width;
    
    if (index >= self.childViewControllers.count) {
        return;
    }
    UIViewController *vc = self.childViewControllers[index];
    
    // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
    if (vc.isViewLoaded) return;
    
    [self.mainScrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(offsetX, 0, self.view.frame.size.width, self.view.frame.size.height);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // 计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    // 1.添加子控制器view
    [self showVc:index];
    
    // 2.把对应的标题选中
    UILabel *selLabel = self.topTitleView.allTitleLabel[index];
    
    // 3.滚动时，改变标题选中
    [self.topTitleView staticTitleLabelSelecteded:selLabel];
    
}


#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------




@end
