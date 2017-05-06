//
//  WSJShopCategoryViewController.m
//  jingGang
//
//  Created by thinker on 15/8/13.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJShopCategoryViewController.h"
#import "GlobeObject.h"
#import "VApiManager.h"
#import "PublicInfo.h"
#import "WSJSearchResultViewController.h"
#import "WSJMeEvaluateViewController.h"
#import "WSJShopHomeViewController.h"
#import "MBProgressHUD.h"

#import "AppDelegate.h"

#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "XKJHMapViewController.h"
#import "WSJSelectCityViewController.h"
#import "MerchantListViewController.h"
#import "UIView+BlockGesture.h"
#import "UIButton+Block.h"


@interface WSJShopCategoryViewController ()
{
    VApiManager *_vapiManager;
    UIButton    *_leftBtn;
    UIView      *_rightView;
}
@property (nonatomic, strong) NSMutableArray *twoDataSource;
@property (nonatomic, strong) NSMutableArray *threeDataSource;
@property (weak, nonatomic  ) IBOutlet UIScrollView   *scrollViewLeft;
@property (weak, nonatomic  ) IBOutlet UIScrollView   *scrollViewRight;

@property (nonatomic,strong)NSNumber *secondClassID;

@end

@implementation WSJShopCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    switch (self.shopType)
    {
        case shopType:
        {
            [self requestDataWithNum:@(2) withID:self.api_classId];
        }
            break;
        case O2OType:
        {
            [self requestO2ODataWithRet:@(1) withID:@(1)];

        }
            break;
        default:
            break;
    }
}


#pragma mark - 请求数据 ------O2O服务--------
/**
 *  O2O服务网络数据请求
 *
 *  @param ret      类别1主类目(parentId不用传)2详细类目
 *  @param parentId 父id
 */
