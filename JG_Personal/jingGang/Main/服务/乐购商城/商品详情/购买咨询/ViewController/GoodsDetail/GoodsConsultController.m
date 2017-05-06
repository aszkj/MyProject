//
//  GoodsConsultController.m
//  jingGang
//
//  Created by 张康健 on 15/8/12.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "GoodsConsultController.h"
#import "UITextView+Placeholder.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "Util.h"
#import "GlobeObject.h"
#import "VApiManager.h"
#import "MBProgressHUD.h"
#import "WSProgressHUD.h"
#import "MJRefresh.h"
#import "KJShoppingAlertView.h"
#import "DownToUpAlertView.h"
@interface GoodsConsultController (){

    VApiManager *_vapManager;

}
@property (weak, nonatomic) IBOutlet UITextView *consultTextView;
@property (weak, nonatomic) IBOutlet UILabel *consultTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textHeightConstraint;

@end

@implementation GoodsConsultController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
}


#pragma mark - private Method
-(void)_init{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.barTintColor = NavBarColor;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem initWithTitle:@"提交" titleColor:[UIColor whiteColor] target:self action:@selector(consult)];
    _vapManager = [[VApiManager alloc] init];
    [Util setNavTitleWithTitle:@"商品咨询" ofVC:self];
    //返回
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(back) target:self];
    
    self.consultTextView.placeholder = @"请问你想了解此商品哪方面信息？";
    self.consultTitle.text = self.goodsName;
    
    //设置不同屏幕textview的高度
    CGFloat textHeight = (200.0 / iPhone6_Height) * kScreenHeight;
    self.textHeightConstraint.constant = textHeight;
    [self.view layoutIfNeeded];
}



#pragma mark - Action Method
-(void)consult{
    [self.view endEditing:YES];
    //检查为不为空
    if (isEmpty(self.consultTextView.text)) {
        [DownToUpAlertView showAlertTitle:@"请问你想了解此商品哪方面信息？" inContentView:self.view];
        return;
    }
    
    [self _consultSaveRequest];


}//商品咨询

-(void)_consultSaveRequest{
    
    [WSProgressHUD showWithMaskType:WSProgressHUDMaskTypeBlack];
      ShopGoodsConsultSaveRequest *reuqest = [[ShopGoodsConsultSaveRequest alloc] init:GetToken];
    reuqest.api_content = self.consultTextView.text;
    reuqest.api_goodsId = self.consultGoodsID;
    [_vapManager shopGoodsConsultSave:reuqest success:^(AFHTTPRequestOperation *operation, ShopGoodsConsultSaveResponse *response) {
        [WSProgressHUD dismiss];
        if (response.errorCode.integerValue == 5) {
            KSensitiveWords
        }else if (response.errorCode.integerValue > 0) {
            [KJShoppingAlertView showAlertTitle:@"咨询失败" inContentView:self.view];
        }else{
            [KJShoppingAlertView showAlertTitle:@"咨询成功" inContentView:self.view];
        }
        [self performSelector:@selector(back) withObject:nil afterDelay:1.0];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [WSProgressHUD dismiss];
        [KJShoppingAlertView showAlertTitle:@"咨询失败" inContentView:self.view];
    }];
    
}

-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
