//
//  VideoCollectionReusableView.m
//  CWRD
//
//  Created by lanou on 15/9/21.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "VideoCollectionReusableView.h"

@implementation VideoCollectionReusableView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];
        //获取当前增广视图的宽和高
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, width - 100, height)];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:13.0];
        [self addSubview:self.nameLabel];
        
        self.more = [UIButton buttonWithType:UIButtonTypeCustom];
        self.more.frame = CGRectMake(width - 60, 0, 60, height);
        self.more.titleLabel.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:11.0];
        [self.more setTitle:@"查看所有" forState:UIControlStateNormal];
        [self.more setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
        [self addSubview:self.more];
        
    }
    return self;
}
@end