- (void) requestO2ODataWithRet:(NSNumber *)ret withID:(NSNumber *)parentId
{
    GroupGroupClassListRequest *groupListRequest = [[GroupGroupClassListRequest alloc] init:GetToken];
    groupListRequest.api_ret = ret;
    groupListRequest.api_parentId = parentId;
    WEAK_SELF
    [_vapiManager groupGroupClassList:groupListRequest success:^(AFHTTPRequestOperation *operation, GroupGroupClassListResponse *response) {
        [weak_self.threeDataSource removeAllObjects];
        if ([ret intValue] == 1)
        {
            for (NSDictionary *dict in response.groupClassList)
            {
                [weak_self.twoDataSource addObject:dict];
            }
        }
        else if([ret intValue] == 2)
        {
            for (NSDictionary *dict in response.classDetails)
            {
                [weak_self.threeDataSource addObject:dict];
            }
        }
        
        if ([ret intValue] == 1)
        {
            [weak_self initScrollViewLeft];
        }
        else if ([ret intValue] == 2)
        {
            [weak_self initScrollViewRight];
            [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:weak_self.view animated: YES];
        [Util ShowAlertWithOnlyMessage:@"数据加载失败"];
        NSLog(@"cheshi ---- %@",error);
        weak_self.scrollViewLeft.hidden = YES;
    }];
}
#pragma mark - 请求数据 ------  商场 ------
/**
 *  网络请求数据
 *
 *  @param num 第几级
 *  @param ID  该级下分类商品的id
 */
- (void) requestDataWithNum:(NSNumber *)num withID:(NSNumber *)ID
{
    GoodsClassListRequest *classListRequest = [[GoodsClassListRequest alloc] init:GetToken];
    classListRequest.api_classNum = num;
    classListRequest.api_classId  = ID;
    WEAK_SELF
    [_vapiManager goodsClassList:classListRequest success:^(AFHTTPRequestOperation *operation, GoodsClassListResponse *response) {
        [self.threeDataSource removeAllObjects];
        for (NSDictionary *d in response.goodsClassList)
        {
            if ([num intValue] == 2)
            {
                [weak_self.twoDataSource addObject:d];
            }
            else if ([num intValue] == 3)
            {
                [weak_self.threeDataSource addObject:d];
            }
        }
        if ([num intValue] == 2)
        {
            if (weak_self.twoDataSource.count >= 1) {
                NSDictionary *dic = weak_self.twoDataSource[0];
                self.secondClassID = dic[@"id"] ;
            }
            [weak_self initScrollViewLeft];
        }
        else if ([num intValue] == 3)
        {
            [weak_self initScrollViewRight];
            [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"cheshi --error-- %@",error);
        self.scrollViewLeft.hidden = YES;
    }];
}

#pragma mark -  实例化右边的Scrollview
- (void) initScrollViewRight
{
    for (UIView *v in self.scrollViewRight.subviews) {
        [v removeFromSuperview];
    }
    
    //添加右边全部view
    UIView *rightAllView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , self.scrollViewRight.frame.size.width, 43)];
    rightAllView.userInteractionEnabled = YES;
    [rightAllView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
        if (self.shopType == shopType) {
            //点击右边全部
            WSJSearchResultViewController *searchResultVC = [[WSJSearchResultViewController alloc] init];
            searchResultVC.type = classSearch;
            
            searchResultVC.ID = self.secondClassID;
            [self.navigationController pushViewController:searchResultVC animated:YES];
            
        }else {
            
            MerchantListViewController *merchantVC = [[MerchantListViewController alloc] initWithNibName:@"MerchantListViewController" bundle:nil];
            merchantVC.classId = self.secondClassID;
            merchantVC.parentClassId = self.twoDataSource.copy;
            merchantVC.subClassId = self.threeDataSource.copy;
//                    merchantVC.mainIndex = _leftBtn.tag;
//                    merchantVC.secondIndex = tap.view.tag;
            [self.navigationController pushViewController:merchantVC animated:YES];
        
        }
        
    }];
    rightAllView.backgroundColor = UIColorFromRGB(0Xf3f3f3);
    rightAllView.tag = 999;
    UILabel *allLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 , 0 , self.scrollViewRight.frame.size.width - 15, 43)];
    allLabel.text = @"全部";
    allLabel.adjustsFontSizeToFitWidth = YES;
    allLabel.font = [UIFont systemFontOfSize:16];
    allLabel.textColor = UIColorFromRGB(0X666666);
    [rightAllView addSubview:allLabel];
    [self.scrollViewRight addSubview:rightAllView];
    
    
    
