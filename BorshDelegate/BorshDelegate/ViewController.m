//
//  ViewController.m
//  BorshDelegate
//
//  Created by Анатолий Кустов on 02/03/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import "ViewController.h"
#import "Granny.h"
#import "Grandson.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Granny *granny = [Granny new];
    id<BorshDelegate> grandson = [Grandson new];
    granny.borshDelegate = grandson;
    
    [granny serveLunch];
    
    
    // Задание:
    // необходимо дописать классы Granny и Grandson таким образом, чтобы
    // при вызове метода serveLunch были выведены в консоль
    // последовательно все события взаимодействия объекта и его делегата
}


@end
