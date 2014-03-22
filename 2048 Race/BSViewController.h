//
//  BSViewController.h
//  2048 Race
//
//  Created by Nathan Pabrai on 3/20/14.
//  Copyright (c) 2014 BaconSteak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
@interface BSViewController : UIViewController <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *tile1;
@property (weak, nonatomic) IBOutlet UILabel *tile2;
@property (weak, nonatomic) IBOutlet UILabel *tile3;
@property (weak, nonatomic) IBOutlet UILabel *tile4;
@property (weak, nonatomic) IBOutlet UILabel *tile5;
@property (weak, nonatomic) IBOutlet UILabel *tile6;
@property (weak, nonatomic) IBOutlet UILabel *tile7;
@property (weak, nonatomic) IBOutlet UILabel *tile8;
@property (weak, nonatomic) IBOutlet UILabel *tile9;
@property (weak, nonatomic) IBOutlet UILabel *tile10;
@property (weak, nonatomic) IBOutlet UILabel *tile11;
@property (weak, nonatomic) IBOutlet UILabel *tile12;
@property (weak, nonatomic) IBOutlet UILabel *tile13;
@property (weak, nonatomic) IBOutlet UILabel *tile14;
@property (weak, nonatomic) IBOutlet UILabel *tile15;
@property (weak, nonatomic) IBOutlet UILabel *tile16;
@property (strong,nonatomic) NSMutableArray *tiles;
@property int score;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak,nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet ADBannerView *ad;
@property BOOL loaded;
@end
