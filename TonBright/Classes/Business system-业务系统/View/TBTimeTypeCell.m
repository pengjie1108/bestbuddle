//
//  TBTimeTypeCell.m
//  TonBright
//
//  Created by jie peng on 2018/2/23.
//  Copyright © 2018年 jie peng. All rights reserved.
//

#import "TBTimeTypeCell.h"

@interface TBTimeTypeCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeDetailL;
@property (weak, nonatomic) IBOutlet UILabel *headTitleL;
@property (weak, nonatomic) IBOutlet UIImageView *downImage;

@end

@implementation TBTimeTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//初始化
+ (TBTimeTypeCell *)timeTypeCellWithTableView:(UITableView *)tableView {
    TBTimeTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TBTimeTypeCell"];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"TBTimeTypeCell" owner:nil options:nil].lastObject;
    }
    return cell;
}

//选择时间
- (IBAction)timeSelect:(id)sender {
    if ([self.delegate respondsToSelector:@selector(timeTypeCellDidSelectTime:PickType:)]) {
        [self.delegate timeTypeCellDidSelectTime:_row PickType:_pickType];
    }
}

- (void)setHideDownBtn:(BOOL)hideDownBtn {
    _hideDownBtn = hideDownBtn;
    _downImage.hidden = hideDownBtn;
}

- (void)setHeadTitle:(NSString *)headTitle {
    _headTitle = headTitle;
    _headTitleL.text = headTitle;
}

- (void)setTimeTitle:(NSString *)timeTitle {
    _timeTitle = timeTitle;
    _timeDetailL.text = timeTitle;
}

@end
