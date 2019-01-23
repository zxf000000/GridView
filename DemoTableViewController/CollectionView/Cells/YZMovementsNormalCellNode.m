//
//  YZMovementsNormalCellNode.m
//  DemoTableViewController
//
//  Created by 云舟02 on 2019/1/23.
//  Copyright © 2019 云舟02. All rights reserved.
//

#import "YZMovementsNormalCellNode.h"
#import <YYText.h>
#import "YZMovementsCollectionViewCell.h"


#define ssRGBHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]



@interface YZMovementsNormalCellNode ()

@property (strong, nonatomic) ASTextNode  *textNode;
@property (strong, nonatomic) ASDisplayNode  *bgNode;
@property(nonatomic, strong) UIColor *darkDataColor;
@property(nonatomic, strong) UIColor *dataColor;
@property(nonatomic, strong) UIColor *titleColor;

@property (strong, nonatomic) ASTextNode  *badgeNode;

@property (strong, nonatomic) ASDisplayNode  *leftLine;
@property (strong, nonatomic) ASDisplayNode  *rightLine;


@end


@implementation YZMovementsNormalCellNode

- (instancetype)initWithModel:(YZMovementsModel *)model {
    if  (self = [super init]) {
        _model = model;
        
        _bgNode = [[ASDisplayNode alloc] init];
        [self addSubnode:_bgNode];
        
        _textNode = [[ASTextNode alloc] init];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:model.title];
        [string setYy_font:[UIFont systemFontOfSize:10]];
        [string setYy_alignment:NSTextAlignmentCenter];

        [self addSubnode:_textNode];
    
        if (model.hasBadge) {
            _badgeNode = [[ASTextNode alloc] init];
            _badgeNode.backgroundColor = [UIColor blueColor];
            NSMutableAttributedString *badgetext = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%zd",model.badgeNumber] attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:8],NSForegroundColorAttributeName: [UIColor whiteColor]}];
            [badgetext setYy_alignment:(NSTextAlignmentCenter)];
            _badgeNode.attributedText = badgetext;
            
            [self addSubnode:_badgeNode];
        }
        
        _leftLine = [[ASDisplayNode alloc] init];
        _leftLine.backgroundColor = ssRGBHex(0xE1E1E1);
        [self addSubnode:_leftLine];

        _rightLine = [[ASDisplayNode alloc] init];
        _rightLine.backgroundColor = ssRGBHex(0xE1E1E1);
        [self addSubnode:_rightLine];
        
        _titleColor = [UIColor colorWithRed:240/255.0 green:235/255.0 blue:229/255.0 alpha:1.0];
        _dataColor = [UIColor colorWithRed:248/255.0 green:247/255.0 blue:243/255.0 alpha:1.0];
        _darkDataColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        
        switch (model.type) {
            case YZMovementsModelPositionLeft: {
                if (model.row % 2 == 0) {
                    self.backgroundColor = _titleColor;
                } else {
                    self.backgroundColor = _dataColor;
                }
                break;
            }
            case YZMovementsModelPositionDefault:{
                if (model.row % 2 == 0) {
                    self.backgroundColor = _darkDataColor;
                } else {
                    self.backgroundColor = _dataColor;
                }
                break;
            }
            case YZMovementsModelPositionTop: {
                if (model.row % 2 == 0) {
                    self.backgroundColor = _titleColor;
                } else {
                    self.backgroundColor = _dataColor;
                }
                break;
            }
        }

        switch (self.model.ballColor) {
                
            case YZMovementsModelBallColorRed:
            {
                _bgNode.backgroundColor = [UIColor redColor];
                [string setYy_color:[UIColor whiteColor]];
            }
                break;
            case YZMovementsModelBallColorBlue:{
                _bgNode.backgroundColor = [UIColor blueColor];
                [string setYy_color:[UIColor whiteColor]];

            }
                break;
            case YZMovementsModelBallColorCyan:
            case YZMovementsModelBallColorBig: {
                _bgNode.backgroundColor = ssRGBHex(0xC9F4E9);
                [string setYy_color:[UIColor blackColor]];

            }
                break;
            case YZMovementsModelBallColorSmall: {
                _bgNode.backgroundColor = ssRGBHex(0xFFDCB9);
                [string setYy_color:[UIColor blackColor]];
            }
                break;
            case YZMovementsModelBallColorOther: {
                _bgNode.backgroundColor = [UIColor clearColor];
                [string setYy_color:[UIColor blackColor]];
                break;
            }
        }
        
        switch (self.model.bgType) {

            case BgTypeNone:
            {
                _bgNode.backgroundColor = [UIColor clearColor];
                [string setYy_color:[UIColor blackColor]];

                break;
            }
            default:
            {
                
            }
                break;
        }
        
        _textNode.attributedText = string;
    }
    return self;
}


- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    
    CGSize maxSize = constrainedSize.max;
    CGFloat radius = (MIN(maxSize.width, maxSize.height)) / 2 - YZMovementsCellBallMargin;

    _leftLine.style.preferredSize = CGSizeMake(0.2, maxSize.height);
    _rightLine.style.preferredSize = CGSizeMake(0.2, maxSize.height);
    
    switch (self.model.bgType) {
        case BgTypeCircle:
        {
            self.bgNode.style.preferredSize = CGSizeMake(radius * 2, radius * 2);
            self.bgNode.cornerRadius = radius;
            self.bgNode.clipsToBounds = YES;
            
        }
            break;
        case BgTypeNone:
        {
            self.bgNode.style.preferredSize = maxSize;

            break;
        }
        case BgTypeSquare:
        {
            self.bgNode.style.preferredSize = CGSizeMake(radius * 2, radius * 2);
            
            break;
        }
        default:
        {
            self.bgNode.style.preferredSize = maxSize;
        }
            break;
    }

    ASCenterLayoutSpec *centerText = [ASCenterLayoutSpec centerLayoutSpecWithCenteringOptions:(ASCenterLayoutSpecCenteringXY) sizingOptions:(ASCenterLayoutSpecSizingOptionDefault) child:_textNode];
    ASOverlayLayoutSpec *overLayout = [ASOverlayLayoutSpec overlayLayoutSpecWithChild:_bgNode overlay:centerText];
    
    if (self.model.hasBadge) {
        _badgeNode.style.preferredSize = CGSizeMake(10, 10);
        _badgeNode.cornerRadius = 5;
        _badgeNode.clipsToBounds = YES;
        ASCornerLayoutSpec *corner = [ASCornerLayoutSpec cornerLayoutSpecWithChild:overLayout corner:_badgeNode location:(ASCornerLayoutLocationTopRight)];
        return [ASCenterLayoutSpec centerLayoutSpecWithCenteringOptions:(ASCenterLayoutSpecCenteringXY) sizingOptions:(ASCenterLayoutSpecSizingOptionDefault) child:corner];
    }
    
    ASCenterLayoutSpec *center =  [ASCenterLayoutSpec centerLayoutSpecWithCenteringOptions:(ASCenterLayoutSpecCenteringXY) sizingOptions:(ASCenterLayoutSpecSizingOptionDefault) child:overLayout];
    
    ASStackLayoutSpec *layout = [ASStackLayoutSpec stackLayoutSpecWithDirection:(ASStackLayoutDirectionHorizontal) spacing:0 justifyContent:(ASStackLayoutJustifyContentSpaceBetween) alignItems:(ASStackLayoutAlignItemsCenter) children:@[_leftLine,center,_rightLine]];
    
    return layout;
}

@end
