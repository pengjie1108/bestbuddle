//
//  UILabel+CallHeight.m
//  Anjuke2
//
//  Created by 郭宏伟 on 2016/10/19.
//  Copyright © 2016年 anjuke inc. All rights reserved.
//

#import "UILabel+CallHeight.h"

@implementation UILabel (CallHeight)

+ (BOOL)isSingleLineWithContent:(NSString *)content andFont:(UIFont *)font andWidth:(CGFloat)width
{
    CGFloat heightMe = [self calllHeightWithContent:@"测试" andLineNumber:0 andFont:font andWidth:width];
    CGFloat heightContent = [self calllHeightWithContent:content andLineNumber:0 andFont:font andWidth:width];
    if (heightMe == heightContent) {
        return YES;
    } else {
        return NO;
    }
}

+ (CGFloat)calllHeightWithContent:(NSString *)content
                    andLineNumber:(NSInteger)lineNumber
                          andFont:(UIFont *)font
{
    return  [self calllHeightWithContent:content
                           andLineNumber:lineNumber
                                 andFont:font
                                andWidth:SreenWidth - 30];
}

+ (CGFloat)calllHeightWithContent:(NSString *)content andLineNumber:(NSInteger)lineNumber andFont:(UIFont *)font andWidth:(CGFloat)width
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, CGFLOAT_MAX)];
    label.font = font;
    label.numberOfLines = lineNumber;
    label.text = content;
    CGRect frameTemp = label.frame;
    CGRect rect;
    rect = [label textRectForBounds:frameTemp limitedToNumberOfLines:lineNumber];
    return ceilf(CGRectGetHeight(rect));
}


+ (CGFloat)callHeightAttributeWithContent:(NSString *)content
                                   andFont:(UIFont *)font
                             andLineNumber:(NSInteger)lineNumber
                              andLineSpace:(NSInteger)spaceNumber
{
    return [self callHeightAttributeWithContent:content
                                        andFont:font
                                  andLineNumber:lineNumber
                                   andLineSpace:spaceNumber
                                       andWidth:(SreenWidth - 30)];
}

+ (CGFloat)callHeightAttributeWithContent:(NSString *)content
                                  andFont:(UIFont *)font
                            andLineNumber:(NSInteger)lineNumber
                             andLineSpace:(NSInteger)spaceNumber
                                 andWidth:(CGFloat)width
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, CGFLOAT_MAX)];
    label.font = font;
    label.numberOfLines = lineNumber;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:spaceNumber];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, content.length)];
    label.attributedText = attributedString;
    CGRect frameTemp = label.frame;
    CGRect rect;
    rect = [label textRectForBounds:frameTemp limitedToNumberOfLines:lineNumber];
    
    return ceilf(CGRectGetHeight(rect));
}

+ (NSAttributedString *)fetchAttributedStringWithContent:(NSString *)content andLineSpace:(NSInteger)lineSpace
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [content length])];
    return attributedString;
}

@end
