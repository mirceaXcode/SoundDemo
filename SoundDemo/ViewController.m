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
@property (assign, nonatomic) SystemSoundID beepC;
@property (assign, nonatomic) SystemSoundID beepD;

@property (nonatomic,strong) AVAudioPlayer *player;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
// Starting iOS 10 we have to use the AudioServicesPlaySystemSoundWithCompletion function, which includes the autodistruction of the sound right after usage. Because of that, we don't need to use a dealloc funtion anymore, but we have to construc the sound every time we push the button, because it gets destroyed after each usage!!!
    
    // Load the media file
    NSURL *urlSong = [[NSBundle mainBundle] URLForResource:@"Parazitii.mp3" withExtension:nil];
    
    NSError *err;
    
    // Setup AVAudioPlayer
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:urlSong error:&err];
    
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
    NSURL *urlA = [[NSBundle mainBundle] URLForResource:@"marimba.aiff" withExtension:nil];
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

    // Load the sound / create the sound ID
    NSURL *urlB = [[NSBundle mainBundle] URLForResource:@"sncf.aiff" withExtension:nil];
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

- (IBAction)playSoundC:(id)sender {
    
    // Load the sound / create the sound ID
    NSURL *urlC = [[NSBundle mainBundle] URLForResource:@"bike horn.aiff" withExtension:nil];
    OSStatus statusReport = AudioServicesCreateSystemSoundID((__bridge CFURLRef)urlC, &_beepC);
    
    // Play the sound C
    if(statusReport == kAudioServicesNoError) {
        AudioServicesPlaySystemSoundWithCompletion(_beepC, ^{
            AudioServicesDisposeSystemSoundID(self.beepC);
        });
        
    } else {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Couldn't load beepC" message:@"BeepC problem" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

- (IBAction)playSoundD:(id)sender {
    
    // Load the sound / create the sound ID
    NSURL *urlD = [[NSBundle mainBundle] URLForResource:@"toy horn.aiff" withExtension:nil];
    OSStatus statusReport = AudioServicesCreateSystemSoundID((__bridge CFURLRef)urlD, &_beepD);
    
    // Play the sound D
    if(statusReport == kAudioServicesNoError) {
        AudioServicesPlaySystemSoundWithCompletion(_beepD, ^{
            AudioServicesDisposeSystemSoundID(self.beepD);
        });
        
    } else {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Couldn't load beepD" message:@"BeepD problem" preferredStyle:UIAlertControllerStyleAlert];
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
