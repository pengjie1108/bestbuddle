//
//  TBTimeTypeCell.h
//  TonBright
//
//  Created by jie peng on 2018/2/23.
//  Copyright © 2018年 jie peng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TBTimeTypeCellDelegate <NSObject>

@optional

- (void)timeTypeCellDidSelectTime:(NSInteger)row PickType:(NSInteger)pickType;

@end

@interface TBTimeTypeCell : UITableViewCell

//隐藏向下的箭头
@property (nonatomic, assign) BOOL hideDownBtn;

//pick类型  0 时间  1 会议内容
@property (nonatomic, assign) NSInteger pickType;

//行数
@property (nonatomic, assign) NSInteger row;

//标题
@property (nonatomic, copy) NSString *headTitle;

//时间
@property (nonatomic, copy) NSString *timeTitle;

//delegate
@property (nonatomic, weak) id<TBTimeTypeCellDelegate> delegate;

//初始化
+ (TBTimeTypeCell *)timeTypeCellWithTableView:(UITableView *)tableView;

@end
