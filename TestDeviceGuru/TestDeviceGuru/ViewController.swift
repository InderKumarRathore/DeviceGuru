//
//  ViewController.swift
//  TestDeviceGuru
//
//  Created by Inder Kumar Rathore on 21/09/16.
//  Copyright © 2016 Inder Kumar Rathore. All rights reserved.
//

import UIKit
import DeviceGuru

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    print("\(String(describing: DeviceGuru().hardwareDescription()))")
  }
}

