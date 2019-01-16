//
//  DemoView.m
//  DemoTableViewController
//
//  Created by 云舟02 on 2019/1/16.
//  Copyright © 2019 云舟02. All rights reserved.
//

#import "DemoView.h"
#import "DemoLayout.h"
#import "TestCollectionViewCell.h"
#import "TestModel.h"



@interface DemoView () <DemoLayoutDelegate, UICollectionViewDelegate, UICollectionViewDataSource>


@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat itemHeight;
@property (strong, nonatomic) UICollectionView  *collectionView;

@property (nonatomic,copy) NSArray *datas;
@property (nonatomic,copy) NSArray  *leftTitles;

@property (nonatomic,copy) NSArray  *topTitles;

@property (strong, nonatomic) CAShapeLayer  *shapeLayer;

@property (strong, nonatomic) UICollectionView  *topTitleView;
@property (strong, nonatomic) UICollectionView  *leftTitleView;


@end

@implementation DemoView

- (instancetype)initWithItemWidth:(CGFloat)itemWidth itemHeight:(CGFloat)itemHeight {
    if (self = [super init]) {
        _itemWidth = itemWidth;
        _itemHeight = itemHeight;
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:1000];
        for (NSInteger i = 0, length = 1000; i < length; i++) {
            TestModel *model;
            if (i == 2 || i == 6) {
                model = [[TestModel alloc] initWithWidth:1 height:1 hasLinePoint:NO bgType:(BgTypeNone) title:@"123"];
            } else if (i > 10 && i %15 == 0) {
                model = [[TestModel alloc] initWithWidth:1 height:1 hasLinePoint:YES bgType:(BgTypeCircle) title:@"123"];
            } else if (i > 10 && i %17 == 0) {
                model = [[TestModel alloc] initWithWidth:1 height:1 hasLinePoint:NO bgType:(BgTypeSquare) title:@"123"];
            } else if (i > 10 && i %13 == 0) {
                model = [[TestModel alloc] initWithWidth:1 height:1 hasLinePoint:NO bgType:(BgTypeFull) title:@"123"];
            } else {
                model = [[TestModel alloc] initWithWidth:1 height:1 hasLinePoint:NO bgType:(BgTypeNone) title:@"123"];
            }
            [array addObject:model];
        }
        self.datas = array.copy;
        
        NSMutableArray *topArr = [NSMutableArray arrayWithCapacity:20];
        for (NSInteger i = 0 ; i < 20 ; i ++) {
            TestModel *model;
            
            if (i == 0) {
                model = [[TestModel alloc] initWithWidth:1 height:2 hasLinePoint:NO bgType:(BgTypeNone) title:@"头部标题"];
            } else if (i == 2 || i == 6) {
                model = [[TestModel alloc] initWithWidth:2 height:1 hasLinePoint:NO bgType:(BgTypeNone) title:@"头部标题"];
            } else {
                model = [[TestModel alloc] initWithWidth:1 height:1 hasLinePoint:NO bgType:(BgTypeNone) title:@"头部标题"];
            }
            [topArr addObject:model];
        }
        self.topTitles = topArr.copy;
        
        NSMutableArray *leftArr = [NSMutableArray arrayWithCapacity:500];
        for (NSInteger i = 0 ; i < 500 ; i ++) {
            TestModel *model = [[TestModel alloc] initWithWidth:1 height:1 hasLinePoint:NO bgType:(BgTypeNone) title:@"左侧标题"];
            [leftArr addObject:model];
        }
        self.leftTitles = leftArr.copy;
        
        [self setupUI];
        [self layoutIfNeeded];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(50, 50, self.bounds.size.width - 50, self.bounds.size.height - 50);
    self.topTitleView.frame = CGRectMake(50, 0, self.bounds.size.width - 50, 50);
    self.leftTitleView.frame = CGRectMake(0, 50, 50, self.bounds.size.height - 50);

}

