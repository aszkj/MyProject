//
//  ComplainProgressCell.m
//  Operator_JingGang
//
//  Created by dengxf on 15/10/28.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "ComplainProgressCell.h"
#import "MDRadialProgressView.h"
#import "MDRadialProgressTheme.h"
#import "MDRadialProgressLabel.h"
@interface ComplainProgressCell()
@property (weak, nonatomic) IBOutlet UILabel *labelDisposeStatus;




@end

@implementation ComplainProgressCell



- (void)setModel:(ComplainDetailModel *)model
{
    _model = model;
    
    
    NSString *strDisposeStatus = [NSString stringWithFormat:@"%@",_model.status];
    
    
    CGRect frame = CGRectMake(self.center.x - 65, 42, 35, 35);
    MDRadialProgressView *radialView2 = [[MDRadialProgressView alloc]initWithFrame:frame];
    if (![strDisposeStatus isEqualToString:@"(null)"]) {
        [self addSubview:radialView2];
        radialView2.centerY = self.labelDisposeStatus.centerY;
        radialView2.theme.thickness = 13;
        radialView2.theme.incompletedColor = rgb(234, 236, 237, 1);
        radialView2.theme.completedColor = rgb(79, 189, 241, 1);
        radialView2.theme.sliceDividerHidden = YES;
        radialView2.label.hidden = YES;
        radialView2.progressTotal = 100;
        if ([strDisposeStatus isEqualToString:@"1"]) {
            self.labelDisposeStatus.text = @"处理中";
            radialView2.progressCounter = 50;
        }else{
            self.labelDisposeStatus.text = @"已完成";
            self.labelDisposeStatus.textColor = [UIColor blackColor];
            radialView2.progressCounter = 100;
        }
        
    }else{
        
        self.labelDisposeStatus.text = @"";
        
    }

    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return self;
}

- (void)awakeFromNib {
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
