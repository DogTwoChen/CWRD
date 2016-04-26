//
//  TapImageView.h
//  CWRD
//
//  Created by lanou on 15/9/17.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TapImageView : UIImageView
-(instancetype)initWithFrame:(CGRect)frame target:(id)target action:(SEL)action;
@end
