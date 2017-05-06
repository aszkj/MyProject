//
//  LeftRightView.m
//  jingGang
//
//  Created by 张康健 on 15/10/25.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "LeftRightView.h"
#import "VApiManager.h"
#import "ZhengZhuangAllTableView.h"
#import "ZhengZhuangCureTable.h"
#import "PublicInfo.h"
#import "FaceDetailVC.h"
#import "GlobeObject.h"
#import "ZhengZhuangListVC.h"
#import "ListVC.h"
#import "UIView+firstResponseController.h"

static NSString *listCellID = @"listCellID";

@interface LeftRightView()<UITableViewDelegate,UITableViewDataSource> {

    VApiManager *_vapManager;
    ZhengZhuangAllTableView *zzhuangAllTable;
    ZhengZhuangCureTable *zzhuangCureTable;
    
    NSMutableArray *_listArr;
    UITableView  *_fenlieTableView;
}

@property (nonatomic,assign)long fen_lie_ID;
@property (nonatomic,strong)NSMutableArray *firstTableArr;
@property (nonatomic,strong)NSArray *seCondTableArr;

@end

@implementation LeftRightView

-(instancetype)initWithFenlieID:(NSInteger)fen_lie_ID frame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        _fen_lie_ID = fen_lie_ID;
        [self _init];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        [self _init];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self _init];
        
    }
    return self;
}

-(void)show {
    
    self.hidden = NO;
    self.hasShow = YES;
    [self _requestData];
    
}


-(void)_requestData {
    
    
    _vapManager = [[VApiManager alloc] init];
    //请求症状或者形体一级分类数据，
    SnsBodyListRequest *request = [[SnsBodyListRequest alloc] init:GetToken];
    if (self.listType == FigureType) {//形体
        request.api_type = @0;
    }else if (self.listType == ZhengZhuangType){//症状
        request.api_type = @1;
    }
    
    [_vapManager snsBodyList:request success:^(AFHTTPRequestOperation *operation, SnsBodyListResponse *response) {
        
        NSLog(@"response %@",response);
        _listArr = [NSMutableArray arrayWithCapacity:response.boyList.count];
        for (NSDictionary *dic in response.boyList) {
            [_listArr addObject:dic];
        }
        
        [_fenlieTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
    }];
    
}


- (void)_init {
    
    
    _fenlieTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    _fenlieTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _fenlieTableView.delegate = self;
    _fenlieTableView.dataSource = self;
    _fenlieTableView.rowHeight = 44.0f;
    _fenlieTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_fenlieTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:listCellID];
    [self addSubview:_fenlieTableView];

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _listArr.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:listCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    NSDictionary *dic = _listArr[indexPath.row];
    cell.textLabel.text = dic[@"name"];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = _listArr[indexPath.row];
    
//    ZhengZhuangListVC *zhengZhuangListVC = [[ZhengZhuangListVC alloc] init];
    ListVC *zhengZhuangListVC = [[ListVC alloc] init];
    if (self.listType == FigureType) {
        zhengZhuangListVC.listType = FigureType;
    }else if (self.listType == ZhengZhuangType){
        zhengZhuangListVC.listType = ZhengZhuangType;
    }
    
    zhengZhuangListVC.fen_lie_ID = [dic[@"id"] longLongValue];
    [self.firstResponseController.navigationController pushViewController:zhengZhuangListVC animated:YES];
}








@end
