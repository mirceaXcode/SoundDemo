//
//  ViewController.m
//  SoundDemo
//
//  Created by Mircea Popescu on 10/5/18.
//  Copyright © 2018 Mircea Popescu. All rights reserved.
//

#import "ViewController.h"
@import AudioToolbox;
@import AVFoundation;

@interface ViewController ()

@property (assign, nonatomic) SystemSoundID beepA;
@property (assign, nonatomic) SystemSoundID beepB;

@property (nonatomic,strong) AVAudioPlayer *player;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
// Starting iOS 10 we have to use the AudioServicesPlaySystemSoundWithCompletion function, which includes the autodistruction of the sound right after usage. Because of that, we don't need to use a dealloc funtion anymore, but we have to construc the sound every time we push the button, because it gets destroyed after each usage!!!
    
    // Load the media file
    NSURL *urlC = [[NSBundle mainBundle] URLForResource:@"Parazitii.mp3" withExtension:nil];
    
    NSError *err;
    
    // Setup AVAudioPlayer
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:urlC error:&err];
    
    if(!self.player){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Could't load mp3" message:[err localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

- (IBAction)playSoundA:(id)sender {
  
    // Archaic C code
    // __bridge = C-level cast
    // Tels ARC to stop taking notice of the casted object
    // Casting -> Don't generate ARC meta data
    
    // Load the sound / create the sound ID
    NSURL *urlA = [[NSBundle mainBundle] URLForResource:@"marimba.aif" withExtension:nil];
    OSStatus statusReport = AudioServicesCreateSystemSoundID((__bridge CFURLRef)urlA, &_beepA);
    
    // Play the sound A
    if(statusReport == kAudioServicesNoError) {
        AudioServicesPlaySystemSoundWithCompletion(_beepA, ^{
            AudioServicesDisposeSystemSoundID(self.beepA);
        });
        
    } else {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Couldn't load beepA" message:@"BeepA problem" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
    }
      
}

- (IBAction)playSoundB:(id)sender {
    
    // Archaic C code
    // __bridge = C-level cast
    // Tels ARC to stop taking notice of the casted object
    // Casting -> Don't generate ARC meta data
    
    // Load the sound / create the sound ID
    NSURL *urlB = [[NSBundle mainBundle] URLForResource:@"sncf.aif" withExtension:nil];
    OSStatus statusReport = AudioServicesCreateSystemSoundID((__bridge CFURLRef)urlB, &_beepB);
    
    // Play the sound B
    if(statusReport == kAudioServicesNoError) {
        AudioServicesPlaySystemSoundWithCompletion(_beepB, ^{
            AudioServicesDisposeSystemSoundID(self.beepB);
        });
        
    } else {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Couldn't load beepB" message:@"BeepB problem" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
    }
}


- (IBAction)playMedia:(id)sender {
    [self.player play];
}


- (IBAction)stopMedia:(id)sender {
    [self.player stop];
}


@end
