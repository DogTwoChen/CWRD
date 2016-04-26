//
//  ReadingDeatilTableViewController.h
//  CWRD
//
//  Created by lanou on 15/9/22.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReadingDeatilTableViewController : UITableViewController
@property (nonatomic, strong) NSMutableArray *articleArray;
@property (nonatomic, strong) NSString *typeid;
@property (nonatomic, strong) NSString *name;
@end
