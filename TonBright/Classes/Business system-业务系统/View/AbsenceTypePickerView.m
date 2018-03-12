//
//  AbsenceTypePickerView.m
//  SFASalesReport
//
//  Created by yy on 2016/12/27.
//  Copyright © 2016年 Jonas. All rights reserved.
//

#import "AbsenceTypePickerView.h"

@interface AbsenceTypePickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *typePick;
@property (nonatomic, strong) AbsenceTypeEnumModel *detailType;
@end

@implementation AbsenceTypePickerView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.typePick.delegate = self;
    self.typePick.dataSource = self;
}

+ (AbsenceTypePickerView *)typePickView {
    return [[NSBundle mainBundle] loadNibNamed:@"AbsenceTypePickerView" owner:nil options:nil].lastObject;
}

- (void)setWorkContent:(NSArray *)workContent {
    _workContent = workContent;
    _detailType = workContent[0];
    [_typePick reloadAllComponents];
}

- (IBAction)yesBtnClick:(id)sender {
    _yesClick(_detailType);
}

- (IBAction)noBtnClick:(id)sender {
    _noClick(nil);
}

#pragma mark pickViewDateSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _workContent.count;
}

#pragma mark pickViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    AbsenceTypeEnumModel *plan = _workContent[row];
    return plan.parameterValue;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _detailType = _workContent[row];
    
}

@end
