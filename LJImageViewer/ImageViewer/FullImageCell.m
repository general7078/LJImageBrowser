//
//  FullImageCell.m
//  LJImageViewer
//
//  Created by 焦鹏 on 2017/3/7.
//  Copyright © 2017年 焦鹏. All rights reserved.
//

#import "FullImageCell.h"
@interface FullImageCell()<UIScrollViewDelegate>
@property (strong, nonatomic) UIImageView* imageView;
@property (strong, nonatomic) UIScrollView* scrollView;
@end

@implementation FullImageCell

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        CGSize size = [UIScreen mainScreen].bounds.size;
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 0, size.width, size.height)];
        _scrollView.contentSize = [UIScreen mainScreen].bounds.size;
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self.contentView addSubview:_scrollView];
        UITapGestureRecognizer *doublTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapped:)];
        doublTap.numberOfTapsRequired = 2;
        [self.scrollView addGestureRecognizer:doublTap];
    }
    return _scrollView;
}
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [UIImageView new];
        [self.scrollView addSubview:_imageView];
    }
    return _imageView;
}

-(void)setImage:(UIImage *)image{
    _image = image;
    self.imageView.image = image;
    [self adjustImagePosition];
}

-(void)resetImageScale{
    [self adjustImagePosition];
}

-(void)prepareForReuse{
    [self adjustImagePosition];
}

-(void) adjustImagePosition{
    self.scrollView.zoomScale = 1;
    self.scrollView.minimumZoomScale = 1.0;
    self.scrollView.maximumZoomScale = 3.0;
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    if (self.image.size.width > self.image.size.height) {
        size.height = self.image.size.height*size.width / self.image.size.width;
        self.imageView.frame = CGRectMake(0, 0, size.width, size.height);
        self.imageView.center = CGPointMake(self.scrollView.bounds.size.width /2, self.scrollView.bounds.size.height / 2);
    }
    
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    
    _imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                    scrollView.contentSize.height * 0.5 + offsetY);
}

-(IBAction)doubleTapped:(UITapGestureRecognizer*)sender{
    if(self.scrollView.zoomScale > 1.0){
        self.scrollView.zoomScale = 1.0;
    }else{
        CGPoint location = [sender locationInView:self.scrollView];
        CGFloat maxZoomScale = self.scrollView.maximumZoomScale;
        CGFloat width = self.scrollView.bounds.size.width / maxZoomScale;
        CGFloat height = self.scrollView.bounds.size.height / maxZoomScale;
        [self.scrollView zoomToRect:CGRectMake(location.x - width/2, location.y - height/2, width, height) animated:YES];
    }
}
@end
