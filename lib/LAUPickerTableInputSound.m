/*
 
 LAUPickerTableInputSound.m
 LAUPickerView
 
 Copyright (cc) 2012 Luis Laugga.
 Some rights reserved, all wrongs deserved.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 the Software, and to permit persons to whom the Software is furnished to do so,
 subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 */

#import "LAUPickerTableInputSound.h"

@implementation LAUPickerTableInputSound

static LAUPickerTableInputSound * _defaultInputSound;

- (id)init
{
    self = [super init];
    if(self)
    {
        NSError * error;

        NSString * tickSoundPath = [[NSBundle mainBundle] pathForResource:@"tick" ofType:@"caf"];
        NSURL * tickSoundURL = [NSURL fileURLWithPath:tickSoundPath]; // TODO add sound to LAUPickerView.bundle
        
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:tickSoundURL error:&error];
        
        if (error)
        {
            // Handle error
        }
        
        [_audioPlayer prepareToPlay];
        
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:&error];
        [[AVAudioSession sharedInstance] setActive:YES error:&error];
        
        if (error)
        {
            // Handle error
        }
    }
    return self;
}

+ (LAUPickerTableInputSound *)sharedPickerTableInputSound
{
    if(_defaultInputSound == nil)
    {
        _defaultInputSound = [[LAUPickerTableInputSound alloc] init]; // singleton object
    }
    
    return _defaultInputSound;
}

- (float)compensatedVolume
{
    // The volume should remain ~ constant (and quiet) regardless of the device's volume setting
    // Lookup table used to compensate volume for different AVAudioSession's outputVolume values
    // The volume values where precalculated from a [0,1] range and 0.05 interval
    static const float precalculatedVolumeValues[21] = { 8.0f, 7.5f, 7.0f, 6.25f, 6.0f, 5.0f, 4.0f, 3.25f, 2.0f, 1.25f, 0.8f, 0.35f, 0.20f, 0.14f, 0.130f, 0.135f, 0.10f, 0.08f, 0.045f, 0.025f, 0.020f};
    
    // Calculate the lookup index from the AVAudioSession's outputVolume
    float outputVolume = [AVAudioSession sharedInstance].outputVolume;
    NSUInteger lookupIndex = MAX(0, MIN(roundf(outputVolume*20.0f), 20));
    
    //NSLog(@"%f > %f [%d]", outputVolume, precalculatedVolumeValues[lookupIndex], lookupIndex);
    
    return precalculatedVolumeValues[lookupIndex];
}

- (void)play
{
    [_audioPlayer setVolume:[self compensatedVolume]];
    [_audioPlayer play];
}

@end
