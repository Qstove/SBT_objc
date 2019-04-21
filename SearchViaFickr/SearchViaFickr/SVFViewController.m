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
#import "SVFImageFilterViewController.h"

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
    [self checkAccessToNotification];
}

- (void)checkAccessToNotification
{
    [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        if (settings.authorizationStatus != UNAuthorizationStatusAuthorized)
        {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Отключены уведомления!"
                                                                           message:@"Включите показ уведомлений в настройках для более корректной работы приложения."
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
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
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 1.0;
    layout.minimumInteritemSpacing = 1.0;
    layout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame)/2-1, CGRectGetWidth(self.view.frame)/2);
    

    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor colorWithRed:121.0/255.0 green:121.0/255.0 blue:121.0/255.0 alpha:1];
    [self.collectionView registerClass:[SVFCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
    
    self.loadingSpinner = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.loadingSpinner.center = self.view.center;
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.loadingSpinner];

}

- (void)viewDidLayoutSubviews
{
    self.collectionView.frame = CGRectMake(0, self.view.safeAreaInsets.top, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - self.view.safeAreaInsets.top);
}


#pragma mark - searchBar Delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchController resignFirstResponder];
    NSString *query = self.searchController.searchBar.text;
    [self.presenter searchButtonDidPressedWith:self.searchController.searchBar.text];       //послали сигнал презентеру
    [self.searchController setActive:NO];
    self.searchController.searchBar.text = query;
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
    [self.loadingSpinner stopAnimating];
    if (imagesArray.count == 0)
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Нет соединения!"
                                                                       message:@"Отсутствие интернет соединения или доступа к ресурсам Flickr!"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        self.ptrToImageArray = imagesArray;
        [self.collectionView reloadData];
    }
}


#pragma mark - UNUserNotificationCenterDelegate

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler
{
    if (completionHandler)
    {
        completionHandler(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge);
    }
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void(^)(void))completionHandler
{
    UNNotificationContent *content = response.notification.request.content;
    if (content.userInfo[@"query"])
    {
        NSString *query = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastQuery"];
        self.searchController.searchBar.text = query;
        [self.presenter searchButtonDidPressedWith:query];
    }
    
    if (completionHandler)
    {
        completionHandler();
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SVFImageFilterViewController *imageFilterViewController = [[SVFImageFilterViewController alloc]initWithImage:self.ptrToImageArray[indexPath.row]];
    [self.navigationController pushViewController:imageFilterViewController animated:YES];
}

@end
