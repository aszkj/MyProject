//
//  XKJHServiceDetailController.m
//  Merchants_JingGang
//
//  Created by 鹏 朱 on 15/9/2.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHServiceDetailController.h"
#import "XKJHServicePriceCell.h"
#import "XKJHServiceNoticeCell.h"
#import "XKJHServiceDetailsCell.h"

@interface XKJHServiceDetailController ()
{
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *dataSource;
@property (nonatomic, strong) UIImage *topImage;
@property (nonatomic, assign) CGFloat cellHeight1;
@property (nonatomic, assign) CGFloat cellHeight2;

@end

@implementation XKJHServiceDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, kScreenHeight-kTopBarHeight);
    
    _cellHeight1 = 0;
    _cellHeight2 = 0;
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.delaysContentTouches = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.contentOffset = CGPointMake(0, 0);
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.backgroundColor = background_Color;
    [self.view addSubview:_tableView];
    
    self.title = @"服务详情";
    self.vapManager = [[VApiManager alloc] init];

    [self _requestServiceDetailData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - private Method
-(void)_init{

}

- (void)resetFrame {
    
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if (self.topImage) {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        XKJHServicePriceCell *cell = [[XKJHServicePriceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (self.topImage) {
            [cell.upImageView setImage:self.topImage];
            
            CGRect imgRect = cell.upImageView.frame;
            imgRect.size.height = kScreenWidth * self.topImage.size.height / self.topImage.size.width;
            [cell.upImageView setFrame:imgRect];
            
        } else {
            [cell.upImageView sd_setImageWithURL:[NSURL URLWithString:self.dataSource[@"groupAccPath"]] placeholderImage:IMAGE(@"Background") completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
            }];
        }
        cell.middleName.text = [NSString stringWithFormat:@"%@",self.dataSource[@"ggName"]];
        cell.saleNum.text = [NSString stringWithFormat:@"已售 %@",self.dataSource[@"selledCount"]];
        
        // 属性字符串
        NSString *content = [NSString stringWithFormat:@"%.2f %.2f",[self.dataSource[@"groupPrice"] doubleValue] ,[self.dataSource[@"costPrice"] doubleValue]];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:content];
        [str addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, content.length)];

        NSRange range = [content rangeOfString:[NSString stringWithFormat:@"%.2f",[self.dataSource[@"groupPrice"] doubleValue]]];
        [str addAttribute:NSForegroundColorAttributeName value:KColorText59C4F0 range:range];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:36] range:range];
        [str addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleNone] range:range];
        cell.nowMoney.attributedText = str;
        
        if (self.topImage) {
            [cell resetCellFrame];
        }
        return cell;

    } else if (indexPath.row == 1) {

        XKJHServiceNoticeCell *cell = [[XKJHServiceNoticeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        WEAK_SELF
        cell.webViewCallBackBlk = ^(CGFloat height) {
            weak_self.cellHeight1 = height;
            [weak_self.tableView reloadData];
            return;
        };
//        NSString *startTime = [NSString stringWithFormat:@"%@",self.dataSource[@"beginTime"]];
//        NSString *endTime  =[NSString stringWithFormat:@"%@",self.dataSource[@"endTime"]];
//        if (startTime.length >= 11) {
//            startTime = [startTime substringToIndex:10];
//        }
//        if (endTime.length >= 11) {
//            endTime = [endTime substringToIndex:10];
//        }
//        cell.validTimer.text = [NSString stringWithFormat:@"有效时间:%@ 至 %@",startTime ,endTime];
//        cell.restriction.text = self.dataSource[@"groupNotice"];
        [cell resetFrame:self.dataSource[@"groupNotice"]];
        
        return cell;
        
    } else if (indexPath.row == 2) {
        
        XKJHServiceDetailsCell *cell = [[XKJHServiceDetailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        WEAK_SELF
        cell.webViewCallBackBlk = ^(CGFloat height) {
            weak_self.cellHeight2 = height;
            [weak_self.tableView reloadData];
            return;
        };

//        cell.detailText.text = self.dataSource[@"groupDesc"];
//        [cell.detailText sizeToFit];
        
//        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:12]};
//        CGRect rect = [self.dataSource[@"groupDesc"] boundingRectWithSize:CGSizeMake(kScreenWidth - 40, MAXFLOAT)
//                                       options:NSStringDrawingUsesLineFragmentOrigin
//                                    attributes:attributes
//                                       context:nil];
//        CGRect frame = cell.detailView.frame;
//        frame.size.height = rect.size.height + 34;
//        cell.detailView.frame = frame;
        
        [cell resetFrame:self.dataSource[@"groupDesc"]];

        return cell;
    }
    
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        if (self.topImage) {
            return (kScreenWidth * self.topImage.size.height / self.topImage.size.width) + 67;
        }
        return 227;
    } else if (indexPath.row == 1) {
        
//        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:12]};
//        CGRect rect = [self.dataSource[@"groupNotice"] boundingRectWithSize:CGSizeMake(kScreenWidth - 40, MAXFLOAT)
//                                                                  options:NSStringDrawingUsesLineFragmentOrigin
//                                                               attributes:attributes
//                                                                  context:nil];
//        return rect.size.height + 150;
        return 55 + _cellHeight1;
        
    } else if (indexPath.row == 2) {

//        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:12]};
//        CGRect rect = [self.dataSource[@"groupDesc"] boundingRectWithSize:CGSizeMake(kScreenWidth - 40, MAXFLOAT)
//                                                  options:NSStringDrawingUsesLineFragmentOrigin
//                                               attributes:attributes
//                                                  context:nil];
//        return 150 + rect.size.height;
        return 55 + _cellHeight2;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - 接口请求

-(void)_requestServiceDetailData{
    
    GroupQueryGoodsDetailsRequest *request = [[GroupQueryGoodsDetailsRequest alloc] init:GetToken];

    request.api_goodsId = self.goodsId;
    NSLog(@"%@",request.api_goodsId);

    WEAK_SELF
    [self.vapManager groupQueryGoodsDetails:request success:^(AFHTTPRequestOperation *operation, GroupQueryGoodsDetailsResponse *response) {
        self.dataSource = (NSDictionary *)response.groupGoodsDetails;
        
        UIImageView *img = [[UIImageView alloc] init];
        [img sd_setImageWithURL:[NSURL URLWithString:self.dataSource[@"groupAccPath"]] placeholderImage:IMAGE(@"Background") completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            weak_self.topImage = image;
            //刷新表
            [weak_self.tableView reloadData];
        }];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        DDLogWarn(@"%@",error);

    }];
}

@end
