//
//  salesReturnVC.m
//  jingGang
//
//  Created by thinker on 15/8/7.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "ApplySalesReturnVC.h"
#import "Masonry.h"
#import "SalesReturnListVC.h"
#import "PublicInfo.h"
#import "APIManager.h"
#import "UIImageView+WebCache.h"
#import "OrderDetailController.h"
#import "UIView+BlockGesture.h"
#import "UITextView+Placeholder.h"
#import "UIAlertView+Extension.h"

@interface ApplySalesReturnVC () <UITextViewDelegate,UIAlertViewDelegate,APIManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleDescription;
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UIView *goodsVIew;
@property (weak, nonatomic) IBOutlet UIImageView *goodLogo;
@property (weak, nonatomic) IBOutlet UILabel *goodDescription;
@property (weak, nonatomic) IBOutlet UIView *applyView;
@property (weak, nonatomic) IBOutlet UILabel *applyTitle;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
//@property (weak, nonatomic) IBOutlet UITextField *applyText;
@property (weak, nonatomic) IBOutlet UITextView *applyText;
@property (nonatomic) APIManager *applyReturnManager;
@property (nonatomic) APIManager *goodsDetail;
@property (nonatomic) NSString *photoPath;
// 周边线上退款详情信息
@property (strong,nonatomic) PersonalOrderDetailsResponse *response;

@property (copy , nonatomic) NSString *groupSn;

@end

@implementation ApplySalesReturnVC


#pragma mark - life cycle
- (instancetype)initWithResponse:(id)response {
    if (self = [super init]) {
        self.response = (PersonalOrderDetailsResponse *)response;
    }
    return self;
}

- (void)viewDidLoad{
    [self setUIContent];
    [self setViewsMASConstraint];
    
    if (!self.response) {
        self.goodsDetail = [[APIManager alloc] initWithDelegate:self];
        [self.goodsDetail getGoodsDetail:@(self.goodsID)];
    }else {
        NSDictionary *detailDic = (NSDictionary *)self.response.orderDetails;
        NSArray *serviceList = [NSArray arrayWithArray:detailDic[@"serviceList"]];
        if (serviceList.count) {
            NSDictionary *serviceListDic = [NSDictionary dictionaryWithDictionary:[serviceList lastObject]];
            NSString *groupAccPath = serviceListDic[@"groupAccPath"];
            
            self.photoPath = groupAccPath;
            self.goodDescription.text = serviceListDic[@"groupName"];
            self.groupSn = TNSString(serviceListDic[@"groupSn"]);
        }
        self.title = @"退款申请";
        self.titleDescription.text = @"退款申请通过后,款项将以云币的形式返回至您的账户";
        self.applyTitle.text = @"退款原因";
    }

}

- (void)viewWillAppear:(BOOL)animated{
    
}

- (void)viewDidAppear:(BOOL)animated {
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    
}

- (void)viewDidLayoutSubviews {
}

#pragma mark - Cocoa Delegate

