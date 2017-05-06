//
//  DLEvaluationDetailsCell.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 17/2/8.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLEvaluationDetailsCell.h"
#import "DLEvaluationModel.h"
#import "UIView+Frame.h"
#import "UIImageView+sd_SetImg.h"


//每列间隔
#define ImageMargin 10
//每行列数高
#define CellMargin  10

@implementation DLEvaluationDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    if (iPhone5_width==kScreenWidth) {
    
        self.starX.constant = 85;
    }
    self.starView.frame = CGRectMake(129, 19, 85, 12);
    self.starView.originalImgName = @"grayStar";
    self.starView.hilightedImgName = @"yellowStar";
    self.starView.scorePercent =self.score;
}




- (void)setModel:(DLEvaluationModel *)model{
    
   
    int maxCols = 5;
    //宽度、高度
    CGFloat TotalWidth = kScreenWidth - 2*CellMargin - (maxCols-1)*ImageMargin;
    CGFloat imageheight = TotalWidth / maxCols;

    NSString *timeStr = model.createTime;
//    self.evaluationContentLabel.text = model.evaluateContent;
    self.evaluationContentLabel.attributedText = model.attributeEvaluateContent;
    self.score = [model.saleProductScore floatValue];
    [self.userImage sd_SetImgWithUrlStr:model.userImageUrl placeHolderImgName:nil];
    self.userNameLabel.text = model.userName;
    self.timeLabel.text = [timeStr substringToIndex:16];
       if (model.originalImages.count>=1) {
        _flowPhotosView.hidden = NO;
            // 2.1 创建一个流水布局photosView(默认为流水布局)
           if (_flowPhotosView==nil) {
            
            _flowPhotosView = [PYPhotosView photosView];
            // 设置分页指示类型
            _flowPhotosView.photosMaxCol = 5;
            _flowPhotosView.photoMargin = ImageMargin;
            
            _flowPhotosView.pageType = PYPhotosViewPageTypeLabel;
            
            _flowPhotosView.py_y = 0;
            _flowPhotosView.py_x = 10;
            [self.evaluationContentView addSubview:_flowPhotosView];
              
           }
        
           
           
           
           // 设置缩略图数组
           _flowPhotosView.thumbnailUrls = model.thumbnailImages;
           // 设置原图地址
           _flowPhotosView.originalUrls = model.originalImages;
           
           
           NSMutableArray *desArray = [NSMutableArray arrayWithCapacity:model.thumbnailImages.count];
           
           for (int i = 0 ; i < model.thumbnailImages.count; i++) {
               [desArray addObject:model.evaluateContent];
           }
           
           _flowPhotosView.detailDesArray = desArray;

           
           _flowPhotosView.photoWidth = imageheight;
           _flowPhotosView.photoHeight = imageheight;
           
       }else{
       
           if (_flowPhotosView!=nil) {
               _flowPhotosView.hidden=YES;
           }
       }
    
    
    
        
       self.contentImagesHeight.constant = model.evaluteImgPartHeight;
        

    
     

}



@end
