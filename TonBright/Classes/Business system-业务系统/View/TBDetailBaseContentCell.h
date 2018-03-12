//
//  TBDetailBaseContentCell.h
//  TonBright
//
//  Created by jie peng on 2018/2/26.
//  Copyright © 2018年 jie peng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TBContractDetailData;


@interface TBDetailBaseContentCell : UITableViewCell

@property (nonatomic,strong) TBContractDetailData *contractDetailData;

@property (weak, nonatomic) IBOutlet UILabel *applyremarksLabel;
@property (weak, nonatomic) IBOutlet UILabel *contractnoLabel;
@property (weak, nonatomic) IBOutlet UILabel *companynmLabel;
@property (weak, nonatomic) IBOutlet UILabel *casetypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *customernmLabel;
@property (weak, nonatomic) IBOutlet UILabel *maincontractnoLabel;
@property (weak, nonatomic) IBOutlet UILabel *customersourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *invoicetypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *casestatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *frontvendornmLabel;
@property (weak, nonatomic) IBOutlet UILabel *rentinvoicetypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *settleinvflgLabel;

@end
