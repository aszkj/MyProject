//
//  ListVC.m
//  jingGang
//
//  Created by 张康健 on 15/11/5.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "ListVC.h"
#import "ZhengZhuangAllTableView.h"
#import "ZhengZhuangCureTable.h"
#import "VApiManager.h"
#import "GlobeObject.h"
#import "FaceDetailVC.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "FoodCuculatorVC.h"

@interface ListVC () {
    
    VApiManager *_vapManager;

}
@property (weak, nonatomic) IBOutlet ZhengZhuangAllTableView *zzhuangAllTable;
@property (weak, nonatomic) IBOutlet ZhengZhuangCureTable *zzhuangCureTable;

@property (nonatomic,strong)NSMutableArray *firstTableArr;
@property (nonatomic,strong)NSArray *seCondTableArr;



@end

@implementation ListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    
    [self _initTable];
    
    [self _requestData];
}




#pragma mark - private Method
-(void)_init{
 
    self.navigationController.navigationBar.barTintColor = kGetColor(94, 180, 231);
    _vapManager = [[VApiManager alloc] init];
    
    if (self.listType == FigureType) {
        [Util setNavTitleWithTitle:@"形体" ofVC:self];
        
    }else if (self.listType == ZhengZhuangType){
        
        [Util setNavTitleWithTitle:@"症状" ofVC:self];
        
    }else if (self.listType == FoodCalculatorType){
        
        [Util setNavTitleWithTitle:@"食物计算器" ofVC:self];
        
    }

    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(back) target:self];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    if (self.listType == FoodCalculatorType) {
        
        self.zzhuangAllTable.isFaceClickTable = NO;
        self.zzhuangCureTable.isFaceClick = NO;
        
    }else {
        self.zzhuangAllTable.isFaceClickTable = YES;
        self.zzhuangCureTable.isFaceClick = YES;
    }
}

-(void)_requestData {

    if (self.listType == FigureType || self.listType == ZhengZhuangType) {
        [self _requestFirstTableData];
    }else if (self.listType == FoodCalculatorType){
        [self _requestFoodCalculatorFirstTableData];
    }
}

-(void)_initTable{
    
    WEAK_SELF;
    self.zzhuangAllTable.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.zzhuangAllTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.zzhuangAllTable.clickZhengZhuangItemBlock = ^(long ID){
        
        if (self.listType == FoodCalculatorType) {
            [weak_self _requestFoodCalcelatorSecondTableDataWithID:@(ID)];
        }else {
            [weak_self _requestSecondTableDataWithID:@(ID)];
        }

    };
    
  
    self.zzhuangCureTable.testBlock = ^(long ID){
        
        FaceDetailVC *faceDetaiVC = [[FaceDetailVC alloc] init];
        faceDetaiVC.faceDetailID = ID;
        [weak_self.navigationController pushViewController:faceDetaiVC animated:YES];
        
        
    };
    
    self.zzhuangCureTable.foodCulateBlock = ^(NSDictionary *dic){
        FoodCuculatorVC *foodCulVC = [[FoodCuculatorVC alloc] init];
        foodCulVC.foodDic = dic;
        [weak_self.navigationController pushViewController:foodCulVC animated:YES];
    };//食物计算器push

    self.zzhuangCureTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.zzhuangCureTable.showsVerticalScrollIndicator = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}

#pragma mark - 请求第一张表数据
-(void)_requestFirstTableData{
    
    NSLog(@"selfID:%ld",self.fen_lie_ID);
    SnsInformationClassRequest *request = [[SnsInformationClassRequest alloc] init:GetToken];
    request.api_parentClassId = @(self.fen_lie_ID);
    
    [_vapManager snsInformationClass:request success:^(AFHTTPRequestOperation *operation, SnsInformationClassResponse *response) {
        
        [self _dealWithFirstTableData:response.informationClasses];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error.localizedDescription);
        
    }];
    
}//请求第一张表数据


#pragma mark - 请求第二张表数据
-(void)_requestSecondTableDataWithID:(NSNumber *)ID{
    
    SnsInformationAllListRequest *request = [[SnsInformationAllListRequest alloc] init:GetToken];
    request.api_classId = ID;
    [_vapManager snsInformationAllList:request success:^(AFHTTPRequestOperation *operation, SnsInformationAllListResponse *response) {
        
        [self _dealWithSecondTableData:response.informations];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error.localizedDescription);
        
    }];
    
}//请求第二张表数据



-(void)_dealWithFirstTableData:(NSArray *)firstArr {

    
    self.firstTableArr = [firstArr mutableCopy];
    //计算第一个表的单元格高度
    if (self.listType == FoodCalculatorType) {
        [self _calCellHeightWithArr:self.firstTableArr withKey:@"name"]  ;
    }else {
        [self _calCellHeightWithArr:self.firstTableArr withKey:@"icName"];
    }
  
    self.zzhuangAllTable.data = self.firstTableArr;
    [self.zzhuangAllTable reloadData];
    
    if (self.firstTableArr.count > 0) {
         //请求第二张表数据，默认第一个分类
         NSDictionary *firstDic = self.firstTableArr[0];
         NSNumber     *classID = firstDic[@"id"];
        if (self.listType == FoodCalculatorType) {//食物计算器
            [self _requestFoodCalcelatorSecondTableDataWithID:classID];
        }else {
            [self _requestSecondTableDataWithID:classID];
        }
    }
}


- (void)_dealWithSecondTableData:(NSArray *)firstArr  {
    
    self.seCondTableArr = firstArr;
    //刷新表
    self.zzhuangCureTable.data = self.seCondTableArr;
    [self.zzhuangCureTable reloadData];
    
}



-(void)_calCellHeightWithArr:(NSArray *)arr withKey:(NSString *)strKey{
    
    NSMutableArray *zzhuangAllCellHeightArr = [NSMutableArray arrayWithCapacity:0];
    //计算cell高度
    for (NSDictionary *dic in arr) {
        NSString *str = dic[strKey];
        CGFloat height = kStringSize(str, 16.0, 200, 200).height + 37;
        JGLog(@"height:%f",height);
        CGSize size = [str boundingRectWithSize:CGSizeMake(300, 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSAttachmentAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
        JGLog(@"seH:%f",size.height);
        CGFloat h = size.height;
        h = h + 37;
        [zzhuangAllCellHeightArr addObject:@(h)];
    }
    
    self.zzhuangAllTable.cellHeightArr = zzhuangAllCellHeightArr;
    
}//面部表算高度

#pragma mark ----------------------- 食物计算器接口请求 -----------------------
-(void)_requestFoodCalculatorFirstTableData {
    
    SnsFoodListRequest *reqest = [[SnsFoodListRequest alloc] init:GetToken];
    reqest.api_pageNum = @1;
    reqest.api_pageSize = @50;
    [_vapManager snsFoodList:reqest success:^(AFHTTPRequestOperation *operation, SnsFoodListResponse *response) {
        
        NSLog(@"食物计算器 response %@",response);
        [self _dealWithFirstTableData:response.foodClassList];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}


-(void)_requestFoodCalcelatorSecondTableDataWithID:(NSNumber *)foodClassID {

    SnsFoodCaloriesListRequest *request = [[SnsFoodCaloriesListRequest alloc] init:GetToken];
    request.api_classId = foodClassID;
    [_vapManager snsFoodCaloriesList:request success:^(AFHTTPRequestOperation *operation, SnsFoodCaloriesListResponse *response) {
        NSLog(@"食物计算器Second %@",response);
        [self _dealWithSecondTableData:response.foodClassList];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}





- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
