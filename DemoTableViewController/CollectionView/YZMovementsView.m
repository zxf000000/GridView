//
// Created by 云舟02 on 2019-01-18.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import "YZMovementsView.h"
#import "YZMovementCollectionViewLayout.h"
#import "YZMovementsCollectionViewCell.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "YZMovementsNormalCellNode.h"
#import "YZMovementsLayoutDelegate.h"
#import "YZMovementsBarNode.h"

@interface YZMovementsView () <YZMovementCollectionViewLayoutDelegate, UICollectionViewDelegate, UICollectionViewDataSource, ASCollectionDelegate, ASCollectionDataSource, HelpDelegate>

@property(nonatomic, assign) CGFloat itemWidth;
@property(nonatomic, assign) CGFloat itemHeight;
@property(strong, nonatomic) ASCollectionNode *collectionView;

@property(strong, nonatomic) UICollectionView *topTitleView;
@property(strong, nonatomic) UICollectionView *leftTitleView;

@property(nonatomic, strong) UILabel *titleLabel;


@property(nonatomic, strong) NSMutableArray *lineLayers;

@property(nonatomic, weak) id <YZMovementsViewDelegate> delegate;

@property(nonatomic, assign) CGFloat topTitleHeight;
@property(nonatomic, assign) CGFloat leftTitleWidth;

@property(nonatomic, assign) BOOL shouldShowTitle;

@end


@implementation YZMovementsView

- (instancetype)initWithDelegate:(id <YZMovementsViewDelegate>)delegate {
    if (self = [super init]) {
        _delegate = delegate;
        [self initConfig];

        [self setupUI];
        [self layoutIfNeeded];
    }
    return self;
}

- (void)initConfig {
    _lineLayers = [NSMutableArray array];

    CGSize itemSize = [self.delegate itemSizeForMovementsView:self];
    _itemWidth = itemSize.width;
    _itemHeight = itemSize.height;

    _topTitleHeight = _itemHeight * [self.delegate topTitleRowCountForMovementsView:self];
    _leftTitleWidth = _itemWidth * [self.delegate leftTitleColumnCountForMovementsView:self];
    _shouldShowTitle = YES;
    if ([self.delegate respondsToSelector:@selector(movementsViewShouldShowTitleWith:)]) {
        _shouldShowTitle  = [self.delegate movementsViewShouldShowTitleWith:self];
    }

    [[NSNotificationCenter defaultCenter]
            addObserver:self selector:@selector(drawLine:) name:@"testNotification" object:nil];
}


- (void)reloadData {

    if (self.shouldShowTitle) {
        [self.topTitleView reloadData];
        [self.leftTitleView reloadData];
        [self.collectionView reloadData];
    } else {
        [self.collectionView reloadData];
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.shouldShowTitle) {
        self.collectionView.frame = CGRectMake(_leftTitleWidth, _topTitleHeight, self.bounds.size.width - _leftTitleWidth, self.bounds.size.height - _topTitleHeight);
        self.topTitleView.frame = CGRectMake(_leftTitleWidth, 0, self.bounds.size.width - _leftTitleWidth, _topTitleHeight);
        self.leftTitleView.frame = CGRectMake(0, _topTitleHeight, _leftTitleWidth, self.bounds.size.height - _topTitleHeight);
        self.titleLabel.frame = CGRectMake(0, 0, _leftTitleWidth, _topTitleHeight);
    } else {
        self.collectionView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    }

}

