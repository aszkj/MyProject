//
//  DLClassificationHeaderView.h
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/12/12.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectRelativeConst.h"

#define kClassificationHeaderViewHeight 32
@interface DLClassificationHeaderView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIButton *secondLevelClassTitleButton;

@property (nonatomic,copy)NoneArgumentBlock clickSecondLevelClassBlock;

@end
