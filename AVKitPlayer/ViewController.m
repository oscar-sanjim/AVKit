//
//  ViewController.m
//  AVKitPlayer
//
//  Created by Alumno ITESM Campus Toluca on 20/10/15.
//  Copyright © 2015 Alumno ITESM Campus Toluca. All rights reserved.
//

#import "ViewController.h"
@import AVKit;
@import AVFoundation;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSURL *movie = [[NSBundle mainBundle]  URLForResource:@"movie" withExtension:@"mov"];
    NSURL *movie2 = [NSURL URLWithString:@"http://www.sample-videos.com/video/mp4/720/big_buck_bunny_720p_1mb.mp4"];
    AVPlayerItem *a = [AVPlayerItem playerItemWithURL:movie];
    AVPlayerItem *b = [AVPlayerItem playerItemWithURL:movie2];
    NSArray<AVPlayerItem *> *arr = [NSArray arrayWithObjects:a,b, nil];
    AVPlayerViewController *playerViewWithController = segue.destinationViewController;
    playerViewWithController.player = [AVQueuePlayer queuePlayerWithItems:arr];
}

@end
