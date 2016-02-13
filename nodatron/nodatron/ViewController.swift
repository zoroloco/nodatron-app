//
//  ViewController.swift
//  nodatron
//
//  Created by Kenneth Centurion on 1/28/16.
//  Copyright © 2016 Kenneth Centurion. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var upDownSlider : UISlider!
    @IBOutlet var upDownLabel  : UILabel!
    @IBOutlet var leftRightSlider : UISlider!
    @IBOutlet var leftRightLabel  : UILabel!

    
    var tcpClient : TcpClient = TcpClient(host: "99.155.61.20",port: 8170);
    
    
    @IBAction func upDown(sender : AnyObject) {
        upDownLabel.text = "\(Int(upDownSlider.value)) degrees";
     
        let upDownSliderValue = Int(upDownSlider.value);
        NSLog(String(upDownSliderValue));
        let data = String(upDownSliderValue);
        tcpClient.sendData("10:"+data);
    }
    
    @IBAction func leftRight(sender : AnyObject){
        leftRightLabel.text = "\(Int(leftRightSlider.value)) degrees";
        
        let leftRightSliderValue = Int(leftRightSlider.value);
        NSLog(String(leftRightSliderValue));
        let data = String(leftRightSliderValue);
        tcpClient.sendData("9:"+data);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tcpClient.connectToNodatron();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

