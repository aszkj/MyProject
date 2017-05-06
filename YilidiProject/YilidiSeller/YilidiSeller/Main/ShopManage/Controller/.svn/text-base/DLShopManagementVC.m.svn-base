//
//  DLMeVC.m
//  YilidiBuyer
//
//  Created by yld on 16/4/16.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLShopManagementVC.h"
#import "DLManagementCell.h"
#import "DLHomeSpecialItemModel.h"
#import "ProjectRelativeMaco.h"
#import "ProjectRelativeKey.h"
#import "DLMefooterView.h"
#import "DLInvoiceManagementVC.h"
#import "DLHelpCenterVC.h"
#import "DLFeedbackVC.h"
#import "DLChangePasswordVC.h"
#import "DLEditStoreVC.h"
#import "UIBarButtonItem+WNXBarButtonItem2.h"
#import "DLRequestUrl.h"
#import "GlobleConst.h"
#import "ProjectRelativeDefineNotification.h"
#import "DLSellerLoginVC.h"
#import "DLBaseNavController.h"
#import "UIImageView+sd_SetImg.h"
#import "DLAboutUsVC.h"
#import "CordovaH5UrlManager.h"
#import "DLCordovaH5VC.h"

static NSString *meCellIdentifier = @"meCellIdentifier";
@interface DLShopManagementVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIImageView *headerImageView;

@property (strong, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (strong, nonatomic) IBOutlet UIButton *storePhone;
@property (strong, nonatomic) IBOutlet UILabel *currentWeekAmountLabel;

@property (strong, nonatomic) IBOutlet UILabel *lastWeekAmountLabel;


@property (weak, nonatomic) IBOutlet UITableView *meTableView;
@property (nonatomic,strong)DLMefooterView *exitFooterView;

@property (nonatomic, assign)CGFloat scrollMaxScrollHeight;

@property (nonatomic, copy)NSDictionary *meDataDic;



@end

@implementation DLShopManagementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _init];
    [self _testData];
    self.navigationController.view.backgroundColor  = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    

}




#pragma mark ------------------------Init---------------------------------
-(void)_init {
    self.pageTitle = @"店铺管理";
//    [self _initRightItem];
    [self _initMeTableView];
    [self _requestStoreInfo];
}

- (void)_initRightItem{

    self.navigationItem.rightBarButtonItem =[UIBarButtonItem initWithNormalImage:@"editStore" target:self action:@selector(_rightClick) width:22 height:22];
}

-(void)_initMeTableView {
    self.meTableView.delegate = self;
    self.meTableView.dataSource = self;
    self.meTableView.rowHeight = kMeCellHeight;
    [self.meTableView registerNib:[UINib nibWithNibName:@"DLManagementCell" bundle:nil] forCellReuseIdentifier:meCellIdentifier];
   
    [self.meTableView reloadData];
}

#pragma mark ------------------------Private------------------------------


#pragma mark ------------------------Api----------------------------------
- (void)_testData {
    CommonImgTitleModel *model1 = [[CommonImgTitleModel alloc] init];
    model1.normalImgName = @"store1";
    model1.title = @"调货单管理";
    
    CommonImgTitleModel *model2 = [[CommonImgTitleModel alloc] init];
    model2.normalImgName = @"store2";
    model2.title = @"修改密码";
    
    CommonImgTitleModel *model4 = [[CommonImgTitleModel alloc] init];
    model4.normalImgName = @"store4";
    model4.title = @"帮助中心";
    
    CommonImgTitleModel *model5 = [[CommonImgTitleModel alloc] init];
    model5.normalImgName = @"store5";
    model5.title = @"关于我们";
   
    CommonImgTitleModel *model7 = [[CommonImgTitleModel alloc] init];
    model7.normalImgName = @"store7";
    model7.title = @"联系客服";
    model7.phone = @"4001-333-866";
    
    
     NSArray *arr1 = @[model1,model2,model4, model5,model7];
    self.meDataDic = @{@"data1":arr1};
    
    
    [self.meTableView reloadData];

}

- (void)_requestStoreInfo {
   
     NSDictionary *dic = [kUserDefaults objectForKey:HomeResponeData];
    if (dic !=nil) {
        [_headerImageView sd_SetImgWithUrlStr:dic[@"userImageUrl"] placeHolderImgName:@"storeDefault"];
        _storeNameLabel.text = dic[@"storeName"];
        [_storePhone setTitle:dic[@"userMobile"] forState:UIControlStateNormal];
        
    }

    
    [self showLoadingHub];
    [AFNHttpRequestOPManager postWithParameters:nil subUrl:kUrl_StoreInfo block:^(NSDictionary *resultDic, NSError *error) {
        [self hideLoadingHub];
        NSLog(@"resulr:%@",resultDic);
        _currentWeekAmountLabel.text = [NSString stringWithFormat:@"￥%.2f",[resultDic[@"entity"][@"currentWeekAmount"]floatValue]/1000];
        _lastWeekAmountLabel.text = [NSString stringWithFormat:@"￥%.2f",[resultDic[@"entity"][@"lastWeekAmount"]floatValue]/1000];
        
    }];
    
}


