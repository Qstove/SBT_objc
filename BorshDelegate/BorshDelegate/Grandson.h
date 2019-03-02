//
//  Granson.h
//  BorshDelegate
//
//  Created by Анатолий Кустов on 02/03/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BorshDelegate.h"

/**
 Класс, представляющий внука, который умеет взаимодействовать с борщом.
 */
@interface Grandson : NSObject <BorshDelegate>

- (BOOL)checkLunchTime;

@end
