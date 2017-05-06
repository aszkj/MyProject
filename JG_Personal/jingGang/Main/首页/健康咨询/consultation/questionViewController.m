//
//  questionViewController.m
//  jingGang
//
//  Created by yi jiehuang on 15/6/11.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "questionViewController.h"
#import "PublicInfo.h"
#import "SVProgressHUD.h"
#import "userDefaultManager.h"
#import "sucsessViewController.h"
#import "UIImageView+WebCache.h"

@interface questionViewController ()
{
    UIView          *_myView;
    UITextField     *_title_tf,*_textView_tf;
    UITextView      *_dis_tv;
    UIButton        *_photo,*_my_img,*del_btn;//照相btn，选择相片btn
    UILabel         *_line_last,*_title_label;//照相btn下方的横线
    float           img_bound ;
    float           img_spase ;
    int             changFrame;//标记第一次进入改变photoBtn坐标
    int             presee;//纪录长按手势发生次数
    VApiManager     *_VApmanager;
    NSMutableArray  * fina_imgArr;//最终需要上传的图片数组
}

@end

@implementation questionViewController

- (void)viewWillAppear:(BOOL)animated
{
    _VApmanager = [[VApiManager alloc]init];
    if (self.title_ID!=NULL && self.title_ID.length != 0) {
        [SVProgressHUD showInView:self.view status:@"正在加载数据..." networkIndicator:NO posY:-1 maskType:1];
        NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
        SnsConsultingDetailRequest *SnsConsultingDetail = [[SnsConsultingDetailRequest alloc] init:accessToken];
        int title_ID = [self.title_ID intValue];
        SnsConsultingDetail.api_cid = [NSNumber numberWithInt:title_ID];
        [_VApmanager snsConsultingDetail:SnsConsultingDetail success:^(AFHTTPRequestOperation *operation, SnsConsultingDetailResponse *response) {
            [SVProgressHUD dismiss];
            NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
            NSString * jsonStr = [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding];
            NSLog( @"dict---->%@, jsonStr----->%@",dict,jsonStr);
            self.title_str = [[dict objectForKey:@"consultingBO"] objectForKey:@"title"];
            self.dis_str = [[dict objectForKey:@"consultingBO"] objectForKey:@"content"];
            self.imgs_url = [[dict objectForKey:@"consultingBO"] objectForKey:@"images"];
            NSLog(@"self.imgURLS---%@",self.imgs_url);
            if(_title_tf!=NULL) _title_tf.text = self.title_str;
            if(_title_label!=NULL)_title_label.text = self.title_str;
            if ([self.bar_title isEqualToString:@"修改提问"]) {
                _dis_tv.text = self.dis_str;
                _textView_tf.hidden = YES;
                NSArray * imgarr = [self.imgs_url componentsSeparatedByString:@"|"];
                for (int i = 0; i < imgarr.count; i++) {
                    [fina_imgArr addObject:[imgarr objectAtIndex:i]];
                }
                
                _title_tf.hidden = NO;
                _title_label.hidden = YES;

                
            }else if([self.bar_title isEqualToString:@"新增回复"]){
                _title_tf.hidden = YES;
                _title_label.hidden = NO;
            }else{
                _title_tf.hidden = NO;
                _title_label.hidden = YES;
            }
                
            if (changFrame == 0 && self.imgs_url.length !=0) {
                [self changePhotoBtnFrame:self.imgs_url];
            }
//            _dis_tv.text = self.dis_str;
//            _textView_tf.hidden = YES;
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [SVProgressHUD dismiss];
            [self showAlertViewWithStr:@"网络错误，请稍后重试"];
        } ];
    }else{
       // [self showAlertViewWithStr:@"请输入标题与正文"];

    }
    [super viewWillAppear:animated];
}