- (void)_requestLogout {
    [self showLoadingHub];
    [AFNHttpRequestOPManager postWithParameters:nil subUrl:kUrl_Logout block:^(NSDictionary *resultDic, NSError *error) {
        [self hideLoadingHub];
        [kUserDefaults setObject:nil forKey:YiLiDiMerchantSessionID];
        [kUserDefaults synchronize];
        [kNotification postNotificationName:KNofiticationLogout object:nil];
        [self performSelector:@selector(_enterLoginPage) withObject:self afterDelay:1];
        
    }];
}




#pragma mark ------------------------View Event---------------------------

- (IBAction)rightClick:(id)sender {
    DLEditStoreVC *editVC = [[DLEditStoreVC alloc]init];
    [self navigatePushViewController:editVC animate:YES];
}



#pragma mark ------------------------Page Navigate---------------------------
- (void)_enterLoginPage {
    DLSellerLoginVC  *loginVC = [[DLSellerLoginVC alloc] init];
    DLBaseNavController *baseNav = [[DLBaseNavController alloc] initWithRootViewController:loginVC];
    [UIApplication sharedApplication].keyWindow.rootViewController = baseNav;
}
- (void)_enterCordovaH5PageWithH5Code:(NSString *)h5Code {
    [[CordovaH5UrlManager sharedManager] getH5Url:^(NSString *h5Url) {
        DLCordovaH5VC *h5Page = [[DLCordovaH5VC alloc] init];
        h5Page.h5Url = h5Url;
        [self navigatePushViewController:h5Page animate:YES];
    } forh5Code:h5Code];
}



#pragma mark ------------------------Delegate-----------------------------

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.meDataDic.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = self.meDataDic.allKeys[section];
    NSArray *datas = self.meDataDic[key];
    return datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = self.meDataDic.allKeys[indexPath.section];
    NSArray *datas = self.meDataDic[key];
    CommonImgTitleModel *model = datas[indexPath.row];
    DLManagementCell *cell = [self.meTableView dequeueReusableCellWithIdentifier:meCellIdentifier forIndexPath:indexPath];
    [cell setMineCellModel:model];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 47.5, kScreenWidth, 0.5)];
    view.backgroundColor = UIColorFromRGB(0xdcdcdc);
    
    if (indexPath.section==0&&indexPath.row==3) {
        
        cell.line.hidden=YES;
        [cell addSubview:view];
    }
    
    if (indexPath.section==0&&indexPath.row==4) {
        cell.line.hidden =YES;
        [cell addSubview:view];
        cell.rightBtn.hidden=YES;
    }
 
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.meTableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section==0) {
        
        if (indexPath.row==0) {
            DLInvoiceManagementVC *couponsVC= [[DLInvoiceManagementVC alloc]init];
            
            [self navigatePushViewController:couponsVC animate:YES];
            
        }else if (indexPath.row==1){
            DLChangePasswordVC *meRedEnvelopeVC = [[DLChangePasswordVC alloc]init];
            [self navigatePushViewController:meRedEnvelopeVC animate:YES];
            
           
        }else if (indexPath.row==2){
          
            [self _enterCordovaH5PageWithH5Code:H5PAGETYPE_COMMON_QUESTION];
            
        }else if(indexPath.row==3){
        
            [self _enterCordovaH5PageWithH5Code:H5PAGETYPE_ABOUT_US];

            
        } else{
            
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"4001333866"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
   
        
    }
      
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.00001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    if (section==0) {
        return 60.0f;
    }
    return 8.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==0) {
        return self.exitFooterView;
    }
    
    return nil;
}




#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------

- (DLMefooterView*)exitFooterView{
    
    if (!_exitFooterView) {
        _exitFooterView = BoundNibView(@"DLMefooterView", DLMefooterView);

        WEAK_SELF
        _exitFooterView.meExitBlock = ^{
            
            [weak_self showSimplyAlertWithTitle:@"提示" message:@"退出当前账户" sureAction:^(UIAlertAction *action) {
                [weak_self _requestLogout];
            } cancelAction:^(UIAlertAction *action) {
                
            }];
            
        };
    }
   
    
    return _exitFooterView;
    
}



@end
