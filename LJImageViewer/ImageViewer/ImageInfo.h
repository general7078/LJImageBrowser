//
//  ImageInfo.h
//  LJImageViewer
//
//  Created by 焦鹏 on 2017/3/7.
//  Copyright © 2017年 焦鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageInfo : NSObject
@property (strong, nonatomic) UIView* sourceView;
@property (strong, nonatomic) UIImage* fullResolutionImage;
@property (strong, nonatomic) UIImage* thumbnailImage;
@end
