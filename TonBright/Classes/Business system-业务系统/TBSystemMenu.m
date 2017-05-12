//
//  TBSystemMenu.m
//  
//
//  Created by jie peng on 2017/5/9.
//
//

#import "TBSystemMenu.h"
#import "TBFunction.h"

@implementation TBSystemMenu

- (void)setFunctions:(NSArray *)functions{
    
    NSMutableArray *tempArray = [NSMutableArray array];
    
    for (NSDictionary *dict in functions) {
        [tempArray addObject:[TBFunction functionWithDict:dict]];
    }
    _functions = tempArray;
}


- (instancetype)initWithDict:(NSDictionary *)dict{
    
    self = [super init];

    if (self) {
        if (dict) {
            [self setValuesForKeysWithDictionary:dict];

        }
        
      }

    return self;
    
}


+ (instancetype)systemMenuWithDict:(NSDictionary *)dict{
    
    return [[self alloc]initWithDict:dict];
}


@end
