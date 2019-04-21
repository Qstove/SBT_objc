//
//  SVFImageFilterViewController.m
//  SearchViaFickr
//
//  Created by Анатолий Кустов on 4/21/19.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import "SVFImageFilterViewController.h"
#define SLIDER_LEFTRIGHT_MARGIN     50
@interface SVFImageFilterViewController ()

@property (nonatomic, strong)UIImage* image;
@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)UIView *sliderView;

@property (nonatomic, strong)UILabel *bwControlFilterLabel;
@property (nonatomic, strong)UISlider *bwFilterSlider;
@property (nonatomic, strong)UILabel *sepiaFilterLabel;
@property (nonatomic, strong)UISlider *sepiaFilterSlider;
@property (nonatomic, strong)UILabel *exposureAdjustFilterLabel;
@property (nonatomic, strong)UISlider *exposureAdjustFilterSlider;

@end

@implementation SVFImageFilterViewController

-(instancetype)initWithImage:(UIImage*)image
{
    self = [super init];
    _imageView = [UIImageView new];
    _image = image;
    _sliderView = [UIView new];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createUI];
}

-(void)createUI
{
    CGRect viewFrame = CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), CGRectGetWidth(UIScreen.mainScreen.bounds), (CGRectGetHeight(UIScreen.mainScreen.bounds)-CGRectGetHeight(self.navigationController.navigationBar.frame)-CGRectGetHeight([UIApplication sharedApplication].statusBarFrame))*(2.0/3.0));
    
    self.view.frame = viewFrame;
    CGRect sliderViewFrame = CGRectMake(0, CGRectGetMaxY(self.view.frame), CGRectGetWidth(self.view.frame), (CGRectGetHeight(UIScreen.mainScreen.bounds)-CGRectGetHeight(self.navigationController.navigationBar.frame) - CGRectGetHeight([UIApplication sharedApplication].statusBarFrame) )*(1.0/3.0));
    self.imageView.frame = self.view.frame;
    self.sliderView.frame = sliderViewFrame;
    
    self.imageView.image = self.image;
    [self.view addSubview: self.imageView];
    self.sliderView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview: self.sliderView];
    
    
    self.bwControlFilterLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(self.sliderView.frame), CGRectGetWidth(self.sliderView.frame), CGRectGetHeight(self.sliderView.frame)/6)];
    self.bwControlFilterLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightSemibold];
    self.bwControlFilterLabel.text = @"Black&White filter";
    self.bwControlFilterLabel.textColor = UIColor.blackColor;
    self.bwControlFilterLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.bwControlFilterLabel];
    
    self.bwFilterSlider = [[UISlider alloc]initWithFrame:CGRectMake(SLIDER_LEFTRIGHT_MARGIN, CGRectGetMaxY(self.bwControlFilterLabel.frame), CGRectGetWidth(self.sliderView.frame) - SLIDER_LEFTRIGHT_MARGIN*2, CGRectGetHeight(self.bwControlFilterLabel.frame))];
    self.bwFilterSlider.value = 0.5;
    [self.bwFilterSlider addTarget:self action:@selector(colorControlSliderValueDidChanged) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.self.bwFilterSlider];
    
    
    self.sepiaFilterLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bwFilterSlider.frame), CGRectGetWidth(self.bwControlFilterLabel.frame), CGRectGetHeight(self.bwControlFilterLabel.frame))];
    self.sepiaFilterLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightSemibold];
    self.sepiaFilterLabel.text = @"Sepia filter";
    self.sepiaFilterLabel.textColor = UIColor.blackColor;
    self.sepiaFilterLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.sepiaFilterLabel];
    
    self.sepiaFilterSlider = [[UISlider alloc]initWithFrame:CGRectMake(SLIDER_LEFTRIGHT_MARGIN, CGRectGetMaxY(self.sepiaFilterLabel.frame), CGRectGetWidth(self.sliderView.frame) - SLIDER_LEFTRIGHT_MARGIN*2, CGRectGetHeight(self.bwControlFilterLabel.frame))];
    self.sepiaFilterSlider.value = 0.5;
    [self.sepiaFilterSlider addTarget:self action:@selector(sepiaSliderValueDidChanged) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.self.sepiaFilterSlider];
    
    
    self.exposureAdjustFilterLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.sepiaFilterSlider.frame), CGRectGetWidth(self.bwControlFilterLabel.frame), CGRectGetHeight(self.bwControlFilterLabel.frame))];
    self.exposureAdjustFilterLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightSemibold];
    self.exposureAdjustFilterLabel.text = @"Exposure Adjust filter";
    self.exposureAdjustFilterLabel.textColor = UIColor.blackColor;
    self.exposureAdjustFilterLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.exposureAdjustFilterLabel];
    
    self.exposureAdjustFilterSlider = [[UISlider alloc]initWithFrame:CGRectMake(SLIDER_LEFTRIGHT_MARGIN, CGRectGetMaxY(self.exposureAdjustFilterLabel.frame), CGRectGetWidth(self.sliderView.frame) - SLIDER_LEFTRIGHT_MARGIN*2, CGRectGetHeight(self.bwControlFilterLabel.frame))];
    self.exposureAdjustFilterSlider.value = 0.5;
    [self.exposureAdjustFilterSlider addTarget:self action:@selector(exposureAdjustSliderValueDidChanged) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.self.exposureAdjustFilterSlider];
}


- (void)colorControlSliderValueDidChanged
{
    NSNumber *intensity = [NSNumber numberWithFloat:self.bwFilterSlider.value * 2 - 1];
    CIImage *inputImage = [CIImage imageWithCGImage:self.image.CGImage];
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *outputImage = [[CIFilter filterWithName:@"CIColorControls" keysAndValues:kCIInputImageKey, inputImage, @"inputBrightness", intensity, @"inputContrast", [NSNumber numberWithFloat:1.1], @"inputSaturation", [NSNumber numberWithFloat:0.0], nil] outputImage];
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *finalImage = [UIImage imageWithCGImage:cgimg];
    self.imageView.image = finalImage;
    CGImageRelease(cgimg);
}

- (void)sepiaSliderValueDidChanged
{
    NSNumber *intensity = [NSNumber numberWithFloat:self.sepiaFilterSlider.value * 2 - 1];
    CIImage *inputImage = [CIImage imageWithCGImage:self.image.CGImage];
    CIContext *context = [CIContext contextWithOptions:nil];
    CIFilter *filterSepia = [CIFilter filterWithName:@"CISepiaTone" keysAndValues: kCIInputImageKey, inputImage, kCIInputIntensityKey, intensity, nil];
    CIImage *outputImage = [filterSepia outputImage];
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *finalImage = [UIImage imageWithCGImage:cgimg];
    self.imageView.image = finalImage;
    CGImageRelease(cgimg);
}

- (void)exposureAdjustSliderValueDidChanged
{
    NSNumber *intensity = [NSNumber numberWithFloat:self.exposureAdjustFilterSlider.value];
    CIImage *inputImage = [CIImage imageWithCGImage:self.image.CGImage];
    CIContext *context = [CIContext contextWithOptions:nil];
    CIFilter *filter = [CIFilter filterWithName:@"CIExposureAdjust" keysAndValues: kCIInputImageKey, inputImage, kCIInputEVKey, intensity, nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *finalImage = [UIImage imageWithCGImage:cgimg];
    self.imageView.image = finalImage;
    
    CGImageRelease(cgimg);
}
@end
