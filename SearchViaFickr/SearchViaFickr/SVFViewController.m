//
//  SVFViewController.m
//  SearchViaFickr
//
//  Created by Qstove on 17/04/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import "SVFViewController.h"
#import "SVFPresenter.h"
#import "SVFService.h"
#import "SVFCollectionViewCell.h"

#define kCellIdentifier @"SVFCollectionViewCell"

@interface SVFViewController ()

@property (nonatomic,strong) UISearchController *searchController;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIActivityIndicatorView *loadingSpinner;
@property (nonatomic,strong) SVFPresenter *presenter;
@property (nonatomic, strong) NSArray <UIImage *> *ptrToImageArray;

@end

@implementation SVFViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.presenter = [[SVFPresenter alloc]initAndAttachView:self];
    [self createUI];
}

- (void) createUI
{
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"Search via Flickr";
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    self.searchController.searchBar.delegate = self;
    //self.searchController.obscuresBackgroundDuringPresentation = NO;
    self.searchController.searchBar.placeholder = @"Search for Images";
    self.searchController.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    self.navigationItem.searchController = self.searchController;
    self.definesPresentationContext = YES;
    self.navigationItem.hidesSearchBarWhenScrolling = NO;
    
    self.searchController.searchBar.delegate = self;
    self.searchController.searchBar.placeholder = @"Search for Images";
    //[self.view addSubview:self.searchBar];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 1.0;
    layout.minimumInteritemSpacing = 1.0;
    layout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame)/2-1, CGRectGetWidth(self.view.frame)/2);
    

    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1];
    [self.collectionView registerClass:[SVFCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
    self.loadingSpinner = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
   
    [self.view addSubview:self.collectionView];
}

- (void)viewDidLayoutSubviews
{
    self.collectionView.frame = CGRectMake(0, self.view.safeAreaInsets.top, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - self.view.safeAreaInsets.top);
}


#pragma mark - searchBar Delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchController resignFirstResponder];
    [self.presenter searchButtonDidPressedWith:self.searchController.searchBar.text];       //послали сигнал презентеру
}

#pragma mark - CollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.ptrToImageArray.count;
}

#pragma mark - CollectionViewDelegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SVFCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *image = self.ptrToImageArray[indexPath.item];
    [(SVFCollectionViewCell *)cell configureWith:image];
}


#pragma mark - Presenter Delegate
- (void) searchViewDidStartLoading
{
    [self.loadingSpinner startAnimating];
}

- (void) searchViewDidFinishedLoadingWith:(NSArray <UIImage *>*)imagesArray
{
    self.ptrToImageArray = imagesArray;
    [self.loadingSpinner stopAnimating];
    [self.collectionView reloadData];
}
@end
