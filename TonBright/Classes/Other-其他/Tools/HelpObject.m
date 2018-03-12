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
@end
