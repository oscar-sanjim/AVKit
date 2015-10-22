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
@synthesize send;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    AVPlayerViewController *playerViewWithController = segue.destinationViewController;
    send = (UIButton *) sender;
    if ([send tag] == 1) {
        NSURL *movie = [[NSBundle mainBundle]  URLForResource:@"movie" withExtension:@"mov"];
        playerViewWithController.player = [AVPlayer playerWithURL:movie];
    }
    else if ([send tag] == 2){
        NSURL *movie = [[NSBundle mainBundle]  URLForResource:@"movie" withExtension:@"mov"];
        NSURL *movie2 = [NSURL URLWithString:@"http://www.sample-videos.com/video/mp4/720/big_buck_bunny_720p_1mb.mp4"];
        AVPlayerItem *a = [AVPlayerItem playerItemWithURL:movie];
        AVPlayerItem *b = [AVPlayerItem playerItemWithURL:movie2];
        NSArray<AVPlayerItem *> *arr = [NSArray arrayWithObjects:a,b, nil];
        playerViewWithController.player = [AVQueuePlayer queuePlayerWithItems:arr];
    }
    
    else if ([send tag] == 3){
        NSURL *movie = [[NSBundle mainBundle]  URLForResource:@"movie" withExtension:@"mov"];
        NSURL *movie2 = [[NSBundle mainBundle]  URLForResource:@"small" withExtension:@"mp4"];
        
        AVMutableComposition *mutableComposition = [AVMutableComposition composition];
        // Create the video composition track.
        AVMutableCompositionTrack *mutableCompositionVideoTrack = [mutableComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
        // Create the audio composition track.
        AVMutableCompositionTrack *mutableCompositionAudioTrack = [mutableComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
        
        // You can retrieve AVAssets from a number of places, like the camera roll for example.
        AVAsset *videoAsset = [AVAsset assetWithURL:movie];
        AVAsset *videoAsset2 = [AVAsset assetWithURL:movie2];
        
        // Get the first video track from each asset.
        AVAssetTrack *videoAssetTrack = [[videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
        AVAssetTrack *videoAssetTrack2 = [[videoAsset2 tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
        
        AVAssetTrack *audioAssetTrack = [[videoAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0];
        AVAssetTrack *audioAssetTrack2 = [[videoAsset2 tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0];
        
        
        // Add them both to the composition.
        [mutableCompositionVideoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero,(videoAssetTrack.timeRange.duration)) ofTrack:videoAssetTrack atTime:kCMTimeZero error:nil];
        [mutableCompositionVideoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero,videoAssetTrack2.timeRange.duration) ofTrack:videoAssetTrack2 atTime:videoAssetTrack.timeRange.duration error:nil];
        
        [mutableCompositionAudioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero,(audioAssetTrack2.timeRange.duration)) ofTrack:audioAssetTrack2 atTime:kCMTimeZero error:nil];
        [mutableCompositionAudioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero,audioAssetTrack.timeRange.duration) ofTrack:audioAssetTrack atTime:audioAssetTrack2.timeRange.duration error:nil];
        
        AVPlayerItem *b = [AVPlayerItem playerItemWithAsset:mutableComposition];
        playerViewWithController.player = [AVPlayer playerWithPlayerItem:b];
    }
    
    else if ([send tag] == 4){
        
        // Esta parte trata de cambiar el color, pero no jala
        
        NSURL *movie = [[NSBundle mainBundle]  URLForResource:@"movie" withExtension:@"mov"];
        
        AVMutableComposition *mutableComposition = [AVMutableComposition composition];
        // Create the video composition track.
        AVMutableCompositionTrack *mutableCompositionVideoTrack = [mutableComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
        // Create the audio composition track.
        AVMutableCompositionTrack *mutableCompositionAudioTrack = [mutableComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
        // You can retrieve AVAssets from a number of places, like the camera roll for example.
        AVAsset *asset = [AVAsset assetWithURL:movie];
        // Get the first video track from each asset.
        AVAssetTrack *videoAssetTrack = [[asset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
        AVAssetTrack *audioAssetTrack = [[asset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0];
        // Add them both to the composition.
        [mutableCompositionVideoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero,videoAssetTrack.timeRange.duration) ofTrack:videoAssetTrack atTime:kCMTimeZero error:nil];
        [mutableCompositionAudioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero,(audioAssetTrack.timeRange.duration)) ofTrack:audioAssetTrack atTime:kCMTimeZero error:nil];
        
        AVMutableVideoCompositionInstruction *mutableVideoCompositionInstruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
        mutableVideoCompositionInstruction.timeRange = CMTimeRangeMake(kCMTimeZero, mutableComposition.duration);
        mutableVideoCompositionInstruction.backgroundColor = [[UIColor redColor] CGColor];
        
        AVMutableVideoCompositionLayerInstruction *firstVideoLayerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:mutableCompositionVideoTrack];
        
        mutableVideoCompositionInstruction.layerInstructions = @[firstVideoLayerInstruction];
        
        AVMutableVideoComposition *a = [AVMutableVideoComposition videoComposition];
        
        a.instructions = @[mutableVideoCompositionInstruction];
        
        CALayer *watermarkLayer = [CALayer layer];
        watermarkLayer.opacity = 0.5;
        //watermarkLayer.backgroundColor = [[UIColor redColor] CGColor];
        watermarkLayer.backgroundColor = [UIColor blueColor].CGColor;
        watermarkLayer.shadowOffset = CGSizeMake(0, 3);
        watermarkLayer.shadowRadius = 5.0;
        watermarkLayer.shadowColor = [UIColor blackColor].CGColor;
        watermarkLayer.shadowOpacity = 0.8;
        watermarkLayer.frame = CGRectMake(30, 30, 128, 192);
        watermarkLayer.borderColor = [UIColor blackColor].CGColor;
        watermarkLayer.borderWidth = 2.0;
        watermarkLayer.cornerRadius = 10.0;

        CALayer *parentLayer = [CALayer layer];
        CALayer *videoLayer = [CALayer layer];
        parentLayer.frame = CGRectMake(0, 0, a.renderSize.width, a.renderSize.height);
        videoLayer.frame = CGRectMake(0, 0, a.renderSize.width, a.renderSize.height);
        [parentLayer addSublayer:videoLayer];
        watermarkLayer.position = CGPointMake(a.renderSize.width/2, a.renderSize.height/4);
        [parentLayer addSublayer:watermarkLayer];
        a.animationTool = [AVVideoCompositionCoreAnimationTool videoCompositionCoreAnimationToolWithPostProcessingAsVideoLayer:videoLayer inLayer:parentLayer];
        
        //mutableCompositionVideoTrack
        
        
        AVPlayerItem *b = [AVPlayerItem playerItemWithAsset:mutableComposition];
        playerViewWithController.player = [AVPlayer playerWithPlayerItem:b];
    }
}

@end
