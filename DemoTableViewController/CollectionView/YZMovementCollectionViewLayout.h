//
//  YZMomventCollectionViewLayout.h
//  DemoTableViewController
//
//  Created by 云舟02 on 2019/1/18.
//  Copyright © 2019 云舟02. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZMovementsModel.h"

@protocol YZMovementCollectionViewLayoutDelegate;

@interface YZMovementCollectionViewLayout : UICollectionViewLayout


@property (weak, nonatomic) id<YZMovementCollectionViewLayoutDelegate>  delegate;

@property (nonatomic, strong, readonly) NSMutableArray  *attrsArr;

@property (nonatomic,copy) void(^complete)(NSArray *attrs, NSDictionary *linePoints);

@property (nonatomic, assign) CGFloat itemWidth;

@property (nonatomic, assign) CGFloat itemHeight;

@end


@protocol YZMovementCollectionViewLayoutDelegate <NSObject>

@optional


- (NSInteger)columnCountForTitleLayout:(YZMovementCollectionViewLayout *)layout;


- (YZMovementsModel *)titleLayout:(YZMovementCollectionViewLayout *)layout modelForIndexPath:(NSIndexPath *)indexPath;


@end


