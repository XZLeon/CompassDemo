//
//  CompassImageView.m
//  CompassDemo
//
//  Created by fh on 2019/4/9.
//  Copyright © 2019年 fh. All rights reserved.
//

#import "CompassImageView.h"

@interface CompassImageView ()
// 北
@property (nonatomic, strong) UIBezierPath *northPath;
// 东北
@property (nonatomic, strong) UIBezierPath *northEastPath;
// 东
@property (nonatomic, strong) UIBezierPath *eastPath;
// 东南
@property (nonatomic, strong) UIBezierPath *eastSouthPath;
// 南
@property (nonatomic, strong) UIBezierPath *southPath;
// 西南
@property (nonatomic, strong) UIBezierPath *southWestPath;
// 西
@property (nonatomic, strong) UIBezierPath *westPath;
// 西北
@property (nonatomic, strong) UIBezierPath *westNorthPath;
@end

@implementation CompassImageView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupPath];
        
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *t = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        
        [self addGestureRecognizer:t];
    }
    return self;
}

- (void)setupPath {
    CGFloat radius = self.frame.size.width * 0.5;
    CGFloat imageViewCenterX = self.frame.size.width * 0.5;
    CGFloat imageViewCenterY = self.frame.size.height * 0.5;
    CGPoint imageViewCenter = CGPointMake(imageViewCenterX, imageViewCenterY);
    
    // 北
    _northPath = [UIBezierPath bezierPathWithArcCenter:imageViewCenter radius:radius startAngle:11 * M_PI / 8 endAngle:13 * M_PI / 8 clockwise:YES];
    [_northPath addLineToPoint:imageViewCenter];
    [_northPath closePath];
    
    // 东北
    _northEastPath = [UIBezierPath bezierPathWithArcCenter:imageViewCenter radius:radius startAngle:13 * M_PI / 8 endAngle:15 * M_PI / 8 clockwise:YES];
    [_northEastPath addLineToPoint:imageViewCenter];
    [_northEastPath closePath];
    
    // 东
    _eastPath = [UIBezierPath bezierPathWithArcCenter:imageViewCenter radius:radius startAngle:-M_PI / 8 endAngle:M_PI / 8  clockwise:YES];
    [_eastPath addLineToPoint:imageViewCenter];
    [_eastPath closePath];
    
    // 东南
    _eastSouthPath = [UIBezierPath bezierPathWithArcCenter:imageViewCenter radius:radius startAngle:M_PI / 8 endAngle:3 * M_PI / 8 clockwise:YES];
    [_eastSouthPath addLineToPoint:imageViewCenter];
    [_eastSouthPath closePath];
    
    // 南
    _southPath = [UIBezierPath bezierPathWithArcCenter:imageViewCenter radius:radius startAngle:3 * M_PI / 8 endAngle:5 * M_PI / 8 clockwise:YES];
    [_southPath addLineToPoint:imageViewCenter];
    [_southPath closePath];
    
    // 西南
    _southWestPath = [UIBezierPath bezierPathWithArcCenter:imageViewCenter radius:radius startAngle:5 * M_PI / 8 endAngle:7 * M_PI / 8 clockwise:YES];
    [_southWestPath addLineToPoint:imageViewCenter];
    [_southWestPath closePath];
    
    // 西
    _westPath = [UIBezierPath bezierPathWithArcCenter:imageViewCenter radius:radius startAngle:7 * M_PI / 8 endAngle:9 * M_PI / 8 clockwise:YES];
    [_westPath addLineToPoint:imageViewCenter];
    [_westPath closePath];
    
    // 西北
    _westNorthPath = [UIBezierPath bezierPathWithArcCenter:imageViewCenter radius:radius startAngle:9 * M_PI / 8 endAngle:11 * M_PI / 8 clockwise:YES];
    [_westNorthPath addLineToPoint:imageViewCenter];
    [_westNorthPath closePath];
}

- (void)tap:(UITapGestureRecognizer *)tap {
    CGPoint point = [tap locationInView:self];
    
    if ([self.delegate respondsToSelector:@selector(compassImageView:didSelectDirection:)]) {
        CompassTapDirection direction;
        if ([_northPath containsPoint:point]) {
            direction = CompassTapDirectionNorth;
        } else if ([_northEastPath containsPoint:point]) {
            direction = CompassTapDirectionNorthEast;
        } else if ([_eastPath containsPoint:point]) {
            direction = CompassTapDirectionEast;
        } else if ([_eastSouthPath containsPoint:point]) {
            direction = CompassTapDirectionEastSouth;
        } else if ([_southPath containsPoint:point]) {
            direction = CompassTapDirectionSouth;
        } else if ([_southWestPath containsPoint:point]) {
            direction = CompassTapDirectionSouthWest;
        } else if ([_westPath containsPoint:point]) {
            direction = CompassTapDirectionWest;
        } else {
            direction = CompassTapDirectionWestNorth;
        }
        [self.delegate compassImageView:self didSelectDirection:direction];
    }
}

@end
