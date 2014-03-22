//
//  BSViewController.m
//  2048 Race
//
//  Created by Nathan Pabrai on 3/20/14.
//  Copyright (c) 2014 BaconSteak. All rights reserved.
//

#import "BSViewController.h"

@interface BSViewController ()

@end

@implementation BSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  [self setUpGestureRecognizers];
  [self setUpTiles];
  
  
  // Get the stored data before the view loads
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  int hs = [defaults integerForKey:@"highscore"];
  float lt = [defaults floatForKey:@"fastest"];
  NSLog(@"The hiscore is %d",hs);
  NSLog(@"Fastest is %f",lt);
  
  UIAlertView *alert;
  if (lt>0){
  alert = [[UIAlertView alloc]
                        initWithTitle:@"How To Play"
                        message:[NSString stringWithFormat:@"Swipe in any direction to move the blocks. Two blocks of the same number join to form a larger block. The goal is to get a block at level 2048 ASAP.\nThe time to beat is %f",lt]//Need to finalize gameplay instructions here!
                        delegate:self
                        cancelButtonTitle:@"Start!"
                        otherButtonTitles:nil];
  }
  else{
    
    alert = [[UIAlertView alloc]
             initWithTitle:@"How To Play"
             message:[NSString stringWithFormat:@"Swipe in any direction to move the blocks. Two blocks of the same number join to form a larger block. The goal is to get a block at level 2048 ASAP.\nGet the 2048 tile for the first time"]//Need to finalize gameplay instructions here!
             delegate:self
             cancelButtonTitle:@"Start!"
             otherButtonTitles:nil];  }
  [alert show];
  
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//restart timer
  if (self.timer) [self.timer invalidate];
  NSTimer *theTimer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(timeTracker) userInfo:nil repeats:YES];
  // Assume a there's a property timer that will retain the created timer for future reference.
  self.timer = theTimer;  for (UILabel* tile in self.tiles){
    [tile setText:@""];
    
  }
  [(id)self.tiles[arc4random()%16] setText:@"2"] ;
  [self.time setText:@"0"];
  
  [self addRandomTile];
  
}
- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
  if (!self.loaded) {
    self.ad.hidden = NO;
    self.loaded = YES;
  }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
  if (self.loaded) {
    self.ad.hidden = YES;
    self.loaded = NO;
  }
}

-(void)timeTracker{
  [self.time setText:[NSString stringWithFormat:@"%8.2f",[[self.time text] floatValue] +.01 ]];
  
  
}
-(void)setUpGestureRecognizers{
  UISwipeGestureRecognizer* swipeUpGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeUpFrom:)];
  swipeUpGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
  [self.view addGestureRecognizer:swipeUpGestureRecognizer];
  UISwipeGestureRecognizer* swipeDownGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeDownFrom:)];
  swipeDownGestureRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
  [self.view addGestureRecognizer:swipeDownGestureRecognizer];
  UISwipeGestureRecognizer* swipeLeftGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeftFrom:)];
  swipeLeftGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
  [self.view addGestureRecognizer:swipeLeftGestureRecognizer];
  UISwipeGestureRecognizer* swipeRightGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRightFrom:)];
  swipeRightGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
  [self.view addGestureRecognizer:swipeRightGestureRecognizer];
}
-(void)setUpTiles{
  self.tiles=[[NSMutableArray alloc] init];
  //add the tiles to the tiles array
  [self.tiles addObject:self.tile1];
  [self.tiles addObject:self.tile2];
  [self.tiles addObject:self.tile3];
  [self.tiles addObject:self.tile4];
  [self.tiles addObject:self.tile5];
  [self.tiles addObject:self.tile6];
  [self.tiles addObject:self.tile7];
  [self.tiles addObject:self.tile8];
  [self.tiles addObject:self.tile9];
  [self.tiles addObject:self.tile10];
  [self.tiles addObject:self.tile11];
  [self.tiles addObject:self.tile12];
  [self.tiles addObject:self.tile13];
  [self.tiles addObject:self.tile14];
  [self.tiles addObject:self.tile15];
  [self.tiles addObject:self.tile16];
  //initialize tile values and pick 2 random starting tiles
  for (UILabel* tile in self.tiles){
    [tile setText:@""];
  }
  [(id)self.tiles[arc4random()%16] setText:@"2"] ;
  
  [self addRandomTile];
}

