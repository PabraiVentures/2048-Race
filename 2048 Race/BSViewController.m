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
  
  UIAlertView *alert = [[UIAlertView alloc]
                        
                        initWithTitle:@"How To Play"
                        message:@"Insert\n\n\n\nGameplay Instructions"//Need to finalize gameplay instructions here!
                        delegate:nil
                        cancelButtonTitle:@"Start!"
                        otherButtonTitles:nil];
  [alert show];
  
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
  
  while ([[(id)self.tiles[tmp] text]intValue])
  {
    tmp=arc4random()%16;
  }
  
  [(id)self.tiles[tmp] setText:@"2"];
}

- (void)handleSwipeDownFrom:(UIGestureRecognizer*)recognizer {
  NSLog(@"Swiped Up :)");
  int i;
  for(int n=1;n<5;n++){
    i=4*n-3;
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
- (void)handleSwipeUpFrom:(UIGestureRecognizer*)recognizer {
  NSLog(@"Swiped Down :)");
  for (int m=0;m<4;m++){
    for (int i=3+4*m;i>=0+4*m;i--){
      if ([[self.tiles[[self flipIndex:i]] text]intValue]) {
        //The tile has a value
        //Tile not at boundry
        if ([[self.tiles[[self flipIndex:i]+1] text]intValue]) {
          //If the tile to right has a value
          //...
          if ([[self.tiles[[self flipIndex:i]+1] text]intValue]==[[self.tiles[[self flipIndex:i]] text]intValue] ) {
            //if the one on the right matches
          }
        }
        else{
          //move the tile to the left
          [self moveUpfrom:i withEdge:4*m+3];
          
        }//ends else
        
        
      }//else the tile is empty
      
    }
  }
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
}
-(void)moveDownfrom: (int) position withEdge: (int) edge{
  //this function moves the tile to the leftmost position through free space
  int j=0;
  int i=position;
  while(([self flipIndex:i]-j-1>[self flipIndex:edge]-1)&&([[self.tiles[[self flipIndex:i]-j-1] text] intValue ]==0)){
    [self.tiles[[self flipIndex:i]-j-1] setText:[self.tiles[[self flipIndex:i]-j] text]];
    [self.tiles[[self flipIndex:i]-j] setText:@""];
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

-(void)moveUpfrom: (int) position withEdge: (int) edge{
  //this function moves the tile to the rightmost position through free space
  int j=0;
  int i=position;
  while(([self flipIndex:i]+j+1<=[self flipIndex:edge])&&([[self.tiles[[self flipIndex:i]+j+1] text] intValue ]==0)){
    [self.tiles[[self flipIndex:i]+j+1] setText:[self.tiles[[self flipIndex:i]+j] text]];
    [self.tiles[[self flipIndex:i]+j] setText:@""];
    j++;
  }//ends while
}
- (void)handleSwipeRightFrom:(UIGestureRecognizer*)recognizer {
  NSLog(@"Swiped Right :)");
  for (int m=0;m<4;m++){
    for (int i=3+4*m;i>=0+4*m;i--){
      if ([[self.tiles[i] text]intValue]) {
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
  
}
-(int)flipIndex: (int) index{
  int tmp=0;
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
