//
//  DailyTableViewCell.h
//  CWRD
//
//  Created by lanou on 15/9/16.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DailySelectionModel.h"

@interface DailyTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *videoImageView;
@property (nonatomic, strong) UILabel *videoNamelabel;
@property (nonatomic, strong) UILabel *videoTypeAndTimeLabel;

- (void)setValueForCellWithModel:(DailySelectionModel *)model;

@end