-(void)addRandomTile{
  int tmp=arc4random()%16;
  int cnt=0;
  self.score=0;
  float i;
  int twenfor=0;
  for (UILabel* tile in self.tiles){
    //need to color based on value
    i=[[tile text]intValue];
    if ([[tile text]intValue] ==0) {
      tile.backgroundColor=[UIColor colorWithRed:.2 green:.3 blue:.2 alpha:1];
    }
    else tile.backgroundColor=[UIColor colorWithRed:.4 green:i/25 blue:.7 *(i/100) alpha:1];
    
 
    if ([tile.text intValue]){
      cnt++;
      self.score+=[tile.text intValue];
      if([tile.text intValue]==2048){
        twenfor=1;
      }
      
    }
  }
  [self.scoreLabel setText:[NSString stringWithFormat:@"Score: %06d",self.score]];
  
  
  if (cnt==16 ||twenfor){
    int record=0;
    [self.timer invalidate];
    NSLog(@"gameover");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int hs = [defaults integerForKey:@"highscore"];
    float lt= [defaults floatForKey:@"fastest"];
    if ((lt==0&&twenfor)||(([[self.time text]floatValue]< lt) && twenfor>0)){
      record=1;
      [defaults setFloat:[[self.time text]floatValue] forKey:@"highscore"];
      
    }
    if (self.score>hs){
      record=1;
      [defaults setInteger:self.score forKey:@"highscore"];
    }
    [defaults synchronize];
    UIAlertView * alert;
    if (record){
      alert = [[UIAlertView alloc]
               
               initWithTitle:@"Congratulations!"
               message:[NSString stringWithFormat:@"New Record!\nYour time: %f\nYour score: %d\nFastest Time: %f\nHighscore: %d",[[self.time text]floatValue],self.score,[defaults floatForKey:@"fastest"],[defaults integerForKey:@"fastest"]]//Need to finalize gameplay instructions here!
               delegate:self
               cancelButtonTitle:@"Start new game!"
               otherButtonTitles:nil];
      
    }
    else if(twenfor){
      alert = [[UIAlertView alloc]
               
               initWithTitle:@"2048!"
               message:[NSString stringWithFormat:@"2048!\nYour time: %f\nYour score: %d\nFastest Time: %f\nHighscore: %d",[[self.time text]floatValue],self.score,[defaults floatForKey:@"fastest"],[defaults integerForKey:@"fastest"]]//Need to finalize gameplay instructions here!
               delegate:self
               cancelButtonTitle:@"Start new game!"
               otherButtonTitles:nil];
      
      
    }
    else{
      
      alert = [[UIAlertView alloc]
               
               initWithTitle:@"Game Over"
               message:[NSString stringWithFormat:@"\nYour time: %f\nYour score: %d\nFastest Time: %f\nHighscore: %d",[[self.time text]floatValue],self.score,[defaults floatForKey:@"fastest"],[defaults integerForKey:@"highscore"]]//Need to finalize gameplay instructions here!
               delegate:self
               cancelButtonTitle:@"Start new game!"
               otherButtonTitles:nil];
      
    }
    [alert show];
       return;
  }
  while ([[(id)self.tiles[tmp] text]intValue])
  {
    tmp=arc4random()%16;
  }
  
  [(id)self.tiles[tmp] setText:@"2"];
  i=2;
  [(id)self.tiles[tmp] setBackgroundColor:[UIColor colorWithRed:.4 green:i/25 blue:.7 *(i/100) alpha:1]];
}

