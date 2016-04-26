//
//  ReadingTableViewCell.h
//  CWRD
//
//  Created by lanou on 15/9/22.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReadingTableViewCell : UITableViewCell
//文章名
@property(nonatomic,strong)UILabel *title;
//配图
@property(nonatomic,strong)UIImageView *post;
//文章片段
@property(nonatomic,strong)UILabel *Info;
@end
