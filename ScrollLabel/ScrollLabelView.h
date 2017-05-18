//
//  ScrollLabelView.h
//  ScrollLabel
//
//  Created by liuyiyi on 2017/5/16.
//  Copyright © 2017年 liuyiyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollLabelView : UIView
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) UIFont *font;
@property (strong, nonatomic) UIColor *textColor;

- (void)setTitle:(NSString *)text font:(UIFont *)font ;

@end
