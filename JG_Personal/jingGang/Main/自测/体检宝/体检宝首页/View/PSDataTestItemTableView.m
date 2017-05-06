//
//  PSDataTestItemTableView.m
//  jingGang
//
//  Created by 张康健 on 15/7/22.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "PSDataTestItemTableView.h"
#import "PSDataTestItemCell.h"
#import "CalenderHeaderCell.h"
#import "UIButton+Block.h"

@implementation PSDataTestItemTableView

static NSString *PSDataTestItemCellID = @"PSDataTestItemCellID";
static NSString *CalenderHeaderCellID = @"CalenderHeaderCellID";

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self _init];
        
    }
    
    return self;
}

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self _init];
    }
    return self;
}



-(void)_init{
    
    self.delegate = self;
    self.dataSource = self;
    [self registerNib:[UINib nibWithNibName:@"PSDataTestItemCell" bundle:nil]  forCellReuseIdentifier:PSDataTestItemCellID];
    [self registerNib:[UINib nibWithNibName:@"CalenderHeaderCell" bundle:nil]  forCellReuseIdentifier:CalenderHeaderCellID];

    self.rowHeight = 44;    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.testTypeArr.count + 1;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {//第0个cell
        
        CalenderHeaderCell *cell = [self dequeueReusableCellWithIdentifier:CalenderHeaderCellID];
        return cell;

    }else{
        
        PSDataTestItemCell *cell = [self dequeueReusableCellWithIdentifier:PSDataTestItemCellID forIndexPath:indexPath];
        
        //配置cell
        [self _configureCellWithCell:cell atIndexPath:indexPath];
        
        return cell;
    }
    
}

#pragma mark - 配置cell 入口
-(void)_configureCellWithCell:(PSDataTestItemCell *)cell atIndexPath:(NSIndexPath *)indexPath
{

    cell.testTypeLabel.text = self.testTypeArr[indexPath.row-1];
    if (indexPath.row == 1 || indexPath.row == 6) {//色盲和闪光才有正常和疑似
        cell.normalButton.hidden = NO;
        cell.doubtFulButton.hidden = NO;
        cell.typeValueLabel.hidden = YES;
        //没有编辑
        cell.editTestButton.hidden = YES;
        
    }else{
        cell.normalButton.hidden = YES;
        cell.doubtFulButton.hidden = YES;
        cell.editTestButton.hidden = NO;
        cell.typeValueLabel.hidden = NO;
        cell.editTestButton.tag = indexPath.row;
        [cell.editTestButton addActionHandler:^(NSInteger tag) {
            if (self.testTypeEditBlock) {
                //编辑回调
                self.testTypeEditBlock(tag);
            }
        }];
    }
    
    //配置网络中请求下来的数据，根据网络请求的数据 进行一些处理
    [self _configureNetworkDataWithCell:cell atIndexPath:indexPath];
    

    //色盲和散光按钮编辑
    [self _editBlindNessAndAtnisWithCell:cell atIndexPath:indexPath];
}


