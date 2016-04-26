//
//  ReadingTableViewCell.m
//  CWRD
//
//  Created by lanou on 15/9/22.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "ReadingTableViewCell.h"

@implementation ReadingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //标题
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, kWidth - 5, 30)];
        self.title.backgroundColor = [UIColor clearColor];
        self.title.textColor = [UIColor whiteColor];
        self.title.textAlignment = NSTextAlignmentLeft;
        self.title.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:18.0];
        [self.contentView addSubview:self.title];
        
        //配图
        self.post = [[UIImageView alloc] initWithFrame:CGRectMake(10, 40, kWidth*2/5, kHeight/6.5)];
        self.post.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.post];
        
        self.Info = [[UILabel alloc] initWithFrame:CGRectMake(20+kWidth*2/5, 40, kWidth*39/75, kHeight/6.5)];
        self.Info.backgroundColor = [UIColor clearColor];
        self.Info.numberOfLines = 0;
        self.Info.textColor = [UIColor whiteColor];
        self.Info.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:self.Info];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, kHeight / 4 - 1, kWidth - 20, 1)];
        lineView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:lineView];
        
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
