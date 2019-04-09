//
//  CompassImageView.h
//  CompassDemo
//
//  Created by fh on 2019/4/9.
//  Copyright © 2019年 fh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CompassImageView;

typedef NS_ENUM(NSUInteger, CompassTapDirection) {
    CompassTapDirectionNorth,           // 北
    CompassTapDirectionNorthEast,       // 东北
    CompassTapDirectionEast,            // 东
    CompassTapDirectionEastSouth,       // 东南
    CompassTapDirectionSouth,           // 南
    CompassTapDirectionSouthWest,       // 西南
    CompassTapDirectionWest,            // 西
    CompassTapDirectionWestNorth        // 西北
};

@protocol CompassImageViewDelegate <NSObject>

- (void)compassImageView:(CompassImageView *)imageView
      didSelectDirection:(CompassTapDirection)direction;

@end

@interface CompassImageView : UIImageView

@property (nonatomic, weak) id<CompassImageViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
