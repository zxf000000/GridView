//
//  YZMovementsNormalCellNode.h
//  DemoTableViewController
//
//  Created by 云舟02 on 2019/1/23.
//  Copyright © 2019 云舟02. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "YZMovementsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YZMovementsNormalCellNode : ASCellNode

@property (nonatomic, copy) NSString *title;

- (instancetype)initWithModel:(YZMovementsModel *)model;

@property(nonatomic, strong) YZMovementsModel *model;

@end

NS_ASSUME_NONNULL_END
