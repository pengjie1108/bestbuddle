//
//  TBAPPSetting.h
//  TonBright
//
//  Created by jie peng on 2017/5/5.
//  Copyright © 2017年 jie peng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBAPPSetting : NSObject

@property (nonatomic,copy) NSString *loginname;

@property (nonatomic,copy) NSString *tokenid;

@property (nonatomic,assign) NSInteger cauthtype;

@property (nonatomic,assign) NSInteger gauthtype;

@property (nonatomic,copy) NSString *userid;

@property (nonatomic,copy) NSString *topcompanyid;

@property (nonatomic,copy) NSString *usernm;

@property (nonatomic,strong) NSArray *userrole;

@property (nonatomic,strong) NSArray *userfunction;

+ (instancetype)shareAppSetting;

- (NSString *)passwordForUserName:(NSString *)userName;

- (void)setPassword:(NSString *)password userName:(NSString *)userName;

@end
