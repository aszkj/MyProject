//
//  XKJHOfflineSwipeCardController.m
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/7.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHOfflineSwipeCardController.h"
#import "XKJHOfflineSwipeCardController.h"
#import "XKJHPullMenuView.h"
#import "XKJHShowSwipeCartStatusView.h"
#import "NSString+BlankString.h"
#import "GroupLinePayReturnRequest.h"
#import "VApiManager.h"

#define KServiceCacheKey @"KServiceCacheKey"
@interface XKJHOfflineSwipeCardController () <UITextFieldDelegate>{

    XKJHPullMenuView *_servicePullMenuView; //服务下拉菜单view
    XKJHShowSwipeCartStatusView *_showSwipeCartStatusView;//刷卡状态view
    NSMutableArray          *_serviceCasheArr;
    
}

@property (nonatomic, strong)NSMutableArray *serviceCasheArr;

@property (weak, nonatomic) IBOutlet UIView *seiviceInputView;
@property (weak, nonatomic) IBOutlet UITextField *serviceInputTextField;
@property (strong, nonatomic) IBOutlet UITextField *phoneCode;
@property (strong, nonatomic) IBOutlet UITextField *consumeMoney;
@property (nonatomic, strong)XKJHPullMenuView *servicePullMenuView;
@property (nonatomic, strong)XKJHShowSwipeCartStatusView *showSwipeCartStatusView;
@property(nonatomic,strong) VApiManager *vapManager;
@property(nonatomic,strong) NSString *tradeNo;
@property(nonatomic,strong) NSNumber *orderId;

@end

@implementation XKJHOfflineSwipeCardController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self _init];
    
}

-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
     _serviceCasheArr = [NSMutableArray arrayWithArray:[kUserDefaults objectForKey:KServiceCacheKey]];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    
    [kUserDefaults setObject:(NSArray *)_serviceCasheArr forKey:KServiceCacheKey];
    [kUserDefaults synchronize];
}


#pragma mark ----------------------- private Method -----------------------
- (void)_init {
    
    [self setDefaultAttribute];
    [self setVCTtitle:@"线下刷卡"];
}

#pragma mark ----------------------- Action Method -----------------------
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - private Method

- (VApiManager *)vapManager
{
    if (!_vapManager) {
        _vapManager = [[VApiManager alloc] init];
    }
    return _vapManager;
}

- (IBAction)beginInputAction:(id)sender {
   
    if (!_serviceCasheArr.count) {//没有历史记录
        return;
    }
    if (!_servicePullMenuView) {
        _servicePullMenuView = [XKJHPullMenuView showDownView:_seiviceInputView inContentView:self.view selectDatas:_serviceCasheArr];
        
        WEAK_SELF;
        //选中block
        _servicePullMenuView.clickIndexPathBlock = ^(id selectObj) {
        
            weak_self.serviceInputTextField.text = (NSString *)selectObj;
            weak_self.servicePullMenuView.hidden = YES;
        };
        //删除block
        _servicePullMenuView.deleteItemBlock = ^(NSInteger deleteIndex) {
            
            [weak_self.serviceCasheArr removeObjectAtIndex:deleteIndex];
            _servicePullMenuView.pullDatas = weak_self.serviceCasheArr;
            [_servicePullMenuView reloadData];
            
            if (!weak_self.serviceCasheArr.count) {
                _servicePullMenuView.hidden = YES;
            }
        };
    }
}


