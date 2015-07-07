//
//  ScoreViewController.m
//  Score Keeper
//
//  Created by Hyrum Mertlich on 7/7/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "ScoreViewController.h"

static CGFloat margin = 20;
static CGFloat scoreViewHeight = 90;

@interface ScoreViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *scoreLabels;

@end

@implementation ScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Score Keeper";
    
    self.scoreLabels = [NSMutableArray new];
    
    // Do any additional setup after loading the view.
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    // Call addScoreView 4 times, passing in index as parameter
    for (NSInteger i = 0; i < 4; i++) {
        [self addScoreView:i];
    }
}

- (void)addScoreView:(NSInteger)index{
    
    CGFloat nameFieldWidth = 90;
    CGFloat scoreFieldWidth = 60;
    CGFloat stepperButtonWidth = 90;
    
    CGFloat width = self.view.frame.size.width;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, index * scoreViewHeight, width, scoreViewHeight)];
    
    UITextField *nameField = [[UITextField alloc] initWithFrame:CGRectMake(margin, margin, nameFieldWidth, 44)];
    nameField.delegate = self;
    nameField.placeholder = @"Name";
    [view addSubview:nameField];

    UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin + nameFieldWidth,  margin, scoreFieldWidth, 44)];
    scoreLabel.text = @"0";
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    [self.scoreLabels addObject:scoreLabel];
    [view addSubview:scoreLabel];
    
    UIStepper *scoreStepper = [[UIStepper alloc] initWithFrame:CGRectMake(60 + nameFieldWidth + scoreFieldWidth, 30, stepperButtonWidth, 44)];
    scoreStepper.maximumValue = 9999;
    scoreStepper.minimumValue = -9999;
    scoreStepper.tag = index;
    
    [scoreStepper addTarget:self action:@selector(scoreStepperChanged:) forControlEvents:UIControlEventValueChanged];
    [view addSubview:scoreStepper];
    
    
   [self.scrollView addSubview:view];
    
    
}

-(void)scoreStepperChanged:(id)sender {
    // Initialize stepper as the value passed in as the method parameter
    UIStepper *stepper = sender;
    
    // Initialize an NSInteger as the stepper tag value
    NSInteger index = stepper.tag;
    
    // Initialize double as stepper value (default is 0)
    double value = [stepper value];
    
    // Initialize UILabel as a scoreLabel from our scoreLabels array property with an index corresponding to the stepper on that line
    UILabel *scoreLabel = self.scoreLabels[index];
    
    // Update the label text with the new stepper value
    scoreLabel.text = [NSString stringWithFormat:@"%d", (int)value];
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
