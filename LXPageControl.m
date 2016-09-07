//
//  LXPageControl.m
//
//  Created by 从今以后 on 16/9/7.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import "LXPageControl.h"

@implementation LXPageControl
{
    CGImageRef _pageCGImage;
    CGImageRef _currentPageCGImage;
}

- (void)dealloc
{
    CGImageRelease(_pageCGImage);
    CGImageRelease(_currentPageCGImage);
}

- (void)setCurrentPageImage:(UIImage *)currentPageImage
{
    _currentPageImage = currentPageImage;

    CGImageRelease(_currentPageCGImage);
    _currentPageCGImage = CGImageRetain([currentPageImage CGImage]);

    self.currentPageIndicatorTintColor = [UIColor clearColor];
}

- (void)setPageImage:(UIImage *)pageImage
{
    _pageImage = pageImage;

    CGImageRelease(_pageCGImage);
    _pageCGImage = CGImageRetain([pageImage CGImage]);

    self.pageIndicatorTintColor = [UIColor clearColor];
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    [super setCurrentPage:currentPage];

    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == currentPage) {
            obj.layer.contents = (__bridge id)_currentPageCGImage;
        } else {
            obj.layer.contents = (__bridge id)_pageCGImage;
        }
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGSize size = self.pageIndicatorSize;;
    CGFloat spacing = self.pageIndicatorCenterSpacing;
    CGPoint center = {CGRectGetMidX(self.bounds),CGRectGetMidY(self.bounds)};

    NSArray<UIView *> *indicators = self.subviews;
    NSUInteger countOfIndicators = indicators.count;

    if (countOfIndicators % 2 == 0) { // 偶数个小圆点
        NSUInteger maxLeftIndex = countOfIndicators / 2 - 1; // 位于左侧的小圆点的最大索引
        NSUInteger minRightIndex = maxLeftIndex + 1; // 位于右侧的小圆点的最小索引
        [indicators enumerateObjectsUsingBlock:^(UIView *indicator, NSUInteger idx, BOOL *stop) {
            indicator.frame = ({
                CGRect frame = indicator.frame;
                frame.size = size;
                frame;
            });
            if (idx <= maxLeftIndex) { // 位于左侧的小圆点
                indicator.center = (CGPoint){center.x - (maxLeftIndex - idx + 0.5) * spacing, center.y};
            } else { // 位于右侧的小圆点
                indicator.center = (CGPoint){center.x + (idx - minRightIndex + 0.5) * spacing, center.y};
            }
        }];
    } else { // 奇数个小圆点
        NSUInteger centerIndicatorIndex = countOfIndicators / 2;
        [indicators enumerateObjectsUsingBlock:^(UIView *indicator, NSUInteger idx, BOOL *stop) {
            indicator.center = (CGPoint){center.x - (centerIndicatorIndex - idx) * spacing, center.y};
        }];
    }
}

@end
