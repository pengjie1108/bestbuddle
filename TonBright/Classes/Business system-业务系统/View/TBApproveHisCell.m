//
//  TBApproveHisCell.m
//  TonBright
//
//  Created by jie peng on 2018/3/8.
//  Copyright © 2018年 jie peng. All rights reserved.
//

#import "TBApproveHisCell.h"
#import <Masonry/Masonry.h>

@interface TBApproveHisCell()

@property (nonatomic,strong) UILabel *approveHisLabel;

@end

@implementation TBApproveHisCell

- (UILabel *)approveHisLabel{
    if (!_approveHisLabel) {
        _approveHisLabel = [[UILabel alloc] init];
        _approveHisLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_approveHisLabel];
    }
    return _approveHisLabel;
}

- (void)setApproveHisString:(NSString *)approveHisString{
    _approveHisString = approveHisString;
    
    self.approveHisLabel.numberOfLines = 0;
    self.approveHisLabel.text = approveHisString;
    CGSize size = [self.approveHisLabel sizeThatFits:CGSizeMake(self.frame.size.width -50, CGFLOAT_MAX)];
    self.approveHisLabel.pj_size = size;
    [self.approveHisLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).with.offset(0);
        make.left.mas_equalTo(self.contentView).with.offset(25);
        make.right.mas_equalTo(self.contentView).with.offset(-25);
        make.bottom.mas_equalTo(self.contentView).with.offset(0);
    }];
    [self.approveHisLabel sizeToFit];
    
    [self.approveHisLabel setNeedsLayout];
}
@end
