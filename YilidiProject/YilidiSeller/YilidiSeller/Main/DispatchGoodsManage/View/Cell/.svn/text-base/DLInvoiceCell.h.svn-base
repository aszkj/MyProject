//
//  DLInvoiceCell.h
//  YilidiSeller
//
//  Created by yld on 16/5/31.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DLInvoiceListModel;
@interface DLInvoiceCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *countLabel;

@property (weak, nonatomic) IBOutlet UILabel *invoiceCode;
@property (weak, nonatomic) IBOutlet UILabel *invoiceStutas;

@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *invoiceTime;
@property (weak, nonatomic) IBOutlet UILabel *invoiceCount;
@property (weak, nonatomic) IBOutlet UILabel *invoicePrice;

@property (nonatomic,strong)DLInvoiceListModel *model;
- (void)setModel:(DLInvoiceListModel *)model invoiceStatus:(NSInteger)status;
@end
