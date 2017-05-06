//
// Created by Joon on 16/8/11.
// Copyright (c) 2016 ___Joon___. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController()



@end


@implementation TestViewController


- (void)viewDidLoad {
    NSLog(@"=============%@", self.title);
}


- (void)setTitle:(NSString *)title {
    [super setTitle:title];

    if ([title isEqualToString:@"头条"]) {
        self.view.backgroundColor = [UIColor redColor];
    }
}


@end
