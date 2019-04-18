//
//  SVFService.h
//  SearchViaFickr
//
//  Created by Qstove on 17/04/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVFServiceProtocol.h"


@interface SVFService : NSObject <SVFServiceInputProtocol, NSURLSessionDelegate, NSURLSessionDownloadDelegate>

@property (nonatomic, weak) id<SVFServiceOutputProtocol> output; /**< Делегат внешних событий, для обработки процессов загрузки и окончания загрузки*/

@end



