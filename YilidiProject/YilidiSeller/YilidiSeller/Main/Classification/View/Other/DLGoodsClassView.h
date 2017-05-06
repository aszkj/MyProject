//
//  DLGoodsClassView.h
//  YilidiBuyer
//
//  Created by mm on 16/12/12.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DLClassificationVC;
@interface DLGoodsClassView : UIView

@property (nonatomic,weak)DLClassificationVC *ownVC;

- (void)requestClassDataConfigure;

@end
