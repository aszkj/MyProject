//
//  PluginComponentController.h
//  BaiYing_Thinker
//
//  Created by 鹏 朱 on 15/11/4.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^FinishLoadBlock)(CGSize);
typedef void (^ComponentDescDidChangedBlock)(NSString *);

@interface PluginComponentController : UIViewController<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic,copy) FinishLoadBlock finishLoadBlock;
@property (nonatomic,copy) ComponentDescDidChangedBlock componentDescDidChangedBlock;
@property (nonatomic,copy) ComponentDescDidChangedBlock componentStateDidChangedBlock;

- (void)reinitWithFrame:(CGRect)frame path:(NSString *)path rule:(NSString *)rule finishLoadBlock:(FinishLoadBlock)finishLoadBlock componentDescDidChangedBlock:(ComponentDescDidChangedBlock)componentDescDidChangedBlock componentStateDidChangedBlock:(ComponentDescDidChangedBlock)componentStateDidChangedBlock;

- (void)initWebViewDataWithPath:(NSString *)path;

@end
