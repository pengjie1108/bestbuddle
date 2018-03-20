//
//  TBHTTPSessionManager.m
//  TonBright
//
//  Created by jie peng on 2017/5/3.
//  Copyright © 2017年 jie peng. All rights reserved.
//

#import "TBHTTPSessionManager.h"

@implementation TBHTTPSessionManager

- (instancetype)initWithBaseURL:(NSURL *)url{
    
    if (self = [super initWithBaseURL:url]) {
        
    }
    return self;
}

+ (instancetype)manager {
    TBHTTPSessionManager *mgr = [super manager];
    // 创建NSMutableSet对象
    NSMutableSet *newSet = [NSMutableSet set];
    // 添加我们需要的类型
    newSet.set = mgr.responseSerializer.acceptableContentTypes;
    [newSet addObject:@"text/html"];
    
    // 重写给 acceptableContentTypes赋值
    mgr.responseSerializer.acceptableContentTypes = newSet;
    [mgr.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    mgr.requestSerializer.timeoutInterval = 8.f;
    [mgr.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    return mgr;
}


@end
