//
//  TrAdViewController.m
//  Pinterest
//
//  Created by Gustavo Halperin on 6/20/14.
//  Copyright (c) 2014 TripAdvisor. All rights reserved.
//

#import "TrAdViewController.h"
#import "TrAdImageCollectionView.h"
#import "TrAdImageCollectionViewCell.h"
#import "TrAdImageCollectionViewDelegate.h"
#import "TrAdImagesCollectionViewDataSource.h"
#import "TrAdPinterestPictures.h"

NSString * const TrAdViewControllerCellIdntifier = @"TrAdViewControllerCellIdntifier";

@interface TrAdViewController ()
@property (weak, nonatomic) IBOutlet TrAdImageCollectionView * collectionView;
@property (strong, nonatomic) IBOutlet TrAdImageCollectionViewDelegate * imageCollectionViewDelegate;
@property (strong, nonatomic) IBOutlet TrAdImagesCollectionViewDataSource * imagesCollectionViewDataSource;
@property (strong, nonatomic) IBOutlet UIPinchGestureRecognizer *pinchGestureRecognizer;
- (IBAction)handleGesture:(UIGestureRecognizer *)gestureRecognizer;

@end

@implementation TrAdViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setImageCollectionViewDelegate:[[TrAdImageCollectionViewDelegate alloc] init]];
    [_collectionView setDelegate:_imageCollectionViewDelegate];
    
    [self setImagesCollectionViewDataSource:[[TrAdImagesCollectionViewDataSource alloc] initReuseIdentifier:TrAdViewControllerCellIdntifier]];
    [_collectionView setDataSource:_imagesCollectionViewDataSource];
    
    [_collectionView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleGesture:(UIGestureRecognizer *)gestureRecognizer
{
    if (   gestureRecognizer.state == UIGestureRecognizerStateBegan
        && [gestureRecognizer numberOfTouches] == 2) {
        
        id (^getIndexPath)(NSInteger) = ^id(NSInteger idx) {
            CGPoint location = [gestureRecognizer locationOfTouch:idx inView:[gestureRecognizer view]];
            CGRect rect = CGRectMake(location.x - 1, location.y - 1, location.x + 1, location.y + 1);
            NSArray * layoutAttributes = [[_collectionView collectionViewLayout] layoutAttributesForElementsInRect:rect];
            __block NSIndexPath * indexPath = nil;
            [layoutAttributes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                if (CGRectContainsPoint(rect, location)) {
                    indexPath = [[layoutAttributes objectAtIndex:idx] indexPath];
                    *stop = YES;
                }
            }];
            
            return indexPath;
        };
        NSUInteger idxFrom = [getIndexPath(0) indexAtPosition:1];
        NSUInteger idxTo   = [getIndexPath(1) indexAtPosition:1];
        
        if (idxFrom == idxTo) {
            [[TrAdPinterestPictures sharedInstance] uncollapaseAtPosition:idxFrom
                                                                  success:^(id<NSObject> uncollapsedImages, BOOL fail) {
                                                                      if (fail) {
                                                                          [[[UIAlertView alloc] initWithTitle:@"Uncollapsion action"
                                                                                                      message:@"Uncollapsed acction fail."
                                                                                                     delegate:nil
                                                                                            cancelButtonTitle:@"OK"
                                                                                            otherButtonTitles:nil] show];
                                                                      }
                                                                      else {
                                                                          [_collectionView reloadData];
                                                                          [[[UIAlertView alloc] initWithTitle:@"Uncollapsion action"
                                                                                                      message:@"Uncollapsed acction succeded."
                                                                                                     delegate:nil
                                                                                            cancelButtonTitle:@"OK"
                                                                                            otherButtonTitles:nil] show];
                                                                      }
                                                                  }];
        }
        else {
            [[TrAdPinterestPictures sharedInstance] collapaseFrom:idxFrom
                                                               to:idxTo
                                                          success:^(id<NSObject> collapsedImages, BOOL fail) {
                                                              if (fail) {
                                                                  [[[UIAlertView alloc] initWithTitle:@"Collapsion action"
                                                                                              message:@"Collapsed acction fail."
                                                                                             delegate:nil
                                                                                    cancelButtonTitle:@"OK"
                                                                                    otherButtonTitles:nil] show];
                                                              }
                                                              else {
                                                                  [_collectionView reloadData];
                                                                  [[[UIAlertView alloc] initWithTitle:@"Collapsion action"
                                                                                              message:@"Collapsed acction succeded."
                                                                                             delegate:nil
                                                                                    cancelButtonTitle:@"OK"
                                                                                    otherButtonTitles:nil] show];
                                                              }
                                                          }];
        }
    }
}
@end
