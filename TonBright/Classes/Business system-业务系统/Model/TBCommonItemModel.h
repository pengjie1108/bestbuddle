//
//  TBCommonItemModel.h
//  TonBright
//
//  Created by jie peng on 2018/2/13.
//  Copyright © 2018年 jie peng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBCommonItemModel : NSObject

@property (copy, nonatomic) NSString *itemId;
@property (copy, nonatomic) NSString *itemName;
@property (assign, nonatomic) BOOL selected;

@end
