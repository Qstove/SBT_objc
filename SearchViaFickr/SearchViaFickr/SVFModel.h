//
//  SVFModel.h
//  SearchViaFickr
//
//  Created by Qstove on 18/04/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVFModelProtocol.h"
#import "SVFPresenterProtocol.h"


@interface SVFModel : NSObject <SVFPresenterProtocol>

@property (nonatomic, weak) id <SVFModelProtocol> delegatePresenter;

- (instancetype)initAndAttachPresenter:(id)presenter;

@end



