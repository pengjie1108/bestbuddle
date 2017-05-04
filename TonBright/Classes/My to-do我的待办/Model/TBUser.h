//
//  TBUser.h
//  TonBright
//
//  Created by jie peng on 2017/5/4.
//  Copyright © 2017年 jie peng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBUser : NSObject

@property (nonatomic,assign) NSInteger cauthtype;

@property (nonatomic,assign) NSInteger gauthtype;

@property (nonatomic,copy) NSString *chiefuserid;

@property (nonatomic,copy) NSString *companyid;

@property (nonatomic,copy) NSString *companyname;

@property (nonatomic,copy) NSString *departmentid;

@property (nonatomic,copy) NSString *departmentname;

@property (nonatomic,copy) NSString *loginname;

@property (nonatomic,copy) NSString *manageruserid;

@property (nonatomic,copy) NSString *tokenid;

@property (nonatomic,copy) NSString *userid;

@property (nonatomic,copy) NSString *topcompanyid;

@property (nonatomic,copy) NSString *usernm;
@end
