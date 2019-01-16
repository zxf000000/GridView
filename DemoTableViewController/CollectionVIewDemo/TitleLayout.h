//
//  TitleLayout.h
//  DemoTableViewController
//
//  Created by 云舟02 on 2019/1/16.
//  Copyright © 2019 云舟02. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TestModel.h"

@class TitleLayout;

@protocol TitleLayoutDelegate <NSObject>

@optional

- (CGSize)titleLayout:(TitleLayout *)layout sizeForCellAtIndexPath:(NSIndexPath *)indexPath;

- (NSInteger)columnCountForDemoLayout:(TitleLayout *)layout;

- (NSInteger)rowCountForTitleLayout:(TitleLayout *)layout;

- (TestModel *)titleLayout:(TitleLayout *)layout modelForIndexPath:(NSIndexPath *)indexPath;

@end


@interface TitleLayout : UICollectionViewLayout

@property (weak, nonatomic) id<TitleLayoutDelegate>  titleDelegaete;

@property (nonatomic, strong, readonly) NSMutableArray  *attrsArr;

@property (nonatomic,copy) void(^complete)(NSArray *attrs);

@property (nonatomic, assign) CGFloat itemWidth;

@property (nonatomic, assign) CGFloat itemHeight;


@end
