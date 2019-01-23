//
//  YZMovementsLayoutDelegate.h
//  DemoTableViewController
//
//  Created by 云舟02 on 2019/1/23.
//  Copyright © 2019 云舟02. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "YZMovementsModel.h"

@protocol HelpDelegate;

@interface YZMovementsLayoutDelegate : NSObject <ASCollectionLayoutDelegate>

@property (weak, nonatomic) id<HelpDelegate>  delegate;


@property (nonatomic, strong, readonly) NSMutableArray  *attrsArr;

@property (nonatomic,copy) void(^complete)(NSArray *attrs, NSDictionary *linePoints);

@property (nonatomic, assign) CGFloat itemWidth;

@property (nonatomic, assign) CGFloat itemHeight;

@property (nonatomic, assign) NSInteger itemCount;


@end


@protocol HelpDelegate <NSObject>


- (NSInteger)columnCountForDelegate:(YZMovementsLayoutDelegate *)layout;


- (YZMovementsModel *)titleDelegate:(YZMovementsLayoutDelegate *)layout modelForIndexPath:(NSIndexPath *)indexPath;





@end




