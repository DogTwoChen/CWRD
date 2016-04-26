//
//  TotalClassViewController.m
//  CWRD
//
//  Created by lanou on 15/9/21.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "TotalClassViewController.h"
#import "WordCollectionReusableView.h"
#import "WordCollectionViewCell.h"
#import "VideoCollectionReusableView.h"
#import "VideoCollectionViewCell.h"
#import "ReadingViewController.h"
#import "ClassificationViewController.h"
#import "VideoModel.h"
#import "ClassDeatilViewController.h"
#import "PKModel.h"
#import "ReadingDeatilTableViewController.h"
#import "SVProgressHUD.h"

@interface TotalClassViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *collectionView;
//存放视频的数组
@property(nonatomic,strong)NSMutableArray *videoArray;
//存放阅读
@property(nonatomic,strong)NSMutableArray *readArray;
//typeid数组
@property (nonatomic, strong) NSArray *typeidArray;

@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation TotalClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //风火轮开始
    [SVProgressHUD setDefaultAnimationType:(SVProgressHUDAnimationTypeNative)];
    [SVProgressHUD show];
    
    [self addWordView];
    [self reloadDataForVideo];
    [self reloadDataForRead];

}

- (NSMutableArray *)videoArray{
    if (!_videoArray) {
        _videoArray = [[NSMutableArray alloc] init];
    }
    return _videoArray;
}


-(NSMutableArray *)readArray {
    if (!_readArray) {
        _readArray = [[NSMutableArray alloc]init];
    }
    return _readArray;
}

#pragma mark ----------视频推荐解析----------
- (void)reloadDataForVideo{
    [LORequestManger GET:kClass success:^(id response) {
        NSDictionary *dic = (NSDictionary *)response;
        for (NSDictionary *obj in dic) {
            VideoModel *model = [VideoModel shareJsonWithDictionary:obj]
            ;
            [self.videoArray addObject:model];
        }
        [self.collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark------------阅读分类-----------
- (void)reloadDataForRead {

    self.typeidArray = @[@"1", @"27", @"10", @"14", @"6", @"18", @"12", @"11", @"7"];

    for (int i = 0; i < 9; i++) {

        NSMutableArray *array = [[NSMutableArray alloc]init];

        NSMutableDictionary *postDic = [NSMutableDictionary dictionaryWithObject:self.typeidArray[i] forKey:@"typeid"];
        [postDic setValue:@"addtime" forKey:@"sort"];
        [postDic setValue:@"0" forKey:@"start"];
        
        [LORequestManger POST:@"http://api2.pianke.me/read/columns_detail" params:postDic success:^(id response) {
            NSDictionary *pkDic = (NSDictionary *)response;
            NSDictionary *dataDic = pkDic[@"data"];
            NSArray *listArray = dataDic[@"list"];
            
            for (NSDictionary *listDic in listArray) {
                PKModel *pkModel = [PKModel shareJsonWithColumnsDictionary:dataDic[@"columnsInfo"] listDictionary:listDic];
                [array addObject:pkModel];
                
            }
            [[self readArray]addObject:array];

            [self.collectionView reloadData];
            [SVProgressHUD dismiss];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error);
        }];
    }
}



//加载阅读的视图
- (void)addWordView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 3;
    layout.minimumLineSpacing = 3;
    layout.itemSize = CGSizeMake((kWidth - 3) / 2, (kWidth - 3) / 2);
    
    //增广视图高度设置
    layout.headerReferenceSize = CGSizeMake(kWidth, 40);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight - 64 - 49 - 49) collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.view = self.collectionView;
    
    //注册
    [self.collectionView registerClass:[WordCollectionViewCell class] forCellWithReuseIdentifier:@"wordCell"];
    [self.collectionView registerClass:[VideoCollectionViewCell class] forCellWithReuseIdentifier:@"videoCell"];
    
    //注册增广视图
    [self.collectionView registerClass:[WordCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"wordView"];
    [self.collectionView registerClass:[VideoCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"videoView"];
    
}

//设置集合视图有多少个分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

//设置每个分区有多少个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return self.readArray.count - 5 ;
    }else {
        return 4;
        
    }
    
}


//自定义cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        WordCollectionViewCell *wordCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"wordCell" forIndexPath:indexPath];

        NSArray *array = self.readArray[indexPath.row];
        PKModel *model = array[0];

        wordCell.nameLabel.text = [NSString stringWithFormat:@"#%@", model.typename];
       
        if ([model.typename isEqualToString:@"读书"]) {
            PKModel *model = array[1];
            
            [wordCell.post sd_setImageWithURL:[NSURL URLWithString:model.coverimg]placeholderImage:[UIImage imageNamed:@"placeholder_square"]];
        }else {
        [wordCell.post sd_setImageWithURL:[NSURL URLWithString:model.coverimg]placeholderImage:[UIImage imageNamed:@"placeholder_square"]];
        }
        return wordCell;
        
    }else{
        VideoCollectionViewCell *videoCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"videoCell" forIndexPath:indexPath];
        VideoModel *model = self.videoArray[indexPath.row];
        [videoCell.post sd_setImageWithURL:[NSURL URLWithString:model.bgPicture]placeholderImage:[UIImage imageNamed:@"placeholder_square"]];
        videoCell.nameLabel.text = [NSString stringWithFormat:@"#%@",model.name];
        

        return videoCell;
    }
    
    
}

