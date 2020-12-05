//
//  ViewController.m
//  PicBro
//
//  Created by Яна Латышева on 14.08.2020.
//  Copyright © 2020 Motodolphin. All rights reserved.
//

#define CELL_IDENTIFIER @"MainCell"

#import "MainViewController.h"
#import "Extensions.h"
#import "MainCell.h"
#import "Presenter.h"
#import "ImageManager.h"


@interface MainViewController ()

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) NSMutableArray *images;
@property (strong, nonatomic) ImageManager *imageManager;

@end

@implementation MainViewController

// MARK: - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Pics";
    
    self.imageManager = [ImageManager new];
    
    [self loadData];
    [self configureCollectionView];
    [self configureRefreshControl];
}


// MARK: - Methods

- (void)loadData {
    
    [self.imageManager clearCache];
    
    NSString *path1 = @"https://images8.alphacoders.com/851/thumb-1920-851566.jpg";
    NSString *path2 = @"https://images.unsplash.com/photo-1541423408854-5df732b6f6d1?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80";
    NSString *path3 = @"https://images.unsplash.com/photo-1497250681960-ef046c08a56e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2134&q=80";
    NSString *path4 = @"https://images.unsplash.com/photo-1568605117036-5fe5e7bab0b7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80";
    NSString *path5 = @"https://images.unsplash.com/photo-1597692969854-b615b33f9696?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2134&q=80";
    NSString *path6 = @"https://images.unsplash.com/photo-1488415032361-b7e238421f1b?ixlib=rb-1.2.1&auto=format&fit=crop&w=1949&q=80";
    
    self.images = [NSMutableArray arrayWithObjects:path1, path2, path3, path4, path5, path6, nil];
}


- (void)configureCollectionView {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    // Register cell class
    [self.collectionView registerClass:[MainCell class] forCellWithReuseIdentifier:CELL_IDENTIFIER];
    
    // Set up delegates
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.view addSubview:_collectionView];
    
    if (@available(iOS 11, *)) {
        [self.collectionView setAnchorTop:self.view.safeAreaLayoutGuide.topAnchor paddingTop:0 bottom:self.view.bottomAnchor paddingBottom:0 leading:self.view.leadingAnchor paddingLeading:0 trailing:self.view.trailingAnchor paddingTrailing:0 centerX:nil centerY:nil];
    } else {
        [self.collectionView setAnchorTop:self.topLayoutGuide.topAnchor paddingTop:0 bottom:self.view.bottomAnchor paddingBottom:0 leading:self.view.leadingAnchor paddingLeading:0 trailing:self.view.trailingAnchor paddingTrailing:0 centerX:nil centerY:nil];
    }
}


- (void)configureRefreshControl {
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    if (@available(iOS 10.0, *)) {
        self.collectionView.refreshControl = _refreshControl;
    } else {
        // Fallback on earlier versions
        [self.collectionView addSubview:_refreshControl];
    }
    
}


// Pull to refresh
- (void)refresh {
    [self loadData];
    [self.collectionView reloadData];
    [self.refreshControl endRefreshing];
}


// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    MainCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    
    // Set flag to prevent deleting the cell
    cell.removable = NO;
    cell.imageView.image = nil;
    cell.imageView.backgroundColor = [UIColor lightGrayColor];
    [cell setHidden:NO];
    
    NSString *imagePath = [_images objectAtIndex:indexPath.row];
    // Save path of image to cell
    cell.imagePath = imagePath;
    
    // Download the image
    [self.imageManager downloadImageWithPath:imagePath completionHandler:^(UIImage * _Nullable image, NSString *imagePath, NSString * _Nullable error) {
        if (error) {
            NSLog(@"Download ERROR: %@. Path: %@", error, imagePath);
            return;
        }
        
        if (!image) {
            NSLog(@"Error: There is no downloaded image! Path: %@", imagePath);
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (cell.imagePath == imagePath) {
                cell.imageView.image = image;
                cell.imageView.backgroundColor = [UIColor whiteColor];
                // Restore flag. Now the cell can be removed
                cell.removable = YES;
            }
        }); //main_queue
        
    }]; //completionHandler
    
    return cell;
}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.images count];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat side = self.collectionView.frame.size.width - 20;
    return CGSizeMake(side, side);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Check state of the cell
    MainCell *cell = (MainCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (!cell.removable) {
        // Image is loading. We cannot delete it!
        return;
    }
        
    // Image is loaded. Now we can remove cell.
    
    // Set new position for cell
    CGRect frame = cell.frame;
    frame.origin.x = self.collectionView.frame.size.width;
    
    [UIView animateWithDuration:0.5 animations:^{
        cell.frame = frame;
    } completion:^(BOOL finished) {
        // Hide cell
        [cell setHidden:YES];
        // Delete item from array
        [self.images removeObjectAtIndex:indexPath.row];
        // Delete cell from colelction view
        [collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil]];
    }];
    
}

@end
