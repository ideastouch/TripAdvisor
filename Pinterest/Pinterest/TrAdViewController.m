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
    
//    [self.collectionView registerClass:[TrAdImageCollectionViewCell class] forCellWithReuseIdentifier:TrAdViewControllerCellIdntifier];
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
    assert([gestureRecognizer numberOfTouches] == 2 && @"Touches must be 2");
    
    id (^getIndexPath)(NSInteger) = ^id(NSInteger idx){
        CGPoint location = [gestureRecognizer locationOfTouch:idx inView:[gestureRecognizer view]];
        CGRect rect = CGRectMake(location.x - 1, location.y - 1, location.x + 1, location.y + 1);
        NSArray * layoutAttributes = [[_collectionView collectionViewLayout] layoutAttributesForElementsInRect:rect];
        assert([layoutAttributes count] == 1 && @"Can not be more/less than one layout");
        return[[layoutAttributes lastObject] indexPath];
    };
    NSIndexPath * indexPath0 = getIndexPath(0);
    NSIndexPath * indexPath1 = getIndexPath(1);
}
@end
