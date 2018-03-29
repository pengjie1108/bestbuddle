//
//  TBSelCompanyTableView.h
//  TonBright
//
//  Created by tonbright on 2018/3/29.
//  Copyright © 2018年 jie peng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbsenceTypeEnumModel.h"

@interface TBSelCompanyTableView : UITableView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,copy)void(^seleCompanyBlock)(AbsenceTypeEnumModel *);
@property (nonatomic,strong)NSArray *companyList;
@end
