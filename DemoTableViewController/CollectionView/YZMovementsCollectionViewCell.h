//
//  YZMovementsCollectionViewCell.h
//  DemoTableViewController
//
//  Created by 云舟02 on 2019/1/18.
//  Copyright © 2019 云舟02. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YZMovementsModel;

extern CGFloat const YZMovementsCellBallMargin;

NS_ASSUME_NONNULL_BEGIN

@interface YZMovementsCollectionViewCell : UICollectionViewCell

@property(nonatomic, strong) YZMovementsModel *model;

@end

NS_ASSUME_NONNULL_END
