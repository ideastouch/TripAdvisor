//
//  TrAdCollectionViewFlowLayout.m
//  Pinterest
//
//  Created by Gustavo Halperin on 6/21/14.
//  Copyright (c) 2014 TripAdvisor. All rights reserved.
//

#import "TrAdCollectionViewLayout.h"
#import "TrAdImageCollectionView.h"
#import "TrAdPinterestPictures.h"

@interface TrAdCollectionViewLayout ()

@property CGSize contentSize;
@property (nonatomic, strong) NSMutableArray * attributesArray;
@property (nonatomic, strong) NSMutableDictionary * collectionViewLayoutAttributes;

@end

@implementation TrAdCollectionViewLayout


- (id)init
{
    self = [super init];
    if (self) {
        self.contentSize = CGSizeZero;
//        self.minimumLineSpacing = [TrAdImageCollectionView minimumSpacing];
//        self.minimumInteritemSpacing = [TrAdImageCollectionView minimumSpacing];
        self.attributesArray = [NSMutableArray array];
        self.collectionViewLayoutAttributes = [NSMutableDictionary dictionary];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.contentSize = CGSizeZero;
//        self.minimumLineSpacing = [TrAdImageCollectionView minimumSpacing];
        //        self.minimumInteritemSpacing = [TrAdImageCollectionView minimumSpacing];
        self.attributesArray = [NSMutableArray array];
        self.collectionViewLayoutAttributes = [NSMutableDictionary dictionary];
    }
    return self;
}


#pragma mark overwriting methods.
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
    
    //Init values
    NSUInteger count = [[[self collectionView] dataSource] collectionView:[self collectionView]
                                                   numberOfItemsInSection:0];
    NSMutableArray  * columnsHeights = [@[@(0), @(0), @(0)] mutableCopy];
    int column = 0;
    const NSUInteger columnsCount = [columnsHeights count];
    const CGFloat columnWidth = [TrAdImageCollectionView cellWidth];
    NSMutableArray * columnsWidths = [NSMutableArray arrayWithCapacity:columnsCount];
    for (int idx = 0; idx < columnsCount; idx++) {
        [columnsWidths addObject:@(columnWidth*idx)];
    }
    
    //Reset properties
    _contentSize = CGSizeMake(columnWidth * columnsCount, 0);
    [_attributesArray removeAllObjects];
    
    //Loop over the images
    for (int idx = 0; idx < count; ) {
        UICollectionViewLayoutAttributes * attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:idx inSection:0]];
        CGSize size = sizeItem(idx);
        CGFloat newHeight = [columnsHeights[column] floatValue] + size.height;
        switch (column) {
            case 0:
                if ([ columnsHeights[column] compare:columnsHeights[1]] != NSOrderedDescending) {
                    [attributes setFrame:CGRectMake([columnsWidths[column] floatValue], [columnsHeights[column] floatValue], size.width, size.height)];
                    columnsHeights[column] = @([columnsHeights[column] floatValue] + size.height);
                    idx++;
                    break;
                }
                else {
                    column = 1;
                    newHeight = [columnsHeights[column] floatValue] + size.height;
                }
            case 1:
                if ( [columnsHeights[column] compare:columnsHeights[0]] == NSOrderedAscending ) {
                    [attributes setFrame:CGRectMake([columnsWidths[column] floatValue], [columnsHeights[column] floatValue], size.width, size.height)];
                    columnsHeights[column] = @([columnsHeights[column] floatValue] + size.height);
                    idx++;
                    break;
                }
                else {
                    column = 2;
                    newHeight = [columnsHeights[column] floatValue] + size.height;
                }
            case 2:
                if ( [columnsHeights[column] compare:columnsHeights[1]] == NSOrderedAscending ) {
                    [attributes setFrame:CGRectMake([columnsWidths[column] floatValue], [columnsHeights[column] floatValue], size.width, size.height)];
                    columnsHeights[column] = @([columnsHeights[column] floatValue] + size.height);
                    idx++;
                }
                else {
                    column = 0;
                    newHeight = [columnsHeights[column] floatValue] + size.height;
                }
                break;
            default:
                assert(@"Can not be column different than 0, 1 or 2");
                break;
        }
        [_attributesArray addObject:attributes];
    }
    __block CGFloat maxHeight = 0;
    [columnsHeights enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        maxHeight = MAX(maxHeight, [obj floatValue]);
    }];
    _contentSize.height = maxHeight;
}

- (void)prepareLayout
{
    [super prepareLayout];
    [self updateCollectionViewContentSize];
    
}

- (CGSize)collectionViewContentSize
{
    return _contentSize;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    __block NSMutableArray * array = [NSMutableArray array];
    [_attributesArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (CGRectIntersectsRect(rect, [obj frame])) {
            [array addObject:obj];
        }
    }];
    return array;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return _attributesArray[[indexPath row]];
}

@end