- (void)changePhotoBtnFrame:(NSString *)str
{
    changFrame = 1;
    [_img_choose_array removeAllObjects];
    _dis_tv.frame = CGRectMake(10, 45, __MainScreen_Width-20, 100);
    _photo.frame = CGRectMake(15, _dis_tv.frame.origin.y+__MainScreen_Height-200-80, 32, 32);
    _my_img.frame = CGRectMake(_photo.frame.origin.x+_photo.frame.size.width+9, _photo.frame.origin.y, 32, 32);
    _line_last.frame = CGRectMake(0, _photo.frame.origin.y+_photo.frame.size.height+15, __MainScreen_Width, 0.5);
    _line_last.hidden = NO;
    NSArray * arr = [str componentsSeparatedByString:@"|"];
    for (int i = 0; i < arr.count; i ++) {
//    NSInteger i = _img_choose_array.count-1;
        NSString * img_url = [arr objectAtIndex:i];
        UIImageView * little_img = [[UIImageView alloc]init];
        [little_img sd_setImageWithURL:[NSURL URLWithString:img_url]];
        little_img.frame = CGRectMake((i+1)*img_spase+i*img_bound, _line_last.frame.origin.y+20, img_bound, img_bound);
        [self.view addSubview:little_img];
        little_img.userInteractionEnabled = YES;
        [_img_choose_array addObject:little_img];
//    [self uploadimgWithImg:little_img];
    
        self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGestures:)];
        self.longPressGestureRecognizer.numberOfTouchesRequired = 1;
        self.longPressGestureRecognizer.allowableMovement = 15.0;
        self.longPressGestureRecognizer.minimumPressDuration = 1.5;
        [little_img addGestureRecognizer:self.longPressGestureRecognizer];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    fina_imgArr = [[NSMutableArray alloc]init] ;
    changFrame = 0;
    presee = 0;
    img_bound = 90;
    img_spase = (__MainScreen_Width-90*3)/4;
    _img_choose_array = [[NSMutableArray alloc]init];
    _del_btn_array = [[NSMutableArray alloc]init];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"home_title"] forBarMetrics:UIBarMetricsDefault];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.navigationItem.titleView = titleLabel;

    UIButton *leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0.0f, 16.0f, 40.0f, 25.0f)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButton;


    UIButton *rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(0.0f, 16.0f, 40.0f, 25.0f)];
    if ([self.bar_title isEqualToString:@"修改提问"]) {
        titleLabel.text = self.bar_title;
        [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    }else if ([self.bar_title isEqualToString:@"新增回复"]){
        titleLabel.text = self.bar_title;
        [rightBtn setTitle:@"发布" forState:UIControlStateNormal];
    }
    else{
        titleLabel.text = @"我要提问";
        [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    }
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButton;


    self.view.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1];
    [self greatUI];
}

static float  text_vc_H;

- (void)greatUI
{
    _myView = [[UIView alloc]init];
    _myView.frame = CGRectMake(0, 10, __MainScreen_Width, __MainScreen_Height-10);
    _myView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_myView];
    
    UILabel * name_lab = [[UILabel alloc]init];
    name_lab.text = @"标题:";
    name_lab.frame = CGRectMake(10, 10, 40, 20);
    name_lab.textColor = [UIColor lightGrayColor];
    [_myView addSubview:name_lab];

    
    UILabel * line_lab = [[UILabel alloc]init];
    line_lab.frame = CGRectMake(name_lab.frame.origin.x+name_lab.frame.size.width+5, 5, 0.5, 30);
    line_lab.backgroundColor = [UIColor lightGrayColor];
    [_myView addSubview:line_lab];

    UILabel * line_lab2 = [[UILabel alloc]init];
    line_lab2.frame = CGRectMake(10, 40, __MainScreen_Width-20, 0.5);
    line_lab2.backgroundColor = [UIColor lightGrayColor];
    [_myView addSubview:line_lab2];

    
    //if(self.title_ID!=NULL){
        _title_label = [[UILabel alloc]init];
        _title_label.frame = CGRectMake(line_lab.frame.origin.x+5, 0, __MainScreen_Width-100, 40);
        [_myView addSubview:_title_label];
    //}else{

    _title_tf = [[UITextField alloc]init];
    
       
    _title_tf.frame = CGRectMake(line_lab.frame.origin.x+5, 0, __MainScreen_Width-100, 40);
    _title_tf.placeholder = @"标题，24字以内";
    [_myView addSubview:_title_tf];
    
   // }
    _dis_tv = [[UITextView alloc]init];
    _dis_tv.delegate = self;
    
    _dis_tv.frame = CGRectMake(10, line_lab2.frame.origin.y+5, __MainScreen_Width-20, 100);
    _dis_tv.layer.borderColor = [UIColor whiteColor].CGColor;
    _dis_tv.layer.borderWidth = 1;
    _dis_tv.layer.cornerRadius = 6;
    _dis_tv.layer.masksToBounds = YES;
    _dis_tv.font = [UIFont systemFontOfSize:17];
    _dis_tv.backgroundColor = [UIColor clearColor];
    [_myView addSubview:_dis_tv];
    _textView_tf = [[UITextField alloc]init];

    
    _textView_tf.frame = CGRectMake(5, 10, __MainScreen_Width-40, 20);
    _textView_tf.placeholder = @"请在此输入您的问题..";
    _textView_tf.font = [UIFont systemFontOfSize:17];
    _textView_tf.userInteractionEnabled = NO;
    [_dis_tv addSubview:_textView_tf];
    
    
