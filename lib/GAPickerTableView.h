/*
 
 GAPickerTableView.h
 GAPickerView
 
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

#import <UIKit/UIKit.h>

#import "GAPickerTableViewDataSource.h"
#import "GAPickerTableViewDelegate.h"

@interface GAPickerTableView : UIView <UIGestureRecognizerDelegate>
{
    NSInteger _component;
    NSInteger _numberOfColumns;
    NSInteger _selectedColumn;
    
    NSMutableArray * _columns;
    
    id<GAPickerTableViewDataSource> _dataSource;
    id<GAPickerTableViewDelegate> _delegate;
    
    UIPanGestureRecognizer * _panGestureRecognizer;
    
    BOOL _isScrolling;
    CGFloat _scrollingTranslation;
    CGFloat _absoluteTranslation;
    CGFloat _selectedTranslation; // pre-calculated
}

@property (nonatomic, readonly) NSInteger selectedColumn;

@property (nonatomic, assign) id<GAPickerTableViewDataSource> dataSource;
@property (nonatomic, assign) id<GAPickerTableViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame andComponent:(NSInteger)component;

- (void)setSelectedColumn:(NSInteger)column animated:(BOOL)animated;

@end