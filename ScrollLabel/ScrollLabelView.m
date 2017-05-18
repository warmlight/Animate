//
//  ScrollLabelView.m
//  ScrollLabel
//
//  Created by liuyiyi on 2017/5/16.
//  Copyright © 2017年 liuyiyi. All rights reserved.
//

#import "ScrollLabelView.h"


@interface ScrollLabelView ()
@property (nonatomic, strong) CAReplicatorLayer *replicatorLayer;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, assign) NSInteger subLayerCount;
@end

@implementation ScrollLabelView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.clipsToBounds = YES;
    return self;
}

- (void)setTitle:(NSString *)text font:(UIFont *)font {
    self.nameLabel.text = text;
    self.nameLabel.font = font;
    CGSize sizeThatFit = [self.nameLabel sizeThatFits:CGSizeZero];
    CGFloat labelWidth = sizeThatFit.width;
    
    if (labelWidth > self.frame.size.width) {
        labelWidth += 50;
    }
    self.nameLabel.frame = CGRectMake(0, 0, labelWidth, self.frame.size.height);
    self.nameLabel.layer.position = CGPointMake(labelWidth / 2, self.nameLabel.frame.size.height / 2);
    
    [self configAnimate];
}

- (void)configAnimate {
    self.subLayerCount = 1;
    if (self.nameLabel.frame.size.width > self.frame.size.width) {
        self.subLayerCount = 2;
        [self startAnimation];
    }
    
    [self.layer addSublayer:self.replicatorLayer];
    [self.replicatorLayer addSublayer:self.nameLabel.layer];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    self.nameLabel.textColor = textColor;
}

#pragma mark over ride

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self makeLayoutForSelf];
}

- (void)makeLayoutForSelf {
    UIView *superView = self.superview;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1 constant:self.frame.size.width]];
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1 constant:self.frame.size.height]];
}

- (void)startAnimation {
    [self.nameLabel.layer removeAllAnimations];
    CABasicAnimation *baseAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    baseAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.nameLabel.frame.size.width / 2, self.nameLabel.frame.size.height / 2)];
    baseAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(- self.nameLabel.frame.size.width / 2, self.nameLabel.frame.size.height / 2)];
    baseAnimation.duration = self.nameLabel.frame.size.width / 20 ;
    baseAnimation.repeatCount = CGFLOAT_MAX;
    baseAnimation.removedOnCompletion = NO;
    [self.nameLabel.layer addAnimation:baseAnimation forKey:@"'shrink"];
}


- (CAReplicatorLayer *)replicatorLayer {
    if (!_replicatorLayer) {
        _replicatorLayer = [CAReplicatorLayer layer];
        _replicatorLayer.bounds = CGRectMake(0, 0, self.nameLabel.frame.size.width * self.subLayerCount, self.nameLabel.frame.size.height);
        _replicatorLayer.instanceCount = self.subLayerCount;
        _replicatorLayer.instanceTransform = CATransform3DMakeTranslation(self.nameLabel.frame.size.width, 0, 0);
        _replicatorLayer.position = CGPointMake(self.nameLabel.frame.size.width / (self.subLayerCount == 1 ? 2 : 1), self.nameLabel.frame.size.height / 2);
    }
    
    return _replicatorLayer;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
    }
    
    return _nameLabel;
}

@end
