/*
 
 LAUPickerViewTest.m
 LAUPickerView
 
 Copyright (cc) 2012 Luis Laugga.
 Some rights reserved, all wrongs deserved.
 
 Licensed under a Creative Commons Attribution-ShareAlike 3.0 License;
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://creativecommons.org/licenses/by-sa/3.0/
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" basis,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 
*/

#import "LAUPickerViewTest.h"

@implementation LAUPickerViewTest

- (void)setUp
{
    [super setUp];
    
    _pickerView = [[LAUPickerView alloc] initWithFrame:CGRectZero];
}

- (void)tearDown
{
    [_pickerView release];
    
    [super tearDown];
}

- (void)testInit
{
    STAssertNil(_pickerView.delegate, @"");
    STAssertNil(_pickerView.dataSource, @"");
    
    STAssertEquals(LAUPickerSelectionAlignmentCenter, _pickerView.selectionAlignment, @"Alignment center set by default");
    STAssertTrue(_pickerView.soundsEnabled, @"Input sounds enabled by default");
}

@end
