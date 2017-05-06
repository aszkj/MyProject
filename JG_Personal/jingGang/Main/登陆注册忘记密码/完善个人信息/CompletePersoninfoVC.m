//
//  CompletePersoninfoVC.m
//  jingGang
//
//  Created by 张康健 on 15/6/23.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "CompletePersoninfoVC.h"
#import "GlobeObject.h"
#import "UIButton+Block.h"
#import "Util.h"
#import "VApiManager.h"
#import "JGBlueToothManager.h"
#import "MBProgressHUD.h"
#import "CalenderView.h"
#import "UIViewExt.h"
#import "UIView+BlockGesture.h"
#import "AppDelegate.h"
#import "AddressChoicePickerView.h"
#import "UserCustomerSavefirstRequest.h"
#import "JGPickerView.h"

//#import "UserCustomerSavefirstRequest.h"
@interface CompletePersoninfoVC ()<UITextFieldDelegate>{

    BOOL _isMan;//性别，默认男性
    NSArray *_btnArr;//性别btn
    VApiManager *_vapManager;
    
    
    BOOL _isSelectBirth; //是否选择生日
    UIView *_maskView;
    
    NSMutableDictionary *userDic;
    NSString            *birThStr;
    
    CalenderView *_birthCalenderView;
    
    NSString *yearStr;
    NSString *monthStr;
    NSString *dayStr;

    NSString *heightStr;
    NSString *weightStr;
//    选择省的下标
    NSInteger proviceIndex;
//    选择市的下标
    NSInteger cityIndex;
//    选择省
    NSString *proviceString;
//    选择市
    NSString *townString;
//    选择县区
    NSString *countiesString;
}

//@property (nonatomic,copy)NSString *newYear;


//@property (retain, nonatomic) IBOutlet CalenderView *birthCalenderView;

//@property (retain, nonatomic) IBOutlet UITextField *ageField;


@property (nonatomic,strong)CalenderView *birthCalenderView;
//@property (nonatomic,strong)UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIButton *addressButton;

@property (weak, nonatomic) IBOutlet UIView *addressBtn;
@property (weak, nonatomic) IBOutlet UILabel *addresslabel;
@property (retain, nonatomic) IBOutlet UITextField *heightFiled;
@property (retain, nonatomic) IBOutlet UITextField *weightField;
@property (retain, nonatomic) IBOutlet UIButton *manBtn;
@property (retain, nonatomic) IBOutlet UIButton *birthBtn;


@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (retain, nonatomic) IBOutlet UIButton *womenBtn;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *bottonConstraint;
@property (nonatomic,copy)NSArray *stringArr;
@property (nonatomic,copy)NSMutableArray *array;

//
@property (copy,nonatomic)NSString *cityString;
@property (copy,nonatomic)NSString *areaString;
//@property (nonatomic,strong) AddressChoicePickerView *addressPickerView;



@end

@implementation CompletePersoninfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.addressButton setTitle:self.addressString forState:UIControlStateNormal];
//    self.addressTextField.delegate = self;
//    self.addressPickerView = [[AddressChoicePickerView alloc]init];
//        self.addressTextField.inputView =nil;
//    self.addressTextField.enabled =YES;
//    [self.addressbutton setTitle:self.addressString forState:UIControlStateNormal];
//    [self _userInfoRequet];
//    self.addressTextField.text = self.addressString;
    [self _loadNavLeft];
    
    [self _loadRight];
    
    [self _init];
}
- (IBAction)addressBtn:(id)sender {
    WEAK_SELF
    JGPickerView *addressPickerView = [[JGPickerView alloc] init];
//    addressPickerView.block = ^(AddressChoicePickerView *view,UIButton *btn,AreaObject *locate){
        //        [self.addressbutton setTitle:[NSString stringWithFormat:@"%@",locate] forState:UIControlStateNormal];
        //        NSLog(@"%@",self.addressbutton.currentTitle);
//        [weak_self.addressButton setTitle: [NSString stringWithFormat:@"%@",locate] forState:UIControlStateNormal];
//        weak_self.cityString = locate.city;
//        weak_self.areaString = locate.area;
//    };
//
    addressPickerView.block = ^(JGPickerView *view,UIButton *btn,AreaObject *locate){
        [self.addressButton setTitle:[NSString stringWithFormat:@"%@",locate] forState:UIControlStateNormal];
                NSLog(@"%@",self.addressButton.currentTitle);
                [weak_self.addressButton setTitle: [NSString stringWithFormat:@"%@",locate] forState:UIControlStateNormal];
                weak_self.cityString = locate.city;
                weak_self.areaString = locate.area;
    };
    [addressPickerView show];
}
//address 选项
//- (IBAction)tapLabel:(UITapGestureRecognizer *)sender {
//    addressPickerView = [[AddressChoicePickerView alloc] init];
//    WEAK_SELF
//    addressPickerView.block = ^(AddressChoicePickerView *view,UIButton *btn,AreaObject *locate){
//        //        [self.addressbutton setTitle:[NSString stringWithFormat:@"%@",locate] forState:UIControlStateNormal];
//        //        NSLog(@"%@",self.addressbutton.currentTitle);
//       
//    };
//    [addressPickerView show];
//}

