//
//  VideoTableViewCell.h
//  CWRD
//
//  Created by lanou on 15/9/22.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"

@interface VideoTableViewCell : UITableViewCell
//排行
@property(nonatomic,strong)UIImageView *rankLabel;
//背景图片
@property(nonatomic,strong)UIImageView *post;
//视频名称
@property(nonatomic,strong)UILabel *nameLabel;
//视频分类和时长
@property(nonatomic,strong)UILabel *classLabel;

- (void)setValueForCellWithModel:(DetailModel *)model;

@end
