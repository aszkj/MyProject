//
//  IntegralResultViewController.m
//  jingGang
//
//  Created by ray on 15/10/29.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "IntegralResultViewController.h"
#import "UIImage+SizeAndTintColor.h"

@interface IntegralResultViewController ()
@property (nonatomic) IntegralResultViewModel *viewModel;


@property (weak, nonatomic) IBOutlet UIImageView *presentImageView;
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;

@end

@implementation IntegralResultViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)setUIAppearance {
    [super setUIAppearance];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(backClick) target:self];
}

- (void)backClick {
//    NSArray *controllers = self.navigationController.viewControllers;
//    if (controllers.count >= 2 && [controllers[controllers.count-2] isKindOfClass:NSClassFromString(@"PayOrderViewController")]) {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    } else {
//        [self btnClick];
//    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)bindViewModel {
    [super bindViewModel];
    RAC(self.orderNumberLabel,text) = RACObserve(self.viewModel, orderNumberString);
}

- (void)setOrderNumber:(NSString *)orderNumber {
    _orderNumber = orderNumber;
    self.viewModel.orderNumber = orderNumber;
}

- (IntegralResultViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[IntegralResultViewModel alloc] init];
    }
    return _viewModel;
}

#pragma mark - dyci debug operation
- (void)updateOnClassInjection {
    UIImage *imageCache = [self.presentImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    if (imageCache) {
//        self.presentImageView.image = imageCache;
//        self.presentImageView.tintColor = [UIColor greenColor];
//    }
    imageCache = [self.presentImageView.image imageWithGradientTintColor:[UIColor redColor]];
    self.presentImageView.image = imageCache;
}

@end
