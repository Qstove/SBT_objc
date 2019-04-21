//
//  SVFModel.m
//  SearchViaFickr
//
//  Created by Qstove on 18/04/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import "SVFModel.h"
#import "SVFDataRepository.h"


@interface SVFModel ()

@property (nonatomic, strong) NSMutableArray <UIImage *> *imageArray;
@property (nonatomic, strong) SVFDataRepository *dataRepository;

@end

@implementation SVFModel

- (instancetype)initAndAttachPresenter:(id)presenter
{
    self = [super init];
    self.delegatePresenter = presenter;
    self.imageArray = [NSMutableArray new];
    self.dataRepository = [[SVFDataRepository alloc]initAndAttachModel:self];
    return self;
}


#pragma PresenterDelegate
- (void)sendQueryToGetImagesWith:(NSString*)query;
{
    [self.imageArray removeAllObjects];
    [self.dataRepository sendQueryToGetDataWith:query];
}

- (void)getImage:(UIImage *)image
{
    if(image)
    {
        [self.imageArray addObject:image];
    }
    [self.delegatePresenter searchViewDidFinishedLoadingWith:self.imageArray];
}


@end
