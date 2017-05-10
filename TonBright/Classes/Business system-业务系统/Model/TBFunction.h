//
//  TBFunction.h
//  TonBright
//
//  Created by jie peng on 2017/5/10.
//  Copyright © 2017年 jie peng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBFunction : NSObject

@property (nonatomic,copy) NSString *functionnm;

@property (nonatomic,assign) NSInteger *functionorder;

@property (nonatomic,copy) NSString *functionurl;

- (instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype) functionWithDict:(NSDictionary *)dict;


@end
