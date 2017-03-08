//
//  ImageBrowserCollectionViewController.m
//  LJImageViewer
//
//  Created by 焦鹏 on 2017/3/7.
//  Copyright © 2017年 焦鹏. All rights reserved.
//

#import "ImageBrowserCollectionViewController.h"
#import "CollectionViewCell.h"
#import "LJImageBrowserController.h"

@interface ImageBrowserCollectionViewController ()<LJImageBrowserDataSource>
@property (strong, nonatomic) NSMutableArray<UIImage*>* data;
@end

@implementation ImageBrowserCollectionViewController

static NSString * const reuseIdentifier = @"CCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = (CollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.image = self.data[indexPath.row];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LJImageBrowserController* controller = [[LJImageBrowserController alloc] init];
    controller.browserDataSource = self;
    controller.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    controller.providesPresentationContextTransitionStyle = YES;
    controller.definesPresentationContext = YES;
    controller.initialIndexPath = indexPath;
    [self presentViewController:controller animated:YES completion:nil];
}

-(NSMutableArray<UIImage *> *)data{
    if(!_data){
        _data = [@[[UIImage imageNamed:@"w4"],[UIImage imageNamed:@"w7"],[UIImage imageNamed:@"w6"]] mutableCopy];
    }
    return _data;
}

#pragma mark LJImageBrowserDataSource
-(NSInteger)numberOfSectionsInBrowser:(LJImageBrowserController *)controller{
    return 1;
}

-(NSInteger)imageBrower:(LJImageBrowserController *)imageBrowser numberOfImagesInSection:(NSInteger)section{
    return self.data.count;
}

-(ImageInfo *)imageBrower:(LJImageBrowserController *)imageBrowser imageInfoForIndexPath:(NSIndexPath *)indexPath{
    ImageInfo* imageInfo = [ImageInfo new];
    imageInfo.sourceView = [self.collectionView cellForItemAtIndexPath:indexPath];
    imageInfo.fullResolutionImage = self.data[indexPath.row];
    return imageInfo;
}

@end
