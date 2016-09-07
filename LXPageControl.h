//
//  LXPageControl.h
//
//  Created by 从今以后 on 16/9/7.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXPageControl : UIPageControl

@property (nonatomic) IBInspectable CGSize pageIndicatorSize;
@property (nonatomic) IBInspectable CGFloat pageIndicatorCenterSpacing;

@property (nullable, nonatomic) IBInspectable UIImage *pageImage;
@property (nullable, nonatomic) IBInspectable UIImage *currentPageImage;

@end

NS_ASSUME_NONNULL_END
