//
//  TrAdImagesCollectionViewDataSource.h
//  Pinterest
//
//  Created by Gustavo Halperin on 6/20/14.
//  Copyright (c) 2014 TripAdvisor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface TrAdImagesCollectionViewDataSource: NSObject <UICollectionViewDataSource>

- (id)initReuseIdentifier:(NSString*)identifier;

@end
