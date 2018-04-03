//
//  UILabel+CallHeight.h
//  Anjuke2
//
//  Created by 郭宏伟 on 2016/10/19.
//  Copyright © 2016年 anjuke inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UILabel (CallHeight)

+ (BOOL)isSingleLineWithContent:(NSString *)content andFont:(UIFont *)font andWidth:(CGFloat)width;
+ (CGFloat)calllHeightWithContent:(NSString *)content andLineNumber:(NSInteger)lineNumber andFont:(UIFont *)font;
+ (CGFloat)calllHeightWithContent:(NSString *)content andLineNumber:(NSInteger)lineNumber andFont:(UIFont *)font andWidth:(CGFloat)width;
+ (CGFloat)callHeightAttributeWithContent:(NSString *)content andFont:(UIFont *)font andLineNumber:(NSInteger)lineNumber andLineSpace:(NSInteger)spaceNumber;
+ (CGFloat)callHeightAttributeWithContent:(NSString *)content andFont:(UIFont *)font andLineNumber:(NSInteger)lineNumber andLineSpace:(NSInteger)spaceNumber andWidth:(CGFloat)width;
+ (NSAttributedString *)fetchAttributedStringWithContent:(NSString *)content andLineSpace:(NSInteger)lineSpace;
@end
