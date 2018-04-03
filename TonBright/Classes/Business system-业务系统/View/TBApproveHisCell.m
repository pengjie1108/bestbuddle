//
//  TBApproveHisCell.m
//  TonBright
//
//  Created by jie peng on 2018/3/8.
//  Copyright © 2018年 jie peng. All rights reserved.
//

#import "TBApproveHisCell.h"
#import "UILabel+CallHeight.h"
#define MAS_SHORTHAND
//可以自动装箱基本数据类型,//使用后可以不适用前缀mas_
#define MAS_SHORTHAND_GLOBALS
#import <Masonry/Masonry.h>

@interface TBApproveHisCell()

@property (nonatomic,strong) UILabel *approveHisLabel;

@end

@implementation TBApproveHisCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _approveHisLabel = [[UILabel alloc] init];
        _approveHisLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_approveHisLabel];
        
        self.approveHisLabel.numberOfLines = 0;
        self.approveHisLabel.text = _approveHisString;
//        self.approveHisLabel.preferredMaxLayoutWidth = SreenWidth - 50;

    }
    return self;
}



//- (UILabel *)approveHisLabel{
//    if (!_approveHisLabel) {
//        _approveHisLabel = [[UILabel alloc] init];
//        _approveHisLabel.font = [UIFont systemFontOfSize:13];
//        [self.contentView addSubview:_approveHisLabel];
//    }
//    return _approveHisLabel;
//}

- (void)setApproveHisString:(NSString *)approveHisString{
    _approveHisString = approveHisString;
    
    self.approveHisLabel.numberOfLines = 0;
    self.approveHisLabel.text = approveHisString;
//    CGSize size = [self.approveHisLabel sizeThatFits:CGSizeMake(self.frame.size.width -50, CGFLOAT_MAX)];
//    self.approveHisLabel.pj_size = size;
//    [self.approveHisLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.contentView).with.offset(14);
//        make.left.mas_equalTo(self.contentView).with.offset(25);
//        make.right.mas_equalTo(self.contentView).with.offset(-25);
//        make.bottom.mas_equalTo(self.contentView).with.offset(14);
//    }];
//    [self.approveHisLabel sizeToFit];
    CGFloat height = [UILabel calllHeightWithContent:_approveHisString andLineNumber:0 andFont:[UIFont systemFontOfSize:13] andWidth:SreenWidth-46];
    [self.approveHisLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.greaterThanOrEqualTo(5);
        make.height.equalTo(height);
        make.centerY.offset(0);
        make.leading.offset(15);
        make.trailing.offset(-15);
        make.bottom.lessThanOrEqualTo(-5);
        //            make.top.mas_equalTo(self.contentView).with.offset(13);
        //            make.left.mas_equalTo(self.contentView).with.offset(25);
        //            make.right.mas_equalTo(self.contentView).with.offset(-25);
        //            make.bottom.mas_equalTo(self.contentView).with.offset(-2);
    }];
    [self.approveHisLabel sizeToFit];

    [self setNeedsLayout];
    [self layoutIfNeeded];
}

@end
