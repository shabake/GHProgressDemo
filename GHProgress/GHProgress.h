//
//  GHProgress.h
//  GHProgressDemo
//
//  Created by zhaozhiwei on 2019/5/22.
//  Copyright © 2019年 Hyman Stephens. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM (NSUInteger,GHProgressCircleLocation) {
    GHProgressCircleLocationBegin,
    GHProgressCircleLocationEnd,
};

typedef void(^GHProgressScaleBlock)(CGFloat scale);
@interface GHProgress : UIView

@property (nonatomic , assign) GHProgressCircleLocation circleLocation;

- (instancetype)initWithFrame:(CGRect)frame circleLocation: (GHProgressCircleLocation)circleLocation;

@property (nonatomic , copy) GHProgressScaleBlock scaleBlock;

/**
 * 设置circleCenterX 范围 [0 - [self getSliderHeight]]
 */
@property (nonatomic , assign) CGFloat circleCenterX;

///**
// * 返回比例block
// */
//@property (nonatomic , copy) GHAdjustFocalScaleBlock scaleBlock;

/**
 获取到circleCenterX
 
 @return circleCenterX
 */
- (CGFloat)getCircleCenterX;


/**
 获取滑杆的宽度
 
 @return 返回滑杆的宽度
 */
- (CGFloat)getSliderWidth;

/**
 * 顶部间距
 */
@property (nonatomic , assign) CGFloat marginY;

/**
 处理circleCenter 两端越界
 */
- (CGFloat)actionCircleCenterX: (CGFloat)circleCenterX;

@end

NS_ASSUME_NONNULL_END
