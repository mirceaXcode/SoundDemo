//
//  ViewController.m
//  SoundDemo
//
//  Created by Mircea Popescu on 10/5/18.
//  Copyright © 2018 Mircea Popescu. All rights reserved.
//

#import "ViewController.h"
@import AudioToolbox;

@interface ViewController ()

@property (assign, nonatomic) SystemSoundID beepA;
@property (assign, nonatomic) SystemSoundID beepB;

@property (assign, nonatomic) BOOL beepAGood;
@property (assign, nonatomic) BOOL beepBGood;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Load the sound / create the sound ID
//    NSString *marimbaSound = [[NSBundle mainBundle] pathForResource:@"marimba" ofType:@"aif"];
//    NSURL *urlA = [NSURL fileURLWithPath:marimbaSound];
   // NSURL *urlA = [[NSBundle mainBundle] URLForResource:@"marimba.aif" withExtension:nil];
    
//    NSString *sncfSound = [[NSBundle mainBundle] pathForResource:@"sncf" ofType:@"aif"];
//    NSURL *urlB = [NSURL fileURLWithPath:sncfSound];
//    NSURL *urlB = [[NSBundle mainBundle] URLForResource:@"sncf.aif" withExtension:nil];
   
// Starting iOS 10 we have to use the AudioServicesPlaySystemSoundWithCompletion function, which includes the autodistruction of the sound right after usage. Because of that, we don't need to use a dealloc funtion anymore, but we have to construc the sound every time we push the button, because it gets destroyed after each usage!!!
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

@end