#pragma mark - mark - 根据网络请求的数据 进行一些处理
-(void)_configureNetworkDataWithCell:(PSDataTestItemCell *)cell atIndexPath:(NSIndexPath *)indexPath
{

    /**
     * 类型|1视力表2视力检测3色盲测试4散光测试5听力6血压7心率8肺活量9血氧
     */
    //cell测试类型num
    NSInteger testTypeNum = [self.typeNumArr[indexPath.row-1] integerValue];
    //从数据源中寻找改类型对应的dic
    NSDictionary *typeCellDic = [self _findtypeCellToDicWithTypeNum:testTypeNum];
    if (typeCellDic) {
        //说明返回了数据
        cell.doneTestButton.selected = YES;
        cell.doneTestSecondButton.hidden = YES;
        cell.typeValueLabel.hidden = NO;
        if (indexPath.row == 1 || indexPath.row == 6) {
            NSInteger value = [typeCellDic[@"maxValue"] integerValue];
            if (value == 1) {//正常
                cell.normalButton.selected = YES;
                cell.doubtFulButton.selected = NO;
            }else{
                cell.normalButton.selected = NO;
                cell.doubtFulButton.selected = YES;
            }
            
        }else{
            
            NSInteger index = indexPath.row;
            switch (index) {
                case 2:
                {
                    float sightValue = [typeCellDic[@"maxValue"] floatValue];
                    //                        NSLog(@"sightValue %.1f",sightValue);
                    cell.typeValueLabel.text = [NSString stringWithFormat:@"%.1f",sightValue];
                    break;
                }
                case 3:
                case 7:
                case 8:
                {
                    NSInteger value = [typeCellDic[@"maxValue"] integerValue];
                    //                        NSLog(@"Value %ld",value);
                    cell.typeValueLabel.text = [NSString stringWithFormat:@"%ld",value];
                    break;
                }
                case 4:
                case 5:
                {
                    NSInteger maxValue = [typeCellDic[@"maxValue"] integerValue];
                    NSInteger minValue = [typeCellDic[@"minValue"] integerValue];
                    cell.typeValueLabel.text = [NSString stringWithFormat:@"%ld/%ld",minValue,maxValue];
                    
                    break;
                }
                default:
                    
                    break;
            }
            
            
        }
        
        
        
        
    }else{
        
        //没数据
        cell.doneTestButton.selected = NO;
        cell.doneTestSecondButton.hidden = NO;
        cell.typeValueLabel.hidden = YES;
//        if (cell.typeValueLabel.text) {//没有数据源，但是有值，说明编辑过
//            cell.typeValueLabel.hidden = NO;
//            
//        }
        if (indexPath.row == 1 || indexPath.row == 6) {
            cell.normalButton.selected = NO;
            cell.doubtFulButton.selected = NO;
        }
        
        cell.doneTestSecondButton.tag = indexPath.row;
        //点击进入不同的测试页面
        [cell.doneTestSecondButton addActionHandler:^(NSInteger tag) {
            if (self.comIntoDiffentTestPageBlock) {
                self.comIntoDiffentTestPageBlock(tag);
            }
        }];
        
    }
}

//点击色盲和散光按钮
-(void)_editBlindNessAndAtnisWithCell:(PSDataTestItemCell *)cell atIndexPath:(NSIndexPath *)indexPath{

    //点击色盲，散光，按钮
    if (indexPath.row == 1 || indexPath.row == 6) {
        //点击正常按钮
        [cell.normalButton addActionHandler:^(NSInteger tag) {
            if (!cell.normalButton.isSelected) {//如果是没有选中的
                //选中
                cell.normalButton.selected = YES;
                if (cell.doubtFulButton.isSelected) {
                    //将疑似置为No
                    cell.doubtFulButton.selected = NO;
                }
                //因为cell里面的显示发生了变化，所以要刷新cell，
                [cell layoutSubviews];
                if (self.normalOrDoutfulTypeBlock) {
                    self.normalOrDoutfulTypeBlock(NormalType,indexPath.row);
                }
            }
        }];
        //点击疑似按钮
        [cell.doubtFulButton addActionHandler:^(NSInteger tag) {
            if (!cell.doubtFulButton.isSelected) {//如果是没有选中的
                cell.doubtFulButton.selected = YES;
                if (cell.normalButton.isSelected) {
                    cell.normalButton.selected = NO;
                }
                //因为cell里面的显示发生了变化，所以要刷新cell，
                [cell layoutSubviews];
                if (self.normalOrDoutfulTypeBlock) {
                    self.normalOrDoutfulTypeBlock(DoutfulType,indexPath.row);
                }
            }
        }];
        
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}


-(NSDictionary *)_findtypeCellToDicWithTypeNum:(NSInteger)typeNum{
    
    for (NSDictionary *dic in self.dataArr) {
        NSInteger typenum = [dic[@"itemCode"] integerValue];
        if (typeNum == typenum) {
            return dic;
            break;
        }
    }
    
    return nil;
}

@end
