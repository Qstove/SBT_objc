//
//  ClothTypeCell_R.h
//  tableView_oppositeCells
//
//  Created by Анатолий Кустов on 09/04/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ClothTypeObject.h"



@interface ClothTypeCell_R : UITableViewCell

- (void)setDataFromClothTypeModel:(ClothTypeObject *)clothType;

@end


