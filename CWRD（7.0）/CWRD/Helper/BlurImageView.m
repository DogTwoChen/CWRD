//
//  BlurImageView.m
//  CWRD
//
//  Created by lanou on 15/9/18.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "BlurImageView.h"

@implementation BlurImageView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        //设置图片
        self.image = [UIImage imageNamed:@"12.jpg"];
        //创建模糊视图
        UIVisualEffectView *backVisual = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        //将模糊视图的大小等同于自身
        backVisual.frame = self.bounds;
        //设置模糊视图的透明度
        backVisual.alpha = 1;
        [self addSubview:backVisual];
        
    }
    return self;
}

@end
