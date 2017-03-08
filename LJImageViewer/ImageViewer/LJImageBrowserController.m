//
//  LJImageBrowserController.m
//  LJImageViewer
//
//  Created by 焦鹏 on 2017/3/7.
//  Copyright © 2017年 焦鹏. All rights reserved.
//

#import "LJImageBrowserController.h"
#import "FullImageCell.h"

static const NSTimeInterval kAnimationDuration = 0.3;
static const NSTimeInterval kSpringAnimationDuration = 0.5;

@interface LJImageBrowserController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong, nonatomic) UICollectionView* fullPageCollectionView;
@property (strong, nonatomic) UICollectionView* thumbnailCollectionView;
@property (strong, nonatomic) UIView* headerView;
@property (strong, nonatomic) UINavigationBar* navigBar;
@end

@implementation LJImageBrowserController

static NSString * const reuseIdentifier = @"Cell";

-(instancetype)init{
    self = [super init];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

-(void) setupUI{
    [self.view addSubview:self.fullPageCollectionView];
    [self.view addSubview:self.thumbnailCollectionView];
    [self.view addSubview:self.headerView];
    
    self.thumbnailCollectionView.hidden = YES;
    self.headerView.hidden = YES;
  
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.fullPageCollectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.fullPageCollectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.fullPageCollectionView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:-10]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.fullPageCollectionView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:10]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.thumbnailCollectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-40]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.thumbnailCollectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.thumbnailCollectionView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.thumbnailCollectionView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:64]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
    
    UINavigationItem *backItem = [[UINavigationItem alloc] initWithTitle:@""];
    [backItem setHidesBackButton:NO];
    self.navigBar.items = @[backItem];
    
//    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.navigationBar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeTop multiplier:1 constant:24]];
//    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.navigationBar attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
//    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.navigationBar attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
//    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.navigationBar attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
//    self.view.backgroundColor = [UIColor clearColor];
//    self.fullPageCollectionView.backgroundColor = [UIColor clearColor];
}

-(void) dismiss:(id)sender{
    
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if (self.initialIndexPath) {
        NSLog(@"%ld,%ld",self.initialIndexPath.section,self.initialIndexPath.row);
        [self.fullPageCollectionView scrollToItemAtIndexPath:self.initialIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageInfo * imageInfo  = [self.browserDataSource imageBrower:self imageInfoForIndexPath:indexPath];
    if (collectionView == self.fullPageCollectionView) {
        FullImageCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FullImageCell" forIndexPath:indexPath];
        cell.image = imageInfo.fullResolutionImage;
        return cell;
    }
    return nil;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.browserDataSource imageBrower:self numberOfImagesInSection:section];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [self.browserDataSource numberOfSectionsInBrowser:self];
}

#pragma mark UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.fullPageCollectionView) {
        [(FullImageCell*)cell resetImageScale];
    }
}

-(UICollectionView *)fullPageCollectionView{
    if(!_fullPageCollectionView){
        UICollectionViewFlowLayout * flowLayout = [UICollectionViewFlowLayout new];
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        flowLayout.itemSize = CGSizeMake(screenSize.width+20, screenSize.height);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0;
        
        _fullPageCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 10, 10, 10) collectionViewLayout:flowLayout];
        _fullPageCollectionView.backgroundColor = [UIColor whiteColor];
        _fullPageCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
        [_fullPageCollectionView registerClass:[FullImageCell class] forCellWithReuseIdentifier:@"FullImageCell"];
        _fullPageCollectionView.pagingEnabled = YES;
        _fullPageCollectionView.dataSource = self;
        _fullPageCollectionView.delegate = self;
        [_fullPageCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    }
    return _fullPageCollectionView;
}

-(UICollectionView *)thumbnailCollectionView{
    if(!_thumbnailCollectionView){
        UICollectionViewFlowLayout * flowLayout = [UICollectionViewFlowLayout new];
        flowLayout.itemSize = [UIScreen mainScreen].bounds.size;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        
        _thumbnailCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _thumbnailCollectionView.backgroundColor = [UIColor clearColor];
        _thumbnailCollectionView.layer.borderWidth = 0.5;
        _thumbnailCollectionView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _thumbnailCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _thumbnailCollectionView;
}

-(UIView *)headerView{
    if (!_headerView) {
        _headerView = [UIView new];
        _headerView.backgroundColor = [UIColor clearColor];
        _headerView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _headerView;
}

-(UINavigationBar *)navigBar{
    if(!_navigBar){
        _navigBar = [UINavigationBar new];
        _navigBar.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _navigBar;
}
@end
