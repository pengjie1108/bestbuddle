//
//  UIView+PJExtension.m
//  TonBright
//
//  Created by jie peng on 2017/5/2.
//  Copyright © 2017年 jie peng. All rights reserved.
//

#import "UIView+PJExtension.h"

@implementation UIView (PJExtension)

- (CGSize)pj_size{
    return self.frame.size;
}

-(void)setPj_size:(CGSize)pj_size{
    CGRect frame = self.frame;
    frame.size = pj_size;
    self.frame = frame;
}

- (CGFloat)pj_width{
    return self.frame.size.width;
}

- (CGFloat)pj_height{
    return self.frame.size.height;
}

- (void)setPj_width:(CGFloat)pj_width{
    CGRect frame = self.frame;
    frame.size.width = pj_width;
    self.frame = frame;
}

- (void)setPj_height:(CGFloat)pj_height{
    CGRect frame = self.frame;
    frame.size.height = pj_height;
    self.frame = frame;
}

- (CGFloat)pj_x{
    return self.frame.origin.x;
}

- (void)setPj_x:(CGFloat)pj_x{
    CGRect frame = self.frame;
    frame.origin.x = pj_x;
    self.frame = frame;
}

- (CGFloat)pj_y{
    return self.frame.origin.y;
}

- (void)setPj_y:(CGFloat)pj_y{
    CGRect frame = self.frame;
    frame.origin.y = pj_y;
    self.frame = frame;
}

- (CGFloat)pj_centerX{
    return self.center.x;
}

- (void)setPj_centerX:(CGFloat)pj_centerX{
    CGPoint center = self.center;
    center.x = pj_centerX;
    self.center = center;
}

- (CGFloat)pj_centerY{
    return self.center.y;
}

- (void)setPj_centerY:(CGFloat)pj_centerY{
    CGPoint center = self.center;
    center.y = pj_centerY;
    self.center = center;
}

- (CGFloat)pj_right{

    return CGRectGetMaxX(self.frame);
}

- (CGFloat)pj_bottom{

    return CGRectGetMaxY(self.frame);
}

- (void)setPj_right:(CGFloat)pj_right{
    self.pj_x = pj_right - self.pj_width;
    
}

-(void)setPj_bottom:(CGFloat)pj_bottom{
    self.pj_y = pj_bottom - self.pj_height;
}

@end