#pragma mark - 暂时把相册相关去掉
    _photo = [[UIButton alloc]init];
    _photo.frame = CGRectMake(15, _dis_tv.frame.origin.y+__MainScreen_Height-200, 32, 32);
    [_photo setBackgroundImage:[UIImage imageNamed:@"ask_photo"] forState:UIControlStateNormal];
    _photo.tag = 100;
    [_photo addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_myView addSubview:_photo];
    _my_img = [[UIButton alloc]init];
    _my_img.frame = CGRectMake(_photo.frame.origin.x+_photo.frame.size.width+9, _photo.frame.origin.y, 32, 32);
    [_my_img setBackgroundImage:[UIImage imageNamed:@"ask_album"] forState:UIControlStateNormal];
    _my_img.tag = 200;
    [_my_img addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_myView addSubview:_my_img];
    
    _line_last = [[UILabel alloc]init];
    _line_last.frame = CGRectMake(0, _photo.frame.origin.y+_photo.frame.size.height+15, __MainScreen_Width, 0.5);
    _line_last.backgroundColor = [UIColor lightGrayColor];
    [_myView addSubview:_line_last];
    _line_last.hidden = YES;
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (![text isEqualToString:@""]){
        _textView_tf.hidden = YES;
    }
    
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1){
        _textView_tf.hidden = NO;
    }
    return YES;
    
}


- (void)btnClick:(UIButton *)btn
{
    
    if (btn.tag == 100) {
        [self ModifyHeadByCamera];
        [SVProgressHUD showInView:self.view status:@"正在调用相机,请稍后..." networkIndicator:NO posY:-1 maskType:1];
    }else if (btn.tag == 200){
        [self ModifyHeadByChoose];
        [SVProgressHUD showInView:self.view status:@"正在调用系统相册,请稍后..." networkIndicator:NO posY:-1 maskType:1];
    }else if (btn.tag > 900){
        [del_btn removeFromSuperview];
        for ( id view in self.view.subviews) {
            if ([view isKindOfClass:[UIImageView class]]) {
                [view removeFromSuperview];
            }
        }
        if (_img_choose_array.count > 1) {
            [_img_choose_array removeObjectAtIndex:btn.tag-1000];
            for (int i = 0; i < _img_choose_array.count; i ++) {
                UIImageView * little_img = [_img_choose_array objectAtIndex:i];
                little_img.frame = CGRectMake((i+1)*img_spase+i*img_bound, _line_last.frame.origin.y+20, img_bound, img_bound);
                [self.view addSubview:little_img];
                little_img.userInteractionEnabled = YES;
                
                self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGestures:)];
                self.longPressGestureRecognizer.numberOfTouchesRequired = 1;
                self.longPressGestureRecognizer.allowableMovement = 15.0;
                self.longPressGestureRecognizer.minimumPressDuration = 1.5;
                [little_img addGestureRecognizer:self.longPressGestureRecognizer];
            }
        }else{
            UIImageView * little_img = [_img_choose_array objectAtIndex:0];
            [little_img removeFromSuperview];
            [_img_choose_array removeAllObjects];
            [fina_imgArr removeAllObjects];
            _dis_tv.frame = CGRectMake(10, 45, __MainScreen_Width-20, 100);
            _photo.frame = CGRectMake(15, _dis_tv.frame.origin.y+__MainScreen_Height-200, 32, 32);
            _my_img.frame = CGRectMake(_photo.frame.origin.x+_photo.frame.size.width+9, _photo.frame.origin.y, 32, 32);
            _line_last.hidden = YES;
        }
        for (UIButton * btn in _del_btn_array) {
            [btn removeFromSuperview];
        }
        [_del_btn_array removeAllObjects];
        presee = 0;
        [self uploadimg];
    }
}

