//
//  WordCollectionViewCell.m
//  CWRD
//
//  Created by lanou on 15/9/21.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "WordCollectionViewCell.h"

@implementation WordCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //获取当前cell的宽和高
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        
        self.post = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        self.post.backgroundColor = [UIColor clearColor];
        //使图片不拉伸
        self.post.contentMode =  UIViewContentModeScaleAspectFill;
        self.post .clipsToBounds = YES;
        
        [self addSubview:self.post];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 70, 100, 30)];
        self.nameLabel.backgroundColor = [UIColor cyanColor];
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 75, width, 30)];
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height / 2, width, 30)];
        self.nameLabel.backgroundColor = [UIColor blackColor];
        self.nameLabel.alpha = 0.5;
        self.nameLabel.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:15.0];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.textColor = [UIColor whiteColor];
        [self.post addSubview:self.nameLabel];
        
    }
    return self;
}

@end
