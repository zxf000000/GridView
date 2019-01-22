//
// Created by 云舟02 on 2019-01-22.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import "YZLengreCell.h"
#import "YZMovementsView.h"
#import "YZFucai3DYilouMovementsDataSource.h"

NSString *const YZLengreCellID = @"YZLengreCell";

@interface YZLengreCell ()

@property(nonatomic, strong) YZMovementsView *movementsView;
@property(nonatomic, strong) YZFucai3DYilouMovementsDataSource *movementsDataSource;
@property(nonatomic, strong) UILabel *titleLabel;
@end

@implementation YZLengreCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _movementsDataSource = [[YZFucai3DYilouMovementsDataSource alloc] init];
        _movementsDataSource.itemSize = CGSizeMake(frame.size.width / 5.f, 30.f);
        [self setupUI];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}

- (void)setDatas:(id)datas {
    _datas = datas;
    _movementsDataSource.datas = _datas;
    _movementsDataSource.columnCount = 5;
    [_movementsView reloadData];
}

- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];

    _movementsView = [[YZMovementsView alloc] initWithDelegate:self.movementsDataSource];
    [self.contentView addSubview:_movementsView];

    _titleLabel = [[UILabel alloc]init];
    _titleLabel.backgroundColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor = [UIColor colorWithWhite:0.4 alpha:1];
    [self.contentView addSubview:_titleLabel];
}

- (void)layoutSubviews {
    _movementsView.frame = CGRectMake(0, 40, self.bounds.size.width, self.bounds.size.height - 40);
//    [_movementsView reloadData];

    _titleLabel.frame = CGRectMake(15, 0, self.bounds.size.width - 15, 40);

}

@end