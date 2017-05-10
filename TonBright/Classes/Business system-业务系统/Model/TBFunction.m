//
//  TBFunction.m
//  TonBright
//
//  Created by jie peng on 2017/5/10.
//  Copyright © 2017年 jie peng. All rights reserved.
//

#import "TBFunction.h"

@implementation TBFunction

- (instancetype)initWithDict:(NSDictionary *)dict{
    
    self = [super init];

    if (self) {

        [self setValuesForKeysWithDictionary:dict];
    }

    return self;
}


+ (instancetype)functionWithDict:(NSDictionary *)dict{
    
    return [[self alloc]initWithDict:dict];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
