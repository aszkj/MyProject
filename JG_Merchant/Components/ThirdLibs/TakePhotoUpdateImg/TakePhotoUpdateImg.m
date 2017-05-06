//
//  TakePhotoUpdateImg.m
//  jingGang
//
//  Created by 张康健 on 15/9/14.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "TakePhotoUpdateImg.h"
#import "ALActionSheetView.h"
#import "AFNetworking.h"
#import "H5Base_url.h"
#import "MBProgressHUD.h"


@interface TakePhotoUpdateImg()<UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
    
    UIViewController *_takePhotoVC;
}

@property (nonatomic, copy)GetPhotoBlock getphotoBlock;
@property (nonatomic, copy)UpdateImgBlock updateImgBlock;


@end

@implementation TakePhotoUpdateImg

-(void)showInVC:(UIViewController *)takePhotoVC getPhoto:(GetPhotoBlock)getPhotoBlock upDateImg:(UpdateImgBlock)updateImgBlock
{
    _takePhotoVC = takePhotoVC;
    _getphotoBlock = getPhotoBlock;
    _updateImgBlock = updateImgBlock;
    
    //弹出选择sheet
    [self _showPhotoSheet];


}

-(void)updateImage:(UIImage *)image isNeedDisplayHub:(BOOL)isNeedDisplayHub getImgurl:(UpdateImgBlock)updateImgBlock  {
    
    _updateImgBlock = updateImgBlock;
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    [self _upLoadHeadImgWithImgData:imageData];

}

-(void)_showPhotoSheet{
    
    ALActionSheetView *actionSheetView = [ALActionSheetView showActionSheetWithTitle:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"拍照", @"从相册中选择"] handler:^(ALActionSheetView *actionSheetView, NSInteger buttonIndex) {
        
        if (buttonIndex == 0) {//拍照
            [self showPickerWithType:UIImagePickerControllerSourceTypeCamera];
        }else if (buttonIndex == 1){//从相册中选
            [self showPickerWithType:UIImagePickerControllerSourceTypePhotoLibrary];
        }else{//取消
            
        }
    }];
    
    [actionSheetView show];
}

- (void)showPickerWithType:(UIImagePickerControllerSourceType)photoType
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = photoType;
    picker.delegate = self;
    [_takePhotoVC presentViewController:picker animated:YES completion:nil];
}

#pragma mark - image piker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    //回调产生的photoblock
    if (self.getphotoBlock) {
        self.getphotoBlock(picker,image,editingInfo);
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    [self _upLoadHeadImgWithImgData:imageData];

}


#pragma mark - 上传图片 - 生成url
#pragma mark - 上传头像图片
-(void)_upLoadHeadImgWithImgData:(NSData *)imgData {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //图片 url + image
    //音频 url + audio
    //视频 url + video
    //@"http://api.jgyes.com/v1/image"
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hub.labelText = @"正在获取图片地址..";
    NSString *postImageUrl = [NSString stringWithFormat:@"%@/v1/image",BaseUrl];
    [manager POST:postImageUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imgData name:@"file" fileName:@"filename" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *newCommentImgUrl =  [[responseObject[@"items"] objectAtIndex:0] objectForKey:@"fileUrl"];
        NSError *error = nil;
        //回调更新图片block
        if (!newCommentImgUrl || [newCommentImgUrl isEqualToString:@""]) {
            error = [NSError errorWithDomain:@"图片上传失败" code:1 userInfo:nil];
        }else {
            error = [NSError errorWithDomain:@"图片上传成功" code:0 userInfo:nil];
        }
        if (self.updateImgBlock) {
            self.updateImgBlock(newCommentImgUrl,error);
        }
        [hub hide:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        NSError *error2 = [NSError errorWithDomain:error.localizedDescription code:1 userInfo:nil];
        [hub hide:YES];
        if (self.updateImgBlock) {
            self.updateImgBlock(nil,error2);
        }
    }];
}


@end
