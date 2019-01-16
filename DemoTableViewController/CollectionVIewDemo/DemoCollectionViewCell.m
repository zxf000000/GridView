//
//  DemoCollectionViewCell.m
//  DemoTableViewController
//
//  Created by 云舟02 on 2019/1/15.
//  Copyright © 2019 云舟02. All rights reserved.
//

#import "DemoCollectionViewCell.h"

@implementation DemoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _label = [[UILabel alloc] init];
        _label.frame = CGRectMake(0, 10, 100, 100);
        [self.contentView addSubview:_label];
    }
    return self;
}

@end