#pragma mark - UITextFieldDelegate
-(BOOL) textView :(UITextView *) textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *) text {
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    
    return YES;
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1000) {
        SalesReturnListVC *VC = [[SalesReturnListVC alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }

}

#pragma mark - 网络请求的处理
- (void)apiManagerDidSuccess:(APIManager *)manager
{
    if (manager == self.applyReturnManager) {
        
    } else if (manager == self.goodsDetail) {
        GoodsDetailsResponse *response = manager.successResponse;
        NSDictionary *goodsDic = (NSDictionary *)response.goodsDetails;
        self.photoPath = goodsDic[@"goodsMainPhotoPath"];
        self.goodDescription.text = goodsDic[@"goodsName"];
    }
}
- (void)apiManagerDidFail:(APIManager *)manager
{

}

#pragma mark - event response

#pragma mark - 退款
-(void)_requestOrderRefund:(NSString *)api_refund{
    if (!self.groupSn) {
        [UIAlertView xf_showWithTitle:@"退款失败" message:nil delay:0.85 onDismiss:^{
            
        }];
        return;
    }
    
    PersonalCouponRefundRequest *request = [[PersonalCouponRefundRequest alloc] init:GetToken];
    request.api_groupSn = self.groupSn;
    request.api_refundReasion = api_refund;
    
    WEAK_SELF
    VApiManager *manager = [[VApiManager alloc] init];
    [manager personalCouponRefund:request success:^(AFHTTPRequestOperation *operation, PersonalCouponRefundResponse *response) {
        if (IsEmpty(response.subCode)) {
            JGLog(@"退款成功");
            JGLog(@"nav:%@",self.navigationController.viewControllers);
            [UIAlertView xf_showWithTitle:@"退款成功" message:nil delay:1.0 onDismiss:^{
                [weak_self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
            }];
            
        } else {
            MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:weak_self.view animated:YES];
            hub.labelText = @"退款失败";
            [hub hide:YES afterDelay:1.5];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:weak_self.view animated:YES];
        hub.labelText = @"退款失败";
        [hub hide:YES afterDelay:1.5];
    }];
}

- (IBAction)commitActin:(id)sender
{
    if (self.response) {
        if (self.applyText.text.length > 0) {
            [self _requestOrderRefund:self.applyText.text];
        }else {
            [UIAlertView xf_showWithTitle:@"信息不全提交失败" message:nil delay:1.0 onDismiss:^{
                
            }];
        }
        
    }else {
        if (self.applyText.text.length > 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"我们会尽快处理您的需求" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            alert.tag = 1000;
            [alert show];
            
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您有什么话想对我们说吗?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }
        
        self.applyReturnManager = [[APIManager alloc] initWithDelegate:self];
        [self.applyReturnManager applyRetuanOrderID:self.orderID returnReason:self.applyText.text goodsID:self.goodsID goodsGspIds:self.goodsGspIds];
    }
}

#pragma mark - private methods

- (void)setBarButtonItem {
    //    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain  target:self  action:nil];
    //    self.navigationItem.backBarButtonItem = backButton;
    [self setLeftBarAndBackgroundColor];

}

- (void)setNavigationBar {
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar.barTintColor = status_color;
    navBar.tintColor = [UIColor whiteColor];
    navBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
}

- (void)setUIContent {
    [self setNavigationBar];
    [self setBarButtonItem];
    self.title = @"申请退换货";
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.applyText.delegate = self;
    self.applyText.placeholder = @"我不要了。";
//    self.applyText.leftViewMode = UITextFieldViewModeAlways;
//    self.applyText.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 6, 0)];
    WEAK_SELF
    [self.goodsVIew addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        OrderDetailController *VC = [[OrderDetailController alloc] init];
        VC.orderID = @(weak_self.orderID);
    }];
}

- (void)setViewsMASConstraint
{
    UIView *superView = self.view;
    [self.titleImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.height.equalTo(@77);
    }];
    [self.titleDescription mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleImage);
//        make.left.equalTo(self.titleImage).with.offset(50);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view).with.offset(-15);
//        make.bottom.greaterThanOrEqualTo(self.titleImage).with.offset(-12);
    }];
    [self.goodsVIew mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleImage.mas_bottom).with.offset(6);
        make.height.equalTo(@85);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
    }];
    
    superView = self.goodsVIew;
    [self.goodLogo mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(69, 69));
        make.centerY.equalTo(superView);
        make.left.equalTo(superView).with.offset(8);
    }];
    [self.goodDescription mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodLogo.mas_right).with.offset(12);
        make.centerY.equalTo(self.goodLogo);
    }];
    
    superView = self.view;
    [self.applyView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsVIew.mas_bottom).with.offset(6);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.bottom.equalTo(superView);
    }];
    
    superView = self.applyView;
    [self.applyTitle mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView).with.offset(8);
        make.left.equalTo(superView).with.offset(8);
    }];
    [self.applyText mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.applyTitle.mas_bottom).with.offset(8);
        make.left.equalTo(superView).with.offset(12);
        make.right.equalTo(superView).with.offset(-12);
        make.bottom.equalTo(self.commitBtn.mas_top).with.offset(-12);
    }];
    [self.commitBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.applyText);
        make.right.equalTo(self.applyText);
        make.height.equalTo(@44);
        make.bottom.equalTo(superView).with.offset(-12);
    }];
}

#pragma mark - getters and settters

- (void)setPhotoPath:(NSString *)photoPath
{
    
    if (self.response) {
        [self.goodLogo sd_setImageWithURL:[NSURL URLWithString:photoPath] placeholderImage:[UIImage imageNamed:@"com_cancel_pressed"]];

        
    }else {
        [self.goodLogo sd_setImageWithURL:[NSURL URLWithString:TwiceImgUrlStr(photoPath,self.goodLogo.frame.size.width,self.goodLogo.frame.size.width)] placeholderImage:[UIImage imageNamed:@"com_cancel_pressed"]];
    }
}

#pragma mark - debug operation

- (void)updateOnClassInjection {
    [self setViewsMASConstraint];
    [self setUIContent];
    
}

- (void)jumpVC {
    SalesReturnListVC *VC = [[SalesReturnListVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

@end
