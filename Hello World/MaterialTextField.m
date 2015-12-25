//
//  MaterialTextField.m
//  Hello World
//
//  Created by Andrey Buksha on 25.12.15.
//  Copyright © 2015 Andrey Buksha. All rights reserved.
//

#import "MaterialTextField.h"

@implementation MaterialTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib {
    self.layer.cornerRadius = 2.0;
    self.layer.borderColor = [UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:0.1].CGColor;
    self.layer.borderWidth = 1.0;
}

-(CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 10, 0);
}

-(CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 10, 0);
}

@end
