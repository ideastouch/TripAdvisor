//
//  TrAdCollectionViewFlowLayout.m
//  Pinterest
//
//  Created by Gustavo Halperin on 6/21/14.
//  Copyright (c) 2014 TripAdvisor. All rights reserved.
//

#import "TrAdCollectionViewFlowLayout.h"
#import "TrAdImageCollectionView.h"
#import "TrAdPinterestPictures.h"

@interface TrAdCollectionViewFlowLayout ()

//@property CGSize contentSize;
@property (nonatomic, strong) NSMutableDictionary * collectionViewLayoutAttributes;

@end

@implementation TrAdCollectionViewFlowLayout


- (id)init
{
    self = [super init];
    if (self) {
//        self.contentSize = CGSizeZero;
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
//        self.contentSize = CGSizeZero;
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



/*
- (void)updateCollectionViewContentSize
{
    
    CGSize (^sizeItem)(NSUInteger) = ^(NSUInteger idx){
        NSArray * images = [[TrAdPinterestPictures sharedInstance] imagesAtIndex:idx];
        UIImage * image = [images lastObject];
        if ([images count] > 1) {
            image = [[TrAdPinterestPictures sharedInstance] tileFashionImage:images];
        }
        return [TrAdImageCollectionView normalizedSize:image];
    };
    
    NSUInteger count = [[[self collectionView] dataSource] collectionView:[self collectionView]
                                                   numberOfItemsInSection:0];
    for (int idx = 0; idx < count; idx++) {
        CGSize size = sizeItem(count);
        
    }
}

- (void)prepareLayout
{
    [super prepareLayout];
    
}

- (CGSize)collectionViewContentSize
{
//    return CGSizeMake(768, 1500);
    return _contentSize;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return nil;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
*/
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
