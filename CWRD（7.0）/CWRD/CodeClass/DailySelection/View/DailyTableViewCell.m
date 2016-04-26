//
//  DailyTableViewCell.m
//  CWRD
//
//  Created by lanou on 15/9/16.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "DailyTableViewCell.h"

@implementation DailyTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor cyanColor];
        _videoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight/4)];
        _videoImageView.image = [UIImage imageNamed:@"80CC8F46-3602-4068-98A8-61F7C684AE03"];
        _videoImageView.backgroundColor = [UIColor blackColor];
        
        //使图片不拉伸
        _videoImageView.contentMode =  UIViewContentModeScaleAspectFill;
        _videoImageView.clipsToBounds = YES;
        
        [self.contentView addSubview:_videoImageView];
        
        
        _videoNamelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kHeight/10, kWidth, 30)];
        _videoNamelabel.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:17.0];

        _videoNamelabel.backgroundColor = [UIColor clearColor];
        _videoNamelabel.textColor = [UIColor whiteColor];
        _videoNamelabel.textAlignment = NSTextAlignmentCenter;
        [_videoImageView addSubview:_videoNamelabel];
        
        
        _videoTypeAndTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kHeight/7.5, kWidth, 30)];
        _videoTypeAndTimeLabel.font = [UIFont fontWithName:@"Lobster 1.4" size:15.0];
        _videoTypeAndTimeLabel.backgroundColor = [UIColor clearColor];
        _videoTypeAndTimeLabel.textColor = [UIColor whiteColor];
        _videoTypeAndTimeLabel.textAlignment = NSTextAlignmentCenter;
        [_videoImageView addSubview:_videoTypeAndTimeLabel];
        
    }
    return self;
}

- (void)setValueForCellWithModel:(DailySelectionModel *)model {

        //给图片赋值
    [_videoImageView sd_setImageWithURL:[NSURL URLWithString: model.coverForDetail ] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        _videoNamelabel.text = model.title;
//    }

    int min = [model.duration intValue]/ 60;
    int sec = [model.duration intValue]% 60;
    _videoTypeAndTimeLabel.text = [NSString stringWithFormat:@"#%@ / %02d'%02d''", model.category, min, sec];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
