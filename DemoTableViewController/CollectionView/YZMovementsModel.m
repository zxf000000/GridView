//
//  YZMovementsModel.m
//  DemoTableViewController
//
//  Created by 云舟02 on 2019/1/18.
//  Copyright © 2019 云舟02. All rights reserved.
//

#import "YZMovementsModel.h"

@implementation YZMovementsModel
- (instancetype)initWithWidth:(NSInteger)width
                       height:(NSInteger)height
                 hasLinePoint:(BOOL)hasLinePoint
                       bgType:(BgType)bgType
                        title:(NSString *)title
                          row:(NSInteger)row
                       column:(NSInteger)column
             lineSerialNumber:(NSInteger)lineSerialNumber
        type:(YZMovementsModelPosition)type {
    self = [super init];
    if (self) {
        _width = width;
        _height = height;
        _hasLinePoint = hasLinePoint;
        _bgType = bgType;
        _title = title;
        _row = row;
        _column = column;
        _lineSerialNumber = lineSerialNumber;
        _type = type;
    }

    return self;
}

+ (instancetype)modelWithWidth:(NSInteger)width
                        height:(NSInteger)height
                  hasLinePoint:(BOOL)hasLinePoint
                        bgType:(BgType)bgType
                         title:(NSString *)title
                           row:(NSInteger)row
                        column:(NSInteger)column
              lineSerialNumber:(NSInteger)lineSerialNumber
                          type:(YZMovementsModelPosition)type {
    return [[self alloc]
                  initWithWidth:width height:height hasLinePoint:hasLinePoint bgType:bgType title:title row:row column:column lineSerialNumber:lineSerialNumber type:
    type];
}


@end
