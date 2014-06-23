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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)collapseFrom:(NSIndexPath*)cellFrom to:(NSIndexPath*)cellTo
{
    
}

@end
