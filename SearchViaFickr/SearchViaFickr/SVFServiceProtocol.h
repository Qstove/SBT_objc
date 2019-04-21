//
//  SVFServiceProtocol.h
//  SearchViaFickr
//
//  Created by Анатолий Кустов on 17/04/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//


@protocol SVFServiceOutputProtocol <NSObject>
@required
- (void)searchViewDidFinishedLoadingWith:(NSData *)data;
@end

@protocol SVFServiceInputProtocol <NSObject>
@optional
- (void)searchFlickrPhotoWith:(NSString *)query;
- (void)startImageLoadingWithURL:(NSString *)imgURL;

@end
