//
//  TrAdImageCollectionViewCell.m
//  Pinterest
//
//  Created by Gustavo Halperin on 6/21/14.
//  Copyright (c) 2014 TripAdvisor. All rights reserved.
//

#import "TrAdImageCollectionViewCell.h"

@interface TrAdImageCollectionViewCell ()

@end

@implementation TrAdImageCollectionViewCell

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

- (void)prepareForReuse
{
    [[self imageView] setImage:nil];
}

@end
