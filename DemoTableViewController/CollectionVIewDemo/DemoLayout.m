//
//  DemoLayout.m
//  DemoTableViewController
//
//  Created by 云舟02 on 2019/1/15.
//  Copyright © 2019 云舟02. All rights reserved.
//

#import "DemoLayout.h"
#import "TestModel.h"

@interface DemoLayout ()

@property (nonatomic, assign) CGFloat lastX;
@property (nonatomic, assign) CGFloat lastY;

@property (nonatomic, strong) NSMutableArray  *attrsArr;


@property (nonatomic, assign) NSInteger columnsCount;


@end


@implementation DemoLayout

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

    if ([self.demoDelegaete respondsToSelector:@selector(columnCountForDemoLayout:)]) {
        _columnsCount = [self.demoDelegaete columnCountForDemoLayout:self];
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
        self.complete(self.attrsArr);
    }
}


/**
 * 返回indexPath位置cell对应的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 创建布局属性
    UICollectionViewLayoutAttributes * attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGSize size = CGSizeZero;
    TestModel *model;
    if ([self.demoDelegaete respondsToSelector:@selector(demoLayout:modelForIndexPath:)]) {
        model = [self.demoDelegaete demoLayout:self modelForIndexPath:indexPath];
    }
    size = CGSizeMake(self.itemWidth * model.width, self.itemHeight);
    
    if (_lastX + size.width > [self collectionViewContentSize].width) {
        _lastX = 0;
        _lastY += size.height;
    }
    
    attrs.frame = CGRectMake(_lastX, _lastY, size.width, size.height);
    _lastX += size.width;
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


//- (TestModel *)modelForIndexPath:(NSIndexPath *)indexPath {
//
//    if (indexPath.item == 2 || indexPath.item == 6) {
//        return [[TestModel alloc] initWithWidth:2];
//    } else {
//        return [[TestModel alloc] initWithWidth:2];
//    }
//
//}

@end