//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
////    addressPickerView.backgroundColor = [UIColor redColor];
//    
//    WEAK_SELF
//    AddressChoicePickerView *addressPickerView = [[AddressChoicePickerView alloc] init];
//    addressPickerView.block = ^(AddressChoicePickerView *view,UIButton *btn,AreaObject *locate){
//        //        [self.addressbutton setTitle:[NSString stringWithFormat:@"%@",locate] forState:UIControlStateNormal];
//        //        NSLog(@"%@",self.addressbutton.currentTitle);
//         weak_self.addressTextField.text = [NSString stringWithFormat:@"%@",locate];
//        weak_self.cityString = locate.city;
//        weak_self.areaString = locate.area;
//    };
//    
//    [addressPickerView show];
//}

-(void)_init{
    
    
    _vapManager = [[VApiManager alloc] init];
    
    self.navigationController.navigationBar.barTintColor = kGetColor(94, 180, 231);

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [Util setNavTitleWithTitle:@"完善资料" ofVC:self];
    
    _btnArr = @[self.manBtn,self.womenBtn];
    
//    self.ageField.text = @"";
    self.heightFiled.text = @"";
    self.weightField.text = @"";
    //默认男性
    _isMan = YES;
    
    _isSelectBirth = NO;
    [self loadCalenderView];
    
    
    //遮罩视图
    [self loadMaskView];
    

    
    
    [self.heightFiled addTarget:self action:@selector(heightEditi:) forControlEvents:UIControlEventEditingChanged];
    
    
    [self.weightField addTarget:self action:@selector(weightEditi:) forControlEvents:UIControlEventEditingChanged];
    

    
    
    //初始化生日视图
//    [self _initCalenderView];
  
}

-(UIButton *)getSeletedButton{
    
    for (UIButton *button in _btnArr) {
        if (button.selected) {
            return button;
            break;
        }
    }
    
    return nil;
}


-(void)_loadNavLeft{
    
    UIButton *navLeftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 25)];
    [navLeftButton setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    WEAK_SELF;
    [navLeftButton addActionHandler:^(NSInteger tag) {
        
//        [weak_self dismissViewControllerAnimated:YES completion:nil];
        [self response];
        [weak_self.navigationController popViewControllerAnimated:YES];
        
    }];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:navLeftButton];
    self.navigationItem.leftBarButtonItem = item;
    
   
}



-(void)_loadRight{

    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45, 40)];
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    WEAK_SELF;
    [rightButton addActionHandler:^(NSInteger tag) {
        
        NSLog(@"heightStr :%@",heightStr);
        if (!heightStr ||  [heightStr isEqualToString:@""] || !weightStr || [weightStr isEqualToString:@""] || !weak_self.birthBtn.titleLabel.text) {
            
            [Util ShowAlertWithOutCancelWithTitle:@"提示" message:@"资料还未填完整，请填完整"];
            
        }else{
        
            //对身高体重进行限制，手环需要
            [self _makeConstraintForHeightAndWeight];
            
//            更新用户信息请求
            [weak_self updateUerInfoRequest];
            

        //给手环中的用户模型
        JGBlueToothManager *manager = [JGBlueToothManager shareInstances];
//            manager.userBodyModel.age = [self.ageField.text intValue];
        if ([heightStr intValue] != 0) {
            
            manager.userBodyModel.height = [heightStr intValue];
        }
        
            NSLog(@"heightStr : %@",heightStr);
            NSLog(@"weightStr : %@",weightStr);
            
        if ((int)[weightStr floatValue] != 0) {
            
            manager.userBodyModel.weight = [weightStr floatValue];
        }
            if (_isMan) {
                manager.userBodyModel.genderType = GenderTypeMan;
            }else{
                manager.userBodyModel.genderType = GenderTypeWoman;
            }
            
            [kUserDefaults setObject:heightStr forKey:@"height"];
            [kUserDefaults setObject:weightStr forKey:@"weight"];
            [kUserDefaults setObject:@(_isMan) forKey:@"sex"];
            [kUserDefaults setObject:birThStr forKey:@"birth"];
            [kUserDefaults synchronize];
        
        }
        
    }];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = item;
   
    
}


