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


@interface SVFDataRepository ()

@property (nonatomic, strong) SVFService *service;

@end

@implementation SVFDataRepository

- (instancetype)initAndAttachModel:(id)model
{
    self = [super init];
    self.delegateModel = model;
    self.service = [SVFService new];
    self.service.output = self;
    return self;
}

- (void)sendQueryToGetDataWith:(NSString*)query
{
    [self.service searchFlickrPhotoWith:query];
}


- (void)searchViewDidFinishedLoadingWith:(NSData *)data
{
    @synchronized (self) {
        [self.delegateModel getImage:[UIImage imageWithData:data]];
    }
}

@end
