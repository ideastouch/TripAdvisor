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

- (void)prepareForReuse
{
    [[self imageView] setImage:nil];
}

@end
