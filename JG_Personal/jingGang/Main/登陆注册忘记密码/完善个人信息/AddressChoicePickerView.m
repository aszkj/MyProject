//
//  AddressChoicePickerView.m
//  Wujiang
//
//  Created by zhengzeqin on 15/5/27.
//  Copyright (c) 2015年 com.injoinow. All rights reserved.
//  make by 郑泽钦 分享

#import "AddressChoicePickerView.h"

@interface AddressChoicePickerView()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHegithCons;
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;
@property (strong, nonatomic) AreaObject *locate;
//保存选中省
@property (assign,nonatomic)NSInteger tagF;

@end
@implementation AddressChoicePickerView

- (instancetype)init{
    
    if (self = [super init]) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"AddressChoicePickerView" owner:nil options:nil]firstObject];
        self.frame = [UIScreen mainScreen].bounds;
        self.pickView.delegate = self;
        self.pickView.dataSource = self;
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

        [self customView];
    }
    return self;
}

- (void)customView{
    self.contentViewHegithCons.constant = 0;
    [self layoutIfNeeded];
}

#pragma mark - setter && getter

- (AreaObject *)locate{
    if (!_locate) {
        _locate = [[AreaObject alloc]init];
    }
    return _locate;
}

#pragma mark - action

//选择完成
- (IBAction)finishBtnPress:(UIButton *)sender {
    self.locate.province = [self.provinceArr objectAtIndex:[self.pickView selectedRowInComponent:0]];
    self.locate.city = [self.cityArr objectAtIndex:[self.pickView selectedRowInComponent:1]];
    self.locate.area = [self.areaArr objectAtIndex:[self.pickView selectedRowInComponent:2]];
    if (self.block) {
        self.block(self,sender,self.locate);
    }
    [self hide];
}

//隐藏
- (IBAction)dissmissBtnPress:(UIButton *)sender {
    
    [self hide];
}

#pragma  mark - function

- (void)show{
    UIWindow *win = [[UIApplication sharedApplication] keyWindow];
//    UIView *topView = [win.subviews firstObject];
    [win addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.contentViewHegithCons.constant = 250;
        [self layoutIfNeeded];
    }];
}

- (void)hide{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        self.contentViewHegithCons.constant = 0;
        [self layoutIfNeeded];
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

        if(component == 0){

            [self.cityArr removeAllObjects];
            [self.areaArr removeAllObjects];
            for(int f;f<self.provinceArr.count;f++){
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
