//
//  DLCashierVC.m
//  YilidiBuyer
//
//  Created by yld on 16/5/16.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLCashierVC.h"
#import "DLCashierCell.h"
@interface DLCashierVC ()<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *cashierTableView;
@property (nonatomic,strong)UILabel *payMoneyLabel;//金额
@end

@implementation DLCashierVC

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self _initLoadCashierTableiView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ------------------------Init---------------------------------
- (void)_initLoadCashierTableiView{

    self.pageTitle = @"一里递收银台";
    [self.cashierTableView registerNib:[UINib nibWithNibName:@"DLCashierCell" bundle:nil] forCellReuseIdentifier:@"DLCashierCell"];
    [self _setExtraCellLineHidden:self.cashierTableView];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, 60)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 150, 30)];
    label.text = @"请支付金额";
    label.textColor = UIColorFromRGB(0x8E8E8E);
    label.font = [UIFont systemFontOfSize:16];
    
    _payMoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-130, 15, 130, 30)];
    _payMoneyLabel.textColor = UIColorFromRGB(0xFF5800);
    _payMoneyLabel.font = [UIFont systemFontOfSize:15];
    _payMoneyLabel.textAlignment = NSTextAlignmentCenter;
    _payMoneyLabel.text = @"￥58000";
    [headerView addSubview:label];
    [headerView addSubview:_payMoneyLabel];
    
    self.cashierTableView.tableHeaderView = headerView;

}
#pragma mark ------------------------Private-------------------------
/***清除tableView多余的线***/
- (void)_setExtraCellLineHidden:(UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    
    view.backgroundColor = [UIColor clearColor];
    //线从最左边开始延伸显示
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
    [tableView setTableFooterView:view];
    
}


#pragma mark ------------------------Api----------------------------------
#pragma mark ------------------------Page Navigate---------------------------


#pragma mark ------------------------View Event---------------------------

#pragma mark ------------------------Delegate-----------------------------



#pragma -- mark UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {


    return 2;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
  
    
}


//线从最左边开始延伸显示
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DLCashierCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DLCashierCell"];

        switch (indexPath.row) {
            case 0:
                cell.titleLabel.text = @"微信支付";
                cell.contentLabel.text = @"微信安全支付";
                cell.image.image = [UIImage imageNamed:@"wechat"];
                
                break;
                
            case 1:
                cell.titleLabel.text = @"支付宝";
                cell.contentLabel.text = @"支付宝支付";
                cell.image.image = [UIImage imageNamed:@"zhifubao"];
                
            default:
                break;
        }
    
    return cell;
}

//自定义组头
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49, kScreenWidth, 1)];
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    bgView.backgroundColor = UIColorFromRGB(0xE1E1E1);
    lineView.backgroundColor = UIColorFromRGB(0xE1E1E1);
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 25, 80, 10)];
    label.text = @"支付方式";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor =UIColorFromRGB(0x8E8E8E);
    [sectionView addSubview:lineView];
    [sectionView addSubview:bgView];
    [sectionView addSubview:label];
    [tableView reloadData];
    return sectionView;
}


#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------




@end
