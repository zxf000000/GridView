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
             lineSerialNumber:(NSInteger)lineSerialNumber {
    self = [super init];
    if (self) {
        self.width = width;
        self.height = height;
        self.hasLinePoint = hasLinePoint;
        self.bgType = bgType;
        self.title = title;
        self.row = row;
        self.column = column;
        self.lineSerialNumber = lineSerialNumber;
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
              lineSerialNumber:(NSInteger)lineSerialNumber {
    return [[self alloc]
                  initWithWidth:width height:height hasLinePoint:hasLinePoint bgType:bgType title:title row:row column:column lineSerialNumber:lineSerialNumber];
}


@end
