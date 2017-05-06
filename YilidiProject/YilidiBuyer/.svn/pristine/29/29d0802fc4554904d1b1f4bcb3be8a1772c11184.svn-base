//
//  DLMyNewsVC.m
//  YilidiBuyer
//
//  Created by yld on 16/5/12.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLMyNewsVC.h"
#import "MycommonTableView.h"
#import "DLMyNewsCell.h"
#import "DLNewsModel.h"
#import "PPiFlatSegmentedControl.h"
#import "NSString+FontAwesome.h"

@interface DLMyNewsVC ()
{
    
    NSArray *_newsArr;
    PPiFlatSegmentedControl *_control;
}
@property (weak, nonatomic) IBOutlet MycommonTableView *myNewsTabbleView;

@property (nonatomic,strong)MycommonTableView *systemTabbleView;
@end

@implementation DLMyNewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
     [self _initSegmentedView];
  
    [self _init];
    [self _requestGetDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark ------------------------Init---------------------------------
- (void)_init{

    [self _initLoadNewsTabbleView];
    [self _initsLoadSystemTabbleView];
}
-(void)_initLoadNewsTabbleView{
    
    _newsArr = @[@{@"data":@{@"xiaoxi":@"个人消息标题个人消息标题个人消息标题",@"xiaoxi2":@"内容消息内容消息内容消息内容消息内容消息内容消息内容消息内容消息内容消息内容消息"}},@{@"data":@{@"xiaoxi":@"个人消息标题个人消息标题个人消息标题",@"xiaoxi2":@"内容消息内容消息内容消息内容消息内容消息内容消息内容消息内容消息内容消息内容消息内容消息内容消息内容消息内容消息内容消息内容消息内容消息内容消息"}}];
    
    self.myNewsTabbleView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.myNewsTabbleView configurecellNibName:@"DLMyNewsCell" cellDataSource:_newsArr configurecellData:^(UITableView *tableView,id cellModel, UITableViewCell *cell) {
        DLMyNewsCell *newsCell = (DLMyNewsCell *)cell;
        DLNewsModel *newsModel = [[DLNewsModel alloc]initWithDefaultDataDic:cellModel[@"data"]];
        [newsCell setMyNewsCell:newsModel];
        
        
        } clickCell:^(UITableView *tableView,id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
       
    }];
    self.myNewsTabbleView.cellHeightBlock = ^CGFloat(UITableView *tableView,id model){
        DLNewsModel *newsModel = [[DLNewsModel alloc]initWithDefaultDataDic:model[@"data"]];
        
        return newsModel.cellHeight;
    };
    WEAK_SELF
    [self.myNewsTabbleView headerRreshRequestBlock:^{
        [weak_self _requestGetDataSource];
    }];
    
   
}

-(void)_initsLoadSystemTabbleView{
    
    _newsArr = @[@{@"data":@{@"xiaoxi":@"系统消息系统消息系统消息系统消息",@"xiaoxi2":@"内容消息内容消息内容消息内容消息内容消息内容息内容消息内容息内容消息内容息内容消息内容息内容消息内容消息内容消息内容消息内容消息内容消息"}},@{@"data":@{@"xiaoxi":@"系统消息",@"xiaoxi2":@"内容消息内容消息内容消息内容消息内容消息内容消息内容消息内容消息内容消息内容消息"}}];
    self.systemTabbleView = [[MycommonTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    self.systemTabbleView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.systemTabbleView.hidden=YES;
    self.systemTabbleView.cellHeightBlock = ^CGFloat(UITableView *tableView,id model){
        DLNewsModel *newsModel = [[DLNewsModel alloc]initWithDefaultDataDic:model[@"data"]];
        
        return newsModel.cellHeight;
    };
    [self.systemTabbleView configurecellNibName:@"DLMyNewsCell" cellDataSource:_newsArr configurecellData:^(UITableView *tableView,id cellModel, UITableViewCell *cell) {
        DLMyNewsCell *newsCell = (DLMyNewsCell *)cell;
        DLNewsModel *newsModel = [[DLNewsModel alloc]initWithDefaultDataDic:cellModel[@"data"]];
        [newsCell setMyNewsCell:newsModel];
       
        
        
    } clickCell:^(UITableView *tableView,id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        
    }];
    
    WEAK_SELF
    [self.systemTabbleView headerRreshRequestBlock:^{
        [weak_self _requestGetDataSource];
    }];
     [self.view addSubview:self.systemTabbleView];
}

-(void)_initSegmentedView {
    _control=[[PPiFlatSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/2, 30) items:@[@{@"text":@"用户消息"},@{@"text":@"系统消息"}]
                                                                iconPosition:IconPositionRight andSelectionBlock:^(NSUInteger segmentIndex) {
                                                                    if (segmentIndex==0) {
                                                                        self.myNewsTabbleView.hidden=NO;
                                                                        self.systemTabbleView.hidden=YES;
                                                                    }else{
                                                                        self.myNewsTabbleView.hidden=YES;
                                                                        self.systemTabbleView.hidden=NO;
                                                                    }
                                                                    
                                                                }];
    _control.color=[UIColor whiteColor];
    _control.borderWidth=1;
    _control.borderColor=kGetColor(255,88,0);
    _control.selectedColor=kGetColor(254, 254, 142);
    _control.textAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor blackColor]};
    _control.selectedTextAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor blackColor]};
    self.navigationItem.titleView=_control;

}
#pragma mark ------------------------Private-------------------------
- (void)_requestGetDataSource{
//    //上下拉刷新
//    WEAK_SELF
//    [AFNHttpRequestOPManager getInfoWithSubUrl:kUrl_GoodsCoupon parameters:nil block:^(id result, NSError *error) {
//        JLog(@"%@",result[@"data"]);
//        [weak_self.myNewsTabbleView configureTableAfterRequestData:result[@"data"]];
//        [weak_self.systemTabbleView configureTableAfterRequestData:result[@"data"]];
//    }];

}

#pragma mark ------------------------Api----------------------------------

#pragma mark ------------------------Page Navigate---------------------------


#pragma mark ------------------------View Event---------------------------


#pragma mark ------------------------Delegate-----------------------------


#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------



@end
