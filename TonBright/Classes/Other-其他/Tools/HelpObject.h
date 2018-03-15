//
//  HelpObject.h
//  MobileLier
//
//  Created by caoshuaikun on 16/4/13.
//  Copyright © 2016年 com.Mobilizer.name. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HelpObject : NSObject

+ (HelpObject *)manager;

- (NSString *)getCurentTime:(NSString *)dateFormateSet dateN:(NSDate *)dateN;
+ (BOOL)isBlankString:(NSString *)string;
+ (NSString *)changeNull:(id)object;
@end