- (void)setupUI {
    
    self.backgroundColor = [UIColor yellowColor];
    
    DemoLayout *layout = [[DemoLayout alloc] init];
    layout.demoDelegaete = self;
    layout.itemWidth = _itemWidth;
    layout.itemHeight = _itemHeight;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:(CGRectMake(0, 100, self.bounds.size.width, self.bounds.size.height - 100)) collectionViewLayout:layout];
    [self addSubview:_collectionView];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerNib:[UINib nibWithNibName:@"TestCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"TestCollectionViewCell"];
    _collectionView.bounces = NO;
    
    layout.complete = ^(NSArray *attrs) {
        [self addLinesForAttrs:attrs];
    };
    
    
    DemoLayout *topLayout = [[DemoLayout alloc] init];
    topLayout.demoDelegaete = self;
    topLayout.itemWidth = _itemWidth;
    topLayout.itemHeight = _itemHeight;
    
    _topTitleView = [[UICollectionView alloc] initWithFrame:(CGRectMake(0, 0, self.bounds.size.width - 50, self.bounds.size.height - 100)) collectionViewLayout:topLayout];
    [self addSubview:_topTitleView];
    
    _topTitleView.dataSource = self;
    _topTitleView.delegate = self;
    _topTitleView.backgroundColor = [UIColor whiteColor];
    [_topTitleView registerNib:[UINib nibWithNibName:@"TestCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"TestCollectionViewCell"];
    _topTitleView.bounces = NO;
    
    layout.complete = ^(NSArray *attrs) {
        [self addLinesForAttrs:attrs];
    };
    
    DemoLayout *leftLayout = [[DemoLayout alloc] init];
    leftLayout.demoDelegaete = self;
    leftLayout.itemWidth = _itemWidth;
    leftLayout.itemHeight = _itemHeight;
    
    _leftTitleView = [[UICollectionView alloc] initWithFrame:(CGRectMake(0, 100, self.bounds.size.width, self.bounds.size.height - 100)) collectionViewLayout:leftLayout];
    [self addSubview:_leftTitleView];
    
    _leftTitleView.dataSource = self;
    _leftTitleView.delegate = self;
    _leftTitleView.backgroundColor = [UIColor whiteColor];
    [_leftTitleView registerNib:[UINib nibWithNibName:@"TestCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"TestCollectionViewCell"];
    _leftTitleView.bounces = NO;
    
    layout.complete = ^(NSArray *attrs) {
        [self addLinesForAttrs:attrs];
    };
    
}

- (TestModel *)demoLayout:(DemoLayout *)layout modelForIndexPath:(NSIndexPath *)indexPath {
    if (layout.collectionView == self.collectionView) {
        return self.datas[indexPath.item];
        
    } else if (layout.collectionView == self.topTitleView) {
        return self.topTitles[indexPath.item];
        
    } else if (layout.collectionView == self.leftTitleView) {
        return self.leftTitles[indexPath.item];
    }
    return nil;
}

- (CGSize)demoLayout:(DemoLayout *)layout sizeForCellAtIndexPath:(NSIndexPath *)indexPath {
    if (layout.collectionView == self.collectionView) {
        return CGSizeMake(50, 50);

    } else if (layout.collectionView == self.topTitleView) {
        
        if (indexPath.item == 2 || indexPath.item == 6) {
            return CGSizeMake(100, 50);
        } else {
            return CGSizeMake(50, 50);
        }
    } else if (layout.collectionView == self.leftTitleView) {
        return CGSizeMake(50, 50);

    }
    return CGSizeMake(50, 50);
}

- (NSInteger)columnCountForDemoLayout:(DemoLayout *)layout {
    if (layout.collectionView == self.collectionView) {
        return 20;

    } else if (layout.collectionView == self.topTitleView) {
        return 20;

    } else if (layout.collectionView == self.leftTitleView) {
        return 1;
    }
    return 1;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (collectionView == self.collectionView) {
        return self.datas.count;
        
    } else if (collectionView == self.topTitleView) {
        return self.topTitles.count;
        
    } else if (collectionView == self.leftTitleView) {
        return self.leftTitles.count;
    }
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TestCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TestCollectionViewCell" forIndexPath:indexPath];
    
    
    if (collectionView == self.collectionView) {
        cell.model = self.datas[indexPath.item];
    } else if (collectionView == self.topTitleView) {
        cell.model = self.topTitles[indexPath.item];
        cell.backgroundColor = [UIColor colorWithRed:245.f/255.f green:246.f/255.f blue:239.f/255.f alpha:1];
        
    } else if (collectionView == self.leftTitleView) {
        cell.model = self.leftTitles[indexPath.item];
        cell.backgroundColor = [UIColor colorWithRed:245.f/255.f green:246.f/255.f blue:239.f/255.f alpha:1];
        
    }
    
    return cell;
}

- (void)addLinesForAttrs:(NSArray *)attrs {
    
    if (self.shapeLayer) {
        return;
    }
    
    NSInteger count = 0;
    CGPoint lastCenter;
    CGFloat offsetOblique = (_itemHeight - 2) / 2 / 1.414;
    for (NSInteger i = 0, length = self.datas.count; i < length; i++) {
        UICollectionViewLayoutAttributes *attr = attrs[i];
        TestModel *model = self.datas[i];
        if (model.hasLinePoint) {
            
            UIBezierPath *path = [UIBezierPath bezierPath];
            
            CGPoint lastLinePoint = CGPointMake(0, 0);
            CGPoint currentLinePoint;
            CGPoint currentPoint = CGPointMake(attr.frame.origin.x + attr.frame.size.width / 2, attr.frame.origin.y + attr.frame.size.height / 2);
            if (count == 0) {
                
            } else {
                if (lastCenter.x > currentPoint.x) {
                    CGFloat lastX = lastCenter.x - offsetOblique;
                    CGFloat lastY = lastCenter.y;
                    CGFloat currentX = currentPoint.x  + offsetOblique;
                    CGFloat currentY = currentPoint.y;
                    lastLinePoint = CGPointMake(lastX, lastY);
                    currentLinePoint = CGPointMake(currentX, currentY);
                } else {
                    CGFloat lastX = lastCenter.x + offsetOblique;
                    CGFloat lastY = lastCenter.y;
                    CGFloat currentX = currentPoint.x  - offsetOblique;
                    CGFloat currentY = currentPoint.y;
                    lastLinePoint = CGPointMake(lastX, lastY);
                    currentLinePoint = CGPointMake(currentX, currentY);
                }
                [path moveToPoint:lastLinePoint];
                [path addLineToPoint:currentLinePoint];
                
                CAShapeLayer *shapeLayer = [CAShapeLayer layer];
                shapeLayer.lineWidth = 1.f;
                shapeLayer.strokeColor = [UIColor grayColor].CGColor;
                shapeLayer.fillColor = [UIColor clearColor].CGColor;
                shapeLayer.path = path.CGPath;
                [self.collectionView.layer addSublayer:shapeLayer];
//                for (UIView *view in self.collectionView.subviews) {
//                    NSLog(@"subVIew ------->>>  %@",view);
//                }
                
            }
            
            count += 1;
            lastCenter = CGPointMake(attr.frame.origin.x + attr.frame.size.width / 2, attr.frame.origin.y + attr.frame.size.height / 2);
            
        }
        self.shapeLayer = [[CAShapeLayer alloc] init];
    }
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
