//
// Created by 云舟02 on 2019-01-23.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import "YZMovementsBarNode.h"


@interface YZMovementsBarNode ()

@property(nonatomic, strong) ASDisplayNode *barNode;

@end

@implementation YZMovementsBarNode
- (instancetype)initWithModel:(YZMovementsModel *)model {
    if (self = [super init]) {
        _model = model;
        _barNode = [[ASDisplayNode alloc] init];
        _barNode.backgroundColor = [UIColor redColor];
        [self addSubnode:_barNode];

        if (model.row % 2 == 0) {
            self.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        } else {
            self.backgroundColor = [UIColor colorWithRed:248/255.0 green:247/255.0 blue:243/255.0 alpha:1.0];
        }
    }
    return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    CGSize maxSize = constrainedSize.max;
    CGFloat percent = self.model.percent * 3;
    UIEdgeInsets insets =
    UIEdgeInsetsMake(5, 0, 5, maxSize.width * (1-percent));

    ASInsetLayoutSpec *insetLayout = [ASInsetLayoutSpec insetLayoutSpecWithInsets:insets child:_barNode];
    return insetLayout;

}

@end