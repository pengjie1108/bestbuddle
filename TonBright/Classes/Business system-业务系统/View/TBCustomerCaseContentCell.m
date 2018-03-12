//
//  TBCustomerCaseContentCell.m
//  TonBright
//
//  Created by jie peng on 2018/3/1.
//  Copyright © 2018年 jie peng. All rights reserved.
//

#import "TBCustomerCaseContentCell.h"
#import "TBContractDetailData.h"
#import "TBCustomerData.h"

@interface TBCustomerCaseContentCell ()

@property (weak, nonatomic) IBOutlet UILabel *mainloannmLabel;
@property (weak, nonatomic) IBOutlet UILabel *mainloanzjnoLabel;
@property (weak, nonatomic) IBOutlet UILabel *hukouLabel;
@property (weak, nonatomic) IBOutlet UILabel *contactaddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *educationLabel;
@property (weak, nonatomic) IBOutlet UILabel *contactInformationLabel;
@property (weak, nonatomic) IBOutlet UILabel *maritalstatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *propertyDataLabel;
@property (weak, nonatomic) IBOutlet UILabel *jinjiDataLabel;
@property (weak, nonatomic) IBOutlet UILabel *customerTypeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *customerDataLabel;
@property (weak, nonatomic) IBOutlet UILabel *creditPlusDataLabel;
@property (weak, nonatomic) IBOutlet UILabel *guarantorlistDataLabel;

@end

@implementation TBCustomerCaseContentCell

