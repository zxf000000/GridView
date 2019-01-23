//
// Created by 云舟02 on 2019-01-23.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import "TestTextureViewController.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "YZMovementCollectionViewLayout.h"
#import "YZMovementsModel.h"
#import "TestTextureCellNode.h"

@interface TestTextureViewController () <YZMovementCollectionViewLayoutDelegate, ASCollectionDataSource, ASCollectionDelegate>

@property(nonatomic, strong) ASCollectionNode *collectionNode;

@end
@implementation TestTextureViewController

- (void)viewDidLoad {

    YZMovementCollectionViewLayout *layout = [[YZMovementCollectionViewLayout alloc] init];
    layout.delegate = self;
    layout.itemWidth = 30;
    layout.itemHeight = 30;
    _collectionNode = [[ASCollectionNode alloc]
            initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:layout];
    [self.view addSubnode:_collectionNode];

    _collectionNode.delegate = self;
    _collectionNode.dataSource = self;

    [super viewDidLoad];
}

- (NSInteger)columnCountForTitleLayout:(YZMovementCollectionViewLayout *)layout {
    return 20;
}


- (YZMovementsModel *)titleLayout:(YZMovementCollectionViewLayout *)layout modelForIndexPath:(NSIndexPath *)indexPath {
    return [YZMovementsModel modelWithWidth:1 height:1 hasLinePoint:NO bgType:BgTypeCircle title:@"title" row:indexPath.item / 20 column:indexPath.item % 20 lineSerialNumber:0 type:YZMovementsModelPositionDefault];
}
/**
 * Asks the data source for the number of items in the given section of the collection node.
 *
 * @see @c collectionView:numberOfItemsInSection:
 */
- (NSInteger)collectionNode:(ASCollectionNode *)collectionNode numberOfItemsInSection:(NSInteger)section {
    return 2000;
}

/**
 * Asks the data source for the number of sections in the collection node.
 *
 * @see @c numberOfSectionsInCollectionView:
 */
- (NSInteger)numberOfSectionsInCollectionNode:(ASCollectionNode *)collectionNode {
    return 1;
}

/**
 * Similar to -collectionNode:nodeForItemAtIndexPath:
 * This method takes precedence over collectionNode:nodeForItemAtIndexPath: if implemented.
 *
 * @param collectionNode The sender.
 * @param indexPath The index path of the item.
 *
 * @return a block that creates the node for display for this item.
 *   Must be thread-safe (can be called on the main thread or a background
 *   queue) and should not implement reuse (it will be called once per row).
 */
- (ASCellNodeBlock)collectionNode:(ASCollectionNode *)collectionNode nodeBlockForItemAtIndexPath:(NSIndexPath *)indexPath {

    // this may be executed on a background thread - it is important to make sure it is thread safe
    ASCellNode *(^cellNodeBlock)(void) = ^ASCellNode *() {
        TestTextureCellNode *cellNode = [[TestTextureCellNode alloc] init];
        return cellNode;
    };

    return cellNodeBlock;
}


@end
