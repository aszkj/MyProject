//
//  FollwerContent.m
//  jingGang
//
//  Created by wangying on 15/6/12.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "FollwerContent.h"
#import "userDefaultManager.h"
#import "PublicInfo.h"
#import "Util.h"
#import "GlobeObject.h"
#import "SVProgressHUD.h"
#import "DeleteImageView.h"
#import "H5Base_url.h"
#import "UIViewExt.h"
#import "KJShoppingAlertView.h"

@interface FollwerContent ()<UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,DeleImageViewDelegate>
{
    BOOL _isAction;
    VApiManager *_VApManager;
    NSString *textContent;
    UIView *topView;
    UITextField *text;
}

/**
 *  textView控件
 */
@property (strong,nonatomic) UITextView *textView;

/**
 *   装图片的容器数组
 */
@property (strong,nonatomic) NSMutableArray *imgChooseArray;

/**
 *   装删除按钮的容器数组
 */
@property (strong,nonatomic) NSMutableArray *deleteButtonArray;


/**
 *   装着发布帖子选择上传成功图片的路径--
 */
@property (strong,nonatomic) NSMutableArray *uploadImageUrlPaths;

/**
 *   使用照相机选择图片按钮
 */
@property (strong,nonatomic) UIButton *caremaButton;
/**
 *   从相册中选择图片按钮
 */
@property (strong,nonatomic) UIButton *photoButton;

/**
 *   两个按钮线面的线
 */
@property (strong,nonatomic) UILabel *lineLab;
@end

@implementation FollwerContent

#pragma mark  -- 懒加载 --
/**
 *   装图片的容器数组
 */
- (NSMutableArray *)imgChooseArray {
    if (!_imgChooseArray) {
        _imgChooseArray = [NSMutableArray array];
    }
    return _imgChooseArray;
}


/**
 *   deleteButtonArray
 */
- (NSMutableArray *)deleteButtonArray {
    if (!_deleteButtonArray) {
        _deleteButtonArray = [NSMutableArray array];
    }
    return _deleteButtonArray;
}

/**
 *  装着发布帖子选择上传成功图片的路径--
 */
- (NSMutableArray *)uploadImageUrlPaths {
    if (!_uploadImageUrlPaths) {
        _uploadImageUrlPaths = [NSMutableArray array];
    }
    return _uploadImageUrlPaths;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    if (self.imgChooseArray.count > 0) {
        [self clearImageMoveDown:NO];
    }
}

/**
 *   删完、或者没图,按钮往下移动,按钮下的线隐藏
 */
- (void)clearImageMoveDown:(BOOL)moveDown {
    if (moveDown) {
        self.caremaButton.frame = CGRectMake(10, self.textView.origin.y+__MainScreen_Height- 64 -150, 32, 32);
    }else {
        self.caremaButton.frame = CGRectMake(10, self.textView.origin.y+__MainScreen_Height- 64 -150-80, 32, 32);
        
    }
    self.photoButton.frame = CGRectMake(self.caremaButton.origin.x+self.caremaButton.width+9, self.caremaButton.origin.y, 32, 32);
    self.lineLab.frame = CGRectMake(0, self.caremaButton.origin.y+self.caremaButton.height+15, __MainScreen_Width, 0.5);
    self.lineLab.hidden = moveDown;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupContent];
}