#pragma mark - 限制身高体重乱填
-(void)_makeConstraintForHeightAndWeight{

    NSInteger height = [heightStr integerValue];
    if (height<=99 || height >= 240 ) {
        [Util ShowAlertWithOutCancelWithTitle:@"提示" message:@"身高填写不合理，请重新填写"];
    }
    
    NSInteger weight = [weightStr integerValue];
    if (weight <= 44 || weight >= 99) {
        [Util ShowAlertWithOutCancelWithTitle:@"提示" message:@"体重填写不合理，请重新填写"];
    }
}



//暂不填写
- (IBAction)nowDoPerfectInfo:(id)sender {
    [self response];
    [self _comminTypeInfo];
    
}

-(void)_comminTypeInfo{
    
    [self.view endEditing:YES];
    if (self.comminTypeInfo == Registe_Commin) {
        
        [self performSelector:@selector(gogogo) withObject:nil afterDelay:0.3];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}



-(void)updateUerInfoRequest{
    
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    UsersCustomerUpdateRequest *request = [[UsersCustomerUpdateRequest alloc] init:GetToken];
    
    if (self.comminTypeInfo == Registe_Commin) {
    
        [self _makeRegisiterParamsWithRequest:request];
        
        [self updateUserInfoRequest];
    }else{
//
        [self _makePerfectInfoParamesWithRequest:request];
    }
    
    
    [_vapManager usersCustomerUpdate:request success:^(AFHTTPRequestOperation *operation, UsersCustomerUpdateResponse *response) {
        
        NSLog(@"error code%@,,,%@",response.errorCode,response);
        hub.labelText = @"保存成功";
        [hub hide:YES];
        if (self.comminTypeInfo == Show_huan_Commin) {//如果不是从注册页进去的，缓存用户字典
            
            [self _cacheUserInfoDic:userDic];
            [self performSelector:@selector(dismissModalViewControllerAnimated:) withObject:@(YES) afterDelay:1.0];
        }else{
        
//            [self.navigationController performSelector:@selector(popToRootViewControllerAnimated:) withObject:@(YES) afterDelay:1.0];
            [self performSelector:@selector(gogogo) withObject:nil afterDelay:0.2];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        hub.labelText = @"请求超时,保存信息失败";
//        [hub hide:YES];
        [self performSelector:@selector(gogogo) withObject:nil afterDelay:0.2];

    }];
    
}

- (void)gogogo
{

    
    [self.view endEditing:YES];
    
    if (self.comminTypeInfo == Registe_Commin) {
        
        AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [app gogogoWithTag:0];
    }else{
//        [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    
    }
    
}

#pragma mark 设置地址格式
-(void)setAddressStyle{
//    获取通过手机号定位的地址信息
    NSString *string = self.addressButton.currentTitle;
//    解成自串
    NSArray *arr = [string componentsSeparatedByString:@","];
//    省区proviceStr 市区cityStr 县区areaStr
    NSString *proviceStr = arr[0];
    NSString *cityStr = arr[1];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"city2" ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];
    NSError *error ;
    
    NSArray *pickerArr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if(error||!pickerArr){
        NSLog(@"json解析失败");
    }
    for(int i=0;i<pickerArr.count;i++){
        NSDictionary *dic = [pickerArr objectAtIndex:i];
        NSString *str = [dic objectForKey:@"areaName"];
        if([str containsString:arr[0]]){
            //            proviceStr = str;
            proviceIndex = i;
            proviceString = str;
            break;
        }
    }
    NSArray *cityArr = pickerArr[proviceIndex][@"cities"];
    for (int j=0; j<cityArr.count;j++) {
        NSString *str = cityArr[j][@"areaName"];
        if([str containsString:arr[1]]){
            cityIndex =j;
            townString = [NSString stringWithFormat:@"%@",str];
            break;
        }
    }
    countiesString = [NSString stringWithFormat:@"%@",cityArr[cityIndex][@"counties"][0][@"areaName"]];
}

-(void)_makeRegisiterParamsWithRequest:(UsersCustomerUpdateRequest *)request{
    
    request.api_height = @(self.heightFiled.text.integerValue);
    request.api_weight = @(self.weightField.text.integerValue);
    request.api_sex = @(_isMan);
    request.api_birthDate = birThStr;
    
    
}//建立注册参数
#pragma mark 保存地址request（不要在意方法名这个细节）
-(void)response{
    if(self.cityString){
        UserCustomerSavefirstRequest *request = [[UserCustomerSavefirstRequest alloc] init:GetToken];
        if(self.heightFiled.text.integerValue){
            request.api_height = @(self.heightFiled.text.integerValue);
        }
        if(self.weightField.text.integerValue){
            request.api_weight = @(self.weightField.text.integerValue);
        }

        request.api_sex = @(_isMan);
        if(birThStr){
             request.api_birthDate = birThStr;
        }
       
        request.api_paddress = self.cityString;
        request.api_address = self.areaString;
        [_vapManager userCustomerSavefirst:request success:^(AFHTTPRequestOperation *operation, UserCustomerSavefirstResponse *response) {
            
            
            NSLog(@"success %@,,,%@",response.errorCode,response);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"bb");
        }];
    }else{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"city2" ofType:@"json"];
        NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];
        NSError *error ;
        
        NSArray *pickerArr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        if(error||!pickerArr){
            NSLog(@"json解析失败");
        }
        
        NSString *string = self.addressButton.currentTitle;
        NSArray *arr = [string componentsSeparatedByString:@","];
        NSString *cityStr;
        NSString *areaStr;
        NSInteger flag = 0;
        NSInteger flag1 = 0;
        for(int i=0;i<pickerArr.count;i++){
            NSDictionary *dic = [pickerArr objectAtIndex:i];
            NSString *str = [dic objectForKey:@"areaName"];
            if([str containsString:arr[0]]){
                //            proviceStr = str;
                flag = i;
                break;
            }
        }
        NSArray *cityArr = pickerArr[flag][@"cities"];
        for (int j=0; j<cityArr.count;j++) {
            NSString *str = cityArr[j][@"areaName"];
            if([str containsString:arr[1]]){
                flag1 =j;
                cityStr = [NSString stringWithFormat:@"%@",str];
                break;
            }
        }
        areaStr = [NSString stringWithFormat:@"%@",cityArr[flag1][@"counties"][0][@"areaName"]];
        UserCustomerSavefirstRequest *request = [[UserCustomerSavefirstRequest alloc] init:GetToken];
