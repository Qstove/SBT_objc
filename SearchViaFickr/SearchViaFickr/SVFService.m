//
//  SVFService.m
//  SearchViaFickr
//
//  Created by Qstove on 17/04/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import "SVFService.h"
#import "SVFServiceHelper.h"
#import "NSString+QSTNSString.h"


@interface SVFService ()

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;

@end

@implementation SVFService


- (void)startImageLoadingWithURL:(NSString *)imgURL
{
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
    self.downloadTask = [self.session downloadTaskWithURL:[NSURL URLWithString:imgURL]];
    [self.downloadTask resume];
}


- (void)searchFlickrPhotoWith:(NSString *)query
{
    dispatch_queue_t myQueue = dispatch_queue_create("myQueue0", DISPATCH_QUEUE_SERIAL);
    NSString *urlString = [SVFServiceHelper FLICKR_URLForSearchString:query];   //сформировали ссылку для поиска
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];              //создаем запрос
    [request setURL:[NSURL URLWithString:urlString]];                               //передали в него ссылку
    [request setHTTPMethod:@"GET"];                                                 //определели его как GET запрос
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setTimeoutInterval:20];
    
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDataTask *sessionDataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
     {
         NSDictionary *temp = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
         [self.session finishTasksAndInvalidate];
         for(NSDictionary *photo in [[temp objectForKey:@"photos"] objectForKey:@"photo"])
         {
             NSString *imgURL = [SVFServiceHelper FLICKR_ImgURL:photo]; //метод, принимающий словарь и генерирущий ссылку
             dispatch_async(myQueue, ^{
                 [self startImageLoadingWithURL:imgURL];
             });
         }
     }];
    [sessionDataTask resume];
}


#pragma mark - NSURLSessionDelegate

//вызывается по окончанию загрузки
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    dispatch_queue_t myQueue = dispatch_queue_create("myQueue1", DISPATCH_QUEUE_SERIAL);
    NSData *data = [NSData dataWithContentsOfURL:location];
    dispatch_sync(myQueue, ^{
        [self.output searchViewDidFinishedLoadingWith:data];
    });
    [session finishTasksAndInvalidate];
}



@end