-(void)setupContent {
    //    self.view.backgroundColor  =  [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    CGFloat width = __MainScreen_Width /2;
    CGFloat height = __StatusScreen_Height;
    self.view.backgroundColor = [UIColor whiteColor];
    
    topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __MainScreen_Width, __Other_Height+1)];
    topView.backgroundColor = [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1];
    [self.navigationController.view addSubview:topView];
    
    UILabel *title_ans = [[UILabel alloc]initWithFrame:CGRectMake(width -40, height, 80, 50)];
    if (self.isRepy) {//回复回复
        title_ans.text = @"回复评论";
    }else{
        title_ans.text = @"回复帖子";
    }
    title_ans.textColor = [UIColor whiteColor];
    title_ans.font = [UIFont systemFontOfSize:20];
    [topView addSubview:title_ans];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, height +10, 40, 30)];
    [btn setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    
    [topView addSubview:btn];
    
    UIButton *btn_bg = [[UIButton alloc]initWithFrame:CGRectMake(width*2 - 60, height +15, 40, 20)];
    [btn_bg setTitle:@"回复" forState:UIControlStateNormal];
    [btn_bg setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn_bg addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:btn_bg];
    
#pragma mark -- 设置ui --
    UILabel *l_ans =[[UILabel alloc]initWithFrame:CGRectMake(10, 70, 250, 50)];
    l_ans.text = [NSString stringWithFormat:@"回复帖子:%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"circleTitle"]];
    
    l_ans.textColor = [UIColor grayColor];
    l_ans.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:l_ans];
    
    UILabel *line_ans =[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(l_ans.frame) + 1, self.view.frame.size.width - 20, 1)];
    line_ans.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.2];
    [self.view addSubview:line_ans];
    
    UITextView *text_ans = [[UITextView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(line_ans.frame) + 5, CGRectGetWidth(line_ans.frame), 100)];
    text_ans.delegate = self;
    text_ans.font = [UIFont systemFontOfSize:16];
    text = [[UITextField alloc]initWithFrame:CGRectMake(5, 0, CGRectGetWidth(line_ans.frame), 60)];
    text.placeholder = @"请输入回复内容";
    
    text.userInteractionEnabled = NO;
    [text_ans addSubview:text];
    [self.view addSubview:text_ans];
    self.textView = text_ans;
    
    /**
     *   照相机选择图片的按钮
     */
    UIButton *cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cameraButton setBackgroundImage:[UIImage imageNamed:@"ask_photo"] forState:UIControlStateNormal];
    [cameraButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cameraButton];
    self.caremaButton = cameraButton;
    RELEASE(caremaButton);
    
    /**
     *   从相册选择图片的按钮
     */
    UIButton *photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [photoButton setBackgroundImage:[UIImage imageNamed:@"ask_album"] forState:UIControlStateNormal];
    [photoButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:photoButton];
    self.photoButton = photoButton;
    RELEASE(photoButton);
    
    /**
     *   按钮底部的线
     */
    UILabel * lineLabel = [[UILabel alloc]init];
    lineLabel.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineLabel];
    self.lineLab = lineLabel;
    [self clearImageMoveDown:YES];
}

/**
 *   监听选择图片的点击事件
 */
- (void)btnClick:(UIButton *)button {
    if (button == self.caremaButton) {
        /**
         *  使用手机拍照
         */
        [self modifyHeadByCamera];
        
        [SVProgressHUD showInView:self.view status:@"正在调用相机,请稍后..." networkIndicator:NO posY:-1 maskType:1];
        
    }else if (button == self.photoButton){
        /**
         *  从相册中选择图片
         */
        [self modifyHeadByChoose];
        
        [SVProgressHUD showInView:self.view status:@"正在调用系统相册,请稍后..." networkIndicator:NO posY:-1 maskType:1];
    }
}

/**
 *   使用手机拍照
 */
- (void) modifyHeadByCamera
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

/**
 *  从相册中选择图片
 */
- (void) modifyHeadByChoose
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

//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.view endEditing:YES];
//}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //    topView.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}
-(void)leftClick
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (self.isRepy) {
        self.commentBlcock(YES);
        return;
    }
    if (self.commentBlcock) {
        self.commentBlcock(false);
    }
}

/**
 *   -- 回复请求 --
 */
