//
//  WSJSelectCityViewController.m
//  jingGang
//
//  Created by thinker on 15/9/17.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJSelectCityViewController.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "PublicInfo.h"
#import "GlobeObject.h"
#import "WSJSelectCityHeader.h"
#import "WSJSelectCityTableViewCell.h"
#import "WSJSelectCityTableHeaderView.h"
#import "WSJCityModel.h"
#import "AppDelegate.h"
#import "mapObject.h"
#import "VApiManager.h"
#import "Util.h"
#import "MBProgressHUD.h"

@interface WSJSelectCityViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    VApiManager *_vapiManager;
    
}
@property (nonatomic, copy) mapObject *map;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *seachText;

//tableView段头数据
@property (nonatomic,strong ) WSJSelectCityTableHeaderView *tableHeaderView;

@property (nonatomic, strong) NSArray *hotCityList;//热门城市数据
@property (nonatomic, strong) NSMutableArray               *allDataSource;
@property (nonatomic, strong) NSMutableArray               *dataSource;

@end


static NSString *selectCityTableViewCell = @"selectCityTableViewCell";

@implementation WSJSelectCityViewController

#pragma mark - 搜索结果，进行所有数据处理
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [self.dataSource removeAllObjects];
    if (textField.text.length > 0)//筛选出想要的数据
    {
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF.areaName CONTAINS %@ or SELF.pinyin CONTAINS %@",textField.text,textField.text];
        for (WSJCityModel *model in self.allDataSource)
        {
            NSArray *array = [model.data filteredArrayUsingPredicate:pred];
            if (array.count > 0)
            {
                WSJCityModel *cityModel = [[WSJCityModel alloc] init];
                cityModel.letter = model.letter;
                [cityModel.data addObjectsFromArray:array];
                [self.dataSource addObject:cityModel];
            }
        }
    }
    else  //搜索所有的城市
    {
        [self.dataSource addObjectsFromArray:self.allDataSource];
        
    }
    [self.tableView reloadData];
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    WSJCityModel *model = self.dataSource[section];
    return model.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSJSelectCityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:selectCityTableViewCell];
    WSJCityModel *model = self.dataSource[indexPath.section];
    NSDictionary *dict = model.data[indexPath.row];
    cell.titleLabel.text = dict[@"areaName"];
    return cell;
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *letter = [NSMutableArray array];
    for (WSJCityModel *model in self.dataSource)
    {
        [letter addObject:model.letter];
    }
    return letter;
}
#pragma mark - UITableViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.seachText resignFirstResponder];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.city)
    {
        WSJCityModel *model = self.dataSource[indexPath.section];
        NSDictionary *dict = model.data[indexPath.row];
        self.city(dict[@"areaName"],dict[@"id"]);
        NSUserDefaults *defaults = kUserDefaults;
        [defaults setObject:dict[@"areaName"] forKey:@"baiduCity"];
        [defaults setObject:dict[@"id"] forKey:@"baiduCityID"];
        self.map.baiduCity = dict[@"areaName"];
        self.map.baiduCityID = dict[@"id"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    WSJSelectCityHeader *header = [[NSBundle mainBundle] loadNibNamed:@"WSJSelectCityHeader" owner:selectCityTableViewCell options:nil][0];
    WSJCityModel *model = self.dataSource[section];
    header.titleLabel.text = model.letter;
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self requestData];
}
#pragma mark - 网络请求数据
- (void)requestData
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading...";
    [hud show:YES];
    WEAK_SELF
    //TODO:获取热门城市
    PersonalHotCityGetRequest *cityGetRequest = [[PersonalHotCityGetRequest alloc]init:GetToken];
    [_vapiManager personalHotCityGet:cityGetRequest success:^(AFHTTPRequestOperation *operation, PersonalHotCityGetResponse *response) {
        weak_self.hotCityList = response.hotCityList;
        dispatch_async(dispatch_get_main_queue(), ^{
            weak_self.tableHeaderView.dataArray = weak_self.hotCityList;
            weak_self.tableView.tableHeaderView = weak_self.tableHeaderView;
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    //TODO:获取所有城市
    PersonalAllCityListRequest *allCityRequest = [[PersonalAllCityListRequest alloc] init:GetToken];
    [_vapiManager personalAllCityList:allCityRequest success:^(AFHTTPRequestOperation *operation, PersonalAllCityListResponse *response) {
        for (NSDictionary *dict in response.areaListBos)
        {
            NSString *pinyin = [Util getPinyinStringWithNSString:dict[@"areaName"]];
            WSJCityModel *cityModel = nil;
            char le = [pinyin characterAtIndex:0] - 32;//获取首字母
            for (WSJCityModel *model  in weak_self.dataSource)
            {
                char c = [model.letter characterAtIndex:0];
                if (le == c)
                {
                    cityModel = model;
                }
            }
            if (cityModel == nil)
            {
                cityModel = [[WSJCityModel alloc] init];
                cityModel.letter = [NSString stringWithFormat:@"%c",le];
                [weak_self.dataSource addObject:cityModel];
            }
            NSDictionary *dictData = @{@"id":dict[@"id"],@"areaName":dict[@"areaName"],@"pinyin":pinyin};
            [cityModel.data addObject:dictData];
        }
        [weak_self.allDataSource addObjectsFromArray:weak_self.dataSource];
        [weak_self.tableView reloadData];
        [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
        NSLog(@"cheshi ---- %@",error);
    }];

}
#pragma mark - 实例化UI
- (void)initUI
{
    _dataSource = [NSMutableArray array];
    _allDataSource = [NSMutableArray array];
    _vapiManager = [[VApiManager alloc] init];
    _map = [mapObject sharedMap];
    [self.tableView registerNib:[UINib nibWithNibName:@"WSJSelectCityTableViewCell" bundle:nil] forCellReuseIdentifier:selectCityTableViewCell];
    self.tableHeaderView = [[NSBundle mainBundle] loadNibNamed:@"WSJSelectCityTableHeaderView" owner:self options:nil][0];
    self.tableView.tableHeaderView = self.tableHeaderView;
    WEAK_SELF
//    self.tableHeaderView.locationCity = ^(NSString *city){
//        [Util setNavTitleWithTitle:[NSString stringWithFormat:@"当前城市-%@",city] ofVC:weak_self];
//    };
     [Util setNavTitleWithTitle:[NSString stringWithFormat:@"当前城市-%@",    [[mapObject sharedMap] baiduCity]] ofVC:weak_self];


    //TODO:点击热门城市获定位回调
    self.tableHeaderView.headerAction = ^(NSString *city,NSNumber *cityID){
        if (weak_self.city)
        {
            weak_self.map.baiduCity = city;
            weak_self.map.baiduCityID = cityID;
            weak_self.city(city,cityID);
            NSUserDefaults *defaults = kUserDefaults;
            [defaults setObject:city forKey:@"baiduCity"];
            [defaults setObject:cityID forKey:@"baiduCityID"];
            [weak_self.navigationController popViewControllerAnimated:YES];
        }
    };
//    [Util setNavTitleWithTitle:@"当前城市- --" ofVC:self];
    //返回上一级控制器按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(btnClick) target:self];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //设置背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
}
//返回上一级界面
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
//    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(__MainScreen_Width/2 - 30, __StatusScreen_Height, 60, 40)];
//    l.textAlignment = NSTextAlignmentCenter;
//    l.text = @"云e生";
//    l.font = [UIFont systemFontOfSize:18];
//    l.textColor = [UIColor whiteColor];
//    self.navigationItem.titleView = l;
}


@end
