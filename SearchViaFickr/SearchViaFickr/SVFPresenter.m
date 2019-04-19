//
//  SVFPresenter.m
//  SearchViaFickr
//
//  Created by Qstove on 17/04/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import "SVFPresenter.h"
#import "SVFModel.h"


@interface SVFPresenter ()

@property (nonatomic, strong) SVFModel *model;

@end

@implementation SVFPresenter

- (instancetype)initAndAttachView:(id)view
{
    self = [super init];
    self.delegateView = view;
    self.model = [[SVFModel alloc]initAndAttachPresenter:self];
    return self;
}


#pragma mark - SVFView delegate
- (void)searchButtonDidPressedWith:(NSString*)query;
{
    [self.delegateView searchViewDidStartLoading]; //послать сигнал о том, чтобы вью начала крутить спинер
    [self.model sendQueryToGetImagesWith:(NSString*)query];
}

- (void)searchViewDidFinishedLoadingWith:(NSArray *)imagesArray
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.delegateView searchViewDidFinishedLoadingWith:imagesArray];
    });
}




@end
