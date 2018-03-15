//
//  HelpObject.m
//  MobileLier
//
//  Created by caoshuaikun on 16/4/13.
//  Copyright © 2016年 com.Mobilizer.name. All rights reserved.
//

#import "HelpObject.h"


static HelpObject *helper = nil;

@implementation HelpObject


+ (HelpObject *)manager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[HelpObject alloc]init];
    });
    return helper;
}


//好的当前时间年月日
- (NSString *)getCurentTime:(NSString *)dateFormateSet dateN:(NSDate *)dateN{
    
    NSDate *date = dateN;
    NSDateFormatter *dateFormate = [[NSDateFormatter alloc]init];
    [dateFormate setDateFormat:dateFormateSet]; //@"YYYY年MM月dd日"];
    return [dateFormate stringFromDate:date];
    
}

//判断字符串是不是空
+ (BOOL)isBlankString:(NSString *)string{
    
    if (string == nil) {
        
        return YES;
        
    }
    
    if (string == NULL) {
        
        return YES;
        
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        
        return YES;
        
    }
    
    return NO;
    
}

+ (NSString *)changeNull:(id)object {
    if ([self isNull:object]) {
        return @"";
    } else {
        return [NSString stringWithFormat:@"%@",object];
    }
}

//完整判断方法
+ (BOOL)isNull:(id)object
{
    // 判断是否为空串
    if ([object isEqual:[NSNull null]]) {
        return YES;
    } else if ([object isKindOfClass:[NSNull class]]) {
        return YES;
    } else if (object==nil) {
        return YES;
    }
    
    return NO;
}

@end
