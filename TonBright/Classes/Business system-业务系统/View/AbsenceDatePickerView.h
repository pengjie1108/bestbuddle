//
//  AbsenceDatePickerView.h
//  SFASalesReport
//
//  Created by yy on 2017/2/16.
//  Copyright © 2017年 Jonas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AbsenceDatePickerView : UIView

typedef void (^BtnClick)(NSString *);

//点击取消按钮
@property (nonatomic, copy) BtnClick noClick;

//点击确定按钮
@property (nonatomic, copy) BtnClick yesClick;

//时间格式
@property (nonatomic, assign) NSInteger dateType;

//初始化
+ (AbsenceDatePickerView *)absenceDatePickerView;

@end
