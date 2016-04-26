//
//  ClassificationCollectionViewCell.m
//  CWRD
//
//  Created by lanou on 15/9/16.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "ClassificationCollectionViewCell.h"

@implementation ClassificationCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        
        
        self.post = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        self.post.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.post];
        
        self.showLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height / 2, width, 30)];
        self.showLabel.textColor = [UIColor whiteColor];
        self.showLabel.textAlignment = NSTextAlignmentCenter;
        self.showLabel.font = [UIFont boldSystemFontOfSize:16];
        [self.post addSubview:self.showLabel];
    }
    return self;
}
@end
