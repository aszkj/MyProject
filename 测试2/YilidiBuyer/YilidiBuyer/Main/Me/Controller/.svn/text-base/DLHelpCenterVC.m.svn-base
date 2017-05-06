//
//  DLHelpCenterVC.m
//  YilidiBuyer
//
//  Created by yld on 16/5/13.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLHelpCenterVC.h"
#import "DLHelpView.h"
#import "DLHelpCenterCell.h"
#import "DLHelpModel.h"
@interface DLHelpCenterVC ()<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *helpCenterTabbleView;
@property (nonatomic,strong) NSMutableArray *helpContentArr;
@property (nonatomic,strong) NSArray *titleArr;
@property (nonatomic,strong) NSMutableArray *sectionStatus;

@end

@implementation DLHelpCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createData];
    [self _initLoadHelPcenterTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ------------------------Init---------------------------------
- (void)createData {

    //将模型添加到数组中
    DLHelpModel *model = [[DLHelpModel alloc]initWithcontent:@"测试数据测试数据测试数据测试数据测试数据"];
    
    DLHelpModel *model2 = [[DLHelpModel alloc]initWithcontent:@"测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据"];
   
    DLHelpModel *model3 = [[DLHelpModel alloc]initWithcontent:@"测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据"];
    
    DLHelpModel *model4 = [[DLHelpModel alloc]initWithcontent:@"测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据"];
    
  
    DLHelpModel *model5 = [[DLHelpModel alloc]initWithcontent:@"测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据"];
    
   _helpContentArr= (NSMutableArray *)@[@[model],@[model2],@[model3],@[model4],@[model5]];

    //初始化每个区的开关状态
    _sectionStatus = [[NSMutableArray alloc] init];
    _titleArr = @[@"一里递的服务时间",@"一里递配送范围",@"设想客户的提问解答",@"设想客户的提问解答",@"设想客户的提问解答"];
 
    for (NSString *name in _titleArr) {
        JLog(@"%@",name);
        [_sectionStatus addObject:@0];
       
    }

}

- (void)_initLoadHelPcenterTableView {

    _helpCenterTabbleView.delegate = self;
    _helpCenterTabbleView.dataSource = self;
    _helpCenterTabbleView.separatorStyle = UITableViewCellSeparatorStyleNone;
     [_helpCenterTabbleView registerNib:[UINib nibWithNibName:@"DLHelpCenterCell" bundle:nil] forCellReuseIdentifier:@"DLHelpCenterCell"];

}
#pragma mark ------------------------Private-------------------------


#pragma mark ------------------------Api----------------------------------
#pragma mark ------------------------Page Navigate---------------------------


#pragma mark ------------------------View Event---------------------------


#pragma mark ------------------------Delegate-----------------------------
#pragma mark - 区视图
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

#pragma mark - Table view data source
//tabView一共有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.helpContentArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_sectionStatus[section] isEqualToNumber:@0]) {
        return 0;
    }

    NSArray *arr2= self.helpContentArr[section];
    
    return[arr2 count];
    
}// 表中组的数量


//3.告知系统每一行显示什么内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     DLHelpCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DLHelpCenterCell" forIndexPath:indexPath];
    if (!cell) {
        cell  = [[DLHelpCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DLHelpCenterCell"];
    }

    cell.model =_helpContentArr[indexPath.section][indexPath.row];

    return cell;
}//创建（复用）单元格

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *title = _titleArr[section];
    DLHelpView *header = [[DLHelpView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    BOOL status = [_sectionStatus[section] boolValue];
    [header updateWith:title WithStatus:status];
    header.block =^{
        NSNumber *num = status? @0 :@1;
        [_sectionStatus replaceObjectAtIndex:section withObject:num];
        //重新加载当前区
        [self.helpCenterTabbleView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DLHelpModel *model = self.helpContentArr[indexPath.section][indexPath.row];
    
    return model.cellHeight;
}

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------
-(NSArray *)helpContentArr{
    
    
    if (!_helpContentArr) {
        
        
        _helpContentArr = [NSMutableArray array];
        
    }
    return _helpContentArr;
}

#pragma mark ------------------------Init---------------------------------


@end
