//
//  ClassDeatilViewController.h
//  CWRD
//
//  Created by lanou on 15/9/18.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassDeatilViewController : UIViewController
//按时间排序
@property(nonatomic,strong)UITableView *timeView;
//分享排行榜
@property(nonatomic,strong)UITableView *shareView;
//分类界面传过来的url数组
@property(nonatomic,strong)NSArray *timeAndShare;
//分类
@property(nonatomic,strong)NSString *classTitle;

@end