//表头(增广视图)
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        WordCollectionReusableView *wordView = [collectionView dequeueReusableSupplementaryViewOfKind :UICollectionElementKindSectionHeader withReuseIdentifier:@"wordView" forIndexPath:indexPath];
        wordView.nameLabel.text = @"阅读";
        wordView.nameLabel.textColor = [UIColor cyanColor];
        //给增广视图按钮添加方法
        [wordView.more addTarget:self action:@selector(goToReading) forControlEvents:UIControlEventTouchUpInside];
        
        return wordView;
    }else{
        
        
            VideoCollectionReusableView *videoView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"videoView" forIndexPath:indexPath];
            videoView.nameLabel.text = @"视频";
            videoView.nameLabel.textColor = [UIColor cyanColor];
            [videoView.more addTarget:self action:@selector(goToClassification) forControlEvents:UIControlEventTouchUpInside];
            return  videoView;
               
        
        
    }
    
}



//跳转到视频推荐的详情页面
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ReadingDeatilTableViewController *readDVC = [[ReadingDeatilTableViewController alloc]init];
        readDVC.articleArray = self.readArray[indexPath.row];
        readDVC.typeid = self.typeidArray[indexPath.row];
        [self.navigationController pushViewController:readDVC animated:YES];
        PKModel *model = self.readArray[indexPath.row][0];
        readDVC.name = model.typename;
        
    }else {
    
    ClassDeatilViewController *deatil = [[ClassDeatilViewController alloc] init];
    NSArray *classUrl = @[@[kOriginalityTime,kOriginalityShare],@[kSportTime,kSportShare],@[kTravelTime,kTravelShare],@[kStoryTime,kStoryShare]];
    deatil.timeAndShare = classUrl[indexPath.row];
    VideoModel *model = self.videoArray[indexPath.row];
    deatil.classTitle = model.name;
    [self.navigationController pushViewController:deatil animated:YES];
    }
}


//跳转到阅读界面
- (void)goToReading{
    
    ReadingViewController *readVC = [[ReadingViewController alloc] init];
    readVC.classArray = self.readArray;
    readVC.typeidArray = self.typeidArray;
    [self.navigationController pushViewController:readVC animated:YES];
}


//跳转到视频分类界面
- (void)goToClassification{
    
    ClassificationViewController *classVC = [[ClassificationViewController alloc] init];
    [self.navigationController pushViewController:classVC animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







@end
