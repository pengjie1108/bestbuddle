//
//  AbsenceTypePickerView.h
//  SFASalesReport
//
//  Created by yy on 2016/12/27.
//  Copyright © 2016年 Jonas. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "PlanModel.h"
#import "AbsenceTypeEnumModel.h"

typedef void (^AbsenceBtnClick)(AbsenceTypeEnumModel *);
@interface AbsenceTypePickerView : UIView

@property (nonatomic, copy) AbsenceBtnClick yesClick;
@property (nonatomic, copy) AbsenceBtnClick noClick;

//内容
@property (nonatomic, strong) NSArray *workContent;

+ (AbsenceTypePickerView *)typePickView;

@end
