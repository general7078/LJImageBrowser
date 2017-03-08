//
//  LJImageBrowserController.h
//  LJImageViewer
//
//  Created by 焦鹏 on 2017/3/7.
//  Copyright © 2017年 焦鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageInfo.h"
@class LJImageBrowserController;
@protocol LJImageBrowserDataSource <NSObject>
-(NSInteger) numberOfSectionsInBrowser:(LJImageBrowserController*)controller;
-(NSInteger) imageBrower:(LJImageBrowserController*) imageBrowser numberOfImagesInSection:(NSInteger) section;
-(ImageInfo*) imageBrower:(LJImageBrowserController*) imageBrowser imageInfoForIndexPath:(NSIndexPath*) indexPath;
@end

@interface LJImageBrowserController : UIViewController
@property (strong, nonatomic) id<LJImageBrowserDataSource> browserDataSource;
@property (strong, nonatomic) NSIndexPath* initialIndexPath;
@end
