//
//  ViewController.swift
//  DeviceGuruWithPod
//
//  Created by Inder Kumar Rathore on 17/03/16.
//  Copyright © 2016 Inder Kumar Rathore. All rights reserved.
//

import UIKit
import DeviceGuru

class ViewController: UIViewController {
  @IBOutlet weak var hardwareString: UILabel!
  @IBOutlet weak var hardwareDescription: UILabel!
  @IBOutlet weak var width: UILabel!
  @IBOutlet weak var height: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.hardwareString.text = DeviceGuru.hardwareString()
    self.hardwareDescription.text = DeviceGuru.hardwareDescription()
    
    //get the camera resolution size in potrait mode
    let size = DeviceGuru.backCameraStillImageResolutionInPixels(DeviceGuru.hardware())
    self.width.text = "\(size.width)"
    self.height.text = "\(size.height)"
  }
}

