//
//  TBInquireData.h
//  TonBright
//
//  Created by jie peng on 2018/3/9.
//  Copyright © 2018年 jie peng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBInquireData : NSObject

@property (nonatomic,copy)NSString *Type;

/**
租赁期开始日from
 */
@property (nonatomic,copy)NSString *loanstartdatef;

/**
 租赁期开始日to
 */
@property (nonatomic,copy)NSString *loanstartdatet;

/**
起租确认日from
 */
@property (nonatomic,copy)NSString *loanconfirmdatef;

/**
起租确认日to
 */
@property (nonatomic,copy)NSString *loanconfirmdatet;

/**
 结清日from
 */
@property (nonatomic,copy)NSString *settleamounttimef;

/**
结清日to
 */
@property (nonatomic,copy)NSString *settleamounttimet;
/**
 状态
 */
@property (nonatomic,copy)NSString *casestatus;
/**
 状态对应键值
 */
@property (nonatomic,copy)NSString *casestatusKey;

/**
合同类型
 */
@property (nonatomic,copy)NSString *casetype;

/**
 合同类型键值
 */
@property (nonatomic,copy)NSString *casetypeKey;


@end
