//
//  AppDelegate.h
//  CWRD
//
//  Created by lanou on 15/9/16.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "IIViewDeckController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) IIViewDeckController *deck;
@property (nonatomic) BOOL isInto;

@end


