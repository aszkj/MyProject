//
//  SaveReportDoneController.m
//  jingGang
//
//  Created by HanZhongchou on 15/10/23.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "SaveReportDoneController.h"

@interface SaveReportDoneController ()
/**
 *  处理结果
 */
@property (weak, nonatomic) IBOutlet UILabel *labelResult;

@end

@implementation SaveReportDoneController

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载设置UI
    [self loadUI];
}



#pragma mark - private
/**
 *  加载设置UI
 */
- (void)loadUI{
    
    self.labelResult.text = [NSString stringWithFormat:@"%@",self.strReportResult];
    self.labelResult.textAlignment = NSTextAlignmentCenter;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
