//
//  JGClientServerController.m
//  jingGang
//
//  Created by HanZhongchou on 16/1/20.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import "JGClientServerController.h"
#import "JGSettingCell.h"
#import "HelpController.h"
#import "H5page_URl.h"
#import "FeelBackQuestionController.h"
@interface JGClientServerController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic,strong) NSArray *arrayData;

@end

@implementation JGClientServerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    
    // Do any additional setup after loading the view from its nib.
}


- (NSArray *)arrayData
{
    if (!_arrayData) {
        _arrayData = [NSArray arrayWithObjects:@"帮助中心",@"意见反馈",@"联系客服",nil];
    }
    return _arrayData;
}

- (void)initUI
{
    self.navigationItem.title = @"客服中心";
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    self.tableview.tableFooterView = [[UIView alloc]init];
}

#pragma mark ---UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifile = @"JGSettingCell";
    JGSettingCell *cell = (JGSettingCell *)[tableView dequeueReusableCellWithIdentifier:identifile];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"JGSettingCell" owner:self options:nil];
        cell = [nib lastObject];
    }
    cell.labelTitle.text = self.arrayData[indexPath.row];
    if (indexPath.row == 2) {
        cell.labelDetail.text = @"4008-355-788";
    }
    
    return cell;
}
#pragma mark ---UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *controller;
    if (indexPath.row == 0) {//帮助中心
        HelpController *helpVC = [[HelpController alloc]init];
        helpVC.loadUrl = AboutYunESheng;
        controller = helpVC;
    }else if (indexPath.row == 1){//意见反馈
        FeelBackQuestionController *feelBackVC = [[FeelBackQuestionController alloc] init];
        controller = feelBackVC;
    }else if (indexPath.row == 2){//联系客服
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否拨打电话:4008-355-788" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
    
    
    
    if (indexPath.row != 2) {
        [self.navigationController pushViewController:controller animated:YES];
    }
    
}

//点击确定打电话
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4008-355-788"]];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
