//
//  YZMomventCollectionViewLayout.m
//  DemoTableViewController
//
//  Created by 云舟02 on 2019/1/18.
//  Copyright © 2019 云舟02. All rights reserved.
//

#import "YZMovementCollectionViewLayout.h"

@interface YZMovementCollectionViewLayout()

@property (nonatomic, assign) CGFloat lastX;
@property (nonatomic, assign) CGFloat lastY;

@property (nonatomic, strong) NSMutableArray  *attrsArr;


@property (nonatomic, assign) NSInteger columnsCount;

@property(nonatomic, strong) NSMutableDictionary *linePoints;

@end

@implementation YZMovementCollectionViewLayout


- (instancetype)init {
    if (self = [super init]) {
        _attrsArr = [NSMutableArray array];
    }
    return self;
}

/**
 * 初始化
 */
- (void)prepareLayout{

    [super prepareLayout];

    self.lastX = 0.f;
    self.lastY = 0.f;
    self.linePoints = [NSMutableDictionary dictionary];

    if ([self.delegate respondsToSelector:@selector(columnCountForTitleLayout:)]) {
        _columnsCount = [self.delegate columnCountForTitleLayout:self];
    }

    // 清楚之前所有的布局属性
    [self.attrsArr removeAllObjects];

    // 开始创建每一个cell对应的布局属性
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    

    for (int i = 0; i < count; i++) {
        // 创建位置
        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        // 获取indexPath位置上cell对应的布局属性
        UICollectionViewLayoutAttributes * attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArr addObject:attrs];
    }
    if (self.complete) {
        self.complete(self.attrsArr, self.linePoints);
    }
}


/**
 * 返回indexPath位置cell对应的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {

    // 创建布局属性
    UICollectionViewLayoutAttributes * attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];

    CGSize size = CGSizeZero;
    YZMovementsModel *model;
    if ([self.delegate respondsToSelector:@selector(titleLayout:modelForIndexPath:)]) {
        model = [self.delegate titleLayout:self modelForIndexPath:indexPath];
    }
    size = CGSizeMake(self.itemWidth * model.width, self.itemHeight * model.height);

    CGFloat y = (model.row ) * self.itemHeight;
    CGFloat x = (model.column ) * self.itemWidth;
    attrs.frame = CGRectMake(x, y, size.width, size.height);

    _lastY = y;


    // 计算line count
    if (model.hasLinePoint) {
        NSNumber *lineNumber = @(model.lineSerialNumber);
        model.frame = attrs.frame;
        if (self.linePoints[lineNumber]) {
            NSMutableArray *points = self.linePoints[lineNumber];
            [points addObject:model];
            self.linePoints[lineNumber] = points;
        } else {
            NSMutableArray *points = [NSMutableArray array];
            [points addObject:model];
            self.linePoints[lineNumber] = points;
        }
    }

    return attrs;
}

/**
 * 决定cell的高度
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{

    return self.attrsArr;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    if (CGRectEqualToRect(newBounds, self.collectionView.bounds)) {
        return NO;
    } else {
        return YES;
    }
    return NO;
}

/**
 * 内容的高度
 */
- (CGSize)collectionViewContentSize{

    return  CGSizeMake(_columnsCount * self.itemWidth, _lastY + self.itemHeight);
}

@end
