//
//  TBSelCompanyCell.h
//  TonBright
//
//  Created by tonbright on 2018/3/29.
//  Copyright © 2018年 jie peng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbsenceTypeEnumModel.h"
@interface TBSelCompanyCell : UITableViewCell
@property (nonatomic,strong)AbsenceTypeEnumModel *seleComModel;
@property (weak, nonatomic) IBOutlet UILabel *lbe_company;
@end
