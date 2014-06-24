//
//  TrAdImagesCollectionViewDataSource.m
//  Pinterest
//
//  Created by Gustavo Halperin on 6/20/14.
//  Copyright (c) 2014 TripAdvisor. All rights reserved.
//

#import "TrAdImagesCollectionViewDataSource.h"
#import "TrAdImageCollectionViewCell.h"
#import "TrAdImageCollectionView.h"
#import "TrAdPinterestPictures.h"
#import "TrAdPinterestPictures.h"

@interface TrAdImagesCollectionViewDataSource ()

@property (nonatomic, retain) NSString * identifier;

@end

@implementation TrAdImagesCollectionViewDataSource

- (id)initReuseIdentifier:(NSString*)identifier
{
    self = [super init];
    if (self) {
        self.identifier = identifier;
    }
    
    return self;
}

#pragma mark required
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[TrAdPinterestPictures sharedInstance] imagesGroupsCount];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * images = [[TrAdPinterestPictures sharedInstance] imagesAtIndex:[indexPath indexAtPosition:1]];
    UIImage * image = [images lastObject];
    if ([images count] > 1) {
        image = [[TrAdPinterestPictures sharedInstance] tileFashionImage:images];
    }
    id collectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:_identifier
                                                                      forIndexPath:indexPath];
    
    CGPoint origin = [collectionViewCell frame].origin;
    CGSize size = [TrAdImageCollectionView normalizedSize:image];
    CGRect rect = CGRectMake(origin.x, origin.y, size.width, size.height);
    
    [collectionViewCell setFrame:rect];
    [[collectionViewCell imageView] setImage:image];
    
    return collectionViewCell;
}

#pragma mark optional
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    assert(0 && "This method is not implemented");
    return nil;
}

@end
