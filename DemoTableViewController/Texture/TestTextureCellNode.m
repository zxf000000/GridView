//
// Created by 云舟02 on 2019-01-23.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import "TestTextureCellNode.h"

@interface TestTextureCellNode ()

@property(nonatomic, strong) ASTextNode *textNode;

@end

@implementation TestTextureCellNode

- (instancetype)init {
    if (self = [super init]) {
        _textNode = [[ASTextNode alloc] init];
        _textNode.attributedText = [[NSAttributedString alloc] initWithString:@"123"];
        _textNode.backgroundColor = [UIColor redColor];
        [self addSubnode:_textNode];

    }
    return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {

    ASInsetLayoutSpec *inset = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(5, 5, 5, 5) child:_textNode];
    return inset;
}

@end