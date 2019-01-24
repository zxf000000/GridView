//
//  YZMovementsLayoutDelegate.m
//  DemoTableViewController
//
//  Created by 云舟02 on 2019/1/23.
//  Copyright © 2019 云舟02. All rights reserved.
//

#import "YZMovementsLayoutDelegate.h"
#import "YZMovementsCollectionLayoutInfo.h"
#import "YZMovementsNormalCellNode.h"
#import <AsyncDisplayKit/ASCollectionElement.h>

@interface YZMovementsLayoutDelegate()
@property (nonatomic, assign) CGFloat lastX;
@property (nonatomic, assign) CGFloat lastY;

@property (nonatomic, strong) NSMutableArray  *attrsArr;


@property (nonatomic, assign) NSInteger columnsCount;

@property(nonatomic, strong) NSMutableDictionary *linePoints;

@property(nonatomic, strong) YZMovementsCollectionLayoutInfo *info;


@end

@implementation YZMovementsLayoutDelegate
- (instancetype)init {
    if (self = [super init]) {
        _attrsArr = [NSMutableArray array];
    }
    return self;
}


- (ASScrollDirection)scrollableDirections {
    return ASScrollDirectionVerticalDirections;
}


- (nullable id)additionalInfoForLayoutWithElements:(ASElementMap *)elements {
    NSInteger columnCount = [self.delegate columnCountForDelegate:self];
    _info = [[YZMovementsCollectionLayoutInfo alloc]
                                                                    initWithNumberOfColumns:columnCount headerHeight:0 columnSpacing:0 sectionInsets:UIEdgeInsetsMake(0, 0, 0, 0) interItemSpacing:UIEdgeInsetsMake(0, 0, 0, 0)];
    _info.itemHeight = self.itemHeight;
    _info.itemWidth = self.itemWidth;

    return _info;
}


+ (ASCollectionLayoutState *)calculateLayoutWithContext:(ASCollectionLayoutContext *)context {
    
    CGFloat lastX = 0.f;
    CGFloat lastY = 0.f;
    NSMutableDictionary *linePoints = [NSMutableDictionary dictionary];
    YZMovementsCollectionLayoutInfo *info = (YZMovementsCollectionLayoutInfo *)context.additionalInfo;

    NSInteger columnCount = info.numberOfColumns;

    ASElementMap *elements = context.elements;
    NSMapTable<ASCollectionElement *, UICollectionViewLayoutAttributes *> *attrsMap = [NSMapTable elementToLayoutAttributesTable];
    // 开始创建每一个cell对应的布局属性
    NSInteger count = elements.count;

    for (int i = 0; i < count; i++) {
        // 创建位置

        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        ASCollectionElement *element = [elements elementForItemAtIndexPath:indexPath];

        // 获取indexPath位置上cell对应的布局属性
        // 创建布局属性
        UICollectionViewLayoutAttributes * attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];

        CGSize size = CGSizeZero;
        YZMovementsNormalCellNode *node = (YZMovementsNormalCellNode *)(element.node);
        YZMovementsModel *model = node.model;
        size = CGSizeMake(info.itemWidth * model.width, info.itemHeight * model.height);

        CGFloat y = (model.row ) * info.itemHeight;
        CGFloat x = (model.column ) * info.itemWidth;
        attrs.frame = CGRectMake(x, y, size.width, size.height);
        [attrsMap setObject:attrs forKey:element];

        lastY = y;

        // 计算line count
        if (model.hasLinePoint) {
            NSNumber *lineNumber = @(model.lineSerialNumber);
            model.frame = attrs.frame;
            if (linePoints[lineNumber]) {
                NSMutableArray *points = linePoints[lineNumber];
                [points addObject:model];
                linePoints[lineNumber] = points;
            } else {
                NSMutableArray *points = [NSMutableArray array];
                [points addObject:model];
                linePoints[lineNumber] = points;
            }
        }
    }
    [[NSNotificationCenter defaultCenter]
            postNotificationName:@"testNotification" object:@{@"linePoints":linePoints}];
    return [[ASCollectionLayoutState alloc] initWithContext:context
            contentSize:CGSizeMake(info.numberOfColumns * info.itemWidth, lastY + info.itemHeight)
            elementToLayoutAttributesTable:attrsMap];
//    if (self.complete) {
//        self.complete(self.attrsArr, self.linePoints);
//    }
}


//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
//    if (CGRectEqualToRect(newBounds, self.collectionView.bounds)) {
//        return NO;
//    } else {
//        return YES;
//    }
//    return NO;
//}
//
///**
// * 内容的高度
// */
//- (CGSize)collectionViewContentSize{
//
//    return  CGSizeMake(_columnsCount * self.itemWidth, _lastY + self.itemHeight);
//}



@end
