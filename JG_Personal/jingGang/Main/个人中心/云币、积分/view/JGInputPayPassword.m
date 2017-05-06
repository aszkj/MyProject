//
//  JGInputPayPassword.m
//  jingGang
//
//  Created by dengxf on 16/1/11.
//  Copyright © 2016年 yi jiehuang. All rights reserved.
//

#import "JGInputPayPassword.h"
#import "CorePasswordView.h"

typedef void(^InputPasswordCompleted)(NSString *passwordKey);

typedef void(^CancelInputBlock)(void);

@interface JGInputPayPassword ()

@property (weak, nonatomic) IBOutlet CorePasswordView *passwordView;

@property (copy , nonatomic) InputPasswordCompleted passwordBlock;

@property (copy , nonatomic) CancelInputBlock cancelBlock;

@end

@implementation JGInputPayPassword

- (instancetype)initWithInputPasswordCompleted:(void (^)(NSString *))complete cancel:(void (^)())cancel{
    if (self = [super init]) {
        self.passwordBlock = complete;
        self.cancelBlock = cancel;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.passwordView beginInput];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    WeakSelf;
    self.passwordView.PasswordCompeleteBlock = ^(NSString *password){
        StrongSelf;
        BLOCK_EXEC(strongSelf.passwordBlock,password);
        [strongSelf.view endEditing:YES];
    };
}


- (IBAction)cancelInputPasswordAction:(id)sender {
    [self.passwordView endInput];
    BLOCK_EXEC(self.cancelBlock);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
