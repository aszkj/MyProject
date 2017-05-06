////
////  DLBrandClassificationVC.m
////  YilidiBuyer
////
////  Created by 曾勇兵 on 16/12/12.
////  Copyright © 2016年 yld. All rights reserved.
////
//
#import "DLBrandClassificationVC.h"
#import "MycommonTableView.h"
#import "LGUIView.h"
#import "DLBrandClassificationCell.h"
#import "DLBrandGoodsVC.h"
#import "DLBrandClassificationHeader.h"
#import "DLBrandModel.h"
#import "ChineseString.h"
#import "UIImageView+sd_SetImg.h"
#import "BrandDataManager.h"
#import "UIBarButtonItem+WNXBarButtonItem2.h"
#import "ProjectStandardUIDefineConst.h"
#import "DLBrandGoodsManageVC.h"
#define TICK   NSDate *startTime = [NSDate date]
#define TOCK   DDLogVerbose(@"Time: %f", -[startTime timeIntervalSinceNow])
@interface DLBrandClassificationVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *dataModelArray;
    NSMutableArray *sortingModelArr;
    NSMutableArray *sortArr;
    NSArray *resultArr;
}
@property (strong, nonatomic) IBOutlet UITableView *brandTableView;
@property (nonatomic,strong)LGUIView *rightView;
@property(nonatomic,strong)NSMutableArray *indexArray;
@property(nonatomic,strong)NSMutableArray *letterResultArr;


@end

@implementation DLBrandClassificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self _init];
    [self _initLeftItemButton];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
   
    self.navBarColor = KSelectedBgColor;
    self.backIconName = @"返回箭头白色";
    self.titleColor = [UIColor whiteColor];
    
}

#pragma mark ------------------------Init---------------------------------
- (void)_init {

    self.pageTitle = @"品牌分类";
//    [self _requestAllBrand];
    
    self.brandTableView.rowHeight = 40.0f;
    [self.brandTableView registerNib:[UINib nibWithNibName:@"DLBrandClassificationCell" bundle:nil] forCellReuseIdentifier:@"brandTableViewID"];
    [self showLoadingHub];
    [[BrandDataManager sharedManager] fetchBrandData:^(NSMutableArray *brandDatas, NSArray *brandIndexs) {
        [self hideLoadingHub];
        sortingModelArr = brandDatas;
        self.indexArray = [brandIndexs mutableCopy];
        [self _createRightIndexView];
        [self.brandTableView reloadData];
        
    }];
    
}

- (void)_initLeftItemButton{

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithNormalImage:@"brandBack" target:self action:@selector(_leftItemClick) width:18 height:18];

}

- (void)_leftItemClick{

     [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ------------------------Private-------------------------

-(void)_createRightIndexView
{
    
    _rightView = [[LGUIView alloc]initWithFrame:CGRectMake(kScreenWidth - 28, 20, 28, kScreenHeight - 120) indexArray:self.indexArray];
    [self.view addSubview:_rightView];
    WEAK_SELF
    [_rightView selectIndexBlock:^(NSInteger section)
     {
         [weak_self.brandTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]
                                               animated:NO
                                         scrollPosition:UITableViewScrollPositionTop];
     }];
    
     [_rightView setCurrentSelectedIndex:0];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    
    NSIndexPath *path =  [_brandTableView indexPathForRowAtPoint:CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y)];
    
//    NSLog(@"这是第%i组",path.section);
    [_rightView setCurrentSelectedIndex:path.section];
    
}

#pragma mark ------------------------Page Navigate---------------------------

#pragma mark ------------------------View Event---------------------------

#pragma mark ------------------------Delegate-----------------------------


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.indexArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[sortingModelArr  objectAtIndex:section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"brandTableViewID";
   
    DLBrandClassificationCell *cell = [self.brandTableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (!cell) {
        cell  = [[DLBrandClassificationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    DLBrandModel *model = (DLBrandModel*)[[sortingModelArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    [cell setModel:model];
    
  
    
    
    //去掉每组最后cell的线
    if (indexPath.row ==[sortingModelArr [indexPath.section]count]-1) {
        cell.lineView.hidden = YES;
    }else{
        cell.lineView.hidden = NO;
        
    }
    

    
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    DLBrandClassificationHeader* header = BoundNibView(@"DLBrandClassificationHeader", DLBrandClassificationHeader);
    header.indexLabel.text = self.indexArray[section];
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 27.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.000001f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

//    NSLog(@"%@",[NSString stringWithFormat:@"%ld",indexPath.row]);
    [self.brandTableView deselectRowAtIndexPath:indexPath animated:NO];
    
    DLBrandModel *model = (DLBrandModel*)[[sortingModelArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    
   
    
    DLBrandGoodsManageVC *brandGoodsVC = [[DLBrandGoodsManageVC alloc]init];
    brandGoodsVC.brandCode = model.brandCode;
    brandGoodsVC.brandName = model.brandName;
    [self navigatePushViewController:brandGoodsVC animate:YES];
    
}


#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------


@end
