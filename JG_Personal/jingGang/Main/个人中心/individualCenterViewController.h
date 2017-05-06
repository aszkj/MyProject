//
//  individualCenterViewController.h
//  jingGang
//
//  Created by yi jiehuang on 15/5/8.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface individualCenterViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>


+ (individualCenterViewController *) instance;
@end
