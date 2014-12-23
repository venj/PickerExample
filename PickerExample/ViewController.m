//
//  ViewController.m
//  PickerExample
//
//  Created by Venj Chu on 14/12/23.
//  Copyright (c) 2014年 Venj Chu. All rights reserved.
//

#import "ViewController.h"
#import <ActionSheetPicker-3.0/ActionSheetCustomPicker.h>

@interface ViewController () <ActionSheetCustomPickerDelegate>
@property (nonatomic, strong) NSArray *keys;
@property (nonatomic, strong) NSArray *values;
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

- (IBAction)showPicker:(id)sender {
    self.keys = @[@"Array 1", @"Array 2", @"Array 3"];
    self.values = @[ @[@"Item 1 - 1", @"Item 1 - 2", @"Item 1 - 3", @"Item 1 - 4", @"Item 1 - 5"],
                     @[@"Item 2 - 1", @"Item 2 - 2", @"Item 2 - 3", @"Item 2 - 4", @"Item 2 - 5"],
                     @[@"Item 3 - 1", @"Item 3 - 2", @"Item 3 - 3", @"Item 3 - 4", @"Item 3 - 5"],
                    ];
    
    ActionSheetCustomPicker *picker = [[ActionSheetCustomPicker alloc] initWithTitle:@"Select some thing." delegate:self showCancelButton:NO origin:sender initialSelections:@[@(0), @(0)]];
    [picker showActionSheetPicker];
}

- (IBAction)notCrash:(id)sender {
    self.keys = @[@"Array 1", @"Array 2", @"Array 3"];
    self.values = @[ @[@"Item 1 - 1"],
                     @[@"Item 2 - 1", @"Item 2 - 2", @"Item 2 - 3"],
                     @[@"Item 3 - 1", @"Item 3 - 2", @"Item 3 - 3", @"Item 3 - 4", @"Item 3 - 5"],
                     ];
    
    ActionSheetCustomPicker *picker = [[ActionSheetCustomPicker alloc] initWithTitle:@"Select something." delegate:self showCancelButton:NO origin:sender initialSelections:@[@(0), @(0)]];
    [picker showActionSheetPicker];
}

- (IBAction)crashMe:(id)sender {
    self.keys = @[@"Array 1", @"Array 2", @"Array 3"];
    self.values = @[ @[@"Item 1 - 1"],
                     @[@"Item 2 - 1", @"Item 2 - 2", @"Item 2 - 3"],
                     @[@"Item 3 - 1", @"Item 3 - 2", @"Item 3 - 3", @"Item 3 - 4", @"Item 3 - 5"],
                     ];
    
    ActionSheetCustomPicker *picker = [[ActionSheetCustomPicker alloc] initWithTitle:@"Select something." delegate:self showCancelButton:NO origin:sender initialSelections:@[@(1), @(2)]];
    [picker showActionSheetPicker];

//    UIPickerView *pv = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
//    pv.backgroundColor = [UIColor redColor];
//    self.pickerView = pv;
//
//    // Default to our delegate being the picker's delegate and datasource
//    pv.delegate = self;
//    pv.dataSource = self;
//    self.initialSelections = @[@1, @2];
//    if ( self.initialSelections )
//    {
//        NSAssert(pv.numberOfComponents == self.initialSelections.count, @"Number of sections not match");
//        for (NSUInteger i = 0; i < [self.initialSelections count]; i++)
//        {
//            NSInteger row = [(NSNumber *) self.initialSelections[i] integerValue];
//            NSAssert([pv numberOfRowsInComponent:i] > row, @"Number of sections not match");
//            [pv selectRow:row inComponent:i animated:NO];
//
//            [pv reloadAllComponents];
//        }
//    }
//    [self.view addSubview:pv];

}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        NSUInteger count = [self.keys count];
        return count;
    }
    else {
        NSInteger selectedRowInFirstComponent = [pickerView selectedRowInComponent:0]; //should be 1
        NSInteger numberOfRowsInSecondRow = [self.values[selectedRowInFirstComponent] count]; //should be 3
        NSLog(@"numberOfRowsInSecondRow = %i", numberOfRowsInSecondRow);
        return numberOfRowsInSecondRow;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSLog(@"Title for:");
    NSLog(@"row = %i", row);
    NSLog(@"component = %i", component);
    if (component == 0) {
        return self.keys[row];
    }
    else {
        NSInteger index = [pickerView selectedRowInComponent:0];
        return self.values[index][row];
    }
}

// Reload picker view component 1 according to component 0 selection change.
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [pickerView reloadComponent:1];
}

- (void)actionSheetPickerDidSucceed:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin {
    NSInteger index1 = [(UIPickerView *)actionSheetPicker.pickerView selectedRowInComponent:0];
    NSInteger index2 = [(UIPickerView *)actionSheetPicker.pickerView selectedRowInComponent:1];
    NSLog(@"Selected: '%@' and '%@'", self.keys[index1], self.values[index1][index2]);
}

@end
