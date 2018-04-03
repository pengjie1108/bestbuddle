//
//  TBConst.m
//  TonBright
//
//  Created by jie peng on 2018/4/3.
//  Copyright © 2018年 jie peng. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 通用的间距值 */
CGFloat const TBMargin = 10;
/** 通用的小间距值 */
CGFloat const TBSmallMargin = TBMargin * 0.5;

#ifdef __OBJC__


#ifdef DEBUG

NSString * const TBContractListURL = @"http://192.168.1.65/nbsst/api/api.caseinfo.list.php";
NSString * const TBLoginURL = @"http://192.168.1.65/nbsst/api/api.m.user.login.php";
NSString * const TBCompanyListURL = @"http://192.168.1.65/nbsst/api/api.company.list.php";
NSString * const TBContractDetailURL = @"http://192.168.1.65/nbsst/api/api.caseinfo.get.php";
NSString * const TBCustomerDetailURL = @"http://192.168.1.65/nbsst/api/api.custome.get.php";

#else

NSString * const TBContractListURL = @"http://203.156.252.183:81/nbs/api/api.caseinfo.list.php";
NSString * const TBLoginURL = @"http://203.156.252.183:81/nbs/api/api.m.user.login.php";
NSString * const TBCompanyListURL = @"http://203.156.252.183:81/nbs/api/api.company.list.php";
NSString * const TBContractDetailURL = @"http://203.156.252.183:81/nbs/api/api.caseinfo.get.php";
NSString * const TBCustomerDetailURL = @"http://203.156.252.183:81/nbs/api/api.custome.get.php";

#endif

#endif

