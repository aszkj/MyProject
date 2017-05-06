//
//  WInputXingViewController.m
//  jingGang
//
//  Created by thinker on 15/10/23.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "WInputXingViewController.h"
#import "PublicInfo.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "Util.h"
#import "MBProgressHUD.h"
#import "WMERResultViewController.h"
#import "MJExtension.h"

@interface WInputXingViewController ()
@property (weak, nonatomic) IBOutlet UILabel *xingLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;

@end

@implementation WInputXingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

#pragma mark - 请求界面参数
-(void) requestData
{
    WEAK_SELF
    ReportItemRequest *request = [[ReportItemRequest alloc] init:GetToken];
    request.api_id = self.api_itemId;
    [self.vapiManager reportItem:request success:^(AFHTTPRequestOperation *operation, ReportItemResponse *response) {
        ResultItem *item = [ResultItem objectWithKeyValues:response.resultItem];
        weak_self.xingLabel.text = [item.referenceValue intValue] ? @"阳" :@"阴";
        weak_self.nameLable.text = item.itemName;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
}

#pragma mark - 实例化UI
- (void)initUI
{
    if (self.detailsModel) {
        self.nameLable.text = self.detailsModel.physicalName;
        self.xingLabel.text = self.detailsModel.positive.intValue ? @"阳" : @"阴";
    }
    NSString *dateStr = self.createTime ? self.createTime :[kUserDefaults objectForKey:kMERTime];
    NSMutableCharacterSet *set = [[NSMutableCharacterSet alloc] init];
    [set addCharactersInString:@"-"];
    [set addCharactersInString:@" "];
    NSArray *dateArray = [dateStr componentsSeparatedByCharactersInSet:set];
    [Util setNavTitleWithTitle:[NSString stringWithFormat:@"%@年%@月%@日体检报告",dateArray[0],dateArray[1],dateArray[2]] ofVC:self];
    
    self.view.backgroundColor = background_Color;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(btnClick) target:self];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
}
#pragma mark - 阳性事件
- (IBAction)yanAction:(id)sender {
    NSLog(@"action ---- %@",@"阳性");
    [self saveData:1];
}
#pragma mark - 阴性事件
- (IBAction)yinAction:(id)sender {
    NSLog(@"action ---- %@",@"阴性");
    [self saveData:0];
}
#pragma mark - 保存数据到服务器 0阴性1阳性
- (void)saveData:(NSInteger)value
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud show:YES];
    ReportResultDetailsSaveRequest *saveRequest = [[ReportResultDetailsSaveRequest alloc] init:GetToken];
    saveRequest.api_itemId = self.api_itemId;
    saveRequest.api_replyId = self.api_replyId ? self.api_replyId :[kUserDefaults objectForKey:kMERID];
    saveRequest.api_value = @(value);
    saveRequest.api_detailsId = self.detailsModel.id;
    WEAK_SELF
    [self.vapiManager reportResultDetailsSave:saveRequest success:^(AFHTTPRequestOperation *operation, ReportResultDetailsSaveResponse *response) {
        NSLog(@"阴阳性 ---- %@",response);
        [MBProgressHUD hideAllHUDsForView: weak_self.view animated: YES];
        if (!response.errorCode) {
            WMERResultViewController *resultVC = [[WMERResultViewController alloc] initWithNibName:@"WMERResultViewController" bundle:nil];
            resultVC.createTime = weak_self.createTime ? weak_self.createTime : [kUserDefaults objectForKey:kMERTime];
            resultVC.apiId = weak_self.api_replyId ? weak_self.api_replyId : [kUserDefaults objectForKey:kMERID];
            [weak_self.navigationController pushViewController:resultVC animated:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error  ---- %@",error);
        [MBProgressHUD hideAllHUDsForView: weak_self.view animated: YES];
        [weak_self errorHandle:error];
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.api_itemId) {
        [self requestData];
    }
}

//返回上一级界面
- (void) btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