- (void)setupUI {

    self.backgroundColor = [UIColor whiteColor];

    if (_shouldShowTitle) {
        YZMovementCollectionViewLayout *topLayout = [[YZMovementCollectionViewLayout alloc] init];
        topLayout.delegate = self;
        topLayout.itemWidth = _itemWidth;
        topLayout.itemHeight = _itemHeight;

        _topTitleView = [[UICollectionView alloc] initWithFrame:(CGRectMake(0, 0, self.bounds.size.width - 50, self.bounds.size.height - 100)) collectionViewLayout:topLayout];
        [self addSubview:_topTitleView];

        _topTitleView.dataSource = self;
        _topTitleView.delegate = self;
        _topTitleView.backgroundColor = [UIColor whiteColor];
        [_topTitleView removeGestureRecognizer:_topTitleView.panGestureRecognizer];
        [_topTitleView registerClass:[YZMovementsCollectionViewCell class] forCellWithReuseIdentifier:@"YZMovementsCollectionViewCell"];

        _topTitleView.bounces = NO;


        YZMovementCollectionViewLayout *leftLayout = [[YZMovementCollectionViewLayout alloc] init];
        leftLayout.delegate = self;
        leftLayout.itemWidth = _itemWidth;
        leftLayout.itemHeight = _itemHeight;

        _leftTitleView = [[UICollectionView alloc] initWithFrame:(CGRectMake(0, 100, self.bounds.size.width, self.bounds.size.height - 100)) collectionViewLayout:leftLayout];
        [self addSubview:_leftTitleView];
        [_leftTitleView removeGestureRecognizer:_leftTitleView.panGestureRecognizer];
        _leftTitleView.dataSource = self;
        _leftTitleView.delegate = self;
        _leftTitleView.backgroundColor = [UIColor whiteColor];
        [_leftTitleView registerClass:[YZMovementsCollectionViewCell class] forCellWithReuseIdentifier:@"YZMovementsCollectionViewCell"];

        _leftTitleView.bounces = NO;


        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"期号";
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor colorWithWhite:0.25 alpha:1];
        _titleLabel.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    CGSize itemSize = [self.delegate itemSizeForMovementsView:self];
    YZMovementsLayoutDelegate *layoutDelegate = [[YZMovementsLayoutDelegate alloc] init];
    layoutDelegate.itemWidth = itemSize.width;
    layoutDelegate.itemHeight = itemSize.height;
    layoutDelegate.itemCount = [self.delegate numberOfItemForMovementsView:self];
    layoutDelegate.delegate = self;
    self.collectionView = [[ASCollectionNode alloc] initWithLayoutDelegate:layoutDelegate layoutFacilitator:nil];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.view.bounces = NO;
    [self addSubnode:self.collectionView];

    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;

}

- (NSInteger)collectionNode:(ASCollectionNode *)collectionNode numberOfItemsInSection:(NSInteger)section {

    return [self.delegate numberOfItemForMovementsView:self];
}

- (NSInteger)numberOfSectionsInCollectionNode:(ASCollectionNode *)collectionNode {
    return 1;
}

- (ASCellNodeBlock)collectionNode:(ASCollectionNode *)collectionNode nodeBlockForItemAtIndexPath:(NSIndexPath *)indexPath {
    YZMovementsModel *model = [self.delegate movementsView:self dataModelForIndex:indexPath.item];
    ASCellNode *(^cellNodeBlock)(void) = ^ASCellNode *() {
        if (model.isPercent) {
            YZMovementsBarNode *cellNode = [[YZMovementsBarNode alloc] initWithModel:model];
            return cellNode;
        } else {
            YZMovementsNormalCellNode *cellNode = [[YZMovementsNormalCellNode alloc] initWithModel:model];
            return cellNode;
        }
    };
    return cellNodeBlock;
}


- (NSInteger)columnCountForDelegate:(YZMovementsLayoutDelegate *)layout {
    return [self.delegate numberOfColumnsForMovementsView:self];
}


- (YZMovementsModel *)titleDelegate:(YZMovementsLayoutDelegate *)layout modelForIndexPath:(NSIndexPath *)indexPath {
    return [self.delegate movementsView:self dataModelForIndex:indexPath.item];
}

#pragma mark titleLayoutDelegate

- (YZMovementsModel *)titleLayout:(YZMovementCollectionViewLayout *)layout modelForIndexPath:(NSIndexPath *)indexPath {

    if (layout.collectionView == self.topTitleView) {
        return [self.delegate movementsView:self topTitleModelForIndex:indexPath.item];

    } else if (layout.collectionView == self.leftTitleView) {
        return [self.delegate movementsView:self leftTitleModelForIndex:indexPath.item];
    }
    return nil;
}

- (NSInteger)columnCountForTitleLayout:(YZMovementCollectionViewLayout *)layout {
    if (layout.collectionView == self.leftTitleView) {
        return 1;
    } else {
        return [self.delegate numberOfColumnsForMovementsView:self];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    if (collectionView == self.topTitleView) {
        return [self.delegate numberOfTopTitleForMovementsView:self];

    } else if (collectionView == self.leftTitleView) {
        return [self.delegate numberOfleftTitleForMovementsView:self];
    }
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    YZMovementsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YZMovementsCollectionViewCell" forIndexPath:indexPath];
    if (collectionView == self.topTitleView) {
        cell.model = [self.delegate movementsView:self topTitleModelForIndex:indexPath.item];
    } else if (collectionView == self.leftTitleView) {
        cell.model = [self.delegate movementsView:self leftTitleModelForIndex:indexPath.item];
    }
    return cell;
}

- (void)drawLine:(NSNotification *)notification {
    NSDictionary *linePoints = notification.object[@"linePoints"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self addLinesForAttrs:nil linePoints:linePoints];
    });
}

