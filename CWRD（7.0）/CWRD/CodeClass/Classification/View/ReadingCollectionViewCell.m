//
//  ReadingCollectionViewCell.m
//  CWRD
//
//  Created by lanou on 15/9/22.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "ReadingCollectionViewCell.h"

@implementation ReadingCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        
        
        self.post = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        
        //使图片不拉伸
        _post.contentMode =  UIViewContentModeScaleAspectFill;
        _post.clipsToBounds = YES;
        self.post.backgroundColor = [UIColor clearColor];
        [self addSubview:self.post];
        
        self.showLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height / 2, width, 30)];
        self.showLabel.backgroundColor = [UIColor blackColor];
        self.showLabel.alpha = 0.5;
        self.showLabel.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:15.0];
        self.showLabel.textAlignment = NSTextAlignmentCenter;
        self.showLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.showLabel];
        
    }
    return self;
}
@end
