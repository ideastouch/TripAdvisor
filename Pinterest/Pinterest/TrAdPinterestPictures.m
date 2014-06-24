//
//  TrAdPinterestPictures.m
//  Pinterest
//
//  Created by Gustavo Halperin on 6/22/14.
//  Copyright (c) 2014 TripAdvisor. All rights reserved.
//

#import "TrAdPinterestPictures.h"
#import "TrAdImageCollectionView.h"

NSInteger const picturesCount = 18;

@interface TrAdPinterestPictures ()

@property (strong, nonatomic) NSMutableArray * images;
@property (strong, nonatomic) NSMutableArray * imagesGroups;

@end

@implementation TrAdPinterestPictures

+ (id)sharedInstance
{
    static dispatch_once_t token = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&token, ^{
        _sharedObject = [[self alloc] init];
    });
    
    // returns the same object each time
    return _sharedObject;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.images = [NSMutableArray array];
        self.imagesGroups = [NSMutableArray array];
    }
    return self;
}

- (NSUInteger)imagesGroupsCount
{
    __block NSUInteger count = picturesCount;
    [_imagesGroups  enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        count -= [obj count] - 1;
    }];
    return count;
}

- (NSArray*)imagesAtIndex:(NSUInteger)idx
{
    if (   [_imagesGroups count] <= idx
        && [_images count] < picturesCount) {
        NSString * prefix = ([_images count] < 10)?@"00":@"0";
        NSString * name = [NSString stringWithFormat:@"%@%ld.jpg", prefix, [_images count]];
        UIImage * image = [UIImage imageNamed:name];
        [_images addObject:image];
        [_imagesGroups addObject:[NSArray arrayWithObject:image]];
    }
    assert([_imagesGroups count] > idx && @"indexPath at position 0 can not be bigger than [_imagesGroup count]");
    return [_imagesGroups objectAtIndex:idx];
}

- (void)uncollapaseAtPosition:(NSUInteger)idx success:(IdBoolBlock)succes
{
    NSArray * array = [self imagesAtIndex:idx];
    __block NSMutableArray  * uncollapsedImages = [NSMutableArray arrayWithCapacity:[array count]];
    BOOL error = NO;
    if ([array count] > 1) {
        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [uncollapsedImages addObject:@[obj]];
        }];
        [_imagesGroups replaceObjectsInRange:NSMakeRange(idx, 1) withObjectsFromArray:uncollapsedImages];
    }
    else {
        error = YES;
    }
    succes(uncollapsedImages, error);
}

- (void)collapaseFrom:(NSUInteger)idxFrom to:(NSUInteger)idxTo success:(IdBoolBlock)succes
{
    NSUInteger from = MIN(idxFrom, idxTo);
    NSUInteger to = MAX(idxFrom, idxTo);
    __block NSMutableArray * collapsed = [NSMutableArray array];
    __block BOOL error = NO;
    NSRange subarrayRange = NSMakeRange(from, to - from + 1);
    NSArray * subarray = [_imagesGroups subarrayWithRange:subarrayRange];
    [subarray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj count] > 1) {
            *stop = YES;
            error = YES;
            collapsed = nil;
        }
        [collapsed addObject:[obj lastObject]];
    }];
    if (collapsed) {
        [_imagesGroups removeObjectsInRange:subarrayRange];
        [_imagesGroups insertObject:collapsed atIndex:from];
    }
    succes(collapsed, error);
}

- (UIImage*)tileFashionImage:(NSArray*)images
{
    __block CGSize smallerSize = [TrAdImageCollectionView normalizedSize:[images objectAtIndex:0]];
    __block CGSize biggerSize = [TrAdImageCollectionView normalizedSize:[images objectAtIndex:0]];
    [[images subarrayWithRange:NSMakeRange(1, [images count]-1)] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGSize size = [TrAdImageCollectionView normalizedSize:obj];
        smallerSize.height = MIN(smallerSize.height, size.height);
        biggerSize.height = MAX(biggerSize.height, size.height);
    }];
    
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(biggerSize.width, biggerSize.height), YES, 0.0);
    [[UIColor whiteColor] setFill];
    UIRectFill(CGRectMake(0, 0, biggerSize.width, biggerSize.height));
    [[UIColor blackColor] setFill];
    UIRectFill(CGRectMake(1, 1, biggerSize.width-2, biggerSize.height-2));
    [[UIColor whiteColor] setFill];
    UIRectFill(CGRectMake(3, 3, biggerSize.width-6, biggerSize.height-6));
    
    CGFloat deltaWidth  = (biggerSize.width-6)  / 3 / [images count];
    CGFloat deltaHeight = (biggerSize.height-6) / 3 / [images count];
    
    for (int idx = 0; idx < [images count]; idx++) {
        UIImage * obj = [images objectAtIndex:idx];
        CGSize size = [TrAdImageCollectionView normalizedSize:obj];
        size.width  *= (CGFloat)2/(CGFloat)3;
        size.height *= (CGFloat)2/(CGFloat)3;
        CGRect rect = CGRectMake(deltaWidth*idx+6, deltaHeight*idx+6, size.width, size.height);
        CGFloat alpha = 0.75 + 0.25 * (CGFloat)([images count]-idx)/(CGFloat)[images count];
        [obj drawInRect:rect blendMode:kCGBlendModeNormal alpha:alpha];
    };
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    // (6) Closing the context:
    UIGraphicsEndImageContext();
    
    return image;
}

@end
