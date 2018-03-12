//
//  TBCustomerCaseContentCell.h
//  TonBright
//
//  Created by jie peng on 2018/3/1.
//  Copyright © 2018年 jie peng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TBContractDetailData;
@class TBCustomerData;

@interface TBCustomerCaseContentCell : UITableViewCell

@property (nonatomic,strong) TBContractDetailData *detailData;
@property (nonatomic,strong) TBCustomerData *customerData;

@end
