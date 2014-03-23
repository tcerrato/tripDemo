//
//  CoreDataViewController.h
//  CoreData
//
//  Created by Tony Cerrato on 3/15/14.
//  Copyright (c) 2014 Tony Cerrato. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface CoreDataViewController : UIViewController

- (IBAction)endTrip:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *endLocation;
@property (weak, nonatomic) IBOutlet UITextView *startLocation;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UILabel *status;


- (IBAction)saveData:(id)sender;
//- (IBAction)findContact:(id)sender;
- (IBAction)getLocation:(id)sender;


@end
