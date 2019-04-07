//
//  SettingsView.h
//  SBT_AirHockey
//
//  Created by Qstove on 02/04/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingsView : UIView <UIPickerViewDelegate, UIPickerViewDataSource>

typedef enum 
{
    EASY = 1,
    MEDIUM = 2,
    HARD = 4,
    NIGHTMARE = 8
}difficulty;

/**
 Создает и возвращает объект SettingsView
 
 @return экземпляр SettingsView
 */
+(SettingsView *) settingsView;


/**
Настраивает созданный раннее экземпляр SettingsView
 */
-(void)createUI;

/**
 Показать/спрятать окно настроек
 */
-(void)toggleViewSettings;

@property (nonatomic) BOOL isHide;              /**< Текущее состояние окна */
@property (nonatomic) difficulty option;        /**< Текущая настройка */
@property (nonatomic, assign) NSInteger score;  /**< Текущее количество очков */

@end

NS_ASSUME_NONNULL_END
