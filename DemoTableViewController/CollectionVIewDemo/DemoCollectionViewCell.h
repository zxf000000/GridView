//
//  DemoCollectionViewCell.h
//  DemoTableViewController
//
//  Created by 云舟02 on 2019/1/15.
//  Copyright © 2019 云舟02. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DemoCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) TestModel  *model;


@end

NS_ASSUME_NONNULL_END
