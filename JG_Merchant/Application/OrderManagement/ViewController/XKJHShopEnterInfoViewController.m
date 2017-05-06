//
//  XKJHShopEnterInfoViewController.m
//  Merchants_JingGang
//
//  Created by thinker on 15/9/2.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHShopEnterInfoViewController.h"
#import "XKJHShopEnterInfoTableViewCell.h"
#import "XKJHShopEnterTableViewCell.h"
#import "XKJHShopEnterHeaderView.h"
#import "XKJHShopEnterPhotoTableViewCell.h"
#import "WSJAddresListViewController.h"
#import <MBProgressHUD.h>
#import "XKJHMapViewController.h"
#import "QueryProgressViewController.h"
#import "KJLoginController.h"

#import "XKJHShopEnterCategoryViewController.h"

@interface XKJHShopEnterInfoViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    XKJHShopEnterInfoModel *m_1ShopName;        //商户名称
    XKJHShopEnterInfoModel *m_2ShopQuan;        //商户全称
    XKJHShopEnterInfoModel *m_3Industry;        //所属行业
    XKJHShopEnterInfoModel *m_4Range;           //经营范围
    XKJHShopEnterInfoModel *m_5Introduction;    //商户介绍
    XKJHShopEnterInfoModel *m_6Business;        //主营类目
    XKJHShopEnterInfoModel *m_7Detailed;        //详细类目
    XKJHShopEnterInfoModel *m_8Location;        //商户所在地
    XKJHShopEnterInfoModel *m_9DetailedAddress; //详细地址
    XKJHShopEnterInfoModel *m_10Tel;            //固定电话
    XKJHShopEnterInfoModel *m_11Mobile;         //手机号码
    XKJHShopEnterInfoModel *m_12Rebate;         //返佣比例
    XKJHShopEnterInfoModel *m_13Discount;       //折扣
    XKJHShopEnterInfoModel *m_14AccountName;    //结算账户名
    XKJHShopEnterInfoModel *m_15Account;        //结算账户
    XKJHShopEnterInfoModel *m_16OpenAccount;    //账户开户行
    
    XKJHShopEnterInfoModel *m_17Identity;       //身份证号码
    XKJHShopEnterInfoModel *M_18OpenLine;       //开户行
    
    XKJHShopEnterInfoModel *sec1;               //隶属运营商编号
    /**
     *  法人身份证正面照
     */
    XKJHShopEnterInfoModel *sec2;
    /**
     *  法人身份证反面照
     */
    XKJHShopEnterInfoModel *sec3;
    /**
     *  银行卡正面照
     */
    XKJHShopEnterInfoModel *sec4;
    /**
     *  银行卡反面照
     */
    XKJHShopEnterInfoModel *sec5;
    /**
     *  经营场所证明（租赁合同或营业执照)
     */
    XKJHShopEnterInfoModel *sec6;
    /**
     *  法人身份证手拿照
     */
    XKJHShopEnterInfoModel *sec7;
    /**
     *  申请人手持信用卡正面照
     */
    XKJHShopEnterInfoModel *sec8;
    /**
     *  其他
     */
    XKJHShopEnterInfoModel *sec9;

    NSInteger _upCount;
    NSInteger _cacheSection;
    VApiManager *_vapiManager;
    
    CGFloat _latitude; //纬度
    CGFloat _longitude; //经度
    NSNumber *_zhuyingID;//主营类目的ID
    NSString *_xiangxiID;//详细类目的ID
    NSNumber *_addressID;//商户所在地区ID
    NSNumber *_bankAreaID;//开户行ID
}

@property (nonatomic, strong) UISwitch *isPOS;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *sectionSource;

@end

static NSString *shopOrdinaryTableViewCell = @"shopOrdinaryTableViewCell";
static NSString *shopEnterTableViewCell = @"shopEnterTableViewCell";
static NSString *shopEnterPhotoTableCell = @"shopEnterPhotoTableCell";

@implementation XKJHShopEnterInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self setData];
    if (_isEdit)
    {
        [self requestData];
    }
}

