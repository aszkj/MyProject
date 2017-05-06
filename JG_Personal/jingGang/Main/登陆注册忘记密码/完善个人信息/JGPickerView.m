//
//  JGPickerView.m
//  jingGang
//
//  Created by Ai song on 16/1/28.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import "JGPickerView.h"

@interface JGPickerView()<UIPickerViewDataSource,UIPickerViewDelegate>
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHegithCons;
@property (strong, nonatomic)  UIPickerView *pickView;
@property (strong, nonatomic) AreaObject *locate;
//保存选中省
@property (assign,nonatomic)NSInteger tagF;

@end
@implementation JGPickerView


- (instancetype)init{
    
    if (self = [super init]) {
//        self = [[[NSBundle mainBundle]loadNibNamed:@"AddressChoicePickerView" owner:nil options:nil]firstObject];
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor clearColor];
        self.pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,self.frame.size.height-216, self.frame.size.width,216)];
        self.pickView.delegate = self;
        self.pickView.dataSource = self;
        self.pickView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.pickView];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(0, self.frame.size.height-246, 80, 30);
//        button.backgroundColor = [UIColor grayColor];
        [button setTitle:@"取消" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(dissmissBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(self.frame.size.width-80, self.frame.size.height-246, 80, 30);
        [btn setTitle:@"完成" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

//        btn.backgroundColor = [UIColor grayColor];
        [btn addTarget:self action:@selector(finishBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        self.provinceArr = [NSMutableArray array];
        self.cityArr = [NSMutableArray array];
        self.areaArr = [NSMutableArray array];
        
        //        [self.pickView selectedRowInComponent:2];
        //        NSString *path = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"city2" ofType:@"json"];
        NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];
        NSError *error ;
        self.pickerArr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        if(error||!self.pickerArr){
            NSLog(@"json解析失败");
        }
        for(int i=0;i<self.pickerArr.count;i++){
            NSDictionary *dic = [self.pickerArr objectAtIndex:i];
            NSString *str = [dic objectForKey:@"areaName"];
            [self.provinceArr addObject:str];
            
        }
        NSArray *cityArray = [[self.pickerArr objectAtIndex:0] objectForKey:@"cities"];
        for(int j=0;j<cityArray.count;j++){
            NSString *str = cityArray[j][@"areaName"];
            [self.cityArr addObject:str];
        }
        NSArray *areaArray = cityArray[0][@"counties"];
        for(int flag=0;flag<areaArray.count;flag++){
            NSString *str = areaArray[flag][@"areaName"];
            [self.areaArr addObject:str];
        }
        self.tagF = 0;
        //        self.pickerDic = [[NSDictionary alloc] initWithContentsOfFile:path];
        //        self.provinceArr = [self.pickerDic allKeys];
        //        self.regionArr = [self.pickerDic objectForKey:[[self.pickerDic allKeys] objectAtIndex:0]];
        
        //        if (self.regionArr.count > 0) {
        //            self.cityArr = [[self.regionArr objectAtIndex:0] allKeys];
        //        }
        //
        //        if (self.cityArr.count > 0) {
        //            self.areaArr = [[self.regionArr objectAtIndex:0] objectForKey:[self.cityArr objectAtIndex:0]];
        //        }
        //        self.regionArr = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AreaPlist.plist" ofType:nil]];
        //        self.provinceArr = self.regionArr[0][@"provinces"];
        //        self.cityArr = self.provinceArr[0][@"cities"];
        //        self.areaArr = self.cityArr[0][@"areas"];
        //        self.locate.region = self.regionArr[0][@"region"];
        //        self.locate.province = self.provinceArr[0][@"province"];
        //        self.locate.city = self.cityArr[0][@"city"];
        //        if (self.areaArr.count) {
        //            self.locate.area = self.areaArr[0];
        //        }else{
        //            self.locate.area = @"";
        //        }
        //    设置样式
        //        [self.pickView selectRow:3 inComponent:2 animated:YES];
        //        [self.pickView selectRow:3 inComponent:1 animated:YES];
        //        [self.pickView selectRow:3 inComponent:0 animated:YES];
        
//        [self customView];
    }
    return self;
}

//- (void)customView{
//    self.contentViewHegithCons.constant = 0;
//    [self layoutIfNeeded];
//}

#pragma mark - setter && getter

- (AreaObject *)locate{
    if (!_locate) {
        _locate = [[AreaObject alloc]init];
    }
    return _locate;
}

#pragma mark - action

//选择完成
- (void)finishBtnPress:(UIButton *)sender {
    self.locate.province = [self.provinceArr objectAtIndex:[self.pickView selectedRowInComponent:0]];
    self.locate.city = [self.cityArr objectAtIndex:[self.pickView selectedRowInComponent:1]];
    self.locate.area = [self.areaArr objectAtIndex:[self.pickView selectedRowInComponent:2]];
    if (self.block) {
        self.block(self,sender,self.locate);
    }
    [self hide];
}

//隐藏
- (void)dissmissBtnPress:(UIButton *)sender {
    
    [self hide];
}

#pragma  mark - function

- (void)show{
    UIWindow *win = [[UIApplication sharedApplication] keyWindow];
    //    UIView *topView = [win.subviews firstObject];
    [win addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
//        self.contentViewHegithCons.constant = 250;
//        [self layoutIfNeeded];
    }];
}

- (void)hide{
    [UIView animateWithDuration:0.3 animations:^{
//        self.alpha = 0;
//        self.contentViewHegithCons.constant = 0;
//        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (component) {
            //        case 0:
            //            return self.regionArr.count;
            //            break;
        case 0:
            return self.provinceArr.count;
            break;
        case 1:
            return self.cityArr.count;
            break;
        case 2:
            if (self.areaArr.count) {
                return self.areaArr.count;
                break;
            }
        default:
            return 0;
            break;
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    switch (component) {
            //        case 0:
            //            return [[self.regionArr objectAtIndex:row] objectForKey:@"region"];
            //            break;
        case 0:
            //            self.provinceArr = self.regionArr[row][@"provinces"];
            //            return [[self.provinceArr objectAtIndex:row] objectForKey:@"province"];
            return [self.provinceArr objectAtIndex:row];
            break;
        case 1:
            //            return [[self.cityArr objectAtIndex:row] objectForKey:@"city"];
            return [self.cityArr objectAtIndex:row];
            break;
        case 2:
            if (self.areaArr.count) {
                return [self.areaArr objectAtIndex:row];
                break;
            }
        default:
            return  @"";
            break;
    }
}
#pragma mark - UIPickerViewDelegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.minimumScaleFactor = 8.0;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    
    return pickerLabel;
}

//
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    //    switch (component) {
    //        case 0:{
    //            self.provinceArr = self.regionArr[row][@"provinces"];
    //            [self.pickView reloadComponent:1];
    //            [self.pickView selectRow:0 inComponent:1 animated:YES];
    //
    //
    //            self.cityArr = [[self.provinceArr objectAtIndex:0] objectForKey:@"cities"];
    //            [self.pickView reloadComponent:2];
    //            [self.pickView selectRow:0 inComponent:2 animated:YES];
    //
    //
    //            self.areaArr = [[self.cityArr objectAtIndex:0] objectForKey:@"areas"];
    //            [self.pickView reloadComponent:3];
    //            [self.pickView selectRow:0 inComponent:3 animated:YES];
    //
    //            self.locate.region = self.regionArr[row][@"region"];
    //            self.locate.province = self.provinceArr[0][@"province"];
    //            self.locate.city = self.cityArr[0][@"city"];
    //            if (self.areaArr.count) {
    //                self.locate.area = self.areaArr[0];
    //            }else{
    //                self.locate.area = @"";
    //            }
    //
    //
    //            break;
    //        }
    //        case 0:
    //        {
    //            self.provinceArr = self.regionArr[row][@"provinces"];
    //            self.cityArr = [[self.provinceArr objectAtIndex:row] objectForKey:@"cities"];
    //            [self.pickView reloadComponent:1];
    //            [self.pickView selectRow:0 inComponent:2 animated:YES];
    //
    //
    //            self.areaArr = [[self.cityArr objectAtIndex:0] objectForKey:@"areas"];
    //            [self.pickView reloadComponent:2];
    //            [self.pickView selectRow:0 inComponent:2 animated:YES];
    //
    //            self.locate.province = self.provinceArr[row][@"province"];
    //            self.locate.city = self.cityArr[0][@"city"];
    //            if (self.areaArr.count) {
    //                self.locate.area = self.areaArr[0];
    //            }else{
    //                self.locate.area = @"";
    //            }
    //            break;
    //        }
    //        case 1:{
    //            self.areaArr = [[self.cityArr objectAtIndex:row] objectForKey:@"areas"];
    //            [self.pickView reloadComponent:2];
    //            [self.pickView selectRow:0 inComponent:2 animated:YES];
    //
    //            self.locate.city = self.cityArr[row][@"city"];
    //            if (self.areaArr.count) {
    //                self.locate.area = self.areaArr[0];
    //            }else{
    //                self.locate.area = @"";
    //            }
    //
    //            break;
    //        }
    //        case 2:{
    //            if (self.areaArr.count) {
    //                self.locate.area = self.areaArr[row];
    //            }else{
    //                self.locate.area = @"";
    //            }
    //
    //            break;
    //        }
    if(component == 0){
        //            self.regionArr = [self.pickerDic objectForKey:[self.provinceArr objectAtIndex:row]];
        //            if (self.regionArr.count > 0) {
        //                self.cityArr = [[self.regionArr objectAtIndex:0] allKeys];
        //            } else {
        //                self.cityArr = nil;
        //            }
        //            if (self.cityArr.count > 0) {
        //                self.areaArr = [[self.regionArr objectAtIndex:0] objectForKey:[self.cityArr objectAtIndex:0]];
        //            } else {
        //                self.areaArr = nil;
        //            }
        //            self.locate.province = self.provinceArr[0];
        //            self.locate.city = self.cityArr[0];
        //            if(self.areaArr.count){
        //                self.locate.area = self.areaArr[0];
        //            }
        //            else{
        //                self.locate.area = @"";
        //            }
        [self.cityArr removeAllObjects];
        [self.areaArr removeAllObjects];
        for(int f = 0;f<self.provinceArr.count;f++){
            if([self.provinceArr[f] isEqualToString:self.provinceArr[row]]){
                self.tagF = row;
                break;
            }
        }
        NSArray *cityArray = self.pickerArr[row][@"cities"];
        for(int i=0;i<cityArray.count;i++){
            NSString *str = cityArray[i][@"areaName"];
            [self.cityArr addObject:str];
        }
        NSArray *areaArray  = cityArray[0][@"counties"];
        for(int j=0;j<areaArray.count;j++){
            NSString *str = areaArray[j][@"areaName"];
            [self.areaArr addObject:str];
        }
        
    }
    [pickerView selectedRowInComponent:1];
    [pickerView reloadComponent:1];
    [pickerView selectedRowInComponent:2];
    
    if(component == 1) {
        //            if (self.regionArr.count > 0 && self.cityArr.count > 0) {
        //                self.areaArr = [[self.regionArr objectAtIndex:0] objectForKey:[self.cityArr objectAtIndex:row]];
        //            } else {
        //                self.areaArr = nil;
        //            }
        [self.areaArr removeAllObjects];
        NSInteger tagA = 0;
        NSArray *arr = self.pickerArr[self.tagF][@"cities"];
        for(int i=0;i<arr.count;i++){
            if([arr[i][@"areaName"]isEqualToString:self.cityArr[row]]){
                tagA = row;
                break;
            }
        }
        NSArray *arrayArea = arr[tagA][@"counties"];
        for(int flag=0;flag<arrayArea.count;flag++){
            NSString *str = arrayArea[flag][@"areaName"];
            
            [self.areaArr addObject:str];
        }
        //            self.locate.city = self.cityArr[0];
        //            if(self.areaArr.count){
        //                self.locate.area = self.areaArr[0];
        //            }
        //            else{
        //                self.locate.area = @"";
        //            }
        [pickerView selectRow:1 inComponent:2 animated:YES];
        
    }
    [pickerView reloadComponent:2];
    //        default:
    //            break;
    //    }
}
@end