// 编辑头像-拍照
- (void) ModifyHeadByCamera
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        //摄像头不可用
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:@"设备没有Camera" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];

        [SVProgressHUD dismiss];
        return;
    }
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType =  UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    ipc.allowsEditing = YES;
    [self presentViewController:ipc animated:YES completion:^{
        [SVProgressHUD dismiss];
    }];
}

// 编辑头像-相册选择
- (void) ModifyHeadByChoose
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        ipc.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    }
    ipc.delegate = self;
    ipc.allowsEditing = YES;
    [self presentViewController:ipc animated:YES completion:^{
        [SVProgressHUD dismiss];
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    UIImageView * img = [[UIImageView alloc]init];
    if ([mediaType isEqualToString:@"public.image"])
    {
        img.image = [info objectForKey:UIImagePickerControllerEditedImage];
        //        //先判断是否需要压缩，然后再发送
        
        //        [self CommitHeadToServer:dataImage];
        //        [SVProgressHUD showInView:self.view status:@"正在上传头像信息..." networkIndicator:NO posY:-1 maskType:SVProgressHUDMaskTypeNone];
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        NSLog(@"选择头像成功");
        if (_img_choose_array.count < 3) {
            [_img_choose_array addObject:img];
            _dis_tv.frame = CGRectMake(10, 45, __MainScreen_Width-20, 100);
            _photo.frame = CGRectMake(15, _dis_tv.frame.origin.y+__MainScreen_Height-200-80, 32, 32);
            _my_img.frame = CGRectMake(_photo.frame.origin.x+_photo.frame.size.width+9, _photo.frame.origin.y, 32, 32);
            _line_last.frame = CGRectMake(0, _photo.frame.origin.y+_photo.frame.size.height+15, __MainScreen_Width, 0.5);
            _line_last.hidden = NO;
            //            for (int i = 0; i < _img_choose_array.count; i ++) {
            NSInteger i = _img_choose_array.count-1;
            UIImageView * little_img = [_img_choose_array  objectAtIndex:i];
            little_img.frame = CGRectMake((i+1)*img_spase+i*img_bound, _line_last.frame.origin.y+20, img_bound, img_bound);
            [self.view addSubview:little_img];
            little_img.userInteractionEnabled = YES;
//            [self uploadimgWithImg:little_img];
            if ([self.bar_title isEqualToString:@"修改提问"]) {
                [fina_imgArr removeAllObjects];
                [self uploadimg];
            }else{
                [self uploadimgWithImg:little_img];
            }
            
            self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGestures:)];
            self.longPressGestureRecognizer.numberOfTouchesRequired = 1;
            self.longPressGestureRecognizer.allowableMovement = 15.0;
            self.longPressGestureRecognizer.minimumPressDuration = 1.5;
            [little_img addGestureRecognizer:self.longPressGestureRecognizer];
            //            }
        }else{
            UIAlertView * alertVc = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您只能选择最多3张图片" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertVc show];

            
        }
        
    }];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

}

- (void)uploadimgWithImg:(UIImageView *)imgView
{
    NSData * dataImage = [[NSData alloc]init];
    dataImage=UIImagePNGRepresentation(imgView.image);
    NSUInteger sizeOrigin = [dataImage length];
    NSUInteger sizesizeOriginKB = sizeOrigin / 1024;
    
    // 图片大于10k要先进行压缩
    if (sizesizeOriginKB > 50)
    {
        float a = 50.00000;
        float  b = (float)sizesizeOriginKB;
        float q = sqrt(a/b);
        CGSize sizeImage = [imgView.image size];
        CGFloat iwidthSmall = sizeImage.width * q;
        CGFloat iheightSmall = sizeImage.height * q;
        CGSize itemSizeSmall = CGSizeMake(iwidthSmall, iheightSmall);
        UIGraphicsBeginImageContext(itemSizeSmall);
        CGRect imageRectSmall = CGRectMake(0.0f, 0.0f, itemSizeSmall.width, itemSizeSmall.height);
        [imgView.image drawInRect:imageRectSmall];
        UIImage *SmallImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        NSData *dataImageSend = UIImageJPEGRepresentation(SmallImage, 1.0);
        dataImage = dataImageSend;
    }
    [self upLoadHeadImgWithImgData:dataImage];
    [SVProgressHUD showInView:self.view status:@"正在上传" networkIndicator:NO posY:-1 maskType:1];
}

