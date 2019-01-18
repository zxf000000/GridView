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
    YZMovementsModelBallColorOther
};

@interface YZMovementsModel : NSObject
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, assign) NSInteger height;

@property (nonatomic, assign) BOOL hasLinePoint;

@property (nonatomic, assign) BgType bgType;

@property (nonatomic,copy) NSString  *title;

@property(nonatomic, assign) NSInteger row;
@property(nonatomic, assign) NSInteger column;

@property(nonatomic, assign) CGRect frame;

@property(nonatomic, assign) NSInteger lineSerialNumber;

@property(nonatomic, assign) YZMovementsModelPosition type;

@property(nonatomic, assign) YZMovementsModelBallColor ballColor;

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


