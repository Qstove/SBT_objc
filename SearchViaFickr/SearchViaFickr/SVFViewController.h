//
//  SVFViewController.h
//  SearchViaFickr
//
//  Created by Qstove on 17/04/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVFPresenterProtocol.h"


@interface SVFViewController : UIViewController <SVFPresenterProtocol, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@end