- (IBAction)inputServiceChanged:(id)sender {
    
    UITextField *textField = (UITextField *)sender;
    if (IsEmpty(textField.text)) {
        if (_serviceCasheArr.count > 0) {
            _servicePullMenuView.hidden = NO;
            _servicePullMenuView.pullDatas = _serviceCasheArr;
            [_servicePullMenuView reloadData];
        }else{
            _servicePullMenuView.hidden = YES;
        }
    }else {
        _servicePullMenuView.hidden = YES;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [textField resignFirstResponder];
    if (!self.servicePullMenuView.hidden) {
        self.servicePullMenuView.hidden = YES;
    }
    
    return YES;
}


- (IBAction)submmitAction:(id)sender {
    
    [self.view endEditing:YES];
    if (![self _veryfyInput]) {
        return;
    }
    [self _requestCartPay];
    
    //缓存服务名称
    [self _cacheServiceStr];
    
}


-(void)_cacheServiceStr {

    BOOL hasCached = NO;
    for (NSString *cacheServiceStr in _serviceCasheArr) {
        if ([cacheServiceStr isEqualToString:self.serviceInputTextField.text]) {
            hasCached = YES;
            break;
        }
    }
    
    if (!hasCached) {//没有缓存这个服务名称
        //缓存服务名称
        [_serviceCasheArr insertObject:self.serviceInputTextField.text atIndex:0];
    }else {//缓存了
        //把之前相同的服务名称移到第一个
        NSInteger cachedIndex = [_serviceCasheArr indexOfObject:self.serviceInputTextField.text];
        [_serviceCasheArr exchangeObjectAtIndex:0 withObjectAtIndex:cachedIndex];
    }
    if (_serviceCasheArr.count > 5) {
        [_serviceCasheArr removeObjectsInRange:NSMakeRange(5, _serviceCasheArr.count-5)];
    }
}

-(BOOL)_veryfyInput {
    
    if (IsEmpty(self.phoneCode.text)) {
            [Util ShowAlertWithOnlyMessage:@"手机号码不能为空"];
            return NO;
    }else {
        if (![Util isValidateMobile:self.phoneCode.text]) {
            [Util ShowAlertWithOnlyMessage:@"请输入正确的手机号"];
            return NO;
        }
    }
    if (IsEmpty(self.consumeMoney.text)) {
        [Util ShowAlertWithOnlyMessage:@"请输入消费金额"];
        return NO;
    }else {
        NSInteger consumeMoney = self.consumeMoney.text.integerValue;
        if (consumeMoney < 0) {
        [Util ShowAlertWithOnlyMessage:@"消费金额不能小于0"];
        return NO;
        }
    }
    
    
    if (IsEmpty(self.serviceInputTextField.text)) {
        [Util ShowAlertWithOnlyMessage:@"服务名称不能为空"];
        return NO;
    }

    return YES;
}


#pragma mark - 接口请求

// 线下支付请求

-(void)_requestCartPay{
    
    
    
    GroupOrderCartPayRequest *request = [[GroupOrderCartPayRequest alloc] init:GetToken];
    
    request.api_mobile = self.phoneCode.text;
    
    request.api_price = [NSNumber numberWithDouble:[self.consumeMoney.text doubleValue]];
    
    request.api_goodsName = self.serviceInputTextField.text;
    
    
    
#if TARGET_IPHONE_SIMULATOR
    
    
    
#else
    
    __unsafe_unretained XKJHOfflineSwipeCardController *weak_self = self;
    
    [self.vapManager groupOrderCartPay:request success:^(AFHTTPRequestOperation *operation, GroupOrderCartPayResponse *response) {
        
        
        
        weak_self.tradeNo = response.tradeNo;
        
        weak_self.orderId = response.orderId;
        
        [EPPayPlugin startEPPay:response.tradeNo mode:0 viewController:weak_self delegate:weak_self];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
#endif
    
}

// 线下支付回调
-(void)_requestLinePay{

    GroupOrderGetRequest *request = [[GroupOrderGetRequest alloc] init:GetToken];
//    request.api_orderId = [NSNumber numberWithFloat:[self.tradeNo floatValue]];
    request.api_orderId = self.orderId;

    [self.vapManager groupOrderGet:request success:^(AFHTTPRequestOperation *operation, GroupOrderGetResponse *response) {
        
        if ([response.orderStatus isEqual:@20]) {
            MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hub.labelText = @"支付成功";
            [hub hide:YES afterDelay:1.5];
        } else {
            MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hub.labelText = @"支付失败";
            [hub hide:YES afterDelay:1.5];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hub.labelText = @"支付失败";
        [hub hide:YES afterDelay:1.5];
    }];
}

#pragma mark - EPPayPluginDelegate

-(void)EPPayPluginResult:(NSString*)result {
    
    if ([result isEqualToString:@"success"]) {
        [self _requestLinePay];
        
    } else if ([result isEqualToString:@"fail"]) {
        
        MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hub.labelText = @"支付失败";
        [hub hide:YES afterDelay:1.5];
    }
}

@end
