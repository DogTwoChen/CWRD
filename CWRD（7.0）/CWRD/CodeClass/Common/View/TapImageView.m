//
//  TapImageView.m
//  CWRD
//
//  Created by lanou on 15/9/17.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "TapImageView.h"

@implementation TapImageView

-(instancetype)initWithFrame:(CGRect)frame target:(id)target action:(SEL)action {
    self = [super initWithFrame:frame];
    if (self) {
        //创建点击事件
        UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:imageTap];
    }
    return self;
}

@end
