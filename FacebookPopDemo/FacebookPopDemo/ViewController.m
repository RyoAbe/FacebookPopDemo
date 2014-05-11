//
//  ViewController.m
//  TestFacebookPop
//
//  Created by RyoAbe on 2014/05/11.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "pop/pop.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *targetView;
@property (weak, nonatomic) IBOutlet UISlider *springBouncinessSlider;
@property (weak, nonatomic) IBOutlet UISlider *springSpeedSlider;
@property (weak, nonatomic) IBOutlet UISwitch *repeatSwitch;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)popDecayAnimation
{
    POPDecayAnimation *animation = [POPDecayAnimation animation];
    animation.property = [POPAnimatableProperty propertyWithName:kPOPLayerSize];
    animation.velocity = [NSValue valueWithCGSize:CGSizeMake(self.targetView.frame.size.height / 2, self.targetView.frame.size.width / 2)];
    animation.velocity = [NSValue valueWithCGSize:self.targetView.frame.size];
    
    CGSize defaultSize = self.targetView.frame.size;
    [animation setCompletionBlock:^(POPAnimation *a, BOOL finished) {
        POPDecayAnimation *animation = [POPDecayAnimation animation];
        animation.property = [POPAnimatableProperty propertyWithName:kPOPLayerSize];
        animation.velocity = [NSValue valueWithCGSize:defaultSize];
        [self.targetView pop_addAnimation:animation forKey:@"decay"];
    }];
    
    [self.targetView pop_addAnimation:animation forKey:@"decay"];
}

- (void)popSpringAnimation
{
    POPSpringAnimation *animation = [POPSpringAnimation animation];
    animation.property = [POPAnimatableProperty propertyWithName:kPOPLayerSize];
    animation.toValue = [NSValue valueWithCGSize:CGSizeMake(self.targetView.frame.size.height / 2, self.targetView.frame.size.width / 2)];
    animation.springBounciness = 20 * self.springBouncinessSlider.value;
    animation.springSpeed = 20 * self.springSpeedSlider.value;
    
    CGSize defaultSize = self.targetView.frame.size;
    [animation setCompletionBlock:^(POPAnimation *a, BOOL finished) {
        POPSpringAnimation *animation = [POPSpringAnimation animation];
        animation.property = [POPAnimatableProperty propertyWithName:kPOPLayerSize];
        animation.toValue = [NSValue valueWithCGSize:defaultSize];
        [self.targetView pop_addAnimation:animation forKey:@"bound"];
    }];
    
    [self.targetView pop_addAnimation:animation forKey:@"bound"];
}

- (IBAction)startButtonTapped:(id)sender
{
    [self popSpringAnimation];
//    [self popDecayAnimation];
}
- (IBAction)stopButtonTapped:(id)sender {
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
