//
// Created by 云舟02 on 2019-01-17.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import "ZXFFormItemLayout.h"

@interface ZXFFormItemLayout()

@property(nonatomic, assign) CGRect frame;



@end


@implementation ZXFFormItemLayout


- (instancetype)initWithRow:(NSInteger)row
                     column:(NSInteger)column
                      width:(NSInteger)width
                     height:(NSInteger)height
               hasLinePoint:(BOOL)hasLinePoint
           lineSerialNumber:(NSInteger)lineSerialNumber {
    self = [super init];
    if (self) {
        self.row = row;
        self.column = column;
        self.width = width;
        self.height = height;
        self.hasLinePoint = hasLinePoint;
        self.lineSerialNumber = lineSerialNumber;
    }

    return self;
}

+ (instancetype)layoutWithRow:(NSInteger)row
                       column:(NSInteger)column
                        width:(NSInteger)width
                       height:(NSInteger)height
                 hasLinePoint:(BOOL)hasLinePoint
             lineSerialNumber:(NSInteger)lineSerialNumber {
    return [[self alloc]
                  initWithRow:row column:column width:width height:height hasLinePoint:hasLinePoint lineSerialNumber:lineSerialNumber];
}


- (void)setFrame:(CGRect)frame {
    _frame = frame;

}

@end