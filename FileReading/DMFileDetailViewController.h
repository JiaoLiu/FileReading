//
//  DMFileDetailViewController.h
//  FileReading
//
//  Created by Jiao on 14-3-14.
//  Copyright (c) 2014年 Jiao Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    PDF_TYPE,
    PIC_TYPE,
    TXT_TYPE,
    DOC_TYPE,
    ZIP_TYPE,
    RAR_TYPE
} SourceType;

@interface DMFileDetailViewController : UIViewController<UIWebViewDelegate>

@property (nonatomic, assign) SourceType type;

- (id)initWithType : (SourceType)type;

@end
