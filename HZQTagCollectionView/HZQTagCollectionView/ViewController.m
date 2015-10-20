//
//  ViewController.m
//  HZQTagCollectionView
//
//  Created by 1 on 15/10/20.
//  Copyright © 2015年 HZQ. All rights reserved.
//

#import "ViewController.h"

#import "HZQTagCell.h"

#define ScreenRectHeight [UIScreen mainScreen].applicationFrame.size.height
#define ScreenRectWidth [UIScreen mainScreen].applicationFrame.size.width

// 每行个数
#define RowCount 4

// 每个按钮的高度
#define BtnHeight 40

@interface ViewController () {
    NSMutableArray *_titles;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeight;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    _titles = [NSMutableArray array];
    
    [_titles addObject:@"三年级1班"];
    [_titles addObject:@"三年级2班"];
    [_titles addObject:@"三年级3班"];
    [_titles addObject:@"三年级4班"];
    [_titles addObject:@"三年级5班"];
    [_titles addObject:@"三年级6班"];
    [_titles addObject:@"三年级7班"];
    
    
    self.view.backgroundColor = [UIColor blueColor];
    
    [self setupColloctionView];
}

// 添加
- (IBAction)addTag:(id)sender {
    [_titles addObject:@"8年级8班"];
    
    [self.collectionView reloadData];
    
    [self settingCollectionViewHeight];
}

/** 设置collectionViewHeight */
- (void)settingCollectionViewHeight {
    if (_titles.count % RowCount == 0) {
        self.collectionViewHeight.constant = ((BtnHeight + 10) * _titles.count / RowCount);
        
    } else {
        self.collectionViewHeight.constant = ((BtnHeight + 10) * ((_titles.count / RowCount) + 1));
    }
    
}

/** 设置ColloctionView属性 */
- (void)setupColloctionView
{
    // 设置collectionViewHeight
    [self settingCollectionViewHeight];
    
    //设置代理
    self.collectionView.alwaysBounceVertical = YES;
    [self.collectionView registerClass:[HZQTagCell class] forCellWithReuseIdentifier:@"cell"];
    
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _titles.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    HZQTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    if (!cell) {
        NSLog(@"无法创建CollectionViewCell时打印，自定义的cell就不可能进来了。");
    }
    
    cell.text.text = _titles[indexPath.row];
    
    return cell;
}


#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //边距占5*4=20 ，2个
    //图片为正方形，边长：(fDeviceWidth-20)/2-5-5 所以总高(fDeviceWidth-20)/2-5-5 +20+30+5+5 label高20 btn高30 边
    int count = RowCount;
    float padding = (count+2)*(count+1);
    
    return CGSizeMake((ScreenRectWidth-padding)/count, BtnHeight);
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_titles removeObjectAtIndex:indexPath.row];
    
    [self.collectionView reloadData];
    
    // 设置collectionViewHeight
    [self settingCollectionViewHeight];
    
    [self.view layoutIfNeeded];
}
@end