//        request.api_height = @(self.heightFiled.text.integerValue);
//        request.api_weight = @(self.weightField.text.integerValue);
//        request.api_sex = @(_isMan);
//        request.api_birthDate = birThStr;
        
        if(self.heightFiled.text.integerValue){
            request.api_height = @(self.heightFiled.text.integerValue);
        }
        if(self.weightField.text.integerValue){
            request.api_weight = @(self.weightField.text.integerValue);
        }
        
        request.api_sex = @(_isMan);
        if(birThStr){
            request.api_birthDate = birThStr;
        }
        request.api_paddress = cityStr;
        request.api_address = areaStr;
        [_vapManager userCustomerSavefirst:request success:^(AFHTTPRequestOperation *operation, UserCustomerSavefirstResponse *response) {
            
            
            NSLog(@"error code%@,,,%@",response.errorCode,response);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"bb");
        }];
    }
    
}
-(void)updateUserInfoRequest{
//    UserCustomerSavefirstRequest *request = [[UserCustomerSavefirstRequest alloc] init:GetToken];
//    request.api_height = @(self.heightFiled.text.integerValue);
//    request.api_weight = @(self.weightField.text.integerValue);
//    request.api_sex = @(_isMan);
//    request.api_birthDate = birThStr;
////    NSString *string = self.addressbutton.currentTitle;
////    NSArray *arr = [string componentsSeparatedByString:@","];
    [self response];
////    if(arr[0]){
////        request.api_paddress = arr[0];
////        
////    }
////    if(arr[1]){
////        request.api_address = arr[1];
////    }
////    
////    request.api_paddress = arr[0];
////    request.api_address = arr[1];
//    [_vapManager userCustomerSavefirst:request success:^(AFHTTPRequestOperation *operation, UserCustomerSavefirstResponse *response) {
//        
//        
//         NSLog(@"error code%@,,,%@",response.errorCode,response);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"bb");
//    }];
}


