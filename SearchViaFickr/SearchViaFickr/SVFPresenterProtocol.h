//
//  SVFPresenterProtocol.h
//  SearchViaFickr
//
//  Created by Анатолий Кустов on 17/04/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

@protocol SVFPresenterProtocol <NSObject>

@optional //todo уточнить

- (void) searchViewDidStartLoading;
- (void) searchViewDidFinishedLoadingWith:(NSArray <UIImage *>*)imagesArray;
- (void) sendQueryToGetImagesWith:(NSString*)query;


@end