- (void)handleSwipeUpFrom:(UIGestureRecognizer*)recognizer {
  NSLog(@"Swiped Up :)");
  int i;
  for(int n=2;n<5;n++){
    i=4*n-4;
    if ([[self.tiles[i] text]intValue]) {
      //The tile has a value
      //Tile not at boundry
      if ([[self.tiles[i-4] text]intValue]) {
        //If the tile to left has a value
        //...
        if ([[self.tiles[i-4] text]intValue]==[[self.tiles[i] text]intValue] ) {
          //if the one on the left matches
        }
      }
      else{
        //move the tile to the left
        [self moveUpfrom:i withEdge:0];
        
      }//ends else
      
      
    }//else the tile is empty
    
  }
  
  
  for(int n=2;n<5;n++){
    i=4*n-3;
    if ([[self.tiles[i] text]intValue]) {
      //The tile has a value
      //Tile not at boundry
      if ([[self.tiles[i-4] text]intValue]) {
        //If the tile to left has a value
        //...
        if ([[self.tiles[i-4] text]intValue]==[[self.tiles[i] text]intValue] ) {
          //if the one on the left matches
        }
      }
      else{
        //move the tile to the left
        [self moveUpfrom:i withEdge:1];
        
      }//ends else
      
      
    }//else the tile is empty
    
  }
  for(int n=2;n<5;n++){
    i=4*n-2;
    if ([[self.tiles[i] text]intValue]) {
      //The tile has a value
      //Tile not at boundry
      if ([[self.tiles[i-4] text]intValue]) {
        //If the tile to left has a value
        //...
        if ([[self.tiles[i-4] text]intValue]==[[self.tiles[i] text]intValue] ) {
          //if the one on the left matches
        }
      }
      else{
        //move the tile to the left
        [self moveUpfrom:i withEdge:2];
        
      }//ends else
      
      
    }//else the tile is empty
    
  }
  for(int n=2;n<5;n++){
    i=4*n-1;
    if ([[self.tiles[i] text]intValue]) {
      //The tile has a value
      //Tile not at boundry
      if ([[self.tiles[i-4] text]intValue]) {
        //If the tile to left has a value
        //...
        if ([[self.tiles[i-4] text]intValue]==[[self.tiles[i] text]intValue] ) {
          //if the one on the left matches
        }
      }
      else{
        //move the tile to the left
        [self moveUpfrom:i withEdge:3];
        
      }//ends else
      
      
    }//else the tile is empty
    
  }
  
  ///////////////////
  //doubler//////////////
  //       //       ////////
  //       //       //////////////
  ///////////////////////////////////////
  
  for(int n=2;n<5;n++){
    i=4*n-4;
    if ([[self.tiles[i] text]intValue]) {
      //The tile has a value
      //Tile not at boundry
      if ([[self.tiles[i-4] text]intValue]) {
        //If the tile to left has a value
        //...
        if ([[self.tiles[i-4] text]intValue]==[[self.tiles[i] text]intValue] ) {
          //if the one on the left matches
          if ([[self.tiles[i-4] text] intValue] &&[ [self.tiles[i-4] text] isEqualToString: [self.tiles[i] text] ]){
            //if theres a match
            //earlier is nothing, next doubles
            [self.tiles[i] setText:@""];
            [self.tiles[i-4] setText:[NSString stringWithFormat:@"%d", [[self.tiles[i-4] text] intValue] *2 ]];
            
          }
        }
      }
   
      
      
    }//else the tile is empty
    
  }
  
  
  for(int n=2;n<5;n++){
    i=4*n-3;
    if ([[self.tiles[i] text]intValue]) {
      //The tile has a value
      //Tile not at boundry
      if ([[self.tiles[i-4] text]intValue]) {
        //If the tile to left has a value
        //...
        if ([[self.tiles[i-4] text]intValue]==[[self.tiles[i] text]intValue] ) {
          //if the one on the left matches
          if ([[self.tiles[i-4] text] intValue] &&[ [self.tiles[i-4] text] isEqualToString: [self.tiles[i] text] ]){
            //if theres a match
            //earlier is nothing, next doubles
            [self.tiles[i] setText:@""];
            [self.tiles[i-4] setText:[NSString stringWithFormat:@"%d", [[self.tiles[i-4] text] intValue] *2 ]];
            
          }
        }
      }
      
      
    }//else the tile is empty
    
  }
  for(int n=2;n<5;n++){
    i=4*n-2;
    if ([[self.tiles[i] text]intValue]) {
      //The tile has a value
      //Tile not at boundry
      if ([[self.tiles[i-4] text]intValue]) {
        //If the tile to left has a value
        //...
        if ([[self.tiles[i-4] text]intValue]==[[self.tiles[i] text]intValue] ) {
          //if the one on the left matches
          if ([[self.tiles[i-4] text] intValue] &&[ [self.tiles[i-4] text] isEqualToString: [self.tiles[i] text] ]){
            //if theres a match
            //earlier is nothing, next doubles
            [self.tiles[i] setText:@""];
            [self.tiles[i-4] setText:[NSString stringWithFormat:@"%d", [[self.tiles[i-4] text] intValue] *2 ]];
            
          }
        }
      }
      
      
    }//else the tile is empty
    
  }
  for(int n=2;n<5;n++){
    i=4*n-1;
    if ([[self.tiles[i] text]intValue]) {
      //The tile has a value
      //Tile not at boundry
      if ([[self.tiles[i-4] text]intValue]) {
        //If the tile to left has a value
        //...
        if ([[self.tiles[i-4] text]intValue]==[[self.tiles[i] text]intValue] ) {
          //if the one on the left matches
          if ([[self.tiles[i-4] text] intValue] &&[ [self.tiles[i-4] text] isEqualToString: [self.tiles[i] text] ]){
            //if theres a match
            //earlier is nothing, next doubles
            [self.tiles[i] setText:@""];
            [self.tiles[i-4] setText:[NSString stringWithFormat:@"%d", [[self.tiles[i-4] text] intValue] *2 ]];
            
          }
        }
      }
      
      
    }//else the tile is empty
    
  }
  [self addRandomTile];
}
- (void)handleSwipeDownFrom:(UIGestureRecognizer*)recognizer {
  NSLog(@"Swiped Down :)");
  int i;
  for(int n=2;n<5;n++){
    i=16-4*n;
    NSLog(@"n is %d",n);
    if ([[self.tiles[i] text]intValue]) {
      //The tile has a value
      //Tile not at boundry
      if ([[self.tiles[i+4] text]intValue]) {
        //If the tile to left has a value
        //...
        if ([[self.tiles[i+4] text]intValue]==[[self.tiles[i] text]intValue] ) {
          //if the one on the left matches
        }
      }
      else{
        //move the tile to the left
        [self moveDownfrom:i withEdge:12];
        
      }//ends else
      
      
    }//else the tile is empty
    
  }
  
  
  for(int n=2;n<5;n++){
    NSLog(@"n is %d",n);
    i=17-4*n;
    if ([[self.tiles[i] text]intValue]) {
      //The tile has a value
      //Tile not at boundry
      if ([[self.tiles[i+4] text]intValue]) {
        //If the tile to left has a value
        //...
        if ([[self.tiles[i+4] text]intValue]==[[self.tiles[i] text]intValue] ) {
          //if the one on the left matches
        }
      }
      else{
        //move the tile to the left
        [self moveDownfrom:i withEdge:13];
        
      }//ends else
      
      
    }//else the tile is empty
    
  }
  for(int n=2;n<5;n++){
    NSLog(@"n is %d",n);
    i=18-4*n;
    if ([[self.tiles[i] text]intValue]) {
      //The tile has a value
      //Tile not at boundry
      if ([[self.tiles[i+4] text]intValue]) {
        //If the tile to left has a value
        //...
        if ([[self.tiles[i+4] text]intValue]==[[self.tiles[i] text]intValue] ) {
          //if the one on the left matches
        }
      }
      else{
        //move the tile to the left
        [self moveDownfrom:i withEdge:14];
        
      }//ends else
      
      
    }//else the tile is empty
    
  }
  for(int n=2;n<5;n++){
    NSLog(@"n is %d",n);
    i=19-4*n;
    if ([[self.tiles[i] text]intValue]) {
      //The tile has a value
      //Tile not at boundry
      if ([[self.tiles[i+4] text]intValue]) {
        //If the tile to left has a value
        //...
        if ([[self.tiles[i+4] text]intValue]==[[self.tiles[i] text]intValue] ) {
          //if the one on the left matches
        }
      }
      else{
        //move the tile to the left
        [self moveDownfrom:i withEdge:15];
      }//ends else
      
      
    }//else the tile is empty
    
  }
  ///////////////////
  //doubler//////////////
  //       //       ////////
  //       //       //////////////
  ///////////////////////////////////////
  for(int n=2;n<5;n++){
    i=16-4*n;
    NSLog(@"n is %d",n);
    if ([[self.tiles[i] text]intValue]) {
      //The tile has a value
      //Tile not at boundry
      if ([[self.tiles[i+4] text]intValue]) {
        //If the tile to left has a value
        //...
        if ([[self.tiles[i+4] text]intValue]==[[self.tiles[i] text]intValue] ) {
          //if the one on the left matches
          if ([[self.tiles[i+4] text] intValue] &&[ [self.tiles[i+4] text] isEqualToString: [self.tiles[i] text] ]){
            //if theres a match
            //earlier is nothing, next doubles
            [self.tiles[i] setText:@""];
            [self.tiles[i+4] setText:[NSString stringWithFormat:@"%d", [[self.tiles[i+4] text] intValue] *2 ]];
            
          }
        }
      }
      
      
    }//else the tile is empty
    
  }
  
  
  for(int n=2;n<5;n++){
    NSLog(@"n is %d",n);
    i=17-4*n;
    if ([[self.tiles[i] text]intValue]) {
      //The tile has a value
      //Tile not at boundry
      if ([[self.tiles[i+4] text]intValue]) {
        //If the tile to left has a value
        //...
        if ([[self.tiles[i+4] text]intValue]==[[self.tiles[i] text]intValue] ) {
          //if the one on the left matches
          if ([[self.tiles[i+4] text] intValue] &&[ [self.tiles[i+4] text] isEqualToString: [self.tiles[i] text] ]){
            //if theres a match
            //earlier is nothing, next doubles
            [self.tiles[i] setText:@""];
            [self.tiles[i+4] setText:[NSString stringWithFormat:@"%d", [[self.tiles[i+4] text] intValue] *2 ]];
            
          }
        }
      }
      
      
      
    }//else the tile is empty
    
  }
  for(int n=2;n<5;n++){
    NSLog(@"n is %d",n);
    i=18-4*n;
    if ([[self.tiles[i] text]intValue]) {
      //The tile has a value
      //Tile not at boundry
      if ([[self.tiles[i+4] text]intValue]) {
        //If the tile to left has a value
        //...
        if ([[self.tiles[i+4] text]intValue]==[[self.tiles[i] text]intValue] ) {
          //if the one on the left matches
          if ([[self.tiles[i+4] text] intValue] &&[ [self.tiles[i+4] text] isEqualToString: [self.tiles[i] text] ]){
            //if theres a match
            //earlier is nothing, next doubles
            [self.tiles[i] setText:@""];
            [self.tiles[i+4] setText:[NSString stringWithFormat:@"%d", [[self.tiles[i+4] text] intValue] *2 ]];
            
          }
        }
      }
      
      
    }//else the tile is empty
    
  }
  for(int n=2;n<5;n++){
    NSLog(@"n is %d",n);
    i=19-4*n;
    if ([[self.tiles[i] text]intValue]) {
      //The tile has a value
      //Tile not at boundry
      if ([[self.tiles[i+4] text]intValue]) {
        //If the tile to left has a value
        //...
        if ([[self.tiles[i+4] text]intValue]==[[self.tiles[i] text]intValue] ) {
          //if the one on the left matches
          if ([[self.tiles[i+4] text] intValue] &&[ [self.tiles[i+4] text] isEqualToString: [self.tiles[i] text] ]){
            //if theres a match
            //earlier is nothing, next doubles
            [self.tiles[i] setText:@""];
            [self.tiles[i+4] setText:[NSString stringWithFormat:@"%d", [[self.tiles[i+4] text] intValue] *2 ]];
            
          }
        }
      }
      
      
      
    }//else the tile is empty
    
  }
  [self addRandomTile];
}
- (void)handleSwipeLeftFrom:(UIGestureRecognizer*)recognizer {
  NSLog(@"Swiped Left :)");
  for (int m=0;m<4;m++){
  for (int i=1+4*m;i<4+4*m;i++){
    if ([[self.tiles[i] text]intValue]) {
      //The tile has a value
        //Tile not at boundry
        if ([[self.tiles[i-1] text]intValue]) {
          //If the tile to left has a value
          //...
          if ([[self.tiles[i-1] text]intValue]==[[self.tiles[i] text]intValue] ) {
            //if the one on the left matches
          }
        }
        else{
          //move the tile to the left
          [self moveLeftfrom:i withEdge:4*m];
          
        }//ends else
      
     
        
      
    }//else the tile is empty
  }
  }
  
  //Doubler
  for (int m=0;m<4;m++){
    for (int i=1+4*m;i<4+4*m;i++){
      if ([[self.tiles[i] text]intValue]) {
        //The tile has a value
        //Tile not at boundry
        if ([[self.tiles[i-1] text]intValue]) {
          //If the tile to left has a value
          //...
          if ([[self.tiles[i-1] text]intValue]==[[self.tiles[i] text]intValue] ) {
            //if the one on the left matches
            if ([[self.tiles[i-1] text] intValue] &&[ [self.tiles[i-1] text] isEqualToString: [self.tiles[i] text] ]){
              //if theres a match
              //earlier is nothing, next doubles
              [self.tiles[i] setText:@""];
              [self.tiles[i-1] setText:[NSString stringWithFormat:@"%d", [[self.tiles[i-1] text] intValue] *2 ]];
              
            }
          }
        }
      }//else the tile is empty
    }
  }
  
  [self addRandomTile];
}