-(void)rightClick
{
    if (_isAction) {
        return;
    }
    _isAction = YES;
    [self.view endEditing:YES];
    _VApManager = [[VApiManager alloc]init];
    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
    UsersCommentAddRequest *usersCommentAddRequest = [[UsersCommentAddRequest alloc] init:accessToken];
    
    usersCommentAddRequest.api_content = textContent;
    usersCommentAddRequest.api_invitationId = _num;
    usersCommentAddRequest.api_pic = [self checkReplyPost:self.uploadImageUrlPaths];
    JGLog(@"usersCommentAddRequest.api_pic:%@",usersCommentAddRequest.api_pic);
    WEAK_SELF
    [_VApManager usersCommentAdd:usersCommentAddRequest success:^(AFHTTPRequestOperation *operation, UsersCommentAddResponse *response) {
        NSLog(@"评论成功%@",response);
        if (response.errorCode.integerValue == 5) {
            KSensitiveWords
        }
        else if (response.errorCode){
            [Util ShowAlertWithOnlyMessage:response.subMsg];
        }
        else
        {
            [self hideHubWithOnlyText:@"评论成功"];
            [weak_self dismissViewControllerAnimated:YES completion:nil];
            if (weak_self.commentBlcock) {
                weak_self.commentBlcock(true);
            }
        }
        _isAction = NO;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self hideHubWithOnlyText:@"评论失败"];
        _isAction = NO;
        NSLog(@"评论失败%@",error);
    }];
    
    [self.view endEditing:NO];
}

/**
 *  对请求提交的参数进行检测-
 *
 *  @param uploadImagePaths 上传图片路径数组
 *
 *  @return 由图片路径拼接的字符串
 */
- (NSString *)checkReplyPost:(NSMutableArray *)uploadImagePaths {
    NSMutableArray *nulArray = [NSMutableArray array];
    for (NSString *path in uploadImagePaths) {
        if (path.length == 0) {
            [nulArray addObject:path];
        }
    }
    
    [uploadImagePaths removeObjectsInArray:[nulArray copy]];
    
    NSString * fina_imgStr = nil;
    if (uploadImagePaths.count == 0) {
        fina_imgStr = @"";
    }else{
        fina_imgStr = [uploadImagePaths firstObject];
        for (int i = 1; i < uploadImagePaths.count; i++) {
            NSString * img_str = [uploadImagePaths objectAtIndex:i];
            fina_imgStr = [NSString stringWithFormat:@"%@|%@",fina_imgStr,img_str];
        }
    }
    return fina_imgStr;
}

/**
 *   -- 处理将要上传图片(将图片进行压缩) --
 */
- (void)handleUpdatingImage:(DeleteImageView *)updataImage {
    NSData * imageData = [[NSData alloc]init];
    imageData=UIImageJPEGRepresentation(updataImage.image, 0.5);
    NSUInteger sizeOrigin = [imageData length];
    NSUInteger sizesizeOriginKB = sizeOrigin / 1024;
    
//    // 图片大于10k要先进行压缩
//    if (sizesizeOriginKB > 50)
//    {
//        float a = 50.00000;
//        float  b = (float)sizesizeOriginKB;
//        float q = sqrt(a/b);
//        CGSize sizeImage = [updataImage size];
//        CGFloat iwidthSmall = sizeImage.width * q;
//        CGFloat iheightSmall = sizeImage.height * q;
//        CGSize itemSizeSmall = CGSizeMake(iwidthSmall, iheightSmall);
//        UIGraphicsBeginImageContext(itemSizeSmall);
//        CGRect imageRectSmall = CGRectMake(0.0f, 0.0f, itemSizeSmall.width, itemSizeSmall.height);
//        [updataImage.image drawInRect:imageRectSmall];
//        UIImage *SmallImage = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        NSData *dataImageSend = UIImageJPEGRepresentation(SmallImage, 0);
//        imageData = dataImageSend;
//    }
    [self uploadImageWithImageData:imageData];
    [SVProgressHUD showInView:self.view status:@"正在上传" networkIndicator:NO posY:-1 maskType:1];
}

/**
 *  将压缩过后的数据流进行上传
 *
 *  @param imageData 图片二进制流
 */
