//
// Created by 云舟02 on 2019-01-18.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import "YZMovementsView.h"
#import "YZMovementCollectionViewLayout.h"
#import "YZMovementsCollectionViewCell.h"

@interface YZMovementsView () <YZMovementCollectionViewLayoutDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, assign) CGFloat itemWidth;
@property(nonatomic, assign) CGFloat itemHeight;
@property(strong, nonatomic) UICollectionView *collectionView;

@property(strong, nonatomic) UICollectionView *topTitleView;
@property(strong, nonatomic) UICollectionView *leftTitleView;

@property(nonatomic, strong) UILabel *titleLabel;


@property(nonatomic, strong) NSMutableArray *lineLayers;

@property(nonatomic, weak) id <YZMovementsViewDelegate> delegate;

@property(nonatomic, assign) CGFloat topTitleHeight;
@property(nonatomic, assign) CGFloat leftTitleWidth;

@property(nonatomic, assign) BOOL pagingEnabled;

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

}


- (void)reloadData {
    [self.topTitleView reloadData];
    [self.leftTitleView reloadData];
    [self.collectionView reloadData];

}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(_leftTitleWidth, _topTitleHeight, self.bounds.size.width - _leftTitleWidth, self.bounds.size.height - _topTitleHeight);
    self.topTitleView.frame = CGRectMake(_leftTitleWidth, 0, self.bounds.size.width - _leftTitleWidth, _topTitleHeight);
    self.leftTitleView.frame = CGRectMake(0, _topTitleHeight, _leftTitleWidth, self.bounds.size.height - _topTitleHeight);
    self.titleLabel.frame = CGRectMake(0, 0, _leftTitleWidth, _topTitleHeight);
}

- (void)setupUI {

    self.backgroundColor = [UIColor yellowColor];

    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"期号";
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor = [UIColor colorWithWhite:0.25 alpha:1];
    _titleLabel.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];

    YZMovementCollectionViewLayout *layout = [[YZMovementCollectionViewLayout alloc] init];
    layout.delegate = self;
    layout.itemWidth = _itemWidth;
    layout.itemHeight = _itemHeight;
    _collectionView = [[UICollectionView alloc] initWithFrame:(CGRectMake(0, 100, self.bounds.size.width, self.bounds.size.height - 100)) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor redColor];
    [self addSubview:_collectionView];

    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[YZMovementsCollectionViewCell class] forCellWithReuseIdentifier:@"YZMovementsCollectionViewCell"];

    _collectionView.bounces = NO;
    __weak typeof(self) weakSelf = self;
    layout.complete = ^(NSArray *attrs, NSDictionary *linePoints) {
        [weakSelf addLinesForAttrs:attrs linePoints:linePoints];
    };


    YZMovementCollectionViewLayout *topLayout = [[YZMovementCollectionViewLayout alloc] init];
    topLayout.delegate = self;
    topLayout.itemWidth = _itemWidth;
    topLayout.itemHeight = _itemHeight;

    _topTitleView = [[UICollectionView alloc] initWithFrame:(CGRectMake(0, 0, self.bounds.size.width - 50, self.bounds.size.height - 100)) collectionViewLayout:topLayout];
    _topTitleView.backgroundColor = [UIColor yellowColor];
    [self addSubview:_topTitleView];

    _topTitleView.dataSource = self;
    _topTitleView.delegate = self;
    _topTitleView.backgroundColor = [UIColor whiteColor];

    [_topTitleView registerClass:[YZMovementsCollectionViewCell class] forCellWithReuseIdentifier:@"YZMovementsCollectionViewCell"];

    _topTitleView.bounces = NO;


    YZMovementCollectionViewLayout *leftLayout = [[YZMovementCollectionViewLayout alloc] init];
    leftLayout.delegate = self;
    leftLayout.itemWidth = _itemWidth;
    leftLayout.itemHeight = _itemHeight;

    _leftTitleView = [[UICollectionView alloc] initWithFrame:(CGRectMake(0, 100, self.bounds.size.width, self.bounds.size.height - 100)) collectionViewLayout:leftLayout];
    _leftTitleView.backgroundColor = [UIColor yellowColor];
    [self addSubview:_leftTitleView];

    _leftTitleView.dataSource = self;
    _leftTitleView.delegate = self;
    _leftTitleView.backgroundColor = [UIColor whiteColor];
    [_leftTitleView registerClass:[YZMovementsCollectionViewCell class] forCellWithReuseIdentifier:@"YZMovementsCollectionViewCell"];

    _leftTitleView.bounces = NO;

}

#pragma mark titleLayoutDelegate

- (YZMovementsModel *)titleLayout:(YZMovementCollectionViewLayout *)layout modelForIndexPath:(NSIndexPath *)indexPath {

    if (layout.collectionView == self.collectionView) {
        return [self.delegate movementsView:self dataModelForIndex:indexPath.item];

    } else if (layout.collectionView == self.topTitleView) {
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

    if (collectionView == self.collectionView) {

        return [self.delegate numberOfItemForMovementsView:self];

    } else if (collectionView == self.topTitleView) {
        return [self.delegate numberOfTopTitleForMovementsView:self];

    } else if (collectionView == self.leftTitleView) {
        return [self.delegate numberOfleftTitleForMovementsView:self];
    }
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    YZMovementsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YZMovementsCollectionViewCell" forIndexPath:indexPath];
    if (collectionView == self.collectionView) {
        cell.model = [self.delegate movementsView:self dataModelForIndex:indexPath.item];
    } else if (collectionView == self.topTitleView) {
        cell.model = [self.delegate movementsView:self topTitleModelForIndex:indexPath.item];
    } else if (collectionView == self.leftTitleView) {
        cell.model = [self.delegate movementsView:self leftTitleModelForIndex:indexPath.item];
    }
    return cell;
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
        UIColor *color = [lineNumber integerValue] == 1 ? [UIColor redColor] : [UIColor blueColor];
        if ([lineNumber integerValue] == 1) {
            color = [UIColor brownColor];
        } else if ([lineNumber integerValue] == 2) {
            color = [UIColor redColor];
        } else {
            color = [UIColor blueColor];
        }
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
                shapeLayer.lineWidth = 1.f;
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
    if (scrollView == self.collectionView) {
        CGPoint offset = self.topTitleView.contentOffset;
        CGPoint offsetLeft = self.leftTitleView.contentOffset;
        offset.x = self.collectionView.contentOffset.x;
        offsetLeft.y = self.collectionView.contentOffset.y;
        self.topTitleView.contentOffset = offset;
        self.leftTitleView.contentOffset = offsetLeft;
    } else if (scrollView == self.leftTitleView) {
        CGPoint offset = self.collectionView.contentOffset;
        offset.y = self.leftTitleView.contentOffset.y;
        self.collectionView.contentOffset = offset;
    } else if (scrollView == self.topTitleView) {
        CGPoint offset = self.collectionView.contentOffset;
        offset.x = self.topTitleView.contentOffset.x;
        self.collectionView.contentOffset = offset;
    }
}
@end
