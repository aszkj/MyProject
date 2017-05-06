//
//  DLImagePicker.m
//  YilidiSeller
//
//  Created by yld on 16/6/6.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLImagePicker.h"

@interface DLImagePicker ()

@end

@implementation DLImagePicker

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
}

- (id)init
{
    
    if (![super init]){
        
    }
    return self;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        CGSize imageSize = image.size;
        imageSize.height = 650;
        imageSize.width = 413;
        
        image = [self imageWithImage:image scaledToSize:imageSize];
        
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil) {
            data = UIImageJPEGRepresentation(image, 0.00001);
            
        }
        else {
            data = UIImagePNGRepresentation(image);
            
        }
        
        //        NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        
        NSString *DocumentsPath = NSTemporaryDirectory();
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        
        
        NSString * str = [NSString stringWithFormat:@"/%@image.jpeg",[self getCurrenTime]];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:str] contents:data attributes:nil];
        
        filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,str];
        
        //        NSLog(@"图片的路径是：%@", filePath);
        
        [picker dismissViewControllerAnimated:YES completion:^{
            
        }];
        
        
        
        
        if (self.getImage != nil) {
            self.getImage(filePath);
        }
        
        
    }
}

- (NSString *)getCurrenTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *date = [formatter stringFromDate:[NSDate date]];
    
    return date;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}


//对图片尺寸进行压缩--
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
