//
//  TrAdImageCollectionView.h
//  Pinterest
//
//  Created by Gustavo Halperin on 6/20/14.
//  Copyright (c) 2014 TripAdvisor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrAdImageCollectionView : UICollectionView

+ (CGFloat)cellWidth;
+ (CGFloat)minimumSpacing;

- (void)collapseFrom:(NSIndexPath*)cellFrom to:(NSIndexPath*)cellTo;

@end