-(void)moveLeftfrom: (int) position withEdge: (int) edge{
  //this function moves the tile to the leftmost position through free space
  int j=0;
  int i=position;
  while((i-j-1>edge-1)&&([[self.tiles[i-j-1] text] intValue ]==0)){
    [self.tiles[i-j-1] setText:[self.tiles[i-j] text]];
    [self.tiles[i-j] setText:@""];
    j++;
    
  }//ends while
  //current position has moved as much as possible
  
  
}
-(void)moveUpfrom: (int) position withEdge: (int) edge{
  //this function moves the tile to the leftmost position through free space
  int j=0;
  int i=position;
  while((i-4*j-4>edge-4)&&([[self.tiles[i-4*j-4] text] intValue ]==0)){
    [self.tiles[i-4*j-4] setText:[self.tiles[i-4*j] text]];
    [self.tiles[i-4*j] setText:@""];
    j++;
  }//ends while
}-(void)moveRightfrom: (int) position withEdge: (int) edge{
  //this function moves the tile to the rightmost position through free space
  int j=0;
  int i=position;
  while((i+j+1<=edge)&&([[self.tiles[i+j+1] text] intValue ]==0)){
    [self.tiles[i+j+1] setText:[self.tiles[i+j] text]];
    [self.tiles[i+j] setText:@""];
    j++;
  }//ends while
}

