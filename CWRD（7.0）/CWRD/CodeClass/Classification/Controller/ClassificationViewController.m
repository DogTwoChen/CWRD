//
//  ClassificationViewController.m
//  CWRD
//
//  Created by lanou on 15/9/16.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "ClassificationViewController.h"
#import "ClassificationCollectionViewCell.h"
#import "ClassDeatilViewController.h"
#import "ClassificationModel.h"
@interface ClassificationViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray *classArray;
@property (nonatomic,strong)UICollectionView *collectionView;
@end

@implementation ClassificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addView];
    
    [self reloadDataForClass];
    
    //设置返回按钮
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back_normal@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    backButton.tintColor = [UIColor cyanColor];
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.title = @"视频";
    
    
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (NSMutableArray *)classArray{
    if (!_classArray) {
        _classArray = [[NSMutableArray alloc] init];
    }
    return _classArray;
}

#pragma mark ------分类页面数据解析----------
- (void)reloadDataForClass{
    [LORequestManger GET:kClass success:^(id response) {
        NSDictionary *dic = (NSDictionary *)response;
        for (NSDictionary *obj in dic) {
            ClassificationModel *model = [ClassificationModel shareJsonWithDictionary:obj];
            [self.classArray addObject:model];
        }
        [self.collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
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
    [self.collectionView registerClass:[ClassificationCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.classArray.count - 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ClassificationCollectionViewCell *classCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    classCell.backgroundColor = [UIColor clearColor];
    ClassificationModel *model = self.classArray[indexPath.row];
    classCell.showLabel.backgroundColor = [UIColor blackColor];
    classCell.showLabel.alpha = 0.5;
    classCell.showLabel.text = [NSString stringWithFormat:@"#%@",model.name];
    classCell.showLabel.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:15.0];
    [classCell.post sd_setImageWithURL:[NSURL URLWithString:model.bgPicture]placeholderImage:[UIImage imageNamed:@"placeholder_square"]];
    
    
    return classCell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CATransform3D rotation;//3D旋转
    rotation = CATransform3DMakeRotation( (180.0*M_PI)/180, 0.0, 0.7, 0.4);
    //逆时针旋转
    rotation.m34 = 1.0/ 600;
    
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = rotation;

    [UIView beginAnimations:@"rotation" context:NULL];
    //旋转时间
    [UIView setAnimationDuration:0.5];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ClassDeatilViewController *detail = [[ClassDeatilViewController alloc] init];
    NSArray *classUrl = @[@[kOriginalityTime,kOriginalityShare],@[kSportTime,kSportShare],@[kTravelTime,kTravelShare],@[kStoryTime,kStoryShare],@[kAnimationTime,kAnimationShare],@[kADTime,kADShare],@[kMusicTime,kMusicShare],@[kEatTime,kEatShare],@[kPreTime,kPreShare],@[kAllTime,kAllShare]];
    detail.timeAndShare = classUrl[indexPath.row];
    
    ClassificationModel *model = self.classArray[indexPath.row];
    detail.classTitle = model.name;
    [self.navigationController pushViewController:detail animated:YES];
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
