//
//  VideoFunctionStatementViewController.m
//  CWRD
//
//  Created by lanou on 15/10/4.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "VideoFunctionStatementViewController.h"

@interface VideoFunctionStatementViewController ()

@end

@implementation VideoFunctionStatementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"视频功能声明";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor cyanColor],NSForegroundColorAttributeName, nil]];
    
    //设置返回按钮
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back_normal@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    backButton.tintColor = [UIColor cyanColor];
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    
    
    NSString *str = @"\n\n1、使用本软件并会使您获得或拥有任何属于我们或第三方的知识产权。本区案件中链接的视频作品以及文章作品的所有权利均属于作者,请勿传播、修改或以其他方式不当使用他人的作品,包括但不限于转载、链接、下载、复制保护措施等。\n\n2、软件所提供的内容均来自于第三方网站,我们对其中的任何内容的合法性以及准确性概不负责,亦不承担任何法律责任。\n\n3、我们将以最大的努力维护本软件的正常运行,但您应对使用软件的结果自行承担风险,我们对此不任何承诺或保证,不保证服务不中断,不保证您所浏览的内容的安全性、准确性、以及完整性。由于网络的宽带、手机(或其他电子设备)硬件限制等任何原因造成您无法正常使用软件,我们不承担任何法律责任。";
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, kWidth - 40, 100)];
    //label.backgroundColor = [UIColor orangeColor];
    label.text = str;
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
    CGRect frame = [str boundingRectWithSize:CGSizeMake(kWidth - 40, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:16] forKey:NSFontAttributeName] context:nil];
    label.frame = CGRectMake(15, 0, kWidth - 30, frame.size.height );
    label.font = [UIFont systemFontOfSize:16];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
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
