//
//  TBContractList.h
//  TonBright
//
//  Created by jie peng on 2018/2/12.
//  Copyright © 2018年 jie peng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBContractList : NSObject
/** 合同编号 */
@property (nonatomic,copy) NSString *contractno;
/** 客户名称 */
@property (nonatomic,copy) NSString *customernm;
/** 案件类型 */
@property (nonatomic,copy) NSString *casetypenm;
/** 车架号 */
@property (nonatomic,copy) NSString *chejiano;
/** 租金合计 */
@property (nonatomic,copy) NSString *rentamount;
/** 未收本金 */
@property (nonatomic,copy) NSString *unrecprincipal;
/** 年利率 */
@property (nonatomic,copy) NSString *yearrate;
/** irr */
@property (nonatomic,copy) NSString *irr;
/** 销售担当 */
@property (nonatomic,copy) NSString *salesusernm;
/** 案件状态 */
@property (nonatomic,copy) NSString *casestatusnm;
/** 过会日期 */
@property (nonatomic,copy) NSString *boardpassdate;
/** 案件ID */
@property (nonatomic,copy) NSString *caseid;
@end
