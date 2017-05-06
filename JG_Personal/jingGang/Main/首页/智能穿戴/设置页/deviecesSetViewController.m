//
//  deviecesSetViewController.m
//  jingGang
//
//  Created by yi jiehuang on 15/6/5.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "deviecesSetViewController.h"
#import "PublicInfo.h"
#import "devieseSetTableViewCell.h"
#import "myDecieseViewController.h"
#import "mySineViewController.h"
#import "GlobeObject.h"

@interface deviecesSetViewController ()
{
    UITableView       *_myTableView;
}

@end

@implementation deviecesSetViewController

- (void)dealloc
{

}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"home_title"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barTintColor = kGetColor(94, 180, 231);

    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 44)];
    titleLabel.text = @"设置";
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;

    
    //    [self.navigationController.navigationBar addSubview:titleLabel];[titleLabel release];
    UIButton *leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0.0f, 16.0f, 40.0f, 25.0f)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButton;
    RELEASE(leftBtn);
    RELEASE(leftButton);

    UIButton *rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(0.0f, 16.0f, 40.0f, 44.0f)];
//    [rightBtn setBackgroundImage:[UIImage imageNamed:@"home_add"] forState:UIControlStateNormal];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    RELEASE(rightBtn);
    RELEASE(rightButton);
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1];

    _myTableView = [[UITableView alloc]init];
    _myTableView.frame = CGRectMake(0, 10, __MainScreen_Width, 47*2);
    _myTableView.rowHeight = 47;
    _myTableView.backgroundColor = [UIColor whiteColor];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [self.view addSubview:_myTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellstr = @"cellStr";
    devieseSetTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellstr];
    if (!cell) {
        NSArray * array = [[NSBundle mainBundle]loadNibNamed:@"devieseSetTableViewCell" owner:self options:nil];
        cell = [array firstObject];
    }
    if (indexPath.row == 1) {
        cell._left_img.image = [UIImage imageNamed:@"home_mytarget"];
        cell._name_lab.text = @"我的目标";
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        myDecieseViewController * mydecieseVc = [[myDecieseViewController alloc]init];
        [self.navigationController pushViewController:mydecieseVc animated:YES];

    }else{
        mySineViewController * mySineVc = [[mySineViewController alloc]init];
        [self.navigationController pushViewController:mySineVc animated:YES];

    }
}

-(void)viewDidLayoutSubviews
{
    if ([_myTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_myTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([_myTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_myTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


- (void)backToMain
{

//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        if (self.isPopBlock) {//标志pop返回
//            self.isPopBlock();
//        }
//
//    });
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
