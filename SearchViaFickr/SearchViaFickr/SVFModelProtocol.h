//
//  SVFModelProtocol.h
//  SearchViaFickr
//
//  Created by Qstove on 18/04/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SVFModelProtocol <NSObject>

@optional
- (void)sendQueryToGetDataWith:(NSString*)query;
- (void)getImage:(UIImage *)image;
- (void)searchViewDidFinishedLoadingWith:(NSArray *)imagesArray;


@end
