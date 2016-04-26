//
//  StatementViewController.m
//  CWRD
//
//  Created by lanou on 15/10/4.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "StatementViewController.h"

@interface StatementViewController ()

@end

@implementation StatementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"免责声明";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor cyanColor],NSForegroundColorAttributeName, nil]];
    
    //设置返回按钮
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back_normal@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    backButton.tintColor = [UIColor cyanColor];
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    
    
    NSString *str = @"\n\n1、一切移动客户端用户在下载并浏览APP手机APP软件时均被视为已经仔细阅读本条款并完全同意。凡以任何方式登陆本APP，或直接、间接使用本APP资料者，均被视为自愿接受本网站相关声明和用户服务协议的约束。\n\n2、APP手机APP转载的内容并不代表APP手机APP之意见及观点，也不意味着本网赞同其观点或证实其内容的真实性。\n\n3、APP手机APP转载的文字、图片、音视频等资料均由本APP用户提供，其真实性、准确性和合法性由信息发布人负责。APP手机APP不提供任何保证，并不承担任何法律责任。\n\n4、APP手机APP所转载的文字、图片、音视频等资料，如果侵犯了第三方的知识产权或其他权利，责任由作者或转载者本人承担，本APP对此不承担责任。";
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, kWidth - 40, 100)];
    //label.backgroundColor = [UIColor orangeColor];
    label.text = str;
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
    CGRect frame = [str boundingRectWithSize:CGSizeMake(kWidth - 40, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:16] forKey:NSFontAttributeName] context:nil];
    label.frame = CGRectMake(15, 0, kWidth - 30, frame.size.height );
    label.font = [UIFont systemFontOfSize:16];

}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
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
