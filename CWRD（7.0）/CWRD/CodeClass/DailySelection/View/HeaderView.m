//
//  HeaderView.m
//  CWRD
//
//  Created by lanou on 15/9/17.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "HeaderView.h"
#import "DailySelectionModel.h"
@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSMutableArray *)imageArray delegate:(id)delegate  action:(SEL)action timer:(NSTimeInterval)timer selector:(SEL)selector {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        
        NSMutableArray *insertArr = [NSMutableArray arrayWithArray:imageArray];
        //把imageArray的第0张插入到最后
        [insertArr insertObject:[imageArray objectAtIndex:0] atIndex:imageArray.count];
        //把imageArray的最后第二张插到最前
        [insertArr insertObject:[imageArray objectAtIndex:imageArray.count - 1] atIndex:0];
        
        //设置ScrollerView的contentSize
        self.contentSize = CGSizeMake(kWidth * [insertArr count], 0);
        //是否允许整页翻
        self.pagingEnabled = YES;
        //水平滚动条
        self.showsHorizontalScrollIndicator = YES;
        //代理
        self.delegate = delegate;
        //边界回弹
        self.bounces = NO;
        //第一显示坐标
        self.contentOffset = CGPointMake(kWidth, 0);
        
        //循环创建ImageView
        for (int i = 0; i < insertArr.count; i++) {
            DailySelectionModel *model = insertArr[i];
            self.touchImageView = [[TapImageView alloc]initWithFrame:CGRectMake(kWidth * i, 0, kWidth, self.bounds.size.height) target:delegate action:action];
            self.touchImageView.image = [UIImage imageNamed:@"image009.jpg"];
            self.touchImageView.contentMode =  UIViewContentModeScaleAspectFill;
            self.touchImageView.clipsToBounds = YES;
            
            
            UILabel *videoNamelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kHeight / 9, kWidth, 30)];
            videoNamelabel.text = @"PAEFMAPODMFAASDF";
            videoNamelabel.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:17.0];
            videoNamelabel.backgroundColor = [UIColor clearColor];
            videoNamelabel.textColor = [UIColor whiteColor];
            videoNamelabel.textAlignment = NSTextAlignmentCenter;
            [self.touchImageView addSubview:videoNamelabel];
            
            
            UILabel *videoTypeAndTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,  kHeight / 7, kWidth, 30)];
            videoTypeAndTimeLabel.font = [UIFont fontWithName:@"Lobster 1.4" size:17.0];
            videoTypeAndTimeLabel.text = @"PAEFMAPODMFAASDF";
            videoTypeAndTimeLabel.backgroundColor = [UIColor clearColor];
            videoTypeAndTimeLabel.textColor = [UIColor whiteColor];
            videoTypeAndTimeLabel.textAlignment = NSTextAlignmentCenter;
            [self.touchImageView addSubview:videoTypeAndTimeLabel];
            
            
            videoNamelabel.text = model.title;
            int min = [model.duration intValue]/ 60;
            
            int sec = [model.duration intValue]% 60;
            videoTypeAndTimeLabel.text = [NSString stringWithFormat:@"#%@ / %02d'%02d''", model.category, min, sec];
            [self.touchImageView sd_setImageWithURL:[NSURL URLWithString:model.coverForDetail]];
            
            [self addSubview:self.touchImageView];
            
            
        }
        //
        self.aTimer = [NSTimer scheduledTimerWithTimeInterval:timer target:delegate selector:selector userInfo:nil repeats:YES];
    }
    return self;
}

- (void)setTimer {
    [self.aTimer invalidate];
}

- (void)addTimerDelegate:(id)delegate timer:(NSTimeInterval)timer selector:(SEL)selector {
    self.aTimer = [NSTimer scheduledTimerWithTimeInterval:timer target:delegate selector:selector userInfo:nil repeats:YES];
}

@end
