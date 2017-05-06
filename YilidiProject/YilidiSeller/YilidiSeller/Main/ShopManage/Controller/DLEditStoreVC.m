//
//  DLEditStoreVC.m
//  YilidiSeller
//
//  Created by yld on 16/6/2.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLEditStoreVC.h"
#import "UIBarButtonItem+WNXBarButtonItem2.h"
#import "DLImagePicker.h"
#import "RBCustomDatePickerView.h"
#import "DLAlterView.h"
#import "AFNHttpRequestOPManager+DLUnNomalApi.h"
#import "UIImageView+sd_SetImg.h"
#import "DLRequestUrl.h"
#import "GlobleConst.h"
@interface DLEditStoreVC ()<UIActionSheetDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *storeImageView;
@property (weak, nonatomic) IBOutlet UITextField *storeName;
@property (weak, nonatomic) IBOutlet UIButton *businessTimeButton;
@property (weak, nonatomic) IBOutlet UITextField *price;
@property (weak, nonatomic) IBOutlet UIButton *storePhoneButton;
@property (weak, nonatomic) IBOutlet UITextField *region;
@property (weak, nonatomic) IBOutlet UITextField *detailedAddress;
@property (weak, nonatomic) IBOutlet UISwitch *switchButton;
@property (nonatomic,strong)DLImagePicker *imagePicker;
@property (nonatomic,strong)RBCustomDatePickerView *pickerView;
@property (nonatomic,strong)UIButton *btn;
@end

@implementation DLEditStoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _init];
    [self _initRightItem];
    self.pageTitle = @"编辑店铺";
    
    [self _getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ------------------------Init---------------------------------
- (void)_init {

    //图片添加点击事件
//    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(_onClickImage)];
//    
//    singleTap.numberOfTouchesRequired = 1;
//    [self.storeImageView addGestureRecognizer:singleTap];
    
    _switchButton.transform = CGAffineTransformMakeScale(0.8, 0.8);
    
}

- (void)_initRightItem {

    _btn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-56, 30, 56, 22)];
    [_btn addTarget:self action:@selector(_rightClick) forControlEvents:UIControlEventTouchUpInside];
    [_btn setTitle:@"保存" forState:UIControlStateNormal];
    [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_btn setBackgroundColor:KSelectedBgColor];
    _btn.layer.cornerRadius=2;
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:_btn];
    
}
#pragma mark ------------------------Private-------------------------
- (void)_parsingData:(NSDictionary *)dic {

    self.storeName.text = dic[@"storeName"];
    NSString *time = [NSString stringWithFormat:@"%@-%@",dic[@"beginBusinessHours"],dic[@"endBusinessHours"]];
    [self.businessTimeButton setTitle:time forState:UIControlStateNormal];
    [self.storePhoneButton setTitle: dic[@"hotline"] forState:UIControlStateNormal];
    self.region.text =[NSString stringWithFormat:@"%@%@%@",dic[@"provinceName"],dic[@"cityName"],dic[@"countyName"]];
    
    self.price.text = [NSString stringWithFormat:@"%d",[dic[@"deduceTransCostAmount"]intValue]/1000];
    self.detailedAddress.text = dic[@"addressDetail"];
    if (!isEmpty(dic[@"userImageUrl"])) {
        
    [self.storeImageView sd_SetImgWithUrlStr:dic[@"userImageUrl"] placeHolderImgName:@"storeDefault"];
    }
    NSNumber *staus = dic[@"storeStatus"];
    switch ([staus intValue] ) {
        case 1:
            _switchButton.on = NO;
            break;
        case 0:
            _switchButton.on = YES;
            break;
            
        default:
            break;
    }
    
}

- (void)_onClickImage {
   UIActionSheet *myActionSheet = [[UIActionSheet alloc]
                     initWithTitle:nil
                     delegate:self
                     cancelButtonTitle:@"取消"
                     destructiveButtonTitle:nil
                     otherButtonTitles:@"打开照相机", @"从手机相册获取", nil];
    myActionSheet.tag =1;
    [myActionSheet showInView:self.view];
}
- (void)_rightClick {
    
    [self _postData];
   
}

