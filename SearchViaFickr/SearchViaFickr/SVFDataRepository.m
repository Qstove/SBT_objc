//
//  SVFDataRepository.m
//  SearchViaFickr
//
//  Created by Qstove on 18/04/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVFDataRepository.h"
#import "SVFService.h"
#import "SVFNotificationService.h"



@interface SVFDataRepository ()

@property (nonatomic, strong) SVFService *networkService;
@property (nonatomic, strong) SVFNotificationService *notificationService;

@end

@implementation SVFDataRepository

- (instancetype)initAndAttachModel:(id)model
{
    self = [super init];
    self.delegateModel = model;
    self.networkService = [SVFService new];
    self.notificationService = [SVFNotificationService new];
    [self.notificationService sheduleLocalNotificationWithDate];
    self.networkService.output = self;
    return self;
}

- (void)sendQueryToGetDataWith:(NSString*)query
{
    [[NSUserDefaults standardUserDefaults] setObject:query forKey:@"lastQuery"];            //save
    [self.networkService searchFlickrPhotoWith:query];
    
}


- (void)searchViewDidFinishedLoadingWith:(NSData *)data
{
    @synchronized (self) {
        [self.delegateModel getImage:[UIImage imageWithData:data]];
    }
}

@end
