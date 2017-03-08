//
//  FullImageCell.h
//  LJImageViewer
//
//  Created by 焦鹏 on 2017/3/7.
//  Copyright © 2017年 焦鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FullImageCell : UICollectionViewCell
@property (strong, nonatomic) UIImage* image;

-(void)resetImageScale;
@end
