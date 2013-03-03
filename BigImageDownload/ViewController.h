//
//  ViewController.h
//  BigImageDownload
//
//  Created by T. Andrew Binkowski on 2/21/13.
//  Copyright (c) 2013 T. Andrew Binkowski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
- (IBAction)downloadImage:(UIButton *)sender;

@end
