//
//  MyView.m
//  CWRD
//
//  Created by lanou on 15/9/17.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "MyView.h"

@implementation MyView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addView];
        
    }
    return self;
}

- (void)addView{
    
    //分割线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, kHeight /3, 260, 0.5)];
    lineView.backgroundColor = [UIColor cyanColor];
    [self addSubview:lineView];
    
    //我的收藏
    self.myCollection = [UIButton buttonWithType:UIButtonTypeCustom];
    self.myCollection.frame = CGRectMake(kWidth / 20, kHeight/2.5, 100, 30);
    [self.myCollection setTitle:@"我的收藏" forState:UIControlStateNormal];
    [self.myCollection setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    self.myCollection.titleLabel.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:12.0];
    self.myCollection.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
    [self addSubview:self.myCollection];
    

    
    //开关
    self.mySwitch = [UIButton buttonWithType:UIButtonTypeCustom];
    self.mySwitch.frame = CGRectMake(kWidth / 20, kHeight /2, 100, 30);
    [self.mySwitch setTitle:@"功能开关" forState:UIControlStateNormal];
    [self.mySwitch addTarget:self action:@selector(mySwitch) forControlEvents:UIControlEventTouchUpInside];
    [self.mySwitch setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    self.mySwitch.titleLabel.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:12.0];
    self.mySwitch.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
    [self addSubview:self.mySwitch];
    
    
    
    //更多
    self.more = [UIButton buttonWithType:UIButtonTypeCustom];
    self.more.frame = CGRectMake(kWidth / 20, kHeight /1.68, 100, 30);
    [self.more setTitle:@"更多" forState:UIControlStateNormal];
    [self.more addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
    [self.more setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    self.more.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
    self.more.titleLabel.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:12.0];
    [self addSubview:self.more];
    
}

@end