- (void)uploadImageWithImageData:(NSData *)imageData {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //@"http://api.jgyes.com/v1/image"
#warning -- 使用Base_URL 拿不到items图片路径，程序会崩溃  须要使用 http://api.jgyes.com这个路径才可以。。
    NSString *postImageUrl = [NSString stringWithFormat:@"%@/v1/image",@"http://api.jgyes.com"];
    [manager POST:postImageUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"filename" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        /**
         *  成功上传图片- 拿到上传图片的路径-》newCommentImgUrl
         */
        NSString *newCommentImgUrl =  [[responseObject[@"items"] objectAtIndex:0] objectForKey:@"fileUrl"];
        
        JGLog(@"\nGetImageUrl:%@",newCommentImgUrl);
        
        NSError *error = nil;
        //回调更新图片block
        if (!newCommentImgUrl || [newCommentImgUrl isEqualToString:@""]) {
            error = [NSError errorWithDomain:@"图片上传失败" code:1 userInfo:nil];
            [SVProgressHUD dismissWithSuccess:@"图片上传失败"];
            
        }else {
//            error = [NSError errorWithDomain:@"图片上传成功" code:0 userInfo:nil];
            
            //将成功上传图片的路径添加到uploadImageUrlPaths容器中去.
            [self.uploadImageUrlPaths addObject:newCommentImgUrl];
            [SVProgressHUD dismissWithSuccess:@"上传成功"];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD dismissWithError:@"网络错误，请稍后重试"];
        [self.uploadImageUrlPaths addObject:@""];
    }];
}

#pragma mark -- UIImagePickerControllerDelegate --
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    DeleteImageView * img = [[DeleteImageView alloc]init];
    if ([mediaType isEqualToString:@"public.image"])
    {
        img.image = [info objectForKey:UIImagePickerControllerEditedImage];
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        NSLog(@"选择头像成功");
        if (self.imgChooseArray.count < 3) {
            //不足三张图片
            [self.imgChooseArray addObject:img];
            [self clearImageMoveDown:NO];
            NSInteger i = self.imgChooseArray.count-1;
            DeleteImageView * little_img = [self.imgChooseArray objectAtIndex:i];
            little_img.delegate = self;
            little_img.isShowDeleteButtn = NO;
            
            CGFloat img_spase = (__MainScreen_Width-90*3)/4;
            CGFloat     img_bound = 90;
            little_img.frame = CGRectMake((i+1)*img_spase+i*img_bound, self.lineLab.frame.origin.y+20, img_bound, img_bound);
            [self.view addSubview:little_img];
            
            /**
             *   做上传图片的处理
             */
            [self handleUpdatingImage:little_img];
            
        }else{
            UIAlertView * alertVc = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您只能选择最多3张图片" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertVc show];
        }
    }];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

#pragma mark -- DeleteImageViewDelegate --
- (void)deleImageViewLongPress:(DeleteImageView *)deleteImageView state:(StateType)stateType {
    switch (stateType) {
        case DeleteButtonHidden:
        {
            for (DeleteImageView *deleteImageView in self.imgChooseArray) {
                [deleteImageView setIsShowDeleteButtn:YES];
            }
        }
            break;
        case DeleteButtonShow:
        {
            for (DeleteImageView *deleteImageView in self.imgChooseArray) {
                [deleteImageView setIsShowDeleteButtn:NO];
            }
        }
            break;
        default:
            break;
    }
}

- (void)deleteButtonClick:(DeleteImageView *)deleteImageView {
    if (self.imgChooseArray.count == 0 ) {
        return;
    }
    // 拿到删除图片的数组下标
    NSUInteger imageViewIndex = [self.imgChooseArray indexOfObject:deleteImageView];
    [self.uploadImageUrlPaths removeObjectAtIndex:imageViewIndex];
    [self.imgChooseArray removeObject:deleteImageView];
    [deleteImageView removeFromSuperview];
    
    if (self.imgChooseArray.count) {
            [self.imgChooseArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {

            DeleteImageView *deleteImage = (DeleteImageView *)obj;
            CGFloat img_spase = (__MainScreen_Width-90*3)/4;
            CGFloat     img_bound = 90;
            deleteImage.frame = CGRectMake((idx+1)*img_spase+idx*img_bound, self.lineLab.frame.origin.y+20, img_bound, img_bound);
        }];
        
    }else {
        // 删完了,按钮往下移动,按钮下的线隐藏
        [self clearImageMoveDown:YES];
    }
}


#pragma mark -- TextViewDelegate --
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    text.hidden = YES;
}
-(void)textViewDidChange:(UITextView *)textView
{
    textContent = [textView.text copy];
}

@end
