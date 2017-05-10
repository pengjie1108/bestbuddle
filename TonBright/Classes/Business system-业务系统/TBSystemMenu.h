//
//  TBSystemMenu.h
//  
//
//  Created by jie peng on 2017/5/9.
//
//

#import <Foundation/Foundation.h>

@interface TBSystemMenu : NSObject

@property (nonatomic,strong) NSArray *functions;

@property (nonatomic,copy) NSString *name;

- (instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype) systemMenuWithDict:(NSDictionary *)dict;

@end
