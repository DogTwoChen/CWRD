//
//  ReadingViewController.m
//  CWRD
//
//  Created by lanou on 15/9/22.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "ReadingViewController.h"
#import "ReadingCollectionViewCell.h"
#import "ReadingDeatilTableViewController.h"
#import "PKModel.h"

@interface ReadingViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UICollectionView *collectionView;
@end

@implementation ReadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
    //设置返回按钮
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back_normal@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    backButton.tintColor = [UIColor cyanColor];
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.title = @"阅读";

   
    
    //注册
    [self.collectionView registerClass:[ReadingCollectionViewCell class] forCellWithReuseIdentifier:@"readCell"];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 3;
    layout.minimumInteritemSpacing = 3;
    layout.itemSize = CGSizeMake((kWidth - 3) / 2, (kWidth - 3) / 2);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
}

//设定分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//设定每个分区有多少个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.classArray.count;
}

//自定义cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ReadingCollectionViewCell *readCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"readCell" forIndexPath:indexPath];
    NSArray *array = self.classArray[indexPath.row];
    PKModel *model = array[0];
    readCell.showLabel.text = [NSString stringWithFormat:@"#%@", model.typename];
   
    [readCell.post sd_setImageWithURL:[NSURL URLWithString:model.coverimg]placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    
    
    return readCell;
}

//跳转到详情界面
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  
    ReadingDeatilTableViewController *readDVC = [[ReadingDeatilTableViewController alloc]init];
    readDVC.articleArray = self.classArray[indexPath.row];
    //        NSLog(@"####%@", self.typeidArray[indexPath.row]);
    readDVC.typeid = self.typeidArray[indexPath.row];
    [self.navigationController pushViewController:readDVC animated:YES];
    PKModel *model = self.classArray[indexPath.row][0];
    readDVC.name = model.typename;
    
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
