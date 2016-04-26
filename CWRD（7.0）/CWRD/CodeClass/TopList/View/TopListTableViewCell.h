//
//  TopListTableViewCell.h
//  CWRD
//
//  Created by lanou on 15/9/17.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"

@interface TopListTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *picView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *rankLabel;
@property (nonatomic, strong) UIImageView *rankNoView;

- (void)setValueForCellWithModel:(DetailModel *)model;

@end
