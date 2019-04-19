//
//  SVFServiceHelper.m
//  SearchViaFickr
//
//  Created by Анатолий Кустов on 17/04/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import "SVFServiceHelper.h"

@implementation SVFServiceHelper

+ (NSString *)FLICKR_URLForSearchString:(NSString *)searchString
{
    NSString *APIKey = @"5553e0626e5d3a905df9a76df1383d98";
    return [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&per_page=20&format=json&nojsoncallback=1", APIKey, searchString];
}

+ (NSString *)FLICKR_ImgURL:(NSDictionary *)photo
{
    /**
     Для получение деталей по фото:
     https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
     example    https://farm1.staticflickr.com/2/1418878_1e92283336_m.jpg
     */
    return [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"],[photo objectForKey:@"secret"]];
}

@end