#pragma mark - 编辑填写信息
- (void)requestData
{
    WEAK_SELF
    GroupStoreInfoGetRequest *storeInfoRequest = [[GroupStoreInfoGetRequest alloc] init:GetToken];
    [_vapiManager groupStoreInfoGet:storeInfoRequest success:^(AFHTTPRequestOperation *operation, GroupStoreInfoGetResponse *response) {
        NSLog(@"info ---- %@",response);
        StoreAppInfo *info = [StoreAppInfo objectWithKeyValues:response.storeAppInfoBo];
        m_1ShopName.content = info.storeName;
        m_2ShopQuan.content = info.licensecName;
        m_3Industry.content = info.industry;
        m_4Range.content = info.licenseBusinessScope;
        m_5Introduction.content = info.licenseCDesc;
        _zhuyingID = info.groupMainId;
        m_6Business.content = info.category;
        m_7Detailed.content = info.detailsInfos;
        _xiangxiID = info.groupDetailInfo;
        m_8Location.content = info.area;
        _addressID = info.areaId;
        m_9DetailedAddress.content = info.storeAddress;
        _latitude = [info.storeLat floatValue];
        _longitude = [info.storeLon floatValue];
        m_10Tel.content = info.storeTelephone;
        m_11Mobile.content = info.licenseCMobile;
        m_12Rebate.content = [info.commissionRebate stringValue];
        m_13Discount.content = [info.groupDiscount stringValue];
        m_14AccountName.content = info.bankAccountName;
        m_15Account.content = info.bankCAccount;
        m_16OpenAccount.content = info.bankName;
        _isPOS.on = [info.isEepay boolValue];

        m_17Identity.content = info.cartCode;
        M_18OpenLine.content = info.bankAreaName;
        _bankAreaID = info.bankAreaId;
        sec1.content = info.operateNumber;
        
        [sec2.imageArray addObject:@"1"];
        [sec3.imageArray addObject:@"1"];
        [sec4.imageArray addObject:@"1"];
        [sec5.imageArray addObject:@"1"];
        [sec6.imageArray addObject:@"1"];
        [sec7.imageArray addObject:@"1"];
        [sec8.imageArray addObject:@"1"];

        [sec2.imageURLArray addObject:info.licenseLegalIdCardFrontPath];
        [sec3.imageURLArray addObject:info.licenseLegalIdCardBackPath];
        [sec4.imageURLArray addObject:info.bankCardFrontPath];
        [sec5.imageURLArray addObject:info.bankCardBackPath];
        [sec6.imageURLArray addObject:info.licenseImagePath];
        [sec7.imageURLArray addObject:info.licenseLegalIdCardReachPath];
        [sec8.imageURLArray addObject:info.businessPlacePhotoPath];
        if (info.otherPhotoPath.length > 3)
        {
            NSArray *array = [info.otherPhotoPath componentsSeparatedByString:@";"];
            for (NSString *path in array)
            {
                [sec9.imageArray addObject:@"1"];
                [sec9.imageURLArray addObject:path];
            }
        }
        
        [weak_self.tableView reloadData];
        weak_self.isPOS.on = info.isEepay.boolValue;
        [weak_self POSAction];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"infoError ---- %@",error);
    }];
}
- (void)setData
{
    //第一段数据
    m_1ShopName = [self getModelWithTitle:@"✻ 商户名称" withRithImage:nil];
    m_2ShopQuan = [self getModelWithTitle:@"✻ 商户全称" withRithImage:nil];
    m_3Industry = [self getModelWithTitle:@"✻ 所属行业" withRithImage:nil];
    m_4Range = [self getModelWithTitle:@"✻ 经营范围" withRithImage:nil];
    m_5Introduction = [self getModelWithTitle:@"✻ 商户介绍" withRithImage:nil];
    m_6Business = [self getModelWithTitle:@"✻ 主营类目" withRithImage:@"Haircut"];
    m_7Detailed = [self getModelWithTitle:@"✻ 详细类目" withRithImage:@"Haircut"];
    m_8Location = [self getModelWithTitle:@"✻ 商户所在地" withRithImage:@"Haircut"];
    m_9DetailedAddress = [self getModelWithTitle:@"✻ 详细地址" withRithImage:@"Address"];
    m_10Tel = [self getModelWithTitle:@"✻ 固定电话" withRithImage:nil];
    m_11Mobile = [self getModelWithTitle:@"✻ 手机号码" withRithImage:nil];
    m_12Rebate = [self getModelWithTitle:@"✻ 返佣比例" withRithImage:@"baifen"];
    m_13Discount = [self getModelWithTitle:@"✻ 折       扣" withRithImage:@"baifen"];
    m_14AccountName = [self getModelWithTitle:@"✻ 结算账户名" withRithImage:nil];
    m_15Account = [self getModelWithTitle:@"✻ 结算账户" withRithImage:nil];
    m_16OpenAccount = [self getModelWithTitle:@"✻ 账户开户行" withRithImage:nil];
    
    m_17Identity = [self getModelWithTitle:@"✻ 身份证号" withRithImage:nil];
    M_18OpenLine = [self getModelWithTitle:@"✻ 开户省、市" withRithImage:@"Haircut"];
    
    m_4Range.rowHeight = 150;
    m_5Introduction.rowHeight = 150;
    m_9DetailedAddress.placeholder = @"点击右侧图标定位";
    m_12Rebate.placeholder = @"如：返佣为10%，请填写0.1";
    m_13Discount.placeholder = @"如：到店消费7折，请填写0.7";
    
    [self.dataSource addObject:m_1ShopName];
    [self.dataSource addObject:m_2ShopQuan];
    [self.dataSource addObject:m_3Industry];
    [self.dataSource addObject:m_4Range];
    [self.dataSource addObject:m_5Introduction];
    [self.dataSource addObject:m_6Business];
    [self.dataSource addObject:m_7Detailed];
    [self.dataSource addObject:m_8Location];
    [self.dataSource addObject:m_9DetailedAddress];
    [self.dataSource addObject:m_10Tel];
    [self.dataSource addObject:m_11Mobile];
    [self.dataSource addObject:m_17Identity];
    [self.dataSource addObject:m_12Rebate];
    [self.dataSource addObject:m_13Discount];
    [self.dataSource addObject:m_14AccountName];
    [self.dataSource addObject:m_15Account];
    [self.dataSource addObject:M_18OpenLine];
    [self.dataSource addObject:m_16OpenAccount];
    
    
    sec1 = [self getModelWithTitle:@"隶属运营商编号" withRithImage:nil];
    //第3段开始的数据----段数据信息
    
    sec2 = [self getModelWithTitle:@"✻ 法人身份证正面照" withRithImage:@""];
    sec3 = [self getModelWithTitle:@"✻ 法人身份证反面照" withRithImage:@""];
    sec4 = [self getModelWithTitle:@"✻ 银行卡正面照" withRithImage:@""];
    sec5 = [self getModelWithTitle:@"✻ 银行卡反面照" withRithImage:@""];
    sec6 = [self getModelWithTitle:@"✻ 经营场所证明（租赁合同或营业执照）" withRithImage:@""];
    sec7 = [self getModelWithTitle:@"✻ 法人身份证手拿照" withRithImage:@""];
    sec8 = [self getModelWithTitle:@"申请人手持信用卡正面照" withRithImage:@""];
    sec9 = [self getModelWithTitle:@"其它（申请人信用卡正面等）" withRithImage:@""];
    
    sec1.titleWidth = 130;
    sec2.rowHeight = sec3.rowHeight = sec4.rowHeight = sec5.rowHeight =  sec6.rowHeight = sec7.rowHeight = sec8.rowHeight = sec9.rowHeight =  140;
    
    [self.sectionSource addObject:sec2];
    [self.sectionSource addObject:sec3];
    [self.sectionSource addObject:sec4];
    [self.sectionSource addObject:sec5];
    [self.sectionSource addObject:sec6];
    [self.sectionSource addObject:sec7];
    [self.sectionSource addObject:sec8];
    [self.sectionSource addObject:sec9];
    [self.tableView reloadData];
    
//    m_1ShopName.content = @"111";
//    m_2ShopQuan.content = @"quancheng";
//    m_3Industry.content = @"222";
//    m_4Range.content = @"333";
//    m_5Introduction.content = @"444";
//    m_9DetailedAddress.content = @"dizhi";
//    m_10Tel.content = @"0594-8083565";
//    m_11Mobile.content = @"18159430615";
//    m_12Rebate.content = @"0.04";
//    m_13Discount.content = @"0.7";
//    m_14AccountName.content = @"jie";
//    m_15Account.content = @"123456";
//    m_16OpenAccount.content = @"hello";
//    m_17Identity.content = @"123456789012345";
//    sec1.content = @"SN100333";
}

