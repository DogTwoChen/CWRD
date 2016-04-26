//
//  TimeTableViewCell.m
//  CWRD
//
//  Created by lanou on 15/9/18.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "TimeTableViewCell.h"

@implementation TimeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addView];
    }
    return self;
}

- (void)addView{
    
    self.post = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight/4)];
    //self.post.backgroundColor = [UIColor brownColor];
    self.post.contentMode =  UIViewContentModeScaleAspectFill;
    self.post.clipsToBounds = YES;
    [self addSubview:self.post];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kHeight/10, kWidth, 30)];
    //self.nameLabel.backgroundColor = [UIColor orangeColor];
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:17];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.post addSubview:self.nameLabel];
    
    self.classLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kHeight/7.5, kWidth, 30)];
    //self.classLabel.backgroundColor = [UIColor blackColor];
    self.classLabel.textColor = [UIColor whiteColor];
    self.classLabel.textAlignment = NSTextAlignmentCenter;
    self.classLabel.font = [UIFont fontWithName:@"Lobster 1.4" size:14];
    [self.post addSubview:self.classLabel];
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
