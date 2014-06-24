//
//  TrAdImageCollectionView.m
//  Pinterest
//
//  Created by Gustavo Halperin on 6/20/14.
//  Copyright (c) 2014 TripAdvisor. All rights reserved.
//

#import "TrAdImageCollectionView.h"

@implementation TrAdImageCollectionView

+ (CGFloat)cellWidth
{
    return 255;
}

+ (CGFloat)minimumSpacing
{
    return 1;
}

+ (CGSize)normalizedSize:(UIImage*)image
{
    return CGSizeMake([TrAdImageCollectionView cellWidth], [TrAdImageCollectionView cellWidth]/[image size].width*[image size].height );
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

@end
