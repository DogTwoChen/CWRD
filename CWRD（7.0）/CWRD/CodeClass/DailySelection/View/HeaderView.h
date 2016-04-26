//
//  HeaderView.h
//  CWRD
//
//  Created by lanou on 15/9/17.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderView : UIScrollView
@property (nonatomic, strong) NSTimer *aTimer;
@property (nonatomic, strong) TapImageView *touchImageView;
- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSMutableArray *)imageArray delegate:(id)delegate  action:(SEL)action timer:(NSTimeInterval)timer selector:(SEL)selector;
- (void)addTimerDelegate:(id)delegate timer:(NSTimeInterval)timer selector:(SEL)selector;
@end
