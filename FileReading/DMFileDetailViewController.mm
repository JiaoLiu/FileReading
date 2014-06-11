//
//  DMFileDetailViewController.m
//  FileReading
//
//  Created by Jiao on 14-3-14.
//  Copyright (c) 2014年 Jiao Liu. All rights reserved.
//

#import "DMFileDetailViewController.h"
#import "ZipArchive.h"
#include <string.h>
#import "Unrar4iOS.framework/Headers/Unrar4iOS.h"

@interface DMFileDetailViewController ()
{
    UIActivityIndicatorView *activityView;
    NSMutableArray *pathArray;
}

@end

@implementation DMFileDetailViewController

- (instancetype)initWithType:(SourceType)type
{
    self = [super init];
    if (self) {
        _type = type;
        pathArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
    // Do any additional setup after loading the view.
    switch (_type) {
        case PDF_TYPE:
        {
            self.title = @"PDF";
            NSString *path = [[NSBundle mainBundle] pathForResource:@"mapreduce" ofType:@"pdf"];
//            NSString *path = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"gif"];
//            NSString *path = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"bmp"];
            UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, SCREEN_HEIGHT - 64)];
            webView.scalesPageToFit = YES;
            [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
            [self.view addSubview:webView];
        }
            break;
        case PIC_TYPE:
        {
            self.title = @"Picture";
            NSString *path = [[NSBundle mainBundle] pathForResource:@"mapreduce" ofType:@"jpeg"];
            UIImage *image = [UIImage imageWithContentsOfFile:path];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
            imageView.center = CGPointMake(320/2, SCREEN_HEIGHT/2);
            imageView.image = image;
            [self.view addSubview:imageView];
        }
            break;
        case DOC_TYPE:
        {
            self.title = @"Office";
            NSString *path = [[NSBundle mainBundle] pathForResource:@"mapreduce" ofType:@"xlsx"];
            UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, SCREEN_HEIGHT - 64)];
            [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
            webView.scalesPageToFit = YES;
            [self.view addSubview:webView];
        }
            break;
        case TXT_TYPE:
        {
            self.title = @"Text";
            NSString *path = [[NSBundle mainBundle] pathForResource:@"mapreduce" ofType:@"txt"];
            NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
            UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, SCREEN_HEIGHT - 64)];
            textView.text = str;
            textView.editable = NO;
            [self.view addSubview:textView];
        }
            break;
        case ZIP_TYPE:
        {
            int i = 0;
            self.title = @"ZIP";
            NSString *path = [[NSBundle mainBundle] pathForResource:@"mapreduce" ofType:@"zip"];
            NSString *toPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:@"/zip"];
            ZipArchive *zip = [[ZipArchive alloc] init];
            UIScrollView *backView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
            [self.view addSubview:backView];
//            UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 640 - 65)];
//            webView.scalesPageToFit = YES;
//            webView.delegate = self;
//            [self.view addSubview:webView];
//            if ([[self getFileType:str]  isEqual: @"pptx"]) {
//                NSString *urlPath = [toPath stringByAppendingString:[NSString stringWithFormat:@"/%@" , str]];
//                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:urlPath]]];
//                [self.view addSubview:webView];
//            }
            if ([zip UnzipOpenFile:path]) {
                BOOL ret = [zip UnzipFileTo:toPath overWrite:YES];
                if (ret == NO) {
                    NSLog(@"fail unzip");
                }
                else
                {
                    NSArray *file = [[NSFileManager defaultManager] subpathsAtPath:toPath];
                    NSLog(@"%@",file);
                    for (NSString *str in file) {
                        NSLog(@"%@",[self getFileType:str]);
                        if (![[self getFileType:str] isEqualToString:@"unknow"] && ![[self getFileType:str] isEqualToString:@"DS_Store"]) {
                            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 20 + i * 44, 320, 44)];
                            [btn setTitle:str forState:UIControlStateNormal];
                            [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                            btn.tag = i;
                            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
                            [backView addSubview:btn];
                            backView.contentSize = CGSizeMake(SCREEN_WIDTH, btn.frame.origin.y + btn.frame.size.height + 20);
                            i++;
                            NSString *urlPath = [toPath stringByAppendingString:[NSString stringWithFormat:@"/%@" , str]];
                            [pathArray addObject:urlPath];
                        }
                    }
                }
                [zip UnzipCloseFile];
            }
        }
            break;
        case RAR_TYPE:
        {
            int i = 0;
            int m = 0;
            self.title = @"RAR";
            NSString *path = [[NSBundle mainBundle] pathForResource:@"mapreduce" ofType:@"rar"];
            NSString *toPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:@"/rar"];
            [[NSFileManager defaultManager] createDirectoryAtPath:toPath withIntermediateDirectories:YES attributes:nil error:nil];
            UIScrollView *backView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
            [self.view addSubview:backView];
            Unrar4iOS *unRar = [[Unrar4iOS alloc] init];
            if ([unRar unrarOpenFile:path]) {
                NSArray *files = [unRar unrarListFiles];
                for (NSString *str in files) {
                    if (![[self getFileType:str] isEqualToString:@"unknow"] && ![[self getFileType:str] isEqualToString:@"DS_Store"]) {
                        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 20 + i * 44, 320, 44)];
                        [btn setTitle:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forState:UIControlStateNormal];
                        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                        btn.tag = i;
                        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
                        [backView addSubview:btn];
                        backView.contentSize = CGSizeMake(SCREEN_WIDTH, btn.frame.origin.y + btn.frame.size.height + 20);
                        i++;
                        NSString *urlPath = [toPath stringByAppendingString:[NSString stringWithFormat:@"/test%d.%@" , m,[self getFileType:str]]];
                        NSData *data = [unRar extractStream:[files objectAtIndex:m]];
                        [[NSFileManager defaultManager] createFileAtPath:urlPath contents:data attributes:nil];
                        [pathArray addObject:urlPath];
                    }
                    m++;
                }
            }
            [unRar unrarCloseFile];
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSString *)getFileType : (NSString *)filePath
{
    NSString *type = @"unknow";
    if ([filePath length]>4) {
        NSRange rag=[filePath rangeOfString:@"." options:NSBackwardsSearch];
        if (rag.location!=NSNotFound) {
            type = [filePath substringFromIndex:rag.location];
        }
    }
    return type;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.center = CGPointMake(webView.frame.size.width / 2, webView.frame.size.height / 2);
    [webView addSubview:activityView];
    [activityView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activityView stopAnimating];
}

- (void)removeAllSubviews : (NSArray *)views
{
    for (UIView *subview in views) {
        [subview removeFromSuperview];
    }
}

- (void)btnClicked:(UIButton *)sender
{
    [self removeAllSubviews:[self.view subviews]];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, SCREEN_HEIGHT - 64)];
    webView.scalesPageToFit = YES;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[pathArray objectAtIndex:sender.tag]]]];
    [self.view addSubview:webView];
}

@end
