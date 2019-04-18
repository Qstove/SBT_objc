//
//  SVFDataRepository.h
//  SearchViaFickr
//
//  Created by Qstove on 18/04/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVFModelProtocol.h"
#import "SVFServiceProtocol.h"


@interface SVFDataRepository : NSObject <SVFServiceOutputProtocol, SVFModelProtocol>

@property (nonatomic, weak) id <SVFModelProtocol> delegateModel;

- (instancetype)initAndAttachModel:(id)model;


@end

