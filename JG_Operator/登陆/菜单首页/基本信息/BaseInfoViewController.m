//
//  BaseInfoViewController.m
//  Operator_JingGang
//
//  Created by ray on 15/9/18.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "BaseInfoViewController.h"
#import "BaseInfoPhotoTableViewCell.h"
#import "BaseInfoViewModel.h"
#import "KJLoginController.h"
#import "XKO_BaseInfoResponseInfo.h"


@interface BaseInfoTableViewCell : UITableViewCell


@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation BaseInfoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth - 30, 44)];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = UIColorFromRGB(0X333333);
    [self.contentView addSubview:self.titleLabel];
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 43, kScreenWidth, 0.3)];
    v.backgroundColor = UIColorFromRGB(0XD7D7D7);
    [self.contentView addSubview:v];
}

@end

static NSString *baseInfoCell = @"baseInfoCell";
static NSString *baseinfoPhotoCell = @"baseinfoPhotoCell";

@interface BaseInfoViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *acrivity;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic) BaseInfoViewModel *viewModel;

@end

@implementation BaseInfoViewController

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section > 1)
    {
        return 1;
    }
    NSArray *array = self.dataSource[section];
    return array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section > 1)
    {
        BaseInfoPhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:baseinfoPhotoCell];
        NSDictionary *dict = self.dataSource[indexPath.section];
        cell.dataImage = dict[@"content"];
        return cell;
    }
    NSArray *array = self.dataSource[indexPath.section];
    BaseInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:baseInfoCell];
    cell.titleLabel.text = array[indexPath.row];
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section > 1)
    {
        return 90;
    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section < 2)
    {
        return 6;
    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1)
    {
        return 6;
    }
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section < 2)
    {
        return nil;
    }
    UIView *v = [[UIView alloc ]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    v.backgroundColor = [UIColor whiteColor];
    UILabel *lable =[[UILabel alloc ]initWithFrame:CGRectMake(15, 0, kScreenWidth - 30, 44)];
    lable.font = [UIFont systemFontOfSize:14];
    lable.textColor = UIColorFromRGB(0X333333);
    lable.text = self.dataSource[section][@"title"];
    [v addSubview:lable];
    return v;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)bindViewModel
{
    [super bindViewModel];
    WEAK_SELF
    XKO_BaseInfoRequestInfo *info = [[XKO_BaseInfoRequestInfo alloc] init];
    [self.dataCenter requestOperatorInfoFromModel:info successBlk:^(NSArray *responseData) {
        XKO_BaseInfoResponseInfo *response = responseData[0];
        NSMutableArray *info1 = [NSMutableArray array];
        [info1 addObject:[NSString stringWithFormat:@"姓名：%@",response.userName]];
        [info1 addObject:[NSString stringWithFormat:@"性别：%@",[response.sex boolValue] == 1 ? @"男":@"女"]];
        [info1 addObject:[NSString stringWithFormat:@"手机号：%@",response.phone]];
        [info1 addObject:[NSString stringWithFormat:@"联系地址：%@",response.address]];
        [info1 addObject:[NSString stringWithFormat:@"身份证号：%@",response.idCard]];
        [info1 addObject:[NSString stringWithFormat:@"民族：%@",response.nation]];
        [info1 addObject:[NSString stringWithFormat:@"运营商级别：%@",[response.level intValue] == 1 ? @"市级运营商":[response.level intValue] == 2 ? @"区级运营商":@"区域级运营商"]];
        [info1 addObject:[NSString stringWithFormat:@"运营地：%@",response.area]];
        [info1 addObject:[NSString stringWithFormat:@"运营商名称：%@",response.operatorName.length ? response.operatorName:@"无"]];
        [info1 addObject:[NSString stringWithFormat:@"运营商编号：%@",response.operatorCode]];
        [info1 addObject:[NSString stringWithFormat:@"邀请码：%@",response.invitationCode.length ? response.invitationCode:@"无"]];
        

        NSMutableArray *info2 = [NSMutableArray array];
        [info2 addObject:[NSString stringWithFormat:@"推荐人：%@",response.refereeName.length ? response.refereeName:@"无"]];
        [info2 addObject:[NSString stringWithFormat:@"开户行：%@",response.bankName]];
        [info2 addObject:[NSString stringWithFormat:@"开户支行：%@",response.subBankName]];
        [info2 addObject:[NSString stringWithFormat:@"银行账户：%@",response.bankNo]];
        [info2 addObject:[NSString stringWithFormat:@"组织机构代码：%@",response.organizationNo.length ? response.organizationNo:@"无"]];
        [info2 addObject:[NSString stringWithFormat:@"营业执照号：%@",response.registrationNo.length ? response.registrationNo : @"无"]];
        [info2 addObject:[NSString stringWithFormat:@"税务登记号：%@",response.taxNo.length ? response.taxNo :@"无"]];
        
        [weak_self.dataSource addObject:info1];
        [weak_self.dataSource addObject:info2];
        if (response.organizationPath)
        {
            [weak_self.dataSource addObject:@{@"title":@"组织机构照片",@"content":@[response.organizationPath]}];
        }
        if (response.registrationPath)
        {
            [weak_self.dataSource addObject:@{@"title":@"营业执照",@"content":@[response.registrationPath]}];
        }
        if (response.taxPath)
        {
            [weak_self.dataSource addObject:@{@"title":@"税务登记证照片",@"content":@[response.taxPath]}];
        }
        
        [weak_self.tableView reloadData];
        weak_self.acrivity.hidden = YES;
    } failBlk:^(NSError *error) {
        weak_self.acrivity.hidden = YES;
        weak_self.viewModel.error = error;
    }];
}
- (NSError *)createError:(NSString *)errorString {
    NSError *error = nil;
    if (errorString.length > 0) {
        error = [[NSError alloc] initWithDomain:@"" code:-1 userInfo:[NSDictionary dictionaryWithObject:errorString                                                                      forKey:NSLocalizedDescriptionKey]];
    }
    return error;
}

- (void)setUIAppearance
{
    [super setUIAppearance];

    [self.tableView registerClass:[BaseInfoTableViewCell class] forCellReuseIdentifier:baseInfoCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"BaseInfoPhotoTableViewCell" bundle:nil] forCellReuseIdentifier:baseinfoPhotoCell];
    self.dataSource = [NSMutableArray array];
    
    [Util setNavTitleWithTitle:@"基本信息" ofVC:self];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(btnClick) target:self];
}
- (void)btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BaseInfoViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[BaseInfoViewModel alloc] init];
    }
    return _viewModel;
}

@end
