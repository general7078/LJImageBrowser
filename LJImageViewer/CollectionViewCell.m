//
//  CollectionViewCell.m
//  LJImageViewer
//
//  Created by 焦鹏 on 2017/3/7.
//  Copyright © 2017年 焦鹏. All rights reserved.
//

#import "CollectionViewCell.h"
@interface CollectionViewCell()
@property (strong, nonatomic) UIImageView *imageView;

@end
@implementation CollectionViewCell

-(UIImageView *)imageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
        [self.contentView addSubview:_imageView];
        self.contentView.clipsToBounds = YES;
    }
    return _imageView;
}
-(void)setImage:(UIImage *)image{
    _image = image;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.image = image;
}
@end
