//
//  TrAdCollectionViewFlowLayout.m
//  Pinterest
//
//  Created by Gustavo Halperin on 6/21/14.
//  Copyright (c) 2014 TripAdvisor. All rights reserved.
//

#import "TrAdCollectionViewFlowLayout.h"
#import "TrAdImageCollectionView.h"

@interface TrAdCollectionViewFlowLayout ()

@property (nonatomic, strong) NSMutableDictionary * collectionViewLayoutAttributes;

@end

@implementation TrAdCollectionViewFlowLayout


- (id)init
{
    self = [super init];
    if (self) {
        self.minimumLineSpacing = [TrAdImageCollectionView minimumSpacing];
        self.minimumInteritemSpacing = [TrAdImageCollectionView minimumSpacing];
        self.collectionViewLayoutAttributes = [NSMutableDictionary dictionary];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.minimumLineSpacing = [TrAdImageCollectionView minimumSpacing];
        self.minimumInteritemSpacing = [TrAdImageCollectionView minimumSpacing];
        self.collectionViewLayoutAttributes = [NSMutableDictionary dictionary];
    }
    return self;
}

- (CGPoint)originItemAtIndexPath:(NSIndexPath *)indexPath withFrame:(CGRect)frame
{
    return CGPointMake(frame.origin.x - 20, frame.origin.y - 30);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes * collectionViewLayoutAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    
    CGRect frame = [collectionViewLayoutAttributes frame];
    CGPoint origin = [self originItemAtIndexPath:indexPath withFrame:frame];
    frame.origin.x = origin.x;
    frame.origin.y = origin.y;
    [collectionViewLayoutAttributes setFrame:frame];
    
    return collectionViewLayoutAttributes;
}

- (NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    rect.size.height *= 1.5;
    NSArray * layoutAttributes = [super layoutAttributesForElementsInRect:rect];
    [layoutAttributes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSIndexPath * indexPath = [obj indexPath];
        CGRect frame = [obj frame];
        if ([indexPath row] < 3) {
            frame.origin.y = 0;
        }
        else {
            NSIndexPath * previousIndexPath = [NSIndexPath indexPathForItem:[indexPath row]-3 inSection:0];
            id previousObj = [_collectionViewLayoutAttributes objectForKey:previousIndexPath];
            CGRect previousFrame = [previousObj frame];
            frame.origin.y = previousFrame.origin.y + previousFrame.size.height + [TrAdImageCollectionView minimumSpacing];
        }
        [obj setFrame:frame];
        [_collectionViewLayoutAttributes setObject:obj forKey:indexPath];
    }];
    return layoutAttributes;
}

@end
