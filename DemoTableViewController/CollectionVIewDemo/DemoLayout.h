//
//  DemoLayout.h
//  DemoTableViewController
//
//  Created by 云舟02 on 2019/1/15.
//  Copyright © 2019 云舟02. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestModel.h"

@class DemoLayout;

@protocol DemoLayoutDelegate <NSObject>

@optional

- (CGSize)demoLayout:(DemoLayout *)layout sizeForCellAtIndexPath:(NSIndexPath *)indexPath;

- (NSInteger)columnCountForDemoLayout:(DemoLayout *)layout;

- (NSInteger)rowCountForDemoLayout:(DemoLayout *)layout;

- (TestModel *)demoLayout:(DemoLayout *)layout modelForIndexPath:(NSIndexPath *)indexPath;

@end


@interface DemoLayout : UICollectionViewLayout

@property (weak, nonatomic) id<DemoLayoutDelegate>  demoDelegaete;

@property (nonatomic, strong, readonly) NSMutableArray  *attrsArr;

@property (nonatomic,copy) void(^complete)(NSArray *attrs);

@property (nonatomic, assign) CGFloat itemWidth;

@property (nonatomic, assign) CGFloat itemHeight;


@end