//    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 45 , self.scrollViewRight.frame.size.width, 43)];
//    v.backgroundColor = [UIColor whiteColor];
//    v.tag = 1000;
//    UITapGestureRecognizer *oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightAction:)];
//    v.userInteractionEnabled = YES;
//    [v addGestureRecognizer:oneTap];
//    UILabel *oneLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 , 0 , self.scrollViewRight.frame.size.width - 15, 43)];
//    oneLabel.text = self.twoDataSource[_leftBtn.tag][@"className"] ? self.twoDataSource[_leftBtn.tag][@"className"] : self.twoDataSource[_leftBtn.tag][@"gcName"];
//    oneLabel.adjustsFontSizeToFitWidth = YES;
//    oneLabel.font = [UIFont systemFontOfSize:16];
//    oneLabel.textColor = UIColorFromRGB(0X666666);
//    [v addSubview:oneLabel];
//    [self.scrollViewRight addSubview:v];
    
    WEAK_SELF
    [self.threeDataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 45 * (idx +1), weak_self.scrollViewRight.frame.size.width, 43)];
        v.tag = idx;
        v.backgroundColor = UIColorFromRGB(0Xf3f3f3);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:weak_self action:@selector(rightAction:)];
        v.userInteractionEnabled = YES;
        [v addGestureRecognizer:tap];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15 , 0 , weak_self.scrollViewRight.frame.size.width - 15, 43)];
        label.tag = 1111;
        label.text = obj[@"className"] ? obj[@"className"] : obj[@"gcName"];
        label.adjustsFontSizeToFitWidth = YES;
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = UIColorFromRGB(0X666666);
        [v addSubview:label];
        [weak_self.scrollViewRight addSubview:v];
    }];
    self.scrollViewRight.contentSize = CGSizeMake(2, 45 * self.threeDataSource.count + 45);
}
- (void) rightAction:(UIGestureRecognizer *)tap
{
    NSString *keyword;
    NSNumber *ID;
    if (tap.view.tag == 1000)
    {
        NSDictionary *dict = self.twoDataSource[_leftBtn.tag];
        keyword = dict[@"className"] ? dict[@"className"] : dict[@"gcName"];
        ID = dict[@"id"];
    }
    else
    {
        UIView *v = tap.view;
        _rightView.backgroundColor = UIColorFromRGB(0Xf3f3f3);
        UILabel *label = (UILabel *)[_rightView viewWithTag:1111];
        label.textColor = UIColorFromRGB(0X666666);
        v.backgroundColor = UIColorFromRGB(0X5AC4F1);
        label = (UILabel *)[v viewWithTag:1111];
        label.textColor = [UIColor whiteColor];
        _rightView = v;
        NSDictionary *dict = self.threeDataSource[_rightView.tag];
        keyword = dict[@"className"] ? dict[@"className"] : dict[@"gcName"];
        ID = dict[@"id"];
    }
    NSLog(@"cheshi -%@--- %@ ---  选中的商品",ID,keyword);
    
    switch (self.shopType)
    {
        case shopType:
        {
            WSJSearchResultViewController *searchResultVC = [[WSJSearchResultViewController alloc] init];
            searchResultVC.type = classSearch;
            searchResultVC.keyword = keyword;
            searchResultVC.ID = ID;
            [self.navigationController pushViewController:searchResultVC animated:YES];
        }
            break;
        case O2OType:
        {
            MerchantListViewController *merchantVC = [[MerchantListViewController alloc] initWithNibName:@"MerchantListViewController" bundle:nil];
            merchantVC.classId = ID.copy;
            merchantVC.classString = keyword.copy;
            merchantVC.parentClassId = self.twoDataSource.copy;
            merchantVC.subClassId = self.threeDataSource.copy;
            merchantVC.mainIndex = _leftBtn.tag; 
            merchantVC.secondIndex = tap.view.tag;
            [self.navigationController pushViewController:merchantVC animated:YES];
        }
            break;
        default:
            break;
    }
}
#pragma mark - 实例化左边的Scrollview
- (void) initScrollViewLeft
{
    for (UIView *v in self.scrollViewLeft.subviews) {
        [v removeFromSuperview];
    }
    
    //添加右边全部view
    UIView *rightAllView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , self.scrollViewLeft.frame.size.width, 43)];
    rightAllView.userInteractionEnabled = YES;
    [rightAllView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        //点击全部
//        rightAllView.backgroundColor = [UIColor whiteColor];
//        self.secondClassID = self.api_classId;
        if (self.shopType == shopType) {
            //点击右边全部
            WSJSearchResultViewController *searchResultVC = [[WSJSearchResultViewController alloc] init];
            searchResultVC.type = classSearch;
            searchResultVC.ID = self.api_classId;
            [self.navigationController pushViewController:searchResultVC animated:YES];
            
        }else {
            
            MerchantListViewController *merchantVC = [[MerchantListViewController alloc] initWithNibName:@"MerchantListViewController" bundle:nil];
            merchantVC.classId = self.api_classId;
            merchantVC.parentClassId = self.twoDataSource.copy;
            merchantVC.subClassId = self.threeDataSource.copy;
            //                    merchantVC.mainIndex = _leftBtn.tag;
            //                    merchantVC.secondIndex = tap.view.tag;
            [self.navigationController pushViewController:merchantVC animated:YES];
            
        }

    }];
    rightAllView.backgroundColor = UIColorFromRGB(0Xf3f3f3);
    rightAllView.tag = 999;
    UILabel *allLabel = [[UILabel alloc] initWithFrame:CGRectMake(0 , 0 , self.scrollViewLeft.frame.size.width - 15, 43)];
    allLabel.text = @"全部";
    allLabel.textAlignment = NSTextAlignmentCenter;
    allLabel.adjustsFontSizeToFitWidth = YES;
    allLabel.font = [UIFont systemFontOfSize:16];
    allLabel.textColor = UIColorFromRGB(0X666666);
    [rightAllView addSubview:allLabel];
    [self.scrollViewLeft addSubview:rightAllView];

    
    WEAK_SELF
    [self.twoDataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(0, 45 * (idx+1) , self.scrollViewLeft.frame.size.width, 43);
        [btn setTitle:obj[@"className"] ? obj[@"className"] : obj[@"gcName"] forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromRGB(0X333333) forState:UIControlStateNormal];
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        btn.tag = idx;
        btn.backgroundColor = UIColorFromRGB(0Xf3f3f3);
        [btn addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5 , self.scrollViewLeft.frame.size.width, 0.5)];
        v.backgroundColor = [UIColor lightGrayColor];
        [btn addSubview:v];
        [weak_self.scrollViewLeft addSubview:btn];
        
        switch (self.shopType)
        {
            case shopType:
            {
                if (idx == 0)
                {
                    _leftBtn = btn;
                    btn.backgroundColor = [UIColor whiteColor];
                    NSDictionary *dict = self.twoDataSource[0];
                    [weak_self requestDataWithNum:@(3) withID:dict[@"id"]];
                }
            }
                break;
            case O2OType:
            {
                if ([obj[@"id"] intValue] == [weak_self.api_classId intValue])
                {
                    _leftBtn = btn;
                    btn.backgroundColor = [UIColor whiteColor];
                    [weak_self requestO2ODataWithRet:@(2) withID:weak_self.api_classId];
                }
            }
                break;
            default:
                break;
        }
    
    }];
    self.scrollViewLeft.contentSize = CGSizeMake(1, 45 * self.twoDataSource.count);
}
- (void) leftButtonAction:(UIButton *)btn
{
    _leftBtn.backgroundColor = UIColorFromRGB(0Xf3f3f3);
    btn.backgroundColor = [UIColor whiteColor];
    _leftBtn = btn;
    NSDictionary *dict = self.twoDataSource[btn.tag];
    switch (self.shopType)
    {
        case shopType:
        {
            [self requestDataWithNum:@(3) withID:dict[@"id"]];
            self.secondClassID = dict[@"id"];
        }
            break;
        case O2OType:
        {
            [self requestO2ODataWithRet:@(2) withID:dict[@"id"]];
            self.secondClassID = dict[@"id"];
        }
            break;
        default:
            break;
    }
}
#pragma mark - 实例化UI
- (void) initUI
{
    NSLog(@"id ---- %@",self.api_classId);
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hub.detailsLabelText = @"Loading...";
    [hub show:YES];
    _vapiManager = [[VApiManager alloc] init];
    self.twoDataSource = [NSMutableArray array];
    self.threeDataSource = [NSMutableArray array];
    if (self.shopType == O2OType) {
        self.secondClassID = self.api_classId;
    }
    //返回上一级控制器按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(btnClick) target:self];
    
}


- (void) btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    AppDelegate *app = kAppDelegate;
    [app.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [app.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];

    
    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(__MainScreen_Width/2 - 30, __StatusScreen_Height, 60, 40)];
    switch (self.shopType) {
        case shopType:
        {
            l.text = @"商品分类";
        }
            break;
        case O2OType:
        {
            l.text = @"商户分类";
        }
            break;
        default:
            break;
    }
    l.font = [UIFont systemFontOfSize:18];
    l.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = l;
    self.navigationController.navigationBar.translucent = NO;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
    [_vapiManager.operationQueue cancelAllOperations];
}

@end
