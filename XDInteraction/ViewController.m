//
//  ViewController.m
//  XDInteraction
//
//  Created by FumikoIshizawa on 2015/06/04.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
  void *ctx1, *ctx2;
  void *subsock, *reqsock;
}

@end

@implementation ViewController

@synthesize gestureRecognizer;

- (void)viewDidLoad {
  [super viewDidLoad];
  gestureRecognizer = [[XDGestureRecognizer alloc] initWithView:self.view];
  
  ctx1 = zmq_init(0);
  subsock = zmq_socket(ctx1, ZMQ_SUB);
  zmq_setsockopt(subsock, ZMQ_SUBSCRIBE, "", 0);
  int rc = zmq_connect(subsock, "tcp://127.0.0.1:5556");
  assert(rc == 0);
  
  ctx2 = zmq_init(1);
  reqsock = zmq_socket(ctx1, ZMQ_REQ);
  rc = zmq_connect(reqsock, "tcp://127.0.0.1:5555");
  assert(rc == 0);
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
