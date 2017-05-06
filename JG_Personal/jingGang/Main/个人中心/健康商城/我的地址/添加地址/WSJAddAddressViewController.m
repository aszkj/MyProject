//
//  WSJAddAddressViewController.m
//  jingGang
//
//  Created by thinker on 15/8/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJAddAddressViewController.h"
#import "PublicInfo.h"
#import "VApiManager.h"
#import "WSJAddresListViewController.h"
#import "GlobeObject.h"
#import "Util.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"

@interface WSJAddAddressViewController ()<UITextViewDelegate,UITextFieldDelegate>
{
//    地区背后两个控件
    __weak IBOutlet UILabel     * label1;
    __weak IBOutlet UIImageView * image1;
//    详细地区的提示
    __weak IBOutlet UILabel     * tishiLabel;
    
    VApiManager * _vapiManager;
    NSNumber    * _addressID;//保存地区的id

}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

//姓名
@property (weak, nonatomic) IBOutlet UITextField  *nameTextField;
//电话
@property (weak, nonatomic) IBOutlet UITextField  *telTextField;
//地区按钮
@property (weak, nonatomic) IBOutlet UIButton     *addressBtn;
//详细地址
@property (weak, nonatomic) IBOutlet UITextView   *detailAddressText;
//邮编
@property (weak, nonatomic) IBOutlet UITextField  *postcodeTextField;
//设置默认地址按钮
@property (weak, nonatomic) IBOutlet UIButton     *radioBtn;
//确认按钮
@property (weak, nonatomic) IBOutlet UIButton     *certainBtn;

@end

@implementation WSJAddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

#pragma mark - 选择地区事件
- (IBAction)setAddressAction:(UIButton *)sender
{
    self.addressBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    WSJAddresListViewController *addresList = [[WSJAddresListViewController alloc] initWithNibName:@"WSJAddresListViewController" bundle:nil];
    WEAK_SELF
    addresList.returnAddress = ^(NSString *address,NSNumber *addressID){
        label1.hidden = YES;
        image1.hidden = YES;
        _addressID = addressID;
        [weak_self.addressBtn setTitle:address forState:UIControlStateNormal];
    };
    [self.navigationController pushViewController:addresList animated:YES];
}

- (void)createAlertMessge:(NSString *)str
{
    UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
    [aler show];
}

#pragma mark -  确认事件
- (IBAction)certainAction:(id)sender
{
    [self hiddenKey:nil];
    if (self.nameTextField.text.length == 0)
    {
        [self createAlertMessge:@"收货人姓名不能为空！"];
        return;
    }
    else if (![Util isValidateMobile:self.telTextField.text])
    {
        [self createAlertMessge:@"收货人手机号码有误！"];
        return;
    }
    else if (self.addressBtn.titleLabel.text.length == 0)
    {
        [self createAlertMessge:@"请选择收货地区！"];
        return;
    }
    else if (self.detailAddressText.text.length == 0)
    {
        [self createAlertMessge:@"详细地址不能为空！"];
        return;
    }
    else if (self.postcodeTextField.text.length == 0)
    {
        [self createAlertMessge:@"邮政编码不能为空！"];
        return;
    }if (![Util isValidatePostcode:self.postcodeTextField.text])
    {
        [self createAlertMessge:@"邮政编码输入有误，请重新输入"];
        return;
    }
    
    ShopCartAddressSaveRequest *request = [[ShopCartAddressSaveRequest alloc] init:GetToken];
#pragma mark - //编辑地址
    if (self.dict)
    {
        NSDictionary *dict = @{@"areaId":_addressID,
                               @"areaInfo":self.detailAddressText.text,
                               @"areaName":self.addressBtn.titleLabel.text,
                               @"defaultVal":@(self.radioBtn.selected),
                               @"trueName":self.nameTextField.text,
                               @"id":self.dict[@"id"],
                               @"mobile":self.telTextField.text,
                               @"zip":self.postcodeTextField.text
                               };
        if (self.addAddress)
        {
            self.addAddress(dict,self.radioBtn.selected);
        }
        request.api_id = self.dict[@"id"];
    }
#pragma mark - //添加地址
    request.api_defaultValue = @(self.radioBtn.selected);
    request.api_trueName = self.nameTextField.text;
    request.api_mobile = self.telTextField.text;
    request.api_areaId = _addressID;
    request.api_areaInfo = self.detailAddressText.text;
    request.api_zip = self.postcodeTextField.text;
    WEAK_SELF
    [_vapiManager shopCartAddressSave:request success:^(AFHTTPRequestOperation *operation, ShopCartAddressSaveResponse *response) {
        if (weak_self.addAddress && weak_self.dict == nil)
        {
            weak_self.addAddress(nil,NO);
        }
        NSLog(@"cheshi ---- %@  addSuccess",response);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"cheshi ---- %@ adderror",error);
    }];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void) initUI
{
    self.certainBtn.clipsToBounds = YES;
    self.certainBtn.layer.cornerRadius = 5;
    _vapiManager = [[VApiManager alloc] init];
    //返回上一级控制器按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(btnClick) target:self];
    //设置背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    
    
    self.scrollview.contentSize = CGSizeMake(1, 460);
    self.detailAddressText.delegate = self;
    self.postcodeTextField.delegate = self;
    if (self.dict)
    {
        self.nameTextField.text = self.dict[@"trueName"];
        self.telTextField.text = self.dict[@"mobile"];
        label1.hidden = YES;
        image1.hidden = YES;
        [self.addressBtn setTitle:self.dict[@"areaName"] forState:UIControlStateNormal];
        tishiLabel.hidden = YES;
        self.detailAddressText.text = self.dict[@"areaInfo"];
        self.postcodeTextField.text = self.dict[@"zip"];
        self.radioBtn.selected = self.isDefault;
        _addressID = self.dict[@"areaId"];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenNoti) name:UIKeyboardWillHideNotification object:nil];
}

- (void) hiddenNoti
{
    [self hiddenKey:nil];
}
//隐藏键盘
- (IBAction)hiddenKey:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES];
    CGRect rect = self.view.frame;
    rect.origin.y = 64;
    [UIView animateWithDuration:0.25 animations:^{
        self.view.frame = rect;
    }];
    self.scrollview.contentSize = CGSizeMake(1, 460);
}


#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    CGRect rect = self.view.frame;
    rect.origin.y = -135;
    [UIView animateWithDuration:0.25 animations:^{
        self.view.frame = rect;
    }];
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (self.detailAddressText.text.length > 1 || text.length != 0)
    {
        tishiLabel.hidden = YES;
    }
    else
    {
        tishiLabel.hidden = NO;
    }
    return YES;
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    CGRect rect = self.view.frame;
    rect.origin.y = -135;
    [UIView animateWithDuration:0.25 animations:^{
        self.view.frame = rect;
    }];
    return YES;
}


#pragma mark - 默认地址设置
- (IBAction)selectAction:(UIButton *)sender
{
    sender.selected = ! sender.selected;
}
- (IBAction)tapSelectAction:(UITapGestureRecognizer *)sender
{
    [self selectAction:self.radioBtn];
}


//返回上一级界面
- (void) btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(__MainScreen_Width/2 - 30, __StatusScreen_Height, 60, 40)];
    l.text = @"管理收货地址";
    l.font = [UIFont systemFontOfSize:18];
    l.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = l;
    self.navigationController.navigationBar.translucent = NO;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
}


@end
