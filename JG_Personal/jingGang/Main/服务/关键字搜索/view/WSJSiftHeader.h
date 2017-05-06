//
//  WSJSiftHeader.h
//  jingGang
//
//  Created by thinker on 15/8/6.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSJSiftHeader : UIView


@property (nonatomic, assign) NSInteger section;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//选中某一段，回调该方法
@property (nonatomic, copy) void(^selectSection)(NSInteger section);

- (void) setStatusSelect:(BOOL)b;

@end
