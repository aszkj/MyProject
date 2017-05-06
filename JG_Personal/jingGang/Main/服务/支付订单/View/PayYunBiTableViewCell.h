//
//  PayYunBiTableViewCell.h
//  jingGang
//
//  Created by thinker on 15/8/20.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShowPassword)(BOOL isSelected,UIButton *button);

@interface PayYunBiTableViewCell : UITableViewCell

@property (copy) ShowPassword showPasswordBlock;

@property (nonatomic, assign)BOOL whetherSetYunbiPasswd;

- (void)setYunbi:(float)yunbi totalPrice:(float)price;
- (NSString *)password;
- (void)needShowPassword:(BOOL)needed;

-(void)_alowInputPasswdConfigure;
-(void)_forbiddenInputPasswdConfigure;


@end
