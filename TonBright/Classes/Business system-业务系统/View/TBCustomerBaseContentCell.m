//
//  TBCustomerBaseContentCell.m
//  TonBright
//
//  Created by jie peng on 2018/2/28.
//  Copyright © 2018年 jie peng. All rights reserved.
//

#import "TBCustomerBaseContentCell.h"
#import "TBCustomerData.h"

@interface TBCustomerBaseContentCell()

@property (weak, nonatomic) IBOutlet UILabel *customeridLabel;
@property (weak, nonatomic) IBOutlet UILabel *customertypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *customernmLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhengjiannoLabel;
@property (weak, nonatomic) IBOutlet UILabel *farenLabel;
@property (weak, nonatomic) IBOutlet UILabel *lianxirenLabel;
@property (weak, nonatomic) IBOutlet UILabel *jingyingdizhiLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhucedizhiLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;
@property (weak, nonatomic) IBOutlet UILabel *caiwuLabel;
@property (weak, nonatomic) IBOutlet UILabel *fapiaojieshouLabel;
@property (weak, nonatomic) IBOutlet UILabel *salesnmLabel;
@property (weak, nonatomic) IBOutlet UILabel *shibienoLabel;
@property (weak, nonatomic) IBOutlet UILabel *paternernoLabel;
@property (weak, nonatomic) IBOutlet UILabel *groupnmLabel;
@property (weak, nonatomic) IBOutlet UILabel *taxnoLabel;


@end

@implementation TBCustomerBaseContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setCustomerData:(TBCustomerData *)customerData{
    _customerData = customerData;
    
    NSDictionary * customertypeDict = @{@"1":@"个人",@"2":@"企业"};
    
    self.customeridLabel.text = [NSString stringWithFormat:@"%ld",(long)customerData.customerid];
    self.customertypeLabel.text = [customertypeDict objectForKey: customerData.customertype];
    self.customernmLabel.text = customerData.customernm;
    self.zhengjiannoLabel.text = customerData.zhengjianno;
    self.farenLabel.text = customerData.faren;
    self.lianxirenLabel.text = [[NSString stringWithFormat:@"姓名:%@",customerData.lianxiren] stringByAppendingFormat:@"\n手机:%@\n座机:%@",customerData.lianxirenshouji,customerData.lianxirenzuoji];
    self.jingyingdizhiLabel.text = customerData.jingyingdizhi;
    self.zhucedizhiLabel.text = customerData.zhucedizhi;
    self.bankLabel.text = customerData.bank;
    self.accountLabel.text = customerData.account;
    self.caiwuLabel.text =  [[NSString stringWithFormat:@"姓名:%@",customerData.caiwu] stringByAppendingFormat:@"\n手机:%@",customerData.caiwushouji];
    self.fapiaojieshouLabel.text = [[NSString stringWithFormat:@"姓名:%@",customerData.fapiaojieshouren] stringByAppendingFormat:@"\n手机:%@\n寄送邮编:%@",customerData.fapiaoshouji,customerData.fapiaopostno];
    self.salesnmLabel.text = customerData.salesnm;
    self.shibienoLabel.text = customerData.shibieno;
    self.paternernoLabel.text = customerData.paternerno;
    self.groupnmLabel.text = customerData.groupnm;
    self.taxnoLabel.text = customerData.taxno;
}

@end
