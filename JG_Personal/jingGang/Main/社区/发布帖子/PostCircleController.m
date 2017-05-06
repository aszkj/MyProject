//
//  PostCircleController.m
//  jingGang
//
//  Created by wangying on 15/6/19.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "PostCircleController.h"
#import "VApiManager.h"
#import "userDefaultManager.h"
#import "PublicInfo.h"
#import "SVProgressHUD.h"
#import "DeleteImageView.h"
#import "MBProgressHUD.h"
#import "GlobeObject.h"
#import "H5Base_url.h"
#import "UIViewExt.h"
@interface PostCircleController ()<UITextViewDelegate,DeleImageViewDelegate>
{
    VApiManager *_VApiManager;
    NSString *str1;
    NSString *str2;
}
@property (retain, nonatomic) IBOutlet UITextView *TextView;
- (IBAction)chenggg:(UITextField *)sender;

@property (retain, nonatomic) IBOutlet UITextField *text;

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

@implementation PostCircleController

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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 友盟统计
    [MobClick beginLogPageView:kPostViewController];
    
    if (self.imgChooseArray.count > 0) {
        [self clearImageMoveDown:NO];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    // 友盟统计
    [MobClick endLogPageView:kPostViewController];
}

/**
 *   发布帖子-----
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *   UI界面内容
     */
    [self  setupContent];
}

/**
 *   UI界面内容
 */
- (void)setupContent {
    str1 = @"";
    str2 = @"";
    _TextView.delegate = self;
    _text.userInteractionEnabled = NO;
    self.view.userInteractionEnabled  = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapClick)];
    [self.view addGestureRecognizer:tap];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1];
    
    UIButton *left_b =[[UIButton alloc]initWithFrame:CGRectMake(20, 25, 35, 25)];
    [left_b setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    
    [left_b addTarget:self action:@selector(selectBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *left =[[UIBarButtonItem alloc]initWithCustomView:left_b];
    self.navigationItem.leftBarButtonItem = left;
    RELEASE(left_b);
    RELEASE(left);
    
    UILabel *ll = [[UILabel alloc]initWithFrame:CGRectMake(30, 30, 100, 40)];
    ll.text = @"发布帖子";
    ll.font = [UIFont systemFontOfSize:15];
    ll.textColor = [UIColor whiteColor];
    self.navigationItem.titleView =ll;
    RELEASE(ll);
    
    UIBarButtonItem *right_ans = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(publish)];
    [right_ans setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = right_ans;
    RELEASE(right_ans);
//    
//    /**
//     *   照相机选择图片的按钮
//     */
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

-(void)TapClick
{
    [self.view endEditing:YES];
}

-(void)selectBack
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  发布帖子---
 */
-(void)publish
{
    if (str1.length == 0) {
        [self showAlertViewWithStr:@"请填写帖子的主题"];
        return;
    }else if (str2.length == 0 ) {
        [self showAlertViewWithStr:@"请填写帖子的内容"];
        return;
    }
    
    // 友盟统计
    [MobClick event:kPostEventMobClickKey];
    
    _VApiManager = [[VApiManager alloc]init];
    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
    UsersInvitationAddRequest *useradd = [[UsersInvitationAddRequest alloc]init:accessToken];
    WEAK_SELF
    useradd.api_circleId = @(self.circleId);
    useradd.api_context = str2;
    useradd.api_title = str1;
    useradd.api_images = [self checkReplyPost:self.uploadImageUrlPaths];
    JGLog(@"api_images:%@",useradd.api_images);

    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_VApiManager usersInvitationAdd:useradd success:^(AFHTTPRequestOperation *operation, UsersInvitationAddResponse *response) {
        
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        
        NSLog(@"dict%@",dict);
        NSString *strCode = [NSString stringWithFormat:@"%@",dict[@"code"]];
        //判断返回的code是否为空，空标示成功，有值返回证明发帖失败
        if ([strCode isEqualToString:@"(null)"]) {
            [weak_self dismissViewControllerAnimated:YES completion:nil];
        }else{
            KSensitiveWords
//            [weak_self showAlertViewWithStr:@"发布的帖子中包含敏感信息词，请核对修改后再发布"];
        }
        
        [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
    }];
    
}

-(void)showAlertViewWithStr:(NSString *)string
{
    UIAlertView * alertVc = [[UIAlertView alloc]initWithTitle:@"提示" message:string delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertVc show];
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

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.length > 0 && [text isEqualToString:@""]) {
        return YES;
    }
    
    if (range.location > 100 || textView.text.length > 100){
        //        [Util ShowAlertWithOutCancelWithTitle:@"提示!" message:@"你评论的字数超过最大限制"];
        return FALSE;
    }
    return TRUE;
}

- (IBAction)chenggg:(UITextField *)sender {
    str1 = [sender.text copy];
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    _text.hidden = YES;
}
-(void)textViewDidChange:(UITextView *)textView
{
    str2 = [textView.text copy];
}

/**
 *   -- 处理将要上传图片(将图片进行压缩) --
 */
- (void)handleUpdatingImage:(DeleteImageView *)updataImage {
    NSData * imageData = [[NSData alloc]init];
    imageData=UIImageJPEGRepresentation(updataImage.image,0.5);
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
//        NSData *dataImageSend = UIImageJPEGRepresentation(SmallImage, 1.0);
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
    // @"http://api.jgyes.com"
    
    
#warning -- 使用Base_URL 拿不到items图片路径，程序会崩溃  须要使用 http://api.jgyes.com这个路径才可以。。
    
    NSString *postImageUrl = [NSString stringWithFormat:@"%@/v1/image",@"http://api.jgyes.com"];
    [manager POST:postImageUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"filename" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        /**
         *  成功上传图片- 拿到上传图片的路径-》newCommentImgUrl
         */
        
        NSArray *items = responseObject[@"items"];
        
        if (items) {
            NSString *newCommentImgUrl =  [[responseObject[@"items"] objectAtIndex:0] objectForKey:@"fileUrl"];
            
            NSError *error = nil;
            //回调更新图片block
            if (!newCommentImgUrl || [newCommentImgUrl isEqualToString:@""]) {
                [SVProgressHUD dismissWithSuccess:@"图片上传失败"];
                
            }else {
                error = [NSError errorWithDomain:@"图片上传成功" code:0 userInfo:nil];
                
                //将成功上传图片的路径添加到uploadImageUrlPaths容器中去.
                [self.uploadImageUrlPaths addObject:newCommentImgUrl];
                [SVProgressHUD dismissWithSuccess:@"上传成功"];
            }
        }else {
            [SVProgressHUD dismissWithSuccess:@"图片上传失败"];
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

/**
 *   删完、或者没图,按钮往下移动,按钮下的线隐藏
 */
- (void)clearImageMoveDown:(BOOL)moveDown {
    if (moveDown) {
        self.caremaButton.frame = CGRectMake(10, self.TextView.origin.y+__MainScreen_Height-150, 32, 32);
    }else {
        self.caremaButton.frame = CGRectMake(10, self.TextView.origin.y+__MainScreen_Height-150-80, 32, 32);
        
    }
    self.photoButton.frame = CGRectMake(self.caremaButton.origin.x+self.caremaButton.width+9, self.caremaButton.origin.y, 32, 32);
    self.lineLab.frame = CGRectMake(0, self.caremaButton.origin.y+self.caremaButton.height+15, __MainScreen_Width, 0.5);
    self.lineLab.hidden = moveDown;
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





@end
