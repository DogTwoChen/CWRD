//
//  TopListTableViewCell.m
//  CWRD
//
//  Created by lanou on 15/9/17.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "TopListTableViewCell.h"

@implementation TopListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _picView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight/4)];
        _picView.contentMode =  UIViewContentModeScaleAspectFill;
        _picView.clipsToBounds = YES;
        
        _rankLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kHeight/20, kWidth, 20)];
        _rankLabel.textColor = [UIColor whiteColor];
        _rankLabel.font = [UIFont fontWithName:@"Lobster 1.4" size:16];
        _rankLabel.textAlignment = NSTextAlignmentCenter;

        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kHeight/10, kWidth, 25)];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:17];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kHeight/7.5, kWidth, 20)];
        _typeLabel.textColor = [UIColor whiteColor];
        _typeLabel.font = [UIFont fontWithName:@"Lobster 1.4" size:14];
        _typeLabel.textAlignment = NSTextAlignmentCenter;
        
        _rankNoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        
        [self addSubview:_picView];
        [self addSubview:_rankLabel];
        [self addSubview:_titleLabel];
        [self addSubview:_typeLabel];
    }
    return self;
}

- (void)setValueForCellWithModel:(DetailModel *)model {
    [_picView sd_setImageWithURL:[NSURL URLWithString:model.coverForDetail]];
    _titleLabel.text = model.title;
    
    _typeLabel.text = [NSString stringWithFormat:@"#%@ / %02d'%02d''", model.category, [model.duration intValue] / 60, [model.duration intValue] % 60];
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
