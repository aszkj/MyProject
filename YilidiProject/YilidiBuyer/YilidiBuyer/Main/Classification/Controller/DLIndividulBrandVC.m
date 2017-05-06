//
//  DLIndividulBrandVC.m
//  YilidiBuyer
//
//  Created by mm on 17/3/29.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLIndividulBrandVC.h"
#import "DLBrandView.h"
#import <Masonry.h>

@interface DLIndividulBrandVC ()

@property (nonatomic,strong) DLBrandView *brandView;

@end

@implementation DLIndividulBrandVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.brandView requestHotBrandDataConfigure];
}

-(DLBrandView *)brandView {
    
    if (!_brandView) {
        _brandView = BoundNibView(@"DLBrandView", DLBrandView);
        [_brandView setShowType:@"hotBrand"];
        
        [self.view addSubview:_brandView];
        [_brandView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
    }
    return _brandView;
    
}

@end
