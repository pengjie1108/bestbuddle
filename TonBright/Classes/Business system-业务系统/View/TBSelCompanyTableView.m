//
//  TBSelCompanyTableView.m
//  TonBright
//
//  Created by tonbright on 2018/3/29.
//  Copyright © 2018年 jie peng. All rights reserved.
//

#import "TBSelCompanyTableView.h"
#import "TBSelCompanyCell.h"
@implementation TBSelCompanyTableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //注册nib文件
        //注册xib---不注册需要loadNibName来使用
        UINib *nib = [UINib nibWithNibName:@"TBSelCompanyCell" bundle:nil];
        [self registerNib:nib forCellReuseIdentifier:@"TBSelCompanyCellId"];
        self.delegate = self;
        self.dataSource = self;
        self.rowHeight = UITableViewAutomaticDimension;
        self.estimatedRowHeight = 60;
        self.backgroundColor = [UIColor whiteColor];
        self.tableFooterView = [UIView new];
    }
    return self;
}

- (void)setCompanyList:(NSArray *)companyList {
    _companyList = companyList;
    [self reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.companyList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TBSelCompanyCell *selectComCell = [tableView dequeueReusableCellWithIdentifier:@"TBSelCompanyCellId" forIndexPath:indexPath];
    
    //赋值-----
    AbsenceTypeEnumModel *seleModel = self.companyList[indexPath.row];
    selectComCell.seleComModel = seleModel;
    return selectComCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AbsenceTypeEnumModel *seleModel = self.companyList[indexPath.row];
    if (self.seleCompanyBlock) {
        self.seleCompanyBlock(seleModel);
    }
}

@end
