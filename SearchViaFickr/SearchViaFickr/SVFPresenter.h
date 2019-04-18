//
//  SVFPresenter.h
//  SearchViaFickr
//
//  Created by Qstove on 17/04/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SVFViewProtocol.h"
#import "SVFPresenterProtocol.h"
#import "SVFModelProtocol.h"



@interface SVFPresenter : NSObject <SVFViewProtocol, SVFModelProtocol>

@property (nonatomic, weak) id <SVFPresenterProtocol> delegateView;
- (instancetype)initAndAttachView:(id)view;



@end


