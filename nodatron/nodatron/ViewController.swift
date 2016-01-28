//
//  ViewController.swift
//  nodatron
//
//  Created by Kenneth Centurion on 1/28/16.
//  Copyright © 2016 Kenneth Centurion. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var angleSlider : UISlider!
    @IBOutlet var angleLabel  : UILabel!
    
    var tcpClient : TcpClient = TcpClient(host: "99.155.61.20",port: 8170);
    
    
    @IBAction func angleChanged(sender : AnyObject) {
        angleLabel.text = "\(Int(angleSlider.value)) degrees";
     
        let sliderValue = Int(angleSlider.value);
        NSLog(String(sliderValue));
        tcpClient.sendData(String(sliderValue));
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

