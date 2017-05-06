//
//  ImageCropperPicker.h
//  imageCropper
//
//  Created by thinker on 16/1/26.
//  Copyright © 2016年 thinker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VPImageCropperViewController.h"

@interface ImageCropperPicker : UIImagePickerController

@property (nonatomic, assign) id<VPImageCropperDelegate> dataSource;

@end
