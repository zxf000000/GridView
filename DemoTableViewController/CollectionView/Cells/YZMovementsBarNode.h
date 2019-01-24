//
// Created by 云舟02 on 2019-01-23.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "YZMovementsModel.h"

@interface YZMovementsBarNode : ASCellNode

@property(nonatomic, strong) YZMovementsModel *model;

- (instancetype)initWithModel:(YZMovementsModel *)model;

@end