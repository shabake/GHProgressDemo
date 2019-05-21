//
//  GHProgress.m
//  GHProgressDemo
//
//  Created by zhaozhiwei on 2019/5/22.
//  Copyright © 2019年 Hyman Stephens. All rights reserved.
//

#import "GHProgress.h"
#import "UIView+Extension.h"

@interface GHProgress()

/**
 背景
 */
@property (nonatomic , strong) UIView *backGround;

/**
 圆头
 */
@property (nonatomic , strong) UIView *circle;

/**
 滑杆
 */
@property (nonatomic , strong) UIView *slider;


@end

@implementation GHProgress

#pragma mark - set
- (void)setCircleCenterX:(CGFloat)circleCenterX {
    _circleCenterX = circleCenterX;
    self.circle.centerx = circleCenterX;

    for (CAShapeLayer *layer in self.slider.layer.sublayers) {
        [layer removeFromSuperlayer];
    }
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = CGRectMake(0, 0,circleCenterX - 25, self.slider.height);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.slider.layer addSublayer:layer];
//
//    CGFloat scale = ([self getSliderHeight] - circleCenterY)/[self getSliderHeight] ;/// 计算比例
    
    //    if (self.scaleBlock) {
    //        self.scaleBlock(scale);
    //    }
}

//- (void)setCircleLocation:(GHAdjustFocalCircleLocation)circleLocation {
//    _circleLocation = circleLocation;
//    self.circle.y = self.circleLocation == GHAdjustFocalCircleLocationBottom ? self.slider.height -self.circle.height * 0.5 :-self.circle.height * 0.5;
//}


- (CGFloat)getCircleCenterX {
    return self.circle.centerx;
}

- (CGFloat)getSliderWidth {
    return self.slider.width;
}

#pragma mark - 自定义初始化
- (instancetype)initWithFrame:(CGRect)frame circleLocation: (GHProgressCircleLocation)circleLocation{
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
        [self configuration];
        self.circleLocation = circleLocation;
    }
    return self;
}

#pragma mark - 初始化
- (instancetype)init {
    if (self == [super init]) {
        [self setupUI];
        [self configuration];
    }
    return self;
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
        [self configuration];
    }
    return self;
}

- (void)configuration {
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = CGRectMake(0, 0, self.slider.width, self.slider.height);
    layer.backgroundColor = [UIColor darkGrayColor].CGColor;
    [self.slider.layer addSublayer:layer];
}

#pragma mark - 创建UI
- (void)setupUI {
    
    // 获取总宽,总高
    CGFloat totalHeight = self.bounds.size.height; /// 总长度
    CGFloat totalWidth = self.bounds.size.width;   /// 总宽度
    
    // 子view的大小等于父view
    CGFloat backGroundY = 0;
    CGFloat backGroundW = totalWidth;
    CGFloat backGroundX = 0;
    CGFloat backGroundH = totalHeight;
    self.backGround.frame = CGRectMake(backGroundX, backGroundY, backGroundW, backGroundH);
    
    // 设置轨道的frame
    CGFloat sliderH = 20;
    CGFloat sliderY = (totalHeight - 20) *.5;
    CGFloat sliderX = 25;
    CGFloat sliderW = totalWidth - 50;
    self.slider.frame = CGRectMake(sliderX, sliderY, sliderW, sliderH);

    // 设置圆圈的frame
    CGFloat circleH = totalHeight;
    CGFloat circleW = circleH;
    CGFloat circleX = 0;
    CGFloat circleY = 0;
    self.circle.frame = CGRectMake(circleX,circleY, circleW, circleH);
    
    /// 添加到view上
    [self addSubview:self.backGround];
    [self.backGround addSubview:self.slider];
    [self.backGround addSubview:self.circle];
}

#pragma mark - private
- (CGFloat)actionCircleCenterX: (CGFloat)circleCenterX {
    if (circleCenterX <= 25) {
        circleCenterX = 25;
    }
    
    if (circleCenterX >= [self getSliderWidth] + 25) {
        circleCenterX = [self getSliderWidth] + 25;
    }
    return circleCenterX;
}

- (void)panView:(UIPanGestureRecognizer *)panGest{
    
    CGPoint trans = [panGest translationInView:panGest.view];
    
    CGFloat circleCenterX = [self getCircleCenterX] ; /// 获取到circleX
    
    circleCenterX += trans.x; /// circleCenterX 累加
    circleCenterX = [self actionCircleCenterX:circleCenterX];
    self.circleCenterX = circleCenterX; /// 设置circleCenterY
    [panGest setTranslation:CGPointZero inView:panGest.view];
    CGFloat totalWidth = [self getSliderWidth]; /// 获取滑动总长度
    CGFloat scale = 1 - (totalWidth - circleCenterX + 25)/totalWidth;/// 计算比例
    
    if (self.scaleBlock) {
        self.scaleBlock(scale);
    }
}
#pragma mark - get

- (UIView *)circle {
    if (_circle == nil) {
        _circle = [[UIView alloc]init];
        _circle.backgroundColor = [UIColor yellowColor];
        _circle.layer.masksToBounds = YES;
        _circle.layer.cornerRadius = 25;
        UIPanGestureRecognizer *panGest = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panView:)];
        panGest.minimumNumberOfTouches = 1;
        [_circle addGestureRecognizer:panGest];
    }
    return _circle;
}

- (UIView *)slider {
    if (_slider == nil) {
        _slider = [[UIView alloc]init];
        _slider.backgroundColor = [UIColor blackColor];
        _slider.layer.masksToBounds = YES;
        _slider.layer.cornerRadius = 10;
    }
    return _slider;
}

- (UIView *)backGround {
    if (_backGround == nil) {
        _backGround = [[UIView alloc]init];
        _backGround.backgroundColor = [UIColor redColor];
    }
    return _backGround;
}

@end
