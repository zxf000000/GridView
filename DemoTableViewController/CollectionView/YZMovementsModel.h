//
//  YZMovementsModel.h
//  DemoTableViewController
//
//  Created by 云舟02 on 2019/1/18.
//  Copyright © 2019 云舟02. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BgType) {
    BgTypeCircle,
    BgTypeSquare,
    BgTypeFull,
    BgTypeNone,
};

typedef NS_ENUM(NSInteger, YZMovementsModelPosition) {
    YZMovementsModelPositionLeft,
    YZMovementsModelPositionTop,
    YZMovementsModelPositionDefault
};

typedef NS_ENUM(NSInteger, YZMovementsModelBallColor) {
    YZMovementsModelBallColorRed,
    YZMovementsModelBallColorBlue,
    YZMovementsModelBallColorBig,
    YZMovementsModelBallColorSmall,
    YZMovementsModelBallColorOther
};


typedef NS_ENUM(NSInteger, YZMovementsModelTitleColor) {
    YZMovementsModelTitleColorOrigin,
    YZMovementsModelTitleColorRed,
    YZMovementsModelTitleColorOther
};

@interface YZMovementsModel : NSObject
// 宽度和高度, 均为整数, 计算的时候为 基础 |itemWidth| 和 |itemHeight| 的整数倍数
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, assign) NSInteger height;
// 是否是连线的点
@property (nonatomic, assign) BOOL hasLinePoint;
// 背景的类型 -- 三种 (圆形, 方块, 整块色)
@property (nonatomic, assign) BgType bgType;
// 文字
@property (nonatomic,copy) NSString  *title;
// 当前item 位置的 行列
@property(nonatomic, assign) NSInteger row;
@property(nonatomic, assign) NSInteger column;
// 这个属性是通过CollectionViewLayout 根据上面的属性计算之后得到然后赋值,需要在画连接线的时候用到
@property(nonatomic, assign) CGRect frame;
// 连接线的编号,一张图上面可能有几条连接线
@property(nonatomic, assign) NSInteger lineSerialNumber;
// 当前model 属于 topTitle / leftTitle 还是 主体数据
@property(nonatomic, assign) YZMovementsModelPosition type;
// 背景颜色
@property(nonatomic, assign) YZMovementsModelBallColor ballColor;
// 标题颜色
@property(nonatomic, assign) YZMovementsModelTitleColor titleColor;
// 是否有角标
@property(nonatomic, assign) BOOL hasBadge;
// 角标的数字
@property(nonatomic, assign) NSInteger badgeNumber;

- (instancetype)initWithWidth:(NSInteger)width
                       height:(NSInteger)height
                 hasLinePoint:(BOOL)hasLinePoint
                       bgType:(BgType)bgType
                        title:(NSString *)title
                          row:(NSInteger)row
                       column:(NSInteger)column
             lineSerialNumber:(NSInteger)lineSerialNumber
                         type:(YZMovementsModelPosition)type;

+ (instancetype)modelWithWidth:(NSInteger)width
                        height:(NSInteger)height
                  hasLinePoint:(BOOL)hasLinePoint
                        bgType:(BgType)bgType
                         title:(NSString *)title
                           row:(NSInteger)row
                        column:(NSInteger)column
              lineSerialNumber:(NSInteger)lineSerialNumber
                          type:(YZMovementsModelPosition)type;



@end


