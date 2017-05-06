//
//  WInputMERViewController.m
//  jingGang
//
//  Created by thinker on 15/10/22.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "WInputMERViewController.h"
#import "Util.h"
#import "VApiManager.h"
#import "PublicInfo.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "IQKeyboardManager.h"
#import "MBProgressHUD.h"
#import "WMERResultViewController.h"


@interface WInputMERViewController ()
@property (weak, nonatomic) IBOutlet UITextField *valueTextFiedl;
@property (weak, nonatomic) IBOutlet UILabel *tishi;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;

@end

@implementation WInputMERViewController

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
        weak_self.tishi.text = [NSString stringWithFormat:@"参考值：%@-%@/%@",item.minValue,item.maxValue,item.unit];
        weak_self.nameLable.text = item.itemName;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
}

#pragma mark - 实例化UI
- (void)initUI
{
    if (self.detailsModel) {
        if (self.detailsModel.minVale == nil) {
            self.tishi.text = [NSString stringWithFormat:@"参考值：>%@/ul",self.detailsModel.maxValue];
        }
        if (self.detailsModel.maxValue == nil) {
            self.tishi.text = [NSString stringWithFormat:@"参考值：<%@/ul",self.detailsModel.minVale];
        }
        if (self.detailsModel.minVale && self.detailsModel.maxValue) {
            self.tishi.text = [NSString stringWithFormat:@"参考值：%@-%@/ul",self.detailsModel.minVale,self.detailsModel.maxValue];
        }
        self.nameLable.text = self.detailsModel.physicalName;
        self.valueTextFiedl.text = self.detailsModel.referenceValue;
    }
    
    
    NSString *dateStr =  self.createTime ? self.createTime : [kUserDefaults objectForKey:kMERTime];
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
#pragma mark - 保存数据到服务器
- (IBAction)saveData:(id)sender {

    if (![Util varifyValidOfStr:self.valueTextFiedl.text])
    {   
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud show:YES];
    ReportResultDetailsSaveRequest *saveRequest = [[ReportResultDetailsSaveRequest alloc] init:GetToken];
    saveRequest.api_itemId = self.api_itemId;
    saveRequest.api_replyId = self.api_replyId ? self.api_replyId : [kUserDefaults objectForKey:kMERID];
    saveRequest.api_value = @([self.valueTextFiedl.text floatValue]);
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

//返回上一级界面
- (void) btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.api_itemId) {
        [self requestData];
    }
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:NO];
}

@end
