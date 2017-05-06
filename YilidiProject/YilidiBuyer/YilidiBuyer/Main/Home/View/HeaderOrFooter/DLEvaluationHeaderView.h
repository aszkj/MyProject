//
//  DLEvaluationHeaderView.h
//  YilidiBuyer
//
//  Created by 曾勇兵 on 17/2/9.
//  Copyright © 2017年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLEvaluationHeaderView : UIView

@property (nonatomic,strong)void (^EvaluationBtnBlock) (void);
@property (strong, nonatomic) IBOutlet UILabel *totalRecordsLabel;
@property (weak, nonatomic) IBOutlet UIButton *lookAllCommentButton;
@property (weak, nonatomic) IBOutlet UILabel *lookAllCommentLabel;

@end
