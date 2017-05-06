//
//  TouchTableView.h
//  BaiYing_Thinker
//
//  Created by 鹏 朱 on 15/11/9.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TouchTableViewDelegate <NSObject>

@optional
- (void)tableView:(UITableView *)tableView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)tableView:(UITableView *)tableView touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)tableView:(UITableView *)tableView touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)tableView:(UITableView *)tableView touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;

@end

@interface TouchTableView : UITableView

@property (nonatomic,assign) id<TouchTableViewDelegate> touchDelegate;

@end