- (void)uploadimg
{
//    if ([self.bar_title isEqualToString:@"修改提问"]) {
        [fina_imgArr removeAllObjects];
//        self.imgs_url = @"";
//    }
    
    //NSLog(@"tuian数组。count---%d",_img_choose_array.count);
//    NSInteger i = _img_choose_array.count-1;
//    UIImageView * fina_img = [_img_choose_array  objectAtIndex:i];
    for (UIImageView * fina_img in _img_choose_array) {
        NSData * dataImage = [[NSData alloc]init];
        dataImage=UIImagePNGRepresentation(fina_img.image);
        NSUInteger sizeOrigin = [dataImage length];
        NSUInteger sizesizeOriginKB = sizeOrigin / 1024;
        
        // 图片大于10k要先进行压缩
        if (sizesizeOriginKB > 50)
        {
            float a = 50.00000;
            float  b = (float)sizesizeOriginKB;
            float q = sqrt(a/b);
            CGSize sizeImage = [fina_img.image size];
            CGFloat iwidthSmall = sizeImage.width * q;
            CGFloat iheightSmall = sizeImage.height * q;
            CGSize itemSizeSmall = CGSizeMake(iwidthSmall, iheightSmall);
            UIGraphicsBeginImageContext(itemSizeSmall);
            CGRect imageRectSmall = CGRectMake(0.0f, 0.0f, itemSizeSmall.width, itemSizeSmall.height);
            [fina_img.image drawInRect:imageRectSmall];
            UIImage *SmallImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            NSData *dataImageSend = UIImageJPEGRepresentation(SmallImage, 1.0);
            dataImage = dataImageSend;
        }
        [self upLoadHeadImgWithImgData:dataImage];
    }

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


-(void)handleLongPressGestures:(UILongPressGestureRecognizer *)paramSender
{
    if (paramSender.state == UIGestureRecognizerStateBegan)
    {
        presee ++;
        int a = presee%2;
        if (a == 1) {
            for (int i = 0; i < _img_choose_array.count; i ++) {
                del_btn = [[UIButton alloc]init];
                del_btn.frame = CGRectMake(0, 0, 20, 20);
                [del_btn setBackgroundImage:[UIImage imageNamed:@"ask_delete"] forState:UIControlStateNormal];
                [del_btn setBackgroundImage:[UIImage imageNamed:@"ask_delete_pressed"] forState:UIControlStateHighlighted];
                del_btn.center = CGPointMake((i+1)*(img_bound+img_spase), _line_last.frame.origin.y+20);
                del_btn.tag = i+1000;
                [_del_btn_array addObject:del_btn];
                [del_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:del_btn];
            }
        }else{
            for (UIButton * btn in _del_btn_array) {
                [btn removeFromSuperview];
            }
        }
    }
}

- (void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBtnClick
{
    NSLog(@"发布");
    if (_title_tf.text.length == 0 && _title_label.text.length == 0) {
        [self showAlertViewWithStr:@"请填写您咨询的主题"];
    }else if (_dis_tv.text.length == 0){
        [self showAlertViewWithStr:@"请填写您需要咨询的具体内容"];
    }else{
        NSLog(@"self.title_id = %@",self.bar_title);
        if ([self.bar_title isEqualToString:@"新增回复"]) {
            [self updateRequest];
        }else if ([self.bar_title isEqualToString:@"修改提问"]){
            NSLog(@"修改提问");
            [self dolastRequest];//修改自己的提问
        }
        else{
            [self doSomeRequest];
        }
    }
}

- (void)doSomeRequest
{
    [SVProgressHUD showInView:self.view status:@"正在刷新数据" networkIndicator:NO posY:-1 maskType:1];
    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
    SnsConsultingAddRequest *SnsConsultingAdd = [[SnsConsultingAddRequest alloc] init:accessToken];
    SnsConsultingAdd.api_expertsUserId = [NSNumber numberWithInt:[self.uID intValue]];
    SnsConsultingAdd.api_title = _title_tf.text;
    SnsConsultingAdd.api_content = _dis_tv.text;
    NSString * fina_imgStr = nil;
    if (fina_imgArr.count==0) {
        fina_imgStr = @"";
    }else{
        fina_imgStr = [fina_imgArr firstObject];
        for (int i = 1; i < fina_imgArr.count; i++) {
            NSString * img_str = [fina_imgArr objectAtIndex:i];
            fina_imgStr = [NSString stringWithFormat:@"%@|%@",fina_imgStr,img_str];
        }
    }

    NSLog(@"fina_img_arr ----- %d",fina_imgArr.count);
    NSLog(@"最后的图片 ------> %@",fina_imgStr);
    SnsConsultingAdd.api_images = fina_imgStr;
    //    SnsConsultingAdd.api_id = @"";
    
    [_VApmanager snsConsultingAdd:SnsConsultingAdd success:^(AFHTTPRequestOperation *operation, SnsConsultingAddResponse *response) {
        [SVProgressHUD dismissWithSuccess:@"发布成功"];
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        NSString * jsonStr = [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        NSLog( @"查询咨询信息dict---->%@, jsonStr----->%@",dict,jsonStr);
        sucsessViewController * sucVc = [[sucsessViewController alloc]init];
      
        self.title_ID = [NSString stringWithFormat:@"%@",[[dict objectForKey:@"consultingBO"] objectForKey:@"id"]];
        
//          sucVc.Web_URL = [NSString stringWithFormat:@"http://192.168.1.50:8089/consulting/my_consulting?id=%@",self.title_ID];
        sucVc.Web_URL = [NSString stringWithFormat:@"%@/consulting/my_consulting?id=%@",SnsConsultingAdd.baseUrl,self.self.title_ID];
        NSLog(@"web_url ===== %@",sucVc.Web_URL);
        sucVc.web_id = self.title_ID;
        sucVc.experts_id = [[dict objectForKey:@"consultingBO"] objectForKey:@"expertsUserId"];
        [self.navigationController pushViewController:sucVc animated:YES];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败, %@",error);
        [SVProgressHUD dismiss];
        [self showAlertViewWithStr:@"网络错误，请稍后重试"];
    }];

}

- (void)updateRequest
{
    [SVProgressHUD showInView:self.view status:@"正在刷新数据" networkIndicator:NO posY:-1 maskType:1];
    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
    SnsConsultingRepayAddRequest *SnsConsultingRepay = [[SnsConsultingRepayAddRequest alloc] init:accessToken];
    int title_id = [self.title_ID intValue];
    SnsConsultingRepay.api_consultingId = [NSNumber numberWithInt:title_id];
    SnsConsultingRepay.api_content = _dis_tv.text;
    NSLog(@"api_consultingId = %d,api_content = %@",title_id,_dis_tv.text);
    [_VApmanager snsConsultingRepayAdd:SnsConsultingRepay success:^(AFHTTPRequestOperation *operation, SnsConsultingRepayAddResponse *response) {
        [SVProgressHUD dismiss];
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        NSString * jsonStr = [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        NSLog( @"dict---->%@, jsonStr----->%@",dict,jsonStr);
        sucsessViewController * sucVc = [[sucsessViewController alloc]init];
        sucVc.Web_URL = [NSString stringWithFormat:@"%@/consulting/my_consulting?id=%@",SnsConsultingRepay.baseUrl,[NSString stringWithFormat:@"%@",[[dict objectForKey:@"consultingBO"] objectForKey:@"id"]]];
        NSLog(@"web_url ===== %@",sucVc.Web_URL);
        sucVc.web_id = self.title_ID;
        sucVc.is_answer = self.is_answer;
        sucVc.vc_str = @"question";
        [self.navigationController pushViewController:sucVc animated:YES];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD dismiss];
        [self showAlertViewWithStr:@"网络错误，请稍后重试"];
    }];
}

#pragma mark - 上传图片
-(void)upLoadHeadImgWithImgData:(NSData *)imgData{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
     NSLog(@"将要上传的时候fina_img_arr ----- %d",fina_imgArr.count);
    
    [manager POST:@"http://api.jgyes.com/v1/image" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imgData name:@"file" fileName:@"filename" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"Success: %@", responseObject);
        [SVProgressHUD dismissWithSuccess:@"上传成功"];
        NSString *newHeadImgUrl =  [[responseObject[@"items"] objectAtIndex:0] objectForKey:@"fileUrl"];
        NSLog(@"newimg_url ==== %@",newHeadImgUrl);
        if ([self.bar_title isEqualToString:@"修改提问"]) {
            self.imgs_url = [NSString stringWithFormat:@"%@|%@",self.imgs_url,newHeadImgUrl];
            NSLog(@"上传头像之后－－－－self.imgUTLs----%@",self.imgs_url);
//            [self uploadimg];
        }
        [fina_imgArr addObject:newHeadImgUrl];
        NSLog(@"上传头像之后fina_img_arr ----- %d",fina_imgArr.count);
//        [self _upDateUsrHeadImgUrl:newHeadImgUrl];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [SVProgressHUD dismissWithError:@"网络错误，请稍后重试"];
    }];
}

- (void)dolastRequest
{
    [SVProgressHUD showInView:self.view status:@"正在刷新数据" networkIndicator:NO posY:-1 maskType:1];
    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
    SnsConsultingAddRequest *SnsConsultingAdd = [[SnsConsultingAddRequest alloc] init:accessToken];
//    SnsConsultingAdd.api_expertsUserId = [NSNumber numberWithInt:[self.web_id intValue]];
    SnsConsultingAdd.api_expertsUserId = [NSNumber numberWithInt:[self.experts_id intValue]];
    SnsConsultingAdd.api_id = [NSNumber numberWithInt:[self.title_ID intValue]];
    SnsConsultingAdd.api_title = _title_tf.text;
    SnsConsultingAdd.api_content = _dis_tv.text;
    NSString * fina_imgStr = nil;
    if (fina_imgArr.count==0) {
        fina_imgStr = @"";
    }else{
        fina_imgStr = [fina_imgArr firstObject];
        for (int i = 1; i < fina_imgArr.count; i++) {
            NSString * img_str = [fina_imgArr objectAtIndex:i];
            fina_imgStr = [NSString stringWithFormat:@"%@|%@",fina_imgStr,img_str];
        }
    }
    NSLog(@"修改咨询提问最后的图片 ------> %@",fina_imgStr);
    
    SnsConsultingAdd.api_images = fina_imgStr;
    NSLog(@"修改咨询传的值－－－－－专家id%@---咨询帖子id---%@－－咨询标题－－%@---咨询内容%@---最后的图片%@",self.experts_id,self.title_ID,_title_tf.text,_dis_tv.text,fina_imgStr);
    //    SnsConsultingAdd.api_id = @"";
    [_VApmanager snsConsultingAdd:SnsConsultingAdd success:^(AFHTTPRequestOperation *operation, SnsConsultingAddResponse *response) {
        [SVProgressHUD dismissWithSuccess:@"发布成功"];
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        NSString * jsonStr = [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        NSLog( @"修改后dict---->%@, jsonStr----->%@",dict,jsonStr);
        sucsessViewController * sucVc = [[sucsessViewController alloc]init];
        sucVc.web_id = self.web_id;
        sucVc.experts_id = self.experts_id;
        sucVc.is_answer = @"Is_Answer";
        sucVc.vc_str = @"question";
        sucVc.Web_URL = [NSString stringWithFormat:@"%@/consulting/my_consulting?id=%@",SnsConsultingAdd.baseUrl,self.web_id];
        NSLog(@"web_url ===== %@",sucVc.Web_URL);
        [self.navigationController pushViewController:sucVc animated:YES];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败, %@",error);
        [SVProgressHUD dismiss];
        [self showAlertViewWithStr:@"网络错误，请稍后重试"];
    }];

}


-(void)showAlertViewWithStr:(NSString *)string
{
    UIAlertView * alertVc = [[UIAlertView alloc]initWithTitle:@"提示" message:string delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];[alertVc show];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
