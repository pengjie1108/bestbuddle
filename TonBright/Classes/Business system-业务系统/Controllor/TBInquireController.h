//
//  TBInquireController.h
//  TonBright
//
//  Created by jie peng on 2018/2/22.
//  Copyright © 2018年 jie peng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TBInquireData;
@class AbsenceApplyModel;

@protocol TBContractListProtocol <NSObject>

- (void)getData:(NSDictionary *)conditionDictionary;

@end

@interface TBInquireController : UITableViewController

@property (nonatomic,strong) NSDictionary *conditionDictionary;

@property (nonatomic, weak) id<TBContractListProtocol> delegate;

@property (nonatomic,strong) TBInquireData *inquireData;

/**
 编辑cell时候传过来的模型----
 */
@property (nonatomic,strong)AbsenceApplyModel *absenceApplyModel;

@end
