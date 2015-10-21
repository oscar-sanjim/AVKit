//
//  MyVideoViewController.m
//  AVKitPlayer
//
//  Created by Alumno ITESM Campus Toluca on 20/10/15.
//  Copyright © 2015 Alumno ITESM Campus Toluca. All rights reserved.
//

#import "MyVideoViewController.h"
@import AVKit;
@import AVFoundation;

@interface MyVideoViewController ()

@end



@implementation MyVideoViewController

@synthesize player;


- (void)viewDidLoad {
    [super viewDidLoad];
    //NSURL *movie = [NSURL URLWithString:@"pelicula"];
    player = [AVPlayer playerWithURL: [[NSBundle mainBundle]
                                       URLForResource: @"pelicula"
                                       withExtension: @"mov"]];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
