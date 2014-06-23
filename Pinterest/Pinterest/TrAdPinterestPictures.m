//
//  TrAdPinterestPictures.m
//  Pinterest
//
//  Created by Gustavo Halperin on 6/22/14.
//  Copyright (c) 2014 TripAdvisor. All rights reserved.
//

#import "TrAdPinterestPictures.h"

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
    if (   [_imagesGroups objectAtIndex:idx] == nil
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

- (void)collapaseFrom:(NSIndexPath*)idxFrom to:(NSIndexPath*)idxTo success:(IdBoolBlock)succes
{
    NSUInteger from = MIN(idxFrom.row, idxTo.row);
    NSUInteger to = MAX(idxFrom.row, idxTo.row);
    __block NSMutableArray * collapsed = [NSMutableArray array];
    __block BOOL error = NO;
    NSRange subarrayRange = NSMakeRange(from, to - from);
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

@end