#pragma mark - 提交事件
- (void)commitAction
{
    //验证数据是否正确
    for (XKJHShopEnterInfoModel *model in self.dataSource)
    {
        if ([model.title containsString:@"✻ "])
        {
            if (model.content.length == 0)
            {
                NSArray *message = [model.title componentsSeparatedByString:@"✻ "];
                [Util ShowAlertWithOnlyMessage:[NSString stringWithFormat:@"%@不能为空",message[1]]];
                return;
            }
        }
    }
    if (![Util isValidateTel:m_10Tel.content])
    {
        [Util ShowAlertWithOnlyMessage:@"输入固定电话号码有误"];
        return;
    }
    if (![Util isValidateMobile:m_11Mobile.content])
    {
        [Util ShowAlertWithOnlyMessage:@"手机号码输入有误"];
        return;
    }

    if (![Util isValidateIdentity:m_17Identity.content])
    {
        [Util ShowAlertWithOnlyMessage:@"身份证号码有误"];
        return;
    }
    
    if ([m_12Rebate.content floatValue] * 100 < 1.0 || [m_12Rebate.content floatValue] * 100 > 99.0)
    {
        [Util ShowAlertWithOnlyMessage:@"返佣比例输入不合理，请重新输入"];
        return;
    }
    if ([m_13Discount.content floatValue] * 100 < 1.0 || [m_13Discount.content floatValue] * 100 > 99.0)
    {
        [Util ShowAlertWithOnlyMessage:@"折扣输入不合理，请重新输入"];
        return;
    }
    for (XKJHShopEnterInfoModel *model  in self.sectionSource)
    {
        if ([model.title containsString:@"✻ "])
        {
            if (model.imageArray.count == 0)
            {
                NSArray *message = [model.title componentsSeparatedByString:@"✻ "];
                [Util ShowAlertWithOnlyMessage:[NSString stringWithFormat:@"%@不能为空",message[1]]];
                return;
            }
        }
    }
    //TODO:完全验证正确开始提交数据
    [self.view endEditing:YES];
    _upCount = 0;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在提交数据中...";
    hud.detailsLabelText = @"提交数据会比较长，请耐心等待";
    [hud show:YES];
    //TODO:提交图片信息
    for (XKJHShopEnterInfoModel *model in self.sectionSource)
    {
        if (model.imageArray.count == 0)
        {
            _upCount ++;
        }
        [model.imageURLArray removeAllObjects];
        for (UIImage *image in model.imageArray)
        {
            [self _upLoadHeadImgWithImgData:image withModel:model];
        }
    }
}