- (void)setDetailData:(TBContractDetailData *)detailData{
    _detailData = detailData;
    
    NSDictionary * hukouDict = @{@"1":@"本市",@"2":@"非本市"};
    NSDictionary * sexDict = @{@"1":@"男",@"2":@"女"};
    NSDictionary * educationDict = @{@"1":@"高中以下",@"2":@"高中及大专",@"3":@"本科",@"4":@"本科以上"};
    NSDictionary * maritalstatusDict = @{@"1":@"已婚",@"2":@"其他"};
    NSDictionary * propertybalDict = @{@"1":@"无",@"2":@"<1倍",@"3":@"[1,3)倍",@"4":@"[3,5)倍",@"5":@">=5倍"};
    NSDictionary * hasDict = @{@"1":@"有",@"2":@"无"};
    NSDictionary * jinjirelationDict = @{@"1":@"亲属(除配偶)",@"2":@"朋友",@"3":@"同事",@"4":@"其他"};
    NSDictionary * companypropertyDict = @{@"1":@"事业单位",@"2":@"企业",@"3":@"个体户"};
    NSDictionary * workyearDict = @{@"1":@"<1年",@"2":@"[1,3)年",@"3":@"[3,5)年",@"4":@">5年"};
    NSDictionary * monthincomeDict = @{@"1":@"<1.5倍",@"2":@"[1.5,2.5]倍",@"3":@"(2.5,3.5]倍",@"4":@"[3,5)倍",@"5":@">5倍"};
    NSDictionary * buildyearDict = @{@"1":@"<1年",@"2":@"[1,5]年",@"3":@"(5,10]年",@"4":@">10年"};
    NSDictionary * registeredcapitalDict = @{@"1":@"<100万",@"2":@"[100,500]万",@"3":@"(500,1000]万",@"4":@">1000万"};
    NSDictionary * companyincomeDict = @{@"1":@"<3倍",@"2":@"[3,5]倍",@"3":@"(5,8]倍",@"4":@"(8,10]倍",@"5":@">10倍"};
    NSDictionary * companyprofitDict = @{@"1":@"<2倍",@"2":@"[2,3]倍",@"3":@"(3,4]倍",@"4":@"(4,5]倍",@"5":@">5倍"};
    NSDictionary * pasttradeDict = @{@"1":@"好",@"2":@"中",@"3":@"无"};
    NSDictionary * creditcardlimitDict = @{@"1":@"<2.5万",@"2":@"[2.5,5]万",@"3":@"(5,10]万",@"4":@">10万"};
    NSDictionary * netpropertyDict = @{@"1":@"<1倍",@"2":@"[1,2]倍",@"3":@"(2,3]倍",@"4":@"(3,5]倍",@"5":@">5倍"};
    
    self.mainloannmLabel.text = detailData.mainloannm;
    self.mainloanzjnoLabel.text = detailData.mainloanzjno;
    self.hukouLabel.text = [hukouDict objectForKey:detailData.hukou];
    self.contactaddressLabel.text = detailData.contactaddress;
    self.sexLabel.text = [sexDict objectForKey:detailData.sex];
    self.birthdayLabel.text = detailData.birthday;
    self.educationLabel.text = [educationDict objectForKey: detailData.education];
    self.contactInformationLabel.text = [NSString stringWithFormat:@"公司固话:%@\n手机:%@\nEmail:%@",detailData.companyphone,detailData.mobile,detailData.email];
    self.maritalstatusLabel.text = [maritalstatusDict objectForKey:detailData.maritalstatus];
    self.propertyDataLabel.text = [NSString stringWithFormat:@"房产余额:%@\n原有车辆:%@\n是否按揭:%@",[propertybalDict objectForKey:detailData.propertybal],[hasDict objectForKey:detailData.oldcarcnt],[hasDict objectForKey:detailData.isloan]];
    NSString *jinjiDataString = [NSString string];
    if (detailData.jinji1nm.length) {
        jinjiDataString = [NSString stringWithFormat:@"紧急联系人一:\n姓名:%@\n与联系人关系:%@\n手机:%@",detailData.jinji1nm,[jinjirelationDict objectForKey:detailData.jinji1relation],detailData.jinji1phone];
    }else{
        jinjiDataString = @"无";
    }
    if (detailData.jinji2nm.length) {
        jinjiDataString = [jinjiDataString stringByAppendingString:[NSString stringWithFormat:@"\n紧急联系人二:\n姓名:%@\n与联系人关系:%@\n手机:%@",detailData.jinji1nm,[jinjirelationDict objectForKey:detailData.jinji1relation],detailData.jinji1phone]];
    }
    self.jinjiDataLabel.text = jinjiDataString;
    NSString *customerDataString = [NSString string];
    if (self.customerData.customertype.intValue == 1) {
        self.customerTypeNameLabel.text = @"个人客户信息";
        customerDataString = [NSString stringWithFormat:@"公司性质:%@\n从业年限:%@\n税单:%@\n身份证地址:%@\n平均月收入:%@",[companypropertyDict objectForKey:detailData.companyproperty],[workyearDict objectForKey:detailData.workyear],[hasDict objectForKey:detailData.taxreceipt],detailData.iccardaddress,[monthincomeDict objectForKey:detailData.monthincome]];
    }else if (self.customerData.customertype.intValue == 2){
        self.customerTypeNameLabel.text = @"企业客户信息";
        customerDataString = [NSString stringWithFormat:@"成立年限:%@\n注册资本:%@\n收入:%@\n利润:%@\n主贷人是否担保人:%@",[buildyearDict objectForKey:detailData.buildyear],[registeredcapitalDict objectForKey:detailData.registeredcapital],[companyincomeDict objectForKey:detailData.companyincome],[companyprofitDict objectForKey:detailData.companyprofit],[hasDict objectForKey:detailData.isguarantor]];
    }
    self.customerDataLabel.text = customerDataString;
    self.creditPlusDataLabel.text = [NSString stringWithFormat:@"过往交易:%@\n信用卡最高额度:%@\n多套住房余额:%@",[pasttradeDict objectForKey:detailData.pasttrade],[creditcardlimitDict objectForKey:detailData.creditcardlimit],[companyprofitDict objectForKey:detailData.manypropertybal]];
    NSString *guarantorDataString = [NSString string];
    if (detailData.guarantorlist.count) {
        int i = 0;
        for (TBGuarantorlist *guarantorDate in detailData.guarantorlist) {
            i ++;
            if (guarantorDate.guarantorid.length) {
                guarantorDataString = [guarantorDataString stringByAppendingString:[NSString stringWithFormat:@"担保人%d信息:\n",i]];
                guarantorDataString = [guarantorDataString stringByAppendingString:[NSString stringWithFormat:@"姓名:%@     性别:%@\n与被担保人关系:%@\n证件号:%@\n户口所在地:%@\n行业职业:%@\n联系地址:%@\n联系邮编:%@\n联系电话:%@\n手机:%@\n平均月收入:%@\n净资产:%@",
                                       guarantorDate.guarantornm,
                                       [sexDict objectForKey:guarantorDate.sex],
                                       [jinjirelationDict objectForKey:guarantorDate.relation],
                                       guarantorDate.zjno,
                                       [hukouDict objectForKey:guarantorDate.hukou],
                                       guarantorDate.industry,
                                       guarantorDate.contactaddress,
                                       guarantorDate.contactpostno,
                                       guarantorDate.phone,
                                       guarantorDate.mobile,
                                       [monthincomeDict objectForKey:guarantorDate.monthincome],
                                       [netpropertyDict objectForKey:guarantorDate.netproperty]]];
                if(detailData.guarantorlist.count > 1 && i < detailData.guarantorlist.count){
                    guarantorDataString = [guarantorDataString stringByAppendingString:@"\n\n"];
                }
            }
            }
    }else{
        guarantorDataString = @"无";
    }
    self.guarantorlistDataLabel.text = guarantorDataString;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
