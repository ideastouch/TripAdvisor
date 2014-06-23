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
    return 18;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = [indexPath row];
    assert(!(index>999) && @"row can not be bigger than 999");
    NSString * prefix = (index < 10)?@"00":(index < 100)?@"0":@"";
    NSString * name = [NSString stringWithFormat:@"%@%ld.jpg", prefix, index];
    UIImage * image = [UIImage imageNamed:name];
    id collectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:_identifier
                                                                      forIndexPath:indexPath];
    
    CGPoint origin = [collectionViewCell frame].origin;
    CGRect rect = CGRectMake(origin.x, origin.y,
                             [TrAdImageCollectionView cellWidth], [TrAdImageCollectionView cellWidth]/[image size].width*[image size].height );
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
