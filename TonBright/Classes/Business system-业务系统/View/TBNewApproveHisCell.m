//
//  TBNewApproveHisCell.m
//  TonBright
//
//  Created by tonbright on 2018/4/3.
//  Copyright © 2018年 jie peng. All rights reserved.
//

#import "TBNewApproveHisCell.h"

@implementation TBNewApproveHisCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setApproveHisString:(NSString *)approveHisString {
    _approveHisString = approveHisString;
    _lbe_his.text = approveHisString;
}

@end
