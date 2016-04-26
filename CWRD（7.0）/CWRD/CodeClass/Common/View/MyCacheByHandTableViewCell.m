//
//  MyCacheByHandTableViewCell.m
//  CWRD
//
//  Created by lanou on 15/9/18.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "MyCacheByHandTableViewCell.h"

@implementation MyCacheByHandTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.post = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 300)];
        self.post.backgroundColor = [UIColor brownColor];
        [self.contentView addSubview:self.post];
    }
    return self;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