-(void)_makePerfectInfoParamesWithRequest:(UsersCustomerUpdateRequest *)request{
    
    userDic = (NSMutableDictionary *)[[kUserDefaults objectForKey:userInfoKey] mutableCopy];
    request.api_nickname = userDic[@"nickName"];
    request.api_name = userDic[@"name"];
    request.api_height = @(self.heightFiled.text.integerValue);
    request.api_weight = @(self.weightField.text.integerValue);
    request.api_sex = @(_isMan);
    request.api_mobile = userDic[@"mobile"];
    request.api_birthDate = userDic[@"birthDate"];
    request.api_email = userDic[@"email"];
    request.api_headImgPath = userDic[@"headImgPath"];
    request.api_allergHistory = userDic[@"allergHistory"];
    request.api_transGenetic = userDic[@"transGenetic"];
    request.api_blood = userDic[@"blood"];
    
}//建立完善个人信息参数




#pragma mark - 更新成功后 重新缓存用户字典
-(void)_cacheUserInfoDic:(NSMutableDictionary *)userInfoDic{
    
    [userInfoDic setObject:@(self.heightFiled.text.integerValue) forKey:@"height"];
    [userInfoDic setObject:@(self.weightField.text.integerValue) forKey:@"weight"];
//    [userInfoDic setObject:@(self.ageField.text.integerValue) forKey:@"age"];
    [userInfoDic setObject:@(_isMan) forKey:@"sex"];
    
    NSDictionary *dic = (NSDictionary *)userInfoDic;
    [kUserDefaults setObject:dic forKey:userInfoKey];
    [kUserDefaults synchronize];
}


-(void)loadCalenderView{
    
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"CalenderView" owner:nil options:nil];
    _birthCalenderView = (CalenderView *)[nibs lastObject];
    _birthCalenderView.backgroundColor = [UIColor redColor];
    
    
    self.birthCalenderView.selectBirthBlock = ^(NSString *year,NSString *month,NSString *day){
        
        yearStr = [year copy];
        monthStr = [month copy];
        dayStr = [day copy];
        
        [self performSelector:@selector(varityTest) withObject:nil afterDelay:0.3];
        
        [self downCalenderView];
        
    };
    _birthCalenderView.frame = CGRectMake(0,[[UIScreen mainScreen] bounds].size.height,self.view.frame.size.width, 292);
    [self.view addSubview:_birthCalenderView];
    
}


-(void)varityTest{


    [self.birthBtn setTitle:[NSString stringWithFormat:@"%@-%@-%@",yearStr,monthStr,dayStr] forState:UIControlStateNormal];

}

- (IBAction)selectSexAction:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    if (button.selected) {
        return;
    }
    
    UIButton *lastSelectedBtn = [self getSeletedButton];
    lastSelectedBtn.selected = NO;
    
    
    button.selected = YES;
    if (button.tag == 2) {
        _isMan = NO;
    }else{
        _isMan = YES;
    }

}


#pragma mark - 生日视图相关

-(void)loadMaskView{
    
    _maskView = [[UIControl alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _maskView.alpha = 0.3;
    _maskView.backgroundColor = [UIColor blackColor];
    _maskView.hidden = YES;
    [(UIControl*)_maskView addTarget:self action:@selector(downCalenderView) forControlEvents:UIControlEventTouchUpInside];
//    [_maskView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
//        [self downCalenderView];
//    }];
    [self.view insertSubview:_maskView belowSubview:_birthCalenderView];
}

-(void)downCalenderView{
    
    CGRect rt = self.birthCalenderView.frame;
    rt.origin.y = self.view.size.height;
    rt.size.height = 292;
    [UIView animateWithDuration:0.3 animations:^{
        
        _maskView.hidden = YES;
//        self.bottonConstraint.constant = -self.birthCalenderView.height;
//        [self.view layoutIfNeeded];
        _birthCalenderView.frame = rt;
        _isSelectBirth = NO;
        
    }];
}//往下

-(void)upCalenderView{
    
    CGRect rt = self.birthCalenderView.frame;
    rt.origin.y = self.view.size.height - 292;
    rt.size.height = 292;
    [UIView animateWithDuration:0.3 animations:^{
//        self.bottonConstraint.constant = 0;
//        [self.view layoutIfNeeded];
        _birthCalenderView.frame = rt;
        _maskView.hidden = NO;
        _isSelectBirth = YES;
    }];
    
}//往上


- (IBAction)selectedBirth:(id)sender {

    [self.view endEditing:YES];
    
    if (!_isSelectBirth) {
        [self upCalenderView];
    }else{
        [self downCalenderView];
    }
    _isSelectBirth = !_isSelectBirth;

}//选择生日


-(void)heightEditi:(UITextField *)field {


    heightStr = field.text;


}


-(void)weightEditi:(UITextField *)field {
    
    weightStr = field.text;

}



//- (UIPickerView *)
- (void)dealloc {

}
     
     
@end
