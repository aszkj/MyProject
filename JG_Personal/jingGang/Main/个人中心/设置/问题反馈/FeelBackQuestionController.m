//
//  FeelBackQuestionController.m
//  Operator_JingGang
//
//  Created by HanZhongchou on 15/11/2.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "FeelBackQuestionController.h"
#import "FeelBackViewModel.h"
#import "UITextView+Placeholder.h"

@interface FeelBackQuestionController ()
@property (weak, nonatomic) IBOutlet UIButton *buttonCommit;//提交按钮
@property (weak, nonatomic) IBOutlet UITextView *feedText;
@property (nonatomic) FeelBackViewModel *viewModel;
@end

@implementation FeelBackQuestionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.buttonCommit.layer.cornerRadius = 4;
    self.navigationItem.title = @"问题反馈";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bindViewModel {
    [super bindViewModel];
    @weakify(self)
    RAC(self.viewModel,content) = self.feedText.rac_textSignal;
    [RACObserve(self.viewModel, content) subscribeNext:^(NSString *x) {
        @strongify(self)
        if (x.length > 0) {
            self.buttonCommit.alpha = 1.0;
            self.buttonCommit.enabled = YES;
        } else {
            self.buttonCommit.alpha = 0.5;
            self.buttonCommit.enabled = NO;
        }
    }];
    //提交反馈
    [[self.buttonCommit rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.viewModel.commitCommand execute:nil];
    }];
    [[[self.viewModel.commitCommand executionSignals] switchToLatest] subscribeNext:^(id x) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"提交成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [[alertView rac_buttonClickedSignal] subscribeNext:^(NSNumber *indexNumber) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertView show];
    }];
}

- (FeelBackViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[FeelBackViewModel alloc] init];
    }
    return _viewModel;
}

- (void)setUIAppearance {
    [super setUIAppearance];
    self.feedText.placeholder = @"请输入您的问题";
}

#pragma mark - dyci debug operation
- (void)updateOnClassInjection {
    [self setUIAppearance];
}

@end
