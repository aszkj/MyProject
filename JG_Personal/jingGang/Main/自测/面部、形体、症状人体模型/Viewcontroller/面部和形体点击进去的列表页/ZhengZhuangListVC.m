//
//  ZhengZhuangListVC.m
//  jingGang
//
//  Created by 张康健 on 15/6/4.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "ZhengZhuangListVC.h"
#import "ZhengZhuangAllTableView.h"
#import "ZhengZhuangCureTable.h"
#import "PublicInfo.h"
#import "GlobeObject.h"
#import "UIButton+Block.h"
#import "userTestViewController.h"
#import "Util.h"
#import "AppDelegate.h"
#import "FoodCuculatorVC.h"
#import "FaceDetailVC.h"
#import "projectViewController.h"
@interface ZhengZhuangListVC (){


    VApiManager *_vapManager;
    NSString *token;
}
@property (nonatomic,strong)ZhengZhuangAllTableView *zzhuangAllTable;
@property (nonatomic,strong)ZhengZhuangCureTable *zzhuangCureTable;


@property (nonatomic,strong)NSDictionary *dataDic;

@property (nonatomic,strong)NSMutableArray *firstTableArr;
@property (nonatomic,strong)NSArray *seCondTableArr;



@end



@implementation ZhengZhuangListVC

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    
    [self _initTable];
    
    [self _loadNavLeft];
    
    [self _loadTitleView];
    
    //初始化数据
    [self _initData];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.view addSubview:self.zzhuangAllTable];
    [self.view addSubview:self.zzhuangCureTable];
}


#pragma mark - private Method
-(void)_init{
    self.navigationController.navigationBar.barTintColor = kGetColor(94, 180, 231);
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _vapManager = [[VApiManager alloc] init];
    token = [userDefaultManager GetLocalDataString:@"Token"];
}


-(void)_initTable{
    
    CGFloat leftTableWidth = 0;
    if (self.comminType == SHANSHI_COMIN) {
        leftTableWidth = 150;
    }else if (self.comminType == FACE_CLICK_COMIN || self.comminType == FIGURE_CLICK_COMIN){
        leftTableWidth = 120;
    }
    id table = [[ZhengZhuangAllTableView alloc] initWithFrame:CGRectMake(0, 0, leftTableWidth, __MainScreen_Height-64) style:UITableViewStylePlain];
    self.zzhuangAllTable = table;
    RELEASE(table);
    
    WEAK_SELF;
    self.zzhuangAllTable.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.zzhuangAllTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.zzhuangAllTable.clickZhengZhuangItemBlock = ^(long ID){
        
        [weak_self _requestSecondTableDataWithID:@(ID)];
        
    };
    
    table = [[ZhengZhuangCureTable alloc] initWithFrame:CGRectMake(leftTableWidth,0, __MainScreen_Width-leftTableWidth, __MainScreen_Height-64) style:UITableViewStylePlain];
    self.zzhuangCureTable = table;
    RELEASE(table);
    

    self.zzhuangCureTable.testBlock = ^(long ID){
    
        if (weak_self.comminType == FACE_CLICK_COMIN || weak_self.comminType == FIGURE_CLICK_COMIN) {//如果是点击面部进入的，推到面部详情页
           FaceDetailVC *faceDetaiVC = [[FaceDetailVC alloc] init];
            faceDetaiVC.faceDetailID = ID;
            [weak_self.navigationController pushViewController:faceDetaiVC animated:YES];
        }
    };
    
    
    self.zzhuangCureTable.foodCulateBlock = ^(NSDictionary *dic){
        FoodCuculatorVC *foodCulVC = [[FoodCuculatorVC alloc] init];
        foodCulVC.foodDic = dic;
        [weak_self.navigationController pushViewController:foodCulVC animated:YES];
        RELEASE(foodCulVC);
        
    };//食物计算器push
    
    self.zzhuangCureTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.zzhuangCureTable.showsVerticalScrollIndicator = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.zzhuangAllTable];
    [self.view addSubview:self.zzhuangCureTable];
    
}



-(void)_loadNavLeft{
    
    UIButton *navLeftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 25)];
    [navLeftButton setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    WEAK_SELF;
    [navLeftButton addActionHandler:^(NSInteger tag) {
     
        [weak_self.navigationController popViewControllerAnimated:YES];

        
    }];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:navLeftButton];
    self.navigationItem.leftBarButtonItem = item;
}




-(void)_loadTitleView{
    if(self.isJingGang){
        [Util setNavTitleWithTitle:@"静港项目" ofVC:self];
    }else{
        if (self.comminType == FACE_CLICK_COMIN) {
            
            [Util setNavTitleWithTitle:@"面部" ofVC:self];
            
        }else if (self.comminType == SHANSHI_COMIN){
            
            [Util setNavTitleWithTitle:@"食物计算器" ofVC:self];
            
        }else if (self.comminType == FIGURE_CLICK_COMIN){
            
            [Util setNavTitleWithTitle:@"形体" ofVC:self];
        }else if (self.comminType == ZhengZhuang_COMIN) {
            
            [Util setNavTitleWithTitle:@"症状" ofVC:self];
        }
    }
}