#pragma mark - 全部验证正确，提交所有的数据
- (void) commitData
{
    
    GroupCheckInSaveRequest *saveRequest = [[GroupCheckInSaveRequest alloc] init:GetToken];
    saveRequest.api_storeName = m_1ShopName.content;
    saveRequest.api_licenseCName = m_2ShopQuan.content;
    saveRequest.api_industry = m_3Industry.content;
    saveRequest.api_licenseBusinessScope = m_4Range.content;
    saveRequest.api_licenseCDesc = m_5Introduction.content;
    saveRequest.api_gcMainId = _zhuyingID;
    saveRequest.api_groupDetailInfo = _xiangxiID;
    saveRequest.api_areaId = _addressID;
    saveRequest.api_storeAddress = m_9DetailedAddress.content;
    saveRequest.api_storeTelephone = m_10Tel.content;
    saveRequest.api_licenseCMobile = m_11Mobile.content;
    saveRequest.api_commissionRebate = @([m_12Rebate.content floatValue]);
    saveRequest.api_groupDiscount = @([m_13Discount.content floatValue]);
    saveRequest.api_bankAccountName = m_14AccountName.content;
    saveRequest.api_bankCAccount = m_15Account.content;
    saveRequest.api_bankName = m_16OpenAccount.content;
    
    saveRequest.api_isEepay = @(_isPOS.on);
    saveRequest.api_licenseLegalIdCardFrontPath = [sec2.imageURLArray componentsJoinedByString:@";"];
    saveRequest.api_licenseLegalIdCardBackPath = [sec3.imageURLArray componentsJoinedByString:@";"];
    saveRequest.api_licenseLegalIdCardReachPath = [sec7.imageURLArray componentsJoinedByString:@";"].length == 0 ? nil :[sec7.imageURLArray componentsJoinedByString:@";"];
    saveRequest.api_bankCardFrontPath = [sec4.imageURLArray componentsJoinedByString:@";"];
    saveRequest.api_bankCardBackPath =[sec5.imageURLArray componentsJoinedByString:@";"];
    saveRequest.api_licenseImagePath = [sec6.imageURLArray componentsJoinedByString:@";"];
    saveRequest.api_businessPlacePhotoPath = [sec8.imageURLArray componentsJoinedByString:@";"].length == 0 ? nil : [sec8.imageURLArray componentsJoinedByString:@";"];
    saveRequest.api_otherPhotoPath = [sec9.imageURLArray componentsJoinedByString:@";"];
    saveRequest.api_storeLat =@(_latitude);
    saveRequest.api_storeLon = @(_longitude);
    saveRequest.api_operateNumber = sec1.content;
    
    saveRequest.api_cardCode = m_17Identity.content;
    saveRequest.api_bankAreaId = _bankAreaID;
    [_vapiManager groupCheckInSave:saveRequest success:^(AFHTTPRequestOperation *operation, GroupCheckInSaveResponse *response) {
        NSLog(@"cheshi ---- %@",response);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (response.subCode.length > 0)
        {
            [Util ShowAlertWithOnlyMessage:[NSString stringWithFormat:@"数据提交失败,%@",response.subMsg]];
        }
        else
        {
            QueryProgressViewController *progressVC = [[QueryProgressViewController alloc] init];
            [self.navigationController pushViewController:progressVC animated:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [Util ShowAlertWithOnlyMessage:@"数据提交失败"];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"cheshi ---- %@",error);
    }];
}

- (XKJHShopEnterInfoModel *)getModelWithTitle:(NSString *)title  withRithImage:(NSString *)image
{
    XKJHShopEnterInfoModel *model = [[XKJHShopEnterInfoModel alloc] init];
    model.title = title;
    model.titleWidth = 90;
    model.rowHeight = 50;
    model.rightImageName = image;
    return model;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionSource.count + 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)//第一段
    {
        return self.dataSource.count;
    }
    else if (section == 1)//第二段
    {
        return 1;
    }
    else if (section > 1)//第三段开始
    {
        XKJHShopEnterInfoModel *model = self.sectionSource[section - 2];
        if (model.imageArray.count > 0)
        {
            return 1;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAK_SELF
    if (indexPath.section == 0)
    {
        XKJHShopEnterInfoModel *model = self.dataSource[indexPath.row];
        if (model.rowHeight > 50)
        {
            XKJHShopEnterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:shopEnterTableViewCell];
            if(!cell){
//                [tableView registerNib:[UINib nibWithNibName:@"XKJHShopEnterTableViewCell" bundle:nil] forCellReuseIdentifier:shopEnterTableViewCell];
                cell = [[[NSBundle mainBundle] loadNibNamed:@"XKJHShopEnterTableViewCell" owner:nil options:0] lastObject];
                
                
//                [self.tableView registerNib:[UINib nibWithNibName:@"XKJHShopEnterTableViewCell" bundle:nil] forCellReuseIdentifier:shopEnterTableViewCell];
                
//                cell = [tableView dequeueReusableCellWithIdentifier:shopEnterTableViewCell];
            }
            cell.model = model;
            return cell;
        }
        else
        {
            XKJHShopEnterInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:shopOrdinaryTableViewCell];
            if(!cell){
//                [tableView registerNib:[UINib nibWithNibName:@"XKJHShopEnterInfoTableViewCell" bundle:nil] forCellReuseIdentifier:shopOrdinaryTableViewCell];
//                cell = [tableView dequeueReusableCellWithIdentifier:shopOrdinaryTableViewCell];
                cell = [[[NSBundle mainBundle] loadNibNamed:@"XKJHShopEnterInfoTableViewCell" owner:nil options:0] lastObject];
            }
            cell.model = model;
            
            //TODO:跳到主营和详细类目界面
            cell.enterCategoryBlock = ^(NSString *title){
//                [weak_self.view endEditing:YES];
                XKJHShopEnterCategoryViewController *categoryVC = [[XKJHShopEnterCategoryViewController alloc] initWithNibName:@"XKJHShopEnterCategoryViewController" bundle:nil];
                categoryVC.titleString = title;
                categoryVC.api_parentId = _zhuyingID;
                if ([title containsString:@"详细类目"] && _zhuyingID == nil)
                {
                    [Util ShowAlertWithOnlyMessage:@"请先填写主营类目"];
                    return ;
                }
                [weak_self.navigationController pushViewController:categoryVC animated:YES];
                categoryVC.selectResult = ^(NSString *result,NSNumber *ID,NSString *resultID){
                    NSLog(@"%@ --选中 =  %@ -- id%@",model.title,result,ID);
                    if ([model.title containsString:@"主营类目"])
                    {
                        _zhuyingID = ID;
                    }
                    else
                    {
                        _xiangxiID = resultID;
                    }
                    m_7Detailed.content = nil;
                    model.content = result;
                    NSIndexPath *path1 = [NSIndexPath indexPathForRow:5 inSection:0];
                    NSIndexPath *path2 = [NSIndexPath indexPathForRow:6 inSection:0];
                    [weak_self.tableView reloadRowsAtIndexPaths:@[path1,path2] withRowAnimation:UITableViewRowAnimationNone];
                };
            };
            //TODO:选择地区信息
            cell.mapBlock = ^(void){
                [weak_self.view endEditing:YES];
                WSJAddresListViewController *addresListVC = [[WSJAddresListViewController alloc] initWithNibName:@"WSJAddresListViewController" bundle:nil];
                addresListVC.addressType = shopDetailsAddress;
                addresListVC.returnAddress = ^(NSString * address,NSNumber *addressID){
                    model.content = address;
                    _addressID = addressID;
//                    m_9DetailedAddress.content = nil;
//                    NSIndexPath *path = [NSIndexPath indexPathForRow:7 inSection:0];
//                    NSIndexPath *path1 = [NSIndexPath indexPathForRow:8 inSection:0];
                     NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
                    [weak_self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];

//                    [weak_self.tableView reloadRowsAtIndexPaths:@[path,path1] withRowAnimation:UITableViewRowAnimationNone];
                };
                [weak_self.navigationController pushViewController:addresListVC animated:YES];
            };
            //TODO:地图上选择地理位置
            cell.mapPositionBlock = ^(void){
                if (m_8Location.content.length > 0)
                {
                    XKJHMapViewController *mapVC = [[XKJHMapViewController alloc ]initWithNibName:@"XKJHMapViewController" bundle:nil];
                    mapVC.address = m_8Location.content;
                    mapVC.latitude = _latitude;
                    mapVC.longitude = _longitude;
                    mapVC.selectAddress = m_9DetailedAddress.content;
                    mapVC.addressBlock = ^(NSString *address,CGFloat latitude, CGFloat longitude){
                        NSLog(@"map ---- %@    %lf    %lf",address,latitude,longitude);
                        model.content = address;
                        _latitude = latitude;
                        _longitude = longitude;
                        NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
                        [weak_self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
                    };
                    [self.navigationController pushViewController:mapVC animated:YES];
                }
                else
                {
                    [Util ShowAlertWithOnlyMessage:@"请先选择商户所在地！"];
                }
            };
            //TODO:开户行省、市
            cell.bankAreaBlock = ^(void){
                [weak_self.view endEditing:YES];
                WSJAddresListViewController *addresListVC = [[WSJAddresListViewController alloc] initWithNibName:@"WSJAddresListViewController" bundle:nil];
                addresListVC.addressType = bankAddress;
                addresListVC.returnAddress = ^(NSString * address,NSNumber *addressID){
                    model.content = address;
                    _bankAreaID = addressID;
                    NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
                    [weak_self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
                };
                [weak_self.navigationController pushViewController:addresListVC animated:YES];
            };
            return cell;
        }
    }
    else if (indexPath.section == 1) //隶属运营商编号
    {
        XKJHShopEnterInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:shopOrdinaryTableViewCell];
        if(!cell){
//            [tableView registerNib:[UINib nibWithNibName:@"XKJHShopEnterInfoTableViewCell" bundle:nil] forCellReuseIdentifier:shopOrdinaryTableViewCell];
//            cell = [tableView dequeueReusableCellWithIdentifier:shopOrdinaryTableViewCell];
            cell = [[[NSBundle mainBundle] loadNibNamed:@"XKJHShopEnterInfoTableViewCell" owner:nil options:0] lastObject];
        }
        cell.model = sec1;
        return cell;
    }
    else if (indexPath.section > 1)//显示图片cell
    {
        XKJHShopEnterPhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:shopEnterPhotoTableCell];
        if(!cell){
//            [tableView registerNib:[UINib nibWithNibName:@"XKJHShopEnterPhotoTableViewCell" bundle:nil] forCellReuseIdentifier:shopEnterPhotoTableCell];
//            cell = [tableView dequeueReusableCellWithIdentifier:shopEnterPhotoTableCell];
            cell = [[[NSBundle mainBundle] loadNibNamed:@"XKJHShopEnterPhotoTableViewCell" owner:nil options:0] lastObject];
        }
        XKJHShopEnterInfoModel *model = self.sectionSource[indexPath.section - 2];
        cell.model = model;
        cell.reloadData = ^(void){
            [self.tableView reloadData];
        };
        
        return cell;
    }
    return nil;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XKJHShopEnterInfoModel *model;
    if (indexPath.section > 1)
    {
        model = self.sectionSource[indexPath.section - 2];
    }
    else if (indexPath.section == 0)
    {
        model = self.dataSource[indexPath.row];
    }
    else if (indexPath.section == 1)
    {
        model = sec1;
    }
    return model.rowHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //前两段的数据
    switch (section) {
        case 0:
        {
            UIView *v  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
            v.backgroundColor = [UIColor clearColor];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 150, 30)];
            label.text = @"商户入驻信息";
            label.font = [UIFont systemFontOfSize:17];
            label.textColor = UIColorFromRGB(0X333333);
            [v addSubview:label];
            UIView *v2 = [[UIView alloc] initWithFrame:CGRectMake(0, 49, kScreenWidth, 0.3)];
            v2.backgroundColor = UIColorFromRGB(0Xd7d7d7);
            [v addSubview:v2];
            
            return v;
        }
            break;
        case 1:
        {
            UIView *v  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
            v.backgroundColor = [UIColor clearColor];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 150, 30)];
            label.text = @"安装POS机";
            label.font = [UIFont systemFontOfSize:15];
            label.textColor = UIColorFromRGB(0X333333);
            [v addSubview:label];
            self.isPOS.frame = CGRectMake(CGRectGetMaxX(label.frame), 10, 50, 30);
            [self.isPOS addTarget:self action:@selector(POSAction) forControlEvents:UIControlEventValueChanged];
            [v addSubview:self.isPOS];
            
            UIView *v2 = [[UIView alloc] initWithFrame:CGRectMake(0, 49, kScreenWidth, 0.25)];
            v2.backgroundColor = UIColorFromRGB(0Xd7d7d7);
            [v addSubview:v2];
            return v;
        }
            break;
        default:
            break;
    }
    //第三段开始的数据
    XKJHShopEnterHeaderView *headerView = [[NSBundle mainBundle] loadNibNamed:@"XKJHShopEnterHeaderView" owner:self options:nil][0];
    XKJHShopEnterInfoModel *model = self.sectionSource[section - 2];
    headerView.model = model;
    headerView.photoBlock = ^(void){
        UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选取", nil];
        [action showInView:self.view];
        _cacheSection = section;
    };
    return headerView;
}
#pragma mark - POS机
- (UISwitch *)isPOS
{
    if (_isPOS == nil) {
        _isPOS = [[UISwitch alloc] init];
        _isPOS.on = YES;
    }
    return _isPOS;
}
- (void)POSAction
{
    NSMutableIndexSet *reloadSet = [[NSMutableIndexSet alloc] init];//刷新第6段和最后一段
    [reloadSet addIndex:6];
    NSMutableIndexSet *set = [[NSMutableIndexSet alloc] init];//删除某段和插入某段
    [set addIndex:7];
    [set addIndex:8];
    NSLog(@"ceshi ---- %@",@"POS机");
    if (_isPOS.on == NO && self.sectionSource.count == 8) {
        sec6.title = @"✻ 经营场所证明（营业执照）";
        sec9.title = @"其它（门店照片或实景图）";
        [self.sectionSource removeObject:sec7];
        [self.sectionSource removeObject:sec8];
        [self.tableView deleteSections:set withRowAnimation:UITableViewRowAnimationLeft];
    }
    else if (_isPOS.on == YES && self.sectionSource.count == 6)
    {
        sec6.title = @"✻ 经营场所证明（租赁合同或营业执照）";
        sec9.title = @"其它（申请人信用卡正面等）";
        [self.sectionSource insertObject:sec8 atIndex:5];
        [self.sectionSource insertObject:sec7 atIndex:5];
        [self.tableView insertSections:set withRowAnimation:UITableViewRowAnimationLeft];
    }
    //刷新经营场所证明（第6段）和其他：最后一段
    [reloadSet addIndex:self.sectionSource.count + 1];
    [self.tableView reloadSections:reloadSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)initUI
{
    _vapiManager = [[VApiManager alloc] init];
    self.navigationController.tabBarController.tabBar.hidden = YES;
    self.dataSource = [NSMutableArray array];
    self.sectionSource = [NSMutableArray array];
    [Util setNavTitleWithTitle:@"商户入驻信息" ofVC:self];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(btnClick) target:self];
    self.view.backgroundColor = VCBackgroundColor;
    
//    [self.tableView registerNib:[UINib nibWithNibName:@"XKJHShopEnterInfoTableViewCell" bundle:nil] forCellReuseIdentifier:shopOrdinaryTableViewCell];
//    [self.tableView registerNib:[UINib nibWithNibName:@"XKJHShopEnterTableViewCell" bundle:nil] forCellReuseIdentifier:shopEnterTableViewCell];
//    [self.tableView registerNib:[UINib nibWithNibName:@"XKJHShopEnterPhotoTableViewCell" bundle:nil] forCellReuseIdentifier:shopEnterPhotoTableCell];
    //提交按钮
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    footerView.backgroundColor = [UIColor clearColor];
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    commitBtn.frame = CGRectMake(15, 15, kScreenWidth - 30 , 45);
    [commitBtn setTitle:@"提   交" forState:UIControlStateNormal];
    commitBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [commitBtn addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitBtn.backgroundColor = UIColorFromRGB(0X025476);
    commitBtn.layer.cornerRadius = 5;
    [footerView addSubview:commitBtn];
    self.tableView.tableFooterView = footerView;
    
}
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0://相机
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.delegate = self;
            [self presentViewController:picker animated:YES completion:nil];
        }
            break;
        case 1://图片库
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.delegate = self;
            [self presentViewController:picker  animated:YES completion:nil];

        }
            break;
        default:
            break;
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    XKJHShopEnterInfoModel *model = self.sectionSource[_cacheSection-2];
    [model.imageArray addObject:image];
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:_cacheSection];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 上传图片 - 生成url
#pragma mark - 上传头像图片
-(void)_upLoadHeadImgWithImgData:(UIImage *)image withModel:(XKJHShopEnterInfoModel *)model {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //图片 url + image
    //音频 url + audio
    //视频 url + video
    //@"http://api.jgyes.com/v1/image"
    NSData *imgData = UIImageJPEGRepresentation(image, 0.5);
    NSString *postImageUrl = [NSString stringWithFormat:@"%@/v1/image",BaseUrl];
    [manager POST:postImageUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imgData name:@"file" fileName:@"filename" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *newCommentImgUrl =  [[responseObject[@"items"] objectAtIndex:0] objectForKey:@"fileUrl"];
        NSLog(@"comment img url %@",newCommentImgUrl);
        [model.imageURLArray addObject:newCommentImgUrl];
        
        if (model.imageURLArray.count == model.imageArray.count)
        {
             _upCount ++;
            if (_upCount == self.sectionSource.count)
            {
                [self commitData];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        static BOOL errorFist = YES;
        if (errorFist)
        {
            errorFist = NO;
            [Util ShowAlertWithOnlyMessage:@"图片上传失败"];
        }
        NSLog(@"Error: %@", error);
    }];
}

//返回上一级界面
- (void) btnClick
{
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        KJLoginController *loginVC = [[KJLoginController alloc] init];
        UINavigationController *logNav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        self.view.window.rootViewController = logNav;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = status_color;
}


@end