#pragma mark ------------------------Api----------------------------------
- (void)_getData {
    
    [self showLoadingHub];
    [AFNHttpRequestOPManager postWithParameters:nil subUrl:kUrl_Store block:^(NSDictionary *resultDic, NSError *error) {
        
        NSLog(@"%@",resultDic);
        [self _parsingData:resultDic[@"entity"]];
        [self hideLoadingHub];
    }];
  
    

}
- (void)_postData {
    NSNumber *integer;
    if (_switchButton.isOn) {
        integer = @0;
    }else{
        integer = @1;
    }
    NSString *time = self.businessTimeButton.titleLabel.text;
    NSArray *arr = [time componentsSeparatedByString:@"-"];
    NSString *startTimer = [NSString stringWithFormat:@"%@",arr[0]];
    NSString *endTimer = [NSString stringWithFormat:@"%@",arr[1]];
    
//    店铺运费 @"transCostAmount":@1 
    NSDictionary *parameters = @{@"storeName":self.storeName.text,@"hotline":self.storePhoneButton.titleLabel.text,@"storeStatus":integer,@"beginBusinessHour":startTimer,@"endBusinessHour":endTimer,@"deduceTransCostAmount":[NSNumber numberWithInt:[self.price.text intValue]*1000]};
    

    NSLog(@"parameters%@",parameters);
    [self showLoadingHub];
    [AFNHttpRequestOPManager postWithParameters:parameters subUrl:kUrl_EditorStore block:^(NSDictionary *resultDic, NSError *error) {
        
        if (error.code!=1) {
            
            [self hideLoadingHub];
        }else{
            //修改内容值需要转换成可变后再存储。
            NSDictionary *homeData  = [kUserDefaults objectForKey:HomeResponeData];
            NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:homeData];
            [mutableDic setObject:startTimer forKey:@"beginBusinessHours"];
            [mutableDic setObject:endTimer forKey:@"endBusinessHours"];
          
            [kUserDefaults setObject:(NSDictionary *)mutableDic forKey:HomeResponeData];
            [kUserDefaults synchronize];

            
            [self hideHubForText:@"修改成功"];
            [self delayGoBack];
        
        NSLog(@"resultDic:%@",resultDic);
        }
    }];
    
    
}
#pragma mark ------------------------Page Navigate---------------------------


#pragma mark ------------------------View Event---------------------------
- (IBAction)businessTimeClick:(UIButton *)sender {
    
    _pickerView = [[RBCustomDatePickerView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
    _pickerView.alpha = 0;
    WEAK_SELF
    _pickerView.timePickerBlock = ^(NSString *str){
    
    NSArray *arr = [str componentsSeparatedByString:@"-"];
    NSString *startTimer = [NSString stringWithFormat:@"%@:00",arr[0]];
    NSString *endTimer = [NSString stringWithFormat:@"%@:00",arr[1]];
        NSString *storeTimer = [NSString stringWithFormat:@"%@-%@",startTimer,endTimer];
        
    [sender setTitle:storeTimer forState:UIControlStateNormal];
    [UIView animateWithDuration:1 animations:^{
            weak_self.pickerView.alpha = 0;
        } completion:^(BOOL finished) {
      
        }];
    };
   
    [UIView animateWithDuration:1 animations:^{
        weak_self.pickerView.alpha = 1;

    } completion:^(BOOL finished) {
        
    }];
    
    [self.view addSubview:_pickerView];
    
}

- (IBAction)storePhoneButtonClick:(UIButton *)sender {
    
    DLAlterView *alterView = [[DLAlterView alloc]init];
    [alterView show];
    [alterView setTextBlock:^(NSString *phoneText,NSString*codeText) {

    }];
}

#pragma mark ------------------------Delegate-----------------------------
#pragma mark - 相册选取文件点击
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        
        [self takePhoto];
        
    }else if(buttonIndex==1) {
        
        [self LocalPhoto];
        
        
    }
    
}


//打开相机
- (void)takePhoto
{
    
    
    //判断当前设备是否有摄像头
    BOOL isCamer = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    if (!isCamer) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有可用摄像头" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alertView show];
        return;
        
    }
    
    self.imagePicker = [[DLImagePicker alloc] init];
    
    //指定资源的来源：来自摄像头
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    
    WEAK_SELF
    self.imagePicker.getImage = ^(NSString *image){
        
        [weak_self.storeImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",image]]];
        
        
        //图片存入相册
        UIImageWriteToSavedPhotosAlbum(weak_self.storeImageView.image, nil, nil, nil);
        
        NSString *img = [NSString stringWithFormat:@"%@",image];
        
         //上传图片。
//        NSString *zm=  [postImage  postRequestWithURL:baseUrl2 postParems:nil picFilePath:img picFileName:nil];
//        
    
        
    };
    
    self.imagePicker.allowsEditing = YES;
    
    [self presentViewController:self.imagePicker animated:YES completion:NULL];
    
    
    
    
}

//打开相册
- (void)LocalPhoto
{
    
    self.imagePicker = [[DLImagePicker alloc]init];
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePicker.allowsEditing = YES;
    
    [self presentViewController:self.imagePicker animated:YES completion:^{
        
    }];
    
   WEAK_SELF
   self.imagePicker.getImage = ^(NSString *image){
        
        [weak_self.storeImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",image]]];
        
        NSString *img = [NSString stringWithFormat:@"%@",image];
        //上传图片。
        
    };
    
    
    
    
}


#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------


@end
