//
//  BorshDelegate.h
//  BorshDelegate
//
//  Created by Анатолий Кустов on 02/03/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Протокол делегирования "работы" по поеданию приготовленного борща.
 */
@protocol BorshDelegate <NSObject>

@optional

/**
 Оповещает о том, что борщ приготовлен и необходимо принять решение
 есть его или не есть.
 
 @return признак был съеден борщ или нет.
 */
- (BOOL)borshServed;

@end
