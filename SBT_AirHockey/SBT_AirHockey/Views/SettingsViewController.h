//
//  SettingsView.h
//  SBT_AirHockey
//
//  Created by Анатолий Кустов on 29/03/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingsViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
/*
typedef enum
{
    EASY,
    MEDIUM,
    HARD,
    NIGHTMARE
}difficulty;
*/
//@property (nonatomic) difficulty option;
@property (nonatomic, strong) NSNumber* score;


@end

NS_ASSUME_NONNULL_END
