//
//  AbsenceDatePickerView.m
//  SFASalesReport
//
//  Created by yy on 2017/2/16.
//  Copyright © 2017年 Jonas. All rights reserved.
//

#import "AbsenceDatePickerView.h"

#import "HelpObject.h"

@interface AbsenceDatePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIDatePicker *timePick;

@end

@implementation AbsenceDatePickerView

//初始化
+ (AbsenceDatePickerView *)absenceDatePickerView {
    return [[NSBundle mainBundle] loadNibNamed:@"AbsenceDatePickerView" owner:nil options:nil].lastObject;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

//点击确定按钮
- (IBAction)yesBtnClick:(id)sender {
    if (_dateType) {
        NSString *dateString = [[HelpObject manager] getCurentTime:@"yyyy-MM-dd " dateN:_timePick.date];
        _yesClick(dateString);
    } else {
        _yesClick([[HelpObject manager] getCurentTime:@"HH:mm" dateN:_timePick.date]);
    }
}

//点击取消按钮
- (IBAction)cancleBtnClick:(id)sender {
    _noClick(@"");
}

- (void)setDateType:(NSInteger)dateType {
    _dateType = dateType;
    if (dateType == 1) {
        _timePick.datePickerMode = UIDatePickerModeDate;
    }
    if (dateType == 2) {
        _timePick.datePickerMode = UIDatePickerModeDate;
    }
    
}


@end