#pragma mark - 请求第一张表数据
-(void)_requestFirstTableData{

    NSLog(@"selfID:%ld",self.fen_lie_ID);
    SnsInformationClassRequest *request = [[SnsInformationClassRequest alloc] init:token];
    request.api_parentClassId = @(self.fen_lie_ID);
    
    [_vapManager snsInformationClass:request success:^(AFHTTPRequestOperation *operation, SnsInformationClassResponse *response) {
        
        NSLog(@"first : %@",response.informationClasses);
        
        self.firstTableArr = [response.informationClasses mutableCopy];
        //计算第一个表的单元格高度
        [self _calCellHeightWithArr:self.firstTableArr withKey:@"icName"];

        //处理如果是面部进来的，如果是女的，去掉胡须数据
        [self _dealFemaleHuxuData];
        
        self.zzhuangAllTable.data = self.firstTableArr;
        [self.zzhuangAllTable reloadData];
        
        if (self.firstTableArr.count > 0) {
            //请求第二张表数据，默认第一个分类
            NSDictionary *firstDic = self.firstTableArr[0];
            [self _requestSecondTableDataWithID:firstDic[@"id"]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        NSLog(@"%@",error.localizedDescription);
        
    }];
    
}//请求第一张表数据


#pragma mark - 请求第二张表数据
-(void)_requestSecondTableDataWithID:(NSNumber *)ID{
    
    SnsInformationAllListRequest *request = [[SnsInformationAllListRequest alloc] init:token];
    request.api_classId = ID;
    [_vapManager snsInformationAllList:request success:^(AFHTTPRequestOperation *operation, SnsInformationAllListResponse *response) {
        
        NSLog(@"second : %@",response.informations);
        
        self.seCondTableArr = response.informations;
        //刷新表
        self.zzhuangCureTable.data = self.seCondTableArr;
        [self.zzhuangCureTable reloadData];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error.localizedDescription);
        
    }];

}//请求第二张表数据

#pragma mark - 处理女子有种植胡须的一行
-(void)_dealFemaleHuxuData {
    
    if (self.comminType == FACE_CLICK_COMIN && self.faceClickType == FACE_CLICK_WOMEN) {
        __block NSInteger huxuIndex = 1000;
        [self.firstTableArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSDictionary *dic = (NSDictionary *)obj;
            if ([dic[@"icName"] isEqualToString:@"种植胡须"]) {
                huxuIndex = idx;
                *stop = YES;
            }
        }];
        if (huxuIndex != 1000) {
            //移除女士胡须的
            [self.firstTableArr removeObjectAtIndex:huxuIndex];
        }
    }
}
// 5001 5003
-(void)_initData{

    if (self.comminType == SHANSHI_COMIN) {
        _dataDic = (NSDictionary *)[self readFoodDictionaryFromStore];
        self.zzhuangAllTable.data = [_dataDic allKeys];
        self.zzhuangAllTable.dataDic = _dataDic;
        self.zzhuangAllTable.cureTable = self.zzhuangCureTable;
        self.zzhuangCureTable.data = _dataDic[_dataDic.allKeys[0]];
        
        [self _calCellHeightOfShiWu:self.zzhuangAllTable.data];
        self.zzhuangAllTable.isFaceClickTable = NO;
        self.zzhuangCureTable.isFaceClick = NO;

    }else{
        
        self.zzhuangAllTable.isFaceClickTable = YES;
        self.zzhuangCureTable.isFaceClick = YES;
        
        [self _requestFirstTableData];
    
    }
}


-(NSMutableDictionary *)readFoodDictionaryFromStore{

    NSString *path = [[NSBundle mainBundle] pathForResource:@"food" ofType:@"json"];
    NSData *data=[NSData dataWithContentsOfFile:path];
    
    id JsonObject=[NSJSONSerialization JSONObjectWithData:data
                                                  options:NSJSONReadingAllowFragments
                                                    error:nil];
    //对json进行重新处理
    NSDictionary *jsonDic = JsonObject;
    NSMutableDictionary *newFoodDic = [NSMutableDictionary dictionaryWithCapacity:0];
    NSArray *foodArr = [jsonDic[@"nodes"] objectForKey:@"node"];
    for (NSDictionary *dic in foodArr) {
        NSString *newKey = dic[@"name"];
        NSArray  *newValueArr = dic[@"item"];
        [newFoodDic setObject:newValueArr forKey:newKey];
    }

    return newFoodDic;

}//从文件中读取食品数据

-(void)_calCellHeightWithArr:(NSArray *)arr withKey:(NSString *)strKey{

    NSMutableArray *zzhuangAllCellHeightArr = [NSMutableArray arrayWithCapacity:0];
    //计算cell高度
    for (NSDictionary *dic in arr) {
        NSString *str = dic[strKey];
        CGFloat height = kStringSize(str, 16.0, 112, 200).height + 37;
        [zzhuangAllCellHeightArr addObject:@(height)];
    }
    
    self.zzhuangAllTable.cellHeightArr = zzhuangAllCellHeightArr;
    
}//面部表算高度

-(void)_calCellHeightOfShiWu:(NSArray *)arr{
    NSMutableArray *zzhuangAllCellHeightArr = [NSMutableArray arrayWithCapacity:0];
    //计算cell高度
    for (NSString *str in arr) {
        CGFloat height = kStringSize(str, 16.0, 112, 200).height + 37;
        [zzhuangAllCellHeightArr addObject:@(height)];
    }
    
    self.zzhuangAllTable.cellHeightArr = zzhuangAllCellHeightArr;

}//食物计算器算高度

#pragma mark - dealloc
- (void)dealloc {
}
    
@end
