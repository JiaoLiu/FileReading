//
//  DMMainViewController.m
//  FileReading
//
//  Created by Jiao on 14-3-14.
//  Copyright (c) 2014年 Jiao Liu. All rights reserved.
//

#import "DMMainViewController.h"
#import "DMFileDetailViewController.h"

@interface DMMainViewController ()
{
    DMFileDetailViewController *fileDetailVC;
}

@end

@implementation DMMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"主页";
    
    UIButton *pdfBtn = [[UIButton alloc] initWithFrame:CGRectMake(320/2 - 60, 100, 120, 40)];
    [pdfBtn setTitle:@"PDF" forState:UIControlStateNormal];
    [pdfBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [pdfBtn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    pdfBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    pdfBtn.layer.borderWidth = 1;
    pdfBtn.layer.cornerRadius = 3;
    pdfBtn.tag = 0;
    [self.view addSubview:pdfBtn];
    
    UIButton *txtBtn = [[UIButton alloc] initWithFrame:CGRectMake(320/2 - 60, 160, 120, 40)];
    [txtBtn setTitle:@"Text" forState:UIControlStateNormal];
    [txtBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [txtBtn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    txtBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    txtBtn.layer.borderWidth = 1;
    txtBtn.layer.cornerRadius = 3;
    txtBtn.tag = 1;
    [self.view addSubview:txtBtn];
    
    UIButton *picBtn = [[UIButton alloc] initWithFrame:CGRectMake(320/2 - 60, 220, 120, 40)];
    [picBtn setTitle:@"Picture" forState:UIControlStateNormal];
    [picBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [picBtn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    picBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    picBtn.layer.borderWidth = 1;
    picBtn.layer.cornerRadius = 3;
    picBtn.tag = 2;
    [self.view addSubview:picBtn];
    
    UIButton *docBtn = [[UIButton alloc] initWithFrame:CGRectMake(320/2 - 60, 280, 120, 40)];
    [docBtn setTitle:@"Office" forState:UIControlStateNormal];
    [docBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [docBtn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    docBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    docBtn.layer.borderWidth = 1;
    docBtn.layer.cornerRadius = 3;
    docBtn.tag = 3;
    [self.view addSubview:docBtn];
    
    UIButton *zipBtn = [[UIButton alloc] initWithFrame:CGRectMake(320/2 - 60, 340, 120, 40)];
    [zipBtn setTitle:@"ZIP" forState:UIControlStateNormal];
    [zipBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [zipBtn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    zipBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    zipBtn.layer.borderWidth = 1;
    zipBtn.layer.cornerRadius = 3;
    zipBtn.tag = 4;
    [self.view addSubview:zipBtn];
    
    UIButton *rarBtn = [[UIButton alloc] initWithFrame:CGRectMake(320/2 - 60, 400, 120, 40)];
    [rarBtn setTitle:@"RAR" forState:UIControlStateNormal];
    [rarBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [rarBtn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    rarBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    rarBtn.layer.borderWidth = 1;
    rarBtn.layer.cornerRadius = 3;
    rarBtn.tag = 5;
    [self.view addSubview:rarBtn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)BtnClicked : (UIButton *)sender
{
    switch (sender.tag) {
        case 0:
        {
            fileDetailVC = [[DMFileDetailViewController alloc] initWithType:PDF_TYPE];
            [self.navigationController pushViewController:fileDetailVC animated:YES];
        }
            break;
        case 1:
        {
            fileDetailVC = [[DMFileDetailViewController alloc] initWithType:TXT_TYPE];
            [self.navigationController pushViewController:fileDetailVC animated:YES];
        }
            break;
        case 2:
        {
            fileDetailVC = [[DMFileDetailViewController alloc] initWithType:PIC_TYPE];
            [self.navigationController pushViewController:fileDetailVC animated:YES];
        }
            break;
        case 3:
        {
            fileDetailVC = [[DMFileDetailViewController alloc] initWithType:DOC_TYPE];
            [self.navigationController pushViewController:fileDetailVC animated:YES];
        }
            break;
        case 4:
        {
            fileDetailVC = [[DMFileDetailViewController alloc] initWithType:ZIP_TYPE];
            [self.navigationController pushViewController:fileDetailVC animated:YES];
        }
            break;
        case 5:
        {
            fileDetailVC = [[DMFileDetailViewController alloc] initWithType:RAR_TYPE];
            [self.navigationController pushViewController:fileDetailVC animated:YES];
        }
            break;
        default:
            break;
    }
}

@end
