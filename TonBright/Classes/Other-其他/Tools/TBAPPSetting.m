//
//  TBAPPSetting.m
//  TonBright
//
//  Created by jie peng on 2017/5/5.
//  Copyright © 2017年 jie peng. All rights reserved.
//

#import "TBAPPSetting.h"
#import <SSKeychain/SSKeychain.h>

@interface TBAPPSetting ()

@property (nonatomic, strong) NSUserDefaults *userDefault;

@end

@implementation TBAPPSetting

+ (instancetype)shareAppSetting{
    
    static TBAPPSetting *shareAppSetting = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareAppSetting = [[self alloc] init];
    });
    
    return shareAppSetting;
}

- (instancetype)init{
    
    if (self = [super init]) {
        _userDefault = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

- (NSString *)loginname{
    return [self.userDefault objectForKey:LOGINNAME_KEY];
}

- (NSString *)tokenid{
    return [self.userDefault objectForKey:TOKENID_KEY];
}

- (NSInteger)cauthtype{
    return [[self.userDefault objectForKey:CAUTHTYPE_KEY] intValue];
}

- (NSInteger)gauthtype{
    return [[self.userDefault objectForKey:GAUTHTYPE_KEY] intValue];
}

- (NSString *)userid{
    return [self.userDefault objectForKey:USERID_KEY];
}

- (NSString *)topcompanyid{
    return [self.userDefault objectForKey:TOPCOMPANYID_KEY];
}

- (NSString *)usernm{
    return [self.userDefault objectForKey:USERNM_KEY];
}

- (NSString *)passwordForUserName:(NSString *)userName{
    return [SSKeychain passwordForService:SERVICENAME account:userName];
}

- (NSArray *)userrole{
    return [self.userDefault objectForKey:USERROLE_KEY];
}

- (NSArray *)userfunction{
    return [self.userDefault objectForKey:USERFUNCTION_KEY];
}

- (NSString *)companyname{
    return [self.userDefault objectForKey:COMPANYNAME_KEY];
}

- (NSString *)companyid{
     return [self.userDefault objectForKey:COMPANYID_KEY];
}

- (NSString *)departmentname{
    return [self.userDefault objectForKey:DEPARTMENTNAME_KEY];
}


- (void)setLoginname:(NSString *)loginname{
    [self.userDefault setObject:loginname forKey:LOGINNAME_KEY];
    [self.userDefault synchronize];
}

- (void)setTokenid:(NSString *)tokenid{
    [self.userDefault setObject:tokenid forKey:TOKENID_KEY];
    [self.userDefault synchronize];
}

- (void)setCauthtype:(NSInteger)cauthtype{
    [self.userDefault setObject:[NSNumber numberWithInteger:cauthtype] forKey:CAUTHTYPE_KEY];
    [self.userDefault synchronize];
}

- (void)setGauthtype:(NSInteger)gauthtype{
    [self.userDefault setObject:[NSNumber numberWithInteger:gauthtype] forKey:GAUTHTYPE_KEY];
    [self.userDefault synchronize];
}

- (void)setUserid:(NSString *)userid{
    [self.userDefault setObject:userid forKey:USERID_KEY];
    [self.userDefault synchronize];
}

- (void)setTopcompanyid:(NSString *)topcompanyid{
    [self.userDefault setObject:topcompanyid forKey:TOPCOMPANYID_KEY];
    [self.userDefault synchronize];
}

- (void)setUsernm:(NSString *)usernm{
    [self.userDefault setObject:usernm forKey:USERNM_KEY];
    [self.userDefault synchronize];
}

- (void)setPassword:(NSString *)password userName:(NSString *)userName{
    [SSKeychain setPassword:password forService:SERVICENAME account:userName];
}

- (void)setUserrole:(NSArray *)userrole{
    [self.userDefault setObject:userrole forKey:USERROLE_KEY];
    [self.userDefault synchronize];
}

- (void)setUserfunction:(NSArray *)userfunction{
    [self.userDefault setObject:userfunction forKey:USERFUNCTION_KEY];
    [self.userDefault synchronize];
}

- (void)setCompanyname:(NSString *)companyname{
    [self.userDefault setObject:companyname forKey:COMPANYNAME_KEY];
    [self.userDefault synchronize];
}

- (void)setCompanyid:(NSString *)companyid{
    [self.userDefault setObject:companyid forKey:COMPANYID_KEY];
    [self.userDefault synchronize];
}

- (void)setDepartmentname:(NSString *)departmentname{
    [self.userDefault setObject:departmentname forKey:DEPARTMENTNAME_KEY];
    [self.userDefault synchronize];
}

@end
