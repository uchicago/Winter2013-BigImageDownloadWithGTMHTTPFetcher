//
//  ViewController.m
//  BigImageDownload
//
//  Created by T. Andrew Binkowski on 2/21/13.
//  Copyright (c) 2013 T. Andrew Binkowski. All rights reserved.
//

#import "ViewController.h"
#import "GTMHTTPFetcher.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Register our custom notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotNotification:) name:@"mobi.uchicago.date" object:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*******************************************************************************
 * @method      gotNotification
 * @abstract    Method called by Notification Center when mobi.uchicago.date is received
 * @description <# description #>
 *******************************************************************************/
- (void)gotNotification:(NSNotification *)notif {
    
    NSLog(@">>>> Notification Center Recieved: %@",notif);
    NSDate *dateObject = (NSDate*)[notif object];
    
    self.dateLabel.text = [NSString stringWithFormat:@"Image Downloaded on %@", [dateObject description]];
}


/*******************************************************************************
 * @method          downloadImage
 * @abstract        <# Abstrace #>
 * @description     <# Description #>
 ******************************************************************************/
- (IBAction)downloadImage:(UIButton *)sender {
    [self downloadBigImage];
}

/*******************************************************************************
 * @method      downloadBigImage
 * @abstract    Download image from URL using Google GTM-HTTP Fetcher
 * @description The UIActivityIndicator (spinner) starts when called and stops when the image is downloaded
 *******************************************************************************/
- (void)downloadBigImage
{
    NSURL *url = [NSURL URLWithString:@"http://i.imwx.com/images/maps/truvu/map_specnews16_ltst_4namus_enus_650x366.jpg"];
    [self.spinner startAnimating];
    
    GTMHTTPFetcher* myFetcher = [GTMHTTPFetcher fetcherWithRequest:[NSURLRequest requestWithURL:url]];
    [myFetcher beginFetchWithCompletionHandler:^(NSData *retrievedData, NSError *error) {
		if (error != nil) {
            // Log error
            NSLog(@"ERROR:%@",error);
        } else {
            
            // Update the UIImageView image property with the downloaded image
            sleep(3); // Fake a bad connection
            
            // Convert data to image
            UIImage *image = [UIImage imageWithData:retrievedData];
            self.bigImageView.image = image;
            
            [self.spinner stopAnimating];
            
            // Send Notification that we received the image
            [[NSNotificationCenter defaultCenter] postNotificationName:@"mobi.uchicago.date" object:[NSDate date]];
            
        }
    }];
}

@end
