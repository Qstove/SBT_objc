//
//  ViewController.m
//  tableView_oppositeCells
//
//  Created by Анатолий Кустов on 09/04/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import "ViewController.h"
#import "ClothTypeCell_L.h"
#import "ClothTypeCell_R.h"
#import "ClothTypeObject.h"


@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) UITableView *tableView;
@property (nonatomic, strong) NSArray<ClothTypeObject *> *clothTypeObjects;

@end

@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self fillClothTypeObjectsArr];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style: UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
  
    [self.tableView registerClass:[ClothTypeCell_L class] forCellReuseIdentifier:NSStringFromClass([ClothTypeCell_L class])];
    [self.tableView registerClass:[ClothTypeCell_R class] forCellReuseIdentifier:NSStringFromClass([ClothTypeCell_R class])];
    
    [self.view addSubview: self.tableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.clothTypeObjects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 0) {
        ClothTypeCell_R *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ClothTypeCell_L class]) forIndexPath:indexPath];
        ClothTypeObject *clothTypeObject = self.clothTypeObjects[indexPath.row];
        [cell setDataFromClothTypeModel:clothTypeObject];
        cell.backgroundColor = UIColor.whiteColor;
        return cell;
    }
    else {
        ClothTypeCell_R *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ClothTypeCell_R class]) forIndexPath:indexPath];
        ClothTypeObject *clothTypeObject = self.clothTypeObjects[indexPath.row];
        [cell setDataFromClothTypeModel:clothTypeObject];
        cell.backgroundColor = UIColor.grayColor;
        return cell;
        
    }
}
    
-(void) fillClothTypeObjectsArr {
    self.clothTypeObjects = @[
                              [[ClothTypeObject alloc]initWithImage:[UIImage imageNamed:@"hat"] title: @"Hat" subtitle:@"Somethink to wear on head"],
                              [[ClothTypeObject alloc]initWithImage:[UIImage imageNamed:@"chest"] title: @"Chest" subtitle:@"Somethink to wear on chest"],
                              [[ClothTypeObject alloc]initWithImage:[UIImage imageNamed:@"pants"] title: @"Pants" subtitle:@"Somethink to wear on legs"],
                              [[ClothTypeObject alloc]initWithImage:[UIImage imageNamed:@"shoes"] title: @"Shoes" subtitle:@"Somethink to wear on heels"],
                              [[ClothTypeObject alloc]initWithImage:[UIImage imageNamed:@"acc"] title: @"acc" subtitle:@"Somethink like accesories"]
                              ];
}
 

@end
