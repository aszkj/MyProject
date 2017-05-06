//
//  DLImagePicker.h
//  YilidiSeller
//
//  Created by yld on 16/6/6.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GetImage)(NSString *str);

@interface DLImagePicker : UIImagePickerController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

{
    NSString *filePath;
}

@property (nonatomic,strong)GetImage getImage;


@end