- (void)addLinesForAttrs:(NSArray *)attrs linePoints:(NSDictionary *)linePoints {

    for (CAShapeLayer *layer in self.lineLayers) {
        [layer removeFromSuperlayer];
    }
    [self.lineLayers removeAllObjects];

    __weak typeof(self) weakSelf = self;
    [linePoints enumerateKeysAndObjectsUsingBlock:^(NSNumber *lineNumber, NSMutableArray *points, BOOL *stop) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSInteger count = 0;
        // 颜色问题
//        UIColor *color = [lineNumber integerValue] == 1 ? [UIColor redColor] : [UIColor blueColor];
//        if ([lineNumber integerValue] == 1) {
//            color = [UIColor brownColor];
//        } else if ([lineNumber integerValue] == 2) {
//            color = [UIColor redColor];
//        } else {
//            color = [UIColor blueColor];
//        }
        UIColor *color = [UIColor redColor];
        CGPoint lastCenter;
        CGFloat offsetOblique = (strongSelf.itemHeight - YZMovementsCellBallMargin * 2) / 2;
        CGFloat radius = offsetOblique;
        for (NSInteger pointIndex = 0, length = points.count; pointIndex < length; ++pointIndex) {

            YZMovementsModel *model = points[pointIndex];

            UIBezierPath *path = [UIBezierPath bezierPath];

            CGPoint lastLinePoint = CGPointMake(0, 0);
            CGPoint currentLinePoint;
            CGPoint currentCenter = CGPointMake(model.frame.origin.x + model.frame.size.width / 2, model.frame.origin.y + model.frame.size.height / 2);

            // 计算角度
            CGFloat offsetX = currentCenter.x - lastCenter.x;
            CGFloat offsetY = currentCenter.y - lastCenter.y;


            CGFloat distance = (CGFloat) sqrt(offsetX * offsetX + offsetY * offsetY);

            CGFloat xMinus = radius / (distance / offsetX);
            CGFloat yMinus = radius / (distance / offsetY);

            if (count == 0) {

            } else {
                CGFloat lastX = lastCenter.x + xMinus;
                CGFloat lastY = lastCenter.y + yMinus;
                CGFloat currentX = currentCenter.x - xMinus;
                CGFloat currentY = currentCenter.y - yMinus;
                lastLinePoint = CGPointMake(lastX, lastY);
                currentLinePoint = CGPointMake(currentX, currentY);
                    
                [path moveToPoint:lastLinePoint];
                [path addLineToPoint:currentLinePoint];

                CAShapeLayer *shapeLayer = [CAShapeLayer layer];
                shapeLayer.lineWidth = 0.5f;
                shapeLayer.strokeColor = color.CGColor;
                shapeLayer.fillColor = [UIColor clearColor].CGColor;
                shapeLayer.path = path.CGPath;
                [strongSelf.collectionView.layer addSublayer:shapeLayer];
                [strongSelf.lineLayers addObject:shapeLayer];
            }

            count += 1;
            lastCenter = CGPointMake(model.frame.origin.x + model.frame.size.width / 2, model.frame.origin.y + model.frame.size.height / 2);
        }
    }];

}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.collectionView.view) {
        CGPoint offset = self.topTitleView.contentOffset;
        CGPoint offsetLeft = self.leftTitleView.contentOffset;
        offset.x = self.collectionView.view.contentOffset.x;
        offsetLeft.y = self.collectionView.view.contentOffset.y;
        self.topTitleView.contentOffset = offset;
        self.leftTitleView.contentOffset = offsetLeft;
    }
    // 暂时不允许标题栏主动拖拽,联动代码会引起卡顿,后期再处理
//    } else if (scrollView == self.leftTitleView) {
//        CGPoint offset = self.collectionView.contentOffset;
//        offset.y = self.leftTitleView.contentOffset.y;
//        self.collectionView.contentOffset = offset;
//    } else if (scrollView == self.topTitleView) {
//        CGPoint offset = self.collectionView.contentOffset;
//        offset.x = self.topTitleView.contentOffset.x;
//        self.collectionView.contentOffset = offset;
//    }
}
@end
