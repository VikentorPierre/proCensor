//
//  ViewController.swift
//  proCensor
//
//  Created by Vikentor Pierre on 7/24/18.
//  Copyright © 2018 mosDev. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    let cameraController = CameraVideoViewController()
    
    let mainCameraView: CameraMainView = CameraMainView()


    override func viewDidLoad() {
        super.viewDidLoad()
        configureCameraController()
    }
    override func loadView() {
        super.loadView()
        self.view = mainCameraView
    }
    
    
    func configureCameraController() {
        cameraController.prepare {(error) in
            if let error = error {
                print(error)
            }
            
            try? self.cameraController.displayPreview(onview: self.view)
        }
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
