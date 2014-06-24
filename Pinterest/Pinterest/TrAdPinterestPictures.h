//
//  TrAdPinterestPictures.h
//  Pinterest
//
//  Created by Gustavo Halperin on 6/22/14.
//  Copyright (c) 2014 TripAdvisor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrAdPinterestPictures : NSObject

+ (id)sharedInstance;

/**
 Return the predicter number of items to show but if already were items agruped then are taken as on item.
 */
- (NSUInteger)imagesGroupsCount;
- (NSArray*)imagesAtIndex:(NSUInteger)idx;
- (void)collapaseFrom:(NSUInteger)idxFrom to:(NSUInteger)idxTo success:(IdBoolBlock)succes;

- (UIImage*)tileFashionImage:(NSArray*)images;

@end
