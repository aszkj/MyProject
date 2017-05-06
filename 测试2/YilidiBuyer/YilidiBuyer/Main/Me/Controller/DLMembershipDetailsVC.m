//
//  DLMembershipDetailsVC.m
//  YilidiBuyer
//
//  Created by yld on 16/5/12.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLMembershipDetailsVC.h"
#import "MycommonTableView.h"
#import "DLMemberProductModel.h"
#import "DLMemberProductCell.h"

@interface DLMembershipDetailsVC ()
{

    NSArray *_productArr;
}
@property (weak, nonatomic) IBOutlet MycommonTableView *productTabbleView;

@end

@implementation DLMembershipDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _initTabbleView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ------------------------Init---------------------------------
-(void)_initTabbleView {
    self.productTabbleView.cellHeight = 90.0f;
    self.productTabbleView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight/3-60)];
    headView.backgroundColor = [UIColor orangeColor];
    self.productTabbleView.tableHeaderView =headView;
    NSArray *arr = @[@{@"productName":@"黑美人黑美人黑美人",
                       @"imageUrl":@"http://183.2.185.81:9400/3/31b023bd3f",@"productPrice":@18,@"count":@"2"},@{@"productName":@"黑美人黑美人黑美人22",                                                       @"imageUrl":@"http://183.2.185.81:9400/3/31b023bd3f",@"productPrice":@25,@"count":@"1"}];
    _productArr = [DLMemberProductModel objectMemberProductModelWithArr:arr];
     NSMutableArray *array = [[NSMutableArray alloc]init];
    for (DLMemberProductModel *model in _productArr) {
        [array addObject:[NSString stringWithFormat:@"%@",[model.productPrice stringValue]]];
    }
    
    NSNumber *sum = [array valueForKeyPath:@"@sum.floatValue"];
    _totalPrice.text  = [sum stringValue];
    
    
    [self.productTabbleView configurecellNibName:@"DLMemberProductCell" cellDataSource:_productArr configurecellData:^(UITableView *tableView,id cellModel, UITableViewCell *cell) {
         DLMemberProductModel *model = (DLMemberProductModel *)cellModel;
        DLMemberProductCell *showCell = (DLMemberProductCell *)cell;
        [showCell setModel:model];

       
        
    } clickCell:^(UITableView *tableView,id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        
    }];

}
#pragma mark ------------------------Private-------------------------


#pragma mark ------------------------Api----------------------------------

#pragma mark ------------------------Page Navigate---------------------------


#pragma mark ------------------------View Event---------------------------

#pragma mark ------------------------Delegate-----------------------------


#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------

#pragma mark ------------------------Init---------------------------------


@end