-(void)moveDownfrom: (int) position withEdge: (int) edge{
  //this function moves the tile to the rightmost position through free space
  int j=0;
  int i=position;
  while((i+4*j+4<=edge)&&([[self.tiles[i+4*j+4] text] intValue ]==0)){
    [self.tiles[i+4*j+4] setText:[self.tiles[i+4*j] text]];
    [self.tiles[i+4*j] setText:@""];
    j++;
  }//ends while
}
- (void)handleSwipeRightFrom:(UIGestureRecognizer*)recognizer {
  NSLog(@"Swiped Right :)");
  for (int m=0;m<4;m++){
    for (int i=3+4*m;i>=0+4*m;i--){
      NSLog(@"I is %d",i);
      if ((i<15) && [[self.tiles[i] text]intValue]) {
        //The tile has a value
        //Tile not at boundry
        if ([[self.tiles[i+1] text]intValue]) {
          //If the tile to right has a value
          //...
          if ([[self.tiles[i+1] text]intValue]==[[self.tiles[i] text]intValue] ) {
            //if the one on the right matches
          }
        }
        else{
          //move the tile to the left
          [self moveRightfrom:i withEdge:4*m+3];
          
        }//ends else
        
        
      }//else the tile is empty
      
    }
  }
  //doubler
  
  for (int m=0;m<4;m++){
    for (int i=3+4*m;i>=0+4*m;i--){
      NSLog(@"I is %d",i);
      if ((i<15)&&[[self.tiles[i] text]intValue]) {
        //The tile has a value
        //Tile not at boundry
        if ([[self.tiles[i+1] text]intValue]) {
          //If the tile to right has a value
          //...
          if ([[self.tiles[i+1] text]intValue]==[[self.tiles[i] text]intValue] ) {
            //if the one on the right matches
            if ([[self.tiles[i+1] text] intValue] &&[ [self.tiles[i+1] text] isEqualToString: [self.tiles[i] text] ]){
              //if theres a match
              //earlier is nothing, next doubles
              [self.tiles[i] setText:@""];
              [self.tiles[i+1] setText:[NSString stringWithFormat:@"%d", [[self.tiles[i+1] text] intValue] *2 ]];
              
            }
          }
        }
        else{
          //move the tile to the left
         // [self moveRightfrom:i withEdge:4*m+3];
          
        }//ends else
        
        
      }//else the tile is empty
      
    }
  }
  [self addRandomTile];
}
-(int)flipIndex: (int) index{
  int a[]={12,8,4,0,13,9,5,1,14,10,6,2,15,11,7,3};
  if (index>15)return 0;
  return a[index];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
