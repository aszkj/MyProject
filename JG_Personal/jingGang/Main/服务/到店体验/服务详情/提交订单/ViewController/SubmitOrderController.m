//
//  SubmitOrderController.m
//  jingGang
//
//  Created by 鹏 朱 on 15/9/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "SubmitOrderController.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "urlManagerHeader.h"
#import "SubmitOrderCell.h"
#import "AddSubCountView.h"
#import "MBProgressHUD.h"
#import "PayOrderViewController.h"
#import "UIImageView+WebCache.h"

@interface SubmitOrderController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic,strong) VApiManager *vapManager;
@property(nonatomic,strong) AddSubCountView *addSubCountView;
@property(nonatomic,strong) UILabel *totalCountLb;

@end

@implementation SubmitOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];

    CGRect frame = CGRectMake(0, 0, __MainScreen_Width, __MainScreen_Height);
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView setSeparatorInset:UIEdgeInsetsZero];
    _tableView.contentOffset = CGPointMake(0, 0);
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
    
    self.dataSource = [[NSMutableArray alloc] initWithObjects:@"鹤祥宫养生",@"数量",@"小计", nil];
    
    [self _loadTitleView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methord
#pragma mark- 初始化UI界面

- (void)initUI
{
    self.maxNum = NSIntegerMax;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(goBack) target:self];

    //设置背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
}

#pragma mark- 导航返回
-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)_loadTitleView{
    
    //这里我们设置的是颜色，还可以设置shadow等，具体可以参见api
    NSDictionary * dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;

//    [Util setTitleViewWithTitle:@"提交订单" andNav:self.navigationController];
    self.title = @"提交订单";
}

- (UIView *)createHeaderView
{
    UIView *bgHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 43 + 25)];
    bgHeaderView.backgroundColor = self.view.backgroundColor;
    
    UIButton *submit = [UIButton buttonWithType:UIButtonTypeCustom];
    submit.backgroundColor = kGetColor(89, 196, 240);
    submit.layer.cornerRadius = kRadius;
    submit.layer.masksToBounds = YES;
    [submit setTitle:@"提交订单" forState:UIControlStateNormal];
    [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(submitOrderInfo) forControlEvents:UIControlEventTouchUpInside];
    [bgHeaderView addSubview:submit];
    
    [submit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(__MainScreen_Width - 30, 43));
        make.left.equalTo(bgHeaderView.mas_left).with.offset(15);
        make.bottom.equalTo(bgHeaderView.mas_bottom).with.offset(0);
    }];
    
    return bgHeaderView;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return 43 + 25;
    } else {
        return 0.1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return [self createHeaderView];
    } else {
        UIView *bgHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 10)];
        bgHeader.backgroundColor = self.view.backgroundColor;
        
        return bgHeader;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    } else if (section == 1) {
        return 1;
    } else if (section == 2) {
        return 10;
    }
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SettingCellIdentifier = @"SettingCellIdentifier";
    if (indexPath.section < self.dataSource.count) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SettingCellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:SettingCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            cell.textLabel.font = kFontSize13;
            cell.textLabel.textColor = KColorText999999;
            cell.detailTextLabel.font = kFontSize15;
        }
        
        if (indexPath.section == 0) {
            
            SubmitOrderCell *submitOrderCell = [[SubmitOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

            submitOrderCell.price.text = [NSString stringWithFormat:@"￥%.2f",self.price.floatValue];
            submitOrderCell.title.text = self.serviceName;
            submitOrderCell.store.text = self.serviceDetail.storeName;
            UIImageView *groupImage = submitOrderCell.serviceImage;
            [groupImage sd_setImageWithURL:[NSURL URLWithString:TwiceImgUrlStr(self.serviceDetail.groupAccPath, CGRectGetWidth(groupImage.frame), CGRectGetHeight(groupImage.frame))] placeholderImage:[UIImage imageNamed:@"com_cancel_pressed"]];

            return submitOrderCell;
        } else if (indexPath.section == 1) {
            cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.section];
            cell.detailTextLabel.text = @"";
            
          AddSubCountView *addSubCountView = [AddSubCountView showInContentView:cell goodStockCount:self.maxNum size:CGSizeMake(108, 30)];
            WEAK_SELF
            addSubCountView.countChangedBlk = ^(NSInteger count){
                
                weak_self.totalCountLb.text = [NSString stringWithFormat:@"%.2f", [weak_self.price floatValue] * count];
            };
          self.addSubCountView = addSubCountView;
            
        } if (indexPath.section == 2) {
            
            cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.section];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%.2f", [self.price floatValue] * self.addSubCountView.buyGoodsCount];
            cell.detailTextLabel.textColor = KColorText5AC4F1;
            self.totalCountLb = cell.detailTextLabel;
        }
        
        return cell;
    }
    
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44.0;
    if (indexPath.section == 0) {
        height = 65;
    }
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma getter

- (VApiManager *)vapManager
{
    if (!_vapManager) {
        _vapManager = [[VApiManager alloc] init];
    }
    return _vapManager;
}

#pragma mark - private methord

- (void)submitOrderInfo {
    [self _requestPersonalPayPage];
}

#pragma mark - 接口请求

#pragma mark - 提交订单接口
-(void)_requestPersonalPayPage {
    
    PersonalPayPageRequest *request = [[PersonalPayPageRequest alloc] init:GetToken];
    request.api_id = [NSNumber numberWithInteger:self.serviceId];
    request.api_count = [NSNumber numberWithInteger:self.addSubCountView.buyGoodsCount];
    
    WEAK_SELF
    [self.vapManager personalPayPage:request success:^(AFHTTPRequestOperation *operation, PersonalPayPageResponse *response) {
        
        if (IsEmpty(response.errorCode)) {
            NSLog(@"提交成功");
            
            NSDictionary *dic = (NSDictionary *)response.payPage;
            
            if (response.payPage) {
                PayOrderViewController *VC = [[PayOrderViewController alloc] initWithNibName:@"PayOrderViewController" bundle:nil];
                VC.orderID = [NSNumber numberWithInteger:[dic[@"id"] integerValue]];
                if (dic[@"orderId"]) {
                    VC.orderNumber = [NSString stringWithFormat:@"%@",dic[@"orderId"]];
                } else {
                    VC.orderNumber = @"";
                }
                if (dic[@"totalPrice" ]) {
                    VC.totalPrice = [dic[@"totalPrice" ] floatValue];
                } else {
                    VC.totalPrice = 0;
                }
                VC.jingGangPay = O2OPay;
                [self.navigationController pushViewController:VC animated:YES];
            } else {
                MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:weak_self.view animated:YES];
                hub.labelText = @"提交失败";
                [hub hide:YES afterDelay:1.5];
            }
        } else {
            NSLog(@"%@",response.subCode);
            MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:weak_self.view animated:YES];
            hub.labelText = @"提交失败";
            [hub hide:YES afterDelay:1.5];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:weak_self.view animated:YES];
        hub.labelText = @"提交失败";
        [hub hide:YES afterDelay:1.5];
    }];
}

@end
