//
//  FlashCardsViewController.m
//  FlashCards
//
//  Created by Arkadijs Makarenko on 17/03/2017.
//  Copyright © 2017 ArchieApps. All rights reserved.

#import "FlashCardsViewController.h"

@interface FlashCardsViewController () <UIAlertViewDelegate>

@property(nonatomic, strong) NSMutableArray *questionsList;
@property(nonatomic, strong) NSMutableArray *answersList;
@property(nonatomic, assign) NSUInteger randomNumber;
@property(nonatomic, assign) NSInteger guessNumber;
@property (weak, nonatomic) IBOutlet UITextView *questionsTextView;
@property (weak, nonatomic) IBOutlet UITextView *answerTextView;
@property (nonatomic,assign) BOOL iscorrect;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainingLabel;


@end
int guessNumber = 0;
const int tag =5;
@implementation FlashCardsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetGame];
    
}
-(void)resetGame{
    self.questionsList = [[NSMutableArray alloc] initWithObjects:@"How many days are their in MAY?", @"Whos is the best fighter in UFC tournament?", nil];
    self.answersList = [[NSMutableArray alloc] initWithObjects:@"31", @"conor mcgregor", nil];
    //NSLog(@"%lu",(unsigned long)self.randomNumber);
    self.totalLabel.text = [NSString stringWithFormat:@"Total Questions: %lu",(unsigned long)[self.questionsList count]];
    self.remainingLabel.text = [NSString stringWithFormat:@"Remaining: %lu",(unsigned long)([self.questionsList count])];
    [self random];
}

- (IBAction)submitAnswer:(id)sender {
    NSString *answer =  [self.answerTextView.text lowercaseString];
    if([answer isEqualToString:self.answersList[self.randomNumber]]){
        self.remainingLabel.text = [NSString stringWithFormat:@"Remaining: %lu",(unsigned long)([self.questionsList count]-1)];
        [self.questionsList removeObjectAtIndex:self.randomNumber];
        [self.answersList removeObjectAtIndex:self.randomNumber];
        self.answerTextView.text = @"";
        self.guessNumber++;
        [self random];
    }else {
        self.guessNumber++;
        return;
    }
}
-(void) random{
    if([self.questionsList count] == 0){
    
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"GAME OVER!" message:[NSString stringWithFormat:@"Number of Guesses: %li", self.guessNumber] preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"Restart" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            [self performSegueWithIdentifier:@"VC" sender:nil];
        }];
    [alert addAction:dismissAction];
        [self presentViewController:alert animated:YES completion:NULL];
        [self resetGame];
    }else{
    
    self.randomNumber = arc4random_uniform([self.questionsList count]);
    self.questionsTextView.text = self.questionsList[self.randomNumber];
}
}

@end
