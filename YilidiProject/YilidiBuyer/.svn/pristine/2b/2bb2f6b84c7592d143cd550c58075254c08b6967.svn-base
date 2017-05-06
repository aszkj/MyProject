//
//  DLEvaluationDetailsCell.h
//  YilidiBuyer
//
//  Created by 曾勇兵 on 17/2/8.
//  Copyright © 2017年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYPhotoBrowseView.h"
#import "PYPhotosView.h"
#import "CWStarRateView.h"
@class DLEvaluationModel;

@interface DLEvaluationDetailsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *evaluationContentLabel;
@property (strong, nonatomic) IBOutlet UIView *evaluationContentView;
@property (nonatomic,strong)DLEvaluationModel *model;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *contentImagesHeight;
@property (strong, nonatomic) IBOutlet CWStarRateView *starView;
@property (nonatomic,assign)CGFloat score;
@property (strong, nonatomic) IBOutlet UIImageView *userImage;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *contentTop;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *starX;

@property (nonatomic,assign)CGFloat imageHeight;
@property (nonatomic,strong)PYPhotosView *flowPhotosView;
@end
