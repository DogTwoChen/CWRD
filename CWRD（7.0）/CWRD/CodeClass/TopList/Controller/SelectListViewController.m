//
//  SelectListViewController.m
//  CWRD
//
//  Created by lanou on 15/9/22.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "SelectListViewController.h"
#import "TopListViewController.h"
#import "ReadListViewController.h"


@interface SelectListViewController ()

@property (nonatomic, strong) TopListViewController *topListVC;
@property (nonatomic, strong) ReadListViewController *readListVC;

@property (nonatomic) BOOL isMovieList;

@end

@implementation SelectListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIBarButtonItem *changeButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"readIcon"] style:(UIBarButtonItemStylePlain) target:self action:@selector(changeView:)];
    self.navigationItem.rightBarButtonItem = changeButton;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor cyanColor];
    self.isMovieList = YES;
    
    _topListVC = [[TopListViewController alloc] init];
    [self addChildViewController:_topListVC];
    
    _readListVC = [[ReadListViewController alloc] init];
    [self addChildViewController:_readListVC];
    
    [self.view addSubview:_topListVC.view];
    
}

#pragma mark ------------- 视图切换 ---------------
- (void)changeView:(UIBarButtonItem *)button {
    self.isMovieList = !self.isMovieList;
    if (self.isMovieList == NO) {
        button.image = [UIImage imageNamed:@"movieIcon"];
        [UIView transitionFromView:_topListVC.view toView:_readListVC.view duration:0.5 options:(UIViewAnimationOptionTransitionFlipFromBottom) completion:nil];
        
    }else {
        button.image = [UIImage imageNamed:@"readIcon"];
        [UIView transitionFromView:_readListVC.view toView:_topListVC.view duration:0.5 options:(UIViewAnimationOptionTransitionFlipFromRight) completion:nil];
    }
}

















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
