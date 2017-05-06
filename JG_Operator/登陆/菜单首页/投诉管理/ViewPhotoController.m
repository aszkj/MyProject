//
//  ViewPhotoController.m
//  Operator_JingGang
//
//  Created by dengxf on 15/10/28.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "ViewPhotoController.h"
#import "ComplainViewPhotoCell.h"
@interface ViewPhotoController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation ViewPhotoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查看图片";
    
    
    [self.view addSubview:self.tableView];
    
    
}

#pragma mark - TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayImageUrl.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *imageCell = @"imageCell";
    ComplainViewPhotoCell *cell = (ComplainViewPhotoCell *)[tableView dequeueReusableCellWithIdentifier:imageCell];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ComplainViewPhotoCell" owner:self options:nil];
        cell = [nib lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.strPhotoUrl = self.arrayImageUrl[indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //图片比例16:9
    CGFloat rowHeight = kScreenWidth / 16 * 9;
    return rowHeight;
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}


#pragma mark -getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


@end
