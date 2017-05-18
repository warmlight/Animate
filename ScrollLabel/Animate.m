//
//  Animate.m
//  ScrollLabel
//
//  Created by liuyiyi on 2017/5/16.
//  Copyright © 2017年 liuyiyi. All rights reserved.
//

#import "Animate.h"

@implementation Animate
+ (CALayer *)circle {
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.frame = CGRectMake(0, 0, 80, 80);
    shape.path = [UIBezierPath bezierPathWithRoundedRect:shape.frame cornerRadius:40].CGPath;
    shape.fillColor = [UIColor redColor].CGColor;
    shape.opaque = 0;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[[Animate alphaAnimation], [Animate scaleAnimation]];
    animationGroup.duration = 3;
    animationGroup.repeatCount = MAXFLOAT;
    [shape addAnimation:animationGroup forKey:@"group"];
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake(0, 0, 80, 80);
    replicatorLayer.instanceDelay = 1;
    replicatorLayer.instanceCount = 3;
    [replicatorLayer addSublayer:shape];
    return replicatorLayer;
    
}

+ (CALayer *)wave {
    CALayer *dotLayer = [CALayer layer];
    dotLayer.frame = CGRectMake(0, 0, 40, 40);
    dotLayer.cornerRadius = 20;
    dotLayer.backgroundColor = [UIColor redColor].CGColor;
    [dotLayer addAnimation:[Animate scaleAnimation1] forKey:@"animate"];
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake(0, 0, 40 * 3 + 20, 80);
    replicatorLayer.instanceDelay = 0.2;
    replicatorLayer.instanceCount = 3;
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(50,0,0);
    [replicatorLayer addSublayer:dotLayer];

    
    return replicatorLayer;
}

+ (CALayer *)triangle {
    CGFloat radius = 100/4;
    CGFloat transX = 100 - radius;
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.borderWidth = 1;
    shape.frame = CGRectMake(0, 0, radius, radius);
    {
        UIBezierPath *path = [UIBezierPath new];
        [path moveToPoint:CGPointMake(radius / 2, 0)];
        [path addLineToPoint:CGPointMake(radius, radius)];
        [path addLineToPoint:CGPointMake(0, radius)];
        [path addLineToPoint:CGPointMake(radius / 2, 0)];
        shape.path = path.CGPath;
    }
    shape.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius, radius)].CGPath;
    shape.strokeColor = [UIColor redColor].CGColor;
    shape.fillColor = [UIColor redColor].CGColor;
    shape.lineWidth = 1;
    [shape addAnimation:[Animate rotationAnimation:transX] forKey:@"rotateAnimation"];
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.borderWidth = 1;
    replicatorLayer.frame = CGRectMake(200, 200, radius, radius);
    replicatorLayer.instanceDelay = 0.0;
    replicatorLayer.instanceCount = 4;
    
    CATransform3D trans3D = CATransform3DIdentity;
//    trans3D = CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0);

    trans3D = CATransform3DTranslate(trans3D, transX, 0, 0);

    trans3D = CATransform3DRotate(trans3D, M_PI_2, 0, 0, 1);  //会旋转instance的坐标系？？？？？？


//    trans3D = CATransform3DMakeRotation(120.0*M_PI/180.0, 0.0, 0.0, 1.0);



    replicatorLayer.instanceTransform = trans3D;
    [replicatorLayer addSublayer:shape];
    
    return replicatorLayer;
}

+ (CALayer *)grid {
    NSInteger column = 3;
    CGFloat between = 5;
    CGFloat radius = (100 - between * (column - 1)) / column;
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.frame = CGRectMake(0, 0, radius, radius);
    shape.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius, radius)].CGPath;
    shape.fillColor = [UIColor redColor].CGColor;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[[Animate scaleAnimation1], [Animate alphaAnimation]];
    animationGroup.duration = 1;
    animationGroup.autoreverses = YES;
    animationGroup.repeatCount = HUGE;
    [shape addAnimation:animationGroup forKey:@"grid"];
    
    CAReplicatorLayer *replicatorLayerX = [CAReplicatorLayer layer];
    replicatorLayerX.frame = CGRectMake(0, 0, 100, 100);
    replicatorLayerX.instanceDelay = 0.3;
    replicatorLayerX.instanceCount = column;
    replicatorLayerX.instanceTransform = CATransform3DTranslate(CATransform3DIdentity, radius+between, 0, 0);
    [replicatorLayerX addSublayer:shape];
    
    CAReplicatorLayer *replicatorLayerY = [CAReplicatorLayer layer];
    replicatorLayerY.frame = CGRectMake(0, 0, 100, 100);
    replicatorLayerY.instanceDelay = 0.3;
    replicatorLayerY.instanceCount = column;
    replicatorLayerY.instanceTransform = CATransform3DTranslate(CATransform3DIdentity, 0, radius+between, 0);
    [replicatorLayerY addSublayer:replicatorLayerX];
    
    return replicatorLayerY;
}

+ (CALayer *)shake {
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(100, 100, 100, 50);
    layer.backgroundColor = [UIColor redColor].CGColor;

    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.repeatCount = HUGE;
    group.autoreverses= YES;
    group.duration = 2;
    group.animations = @[[Animate shakeAnimate], [Animate shakeScale], [Animate shakePosition]];
    
    [layer addAnimation:group forKey:@"shake"];
    
    return layer;
}

+ (CABasicAnimation *)shakeScale {
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scale.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.0, 0.0, 0.0)];
    scale.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0.0)];
    scale.repeatCount = HUGE;
    
    return scale;
}

+ (CABasicAnimation *)shakePosition {
    CABasicAnimation *position = [CABasicAnimation animationWithKeyPath:@"position.y"];
    position.fromValue = @100;
    position.toValue = @300;
    
    return position;
}


+ (CAKeyframeAnimation *)shakeAnimate {
    CAKeyframeAnimation *shake = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    shake.values = @[@-0.2, @0.2, @-0.2];
    shake.duration = 2;
    shake.repeatCount = HUGE;
    
    return shake;
}

+ (CABasicAnimation *)alphaAnimation {
    CABasicAnimation *alpha = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alpha.fromValue = @1;
    alpha.toValue = @0;

    return alpha;
}

+ (CABasicAnimation *)scaleAnimation {
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    scale.repeatCount = MAXFLOAT;
    scale.duration = 1;
    scale.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.0, 0.0, 0.0)];
    scale.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0.0)];
    return scale;
}

+ (CABasicAnimation *)scaleAnimation1 {
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    scale.repeatCount = MAXFLOAT;
    scale.autoreverses = YES;
    scale.duration = 0.5;
    scale.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.0, 0.0, 0.0)];
    scale.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0.0)];
    return scale;
}

+ (CABasicAnimation *)rotationAnimation:(CGFloat)transX{
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D fromValue = CATransform3DRotate(CATransform3DIdentity, 0.0, 0.0, 0.0, 0.0);
    scale.fromValue = [NSValue valueWithCATransform3D:fromValue];
    CATransform3D toValue = CATransform3DTranslate(CATransform3DIdentity, transX, 0.0, 0.0);
    
    scale.toValue = [NSValue valueWithCATransform3D:toValue];
    scale.autoreverses = NO;
    scale.repeatCount = HUGE;
    scale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scale.duration = 0.8;
    return scale;
}
@end
