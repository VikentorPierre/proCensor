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
    
    
    var myCamera = CameraVideoViewController()
    
    let mainCameraView: CameraMainView = CameraMainView()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        print("print name")
        if (myCamera.setupCaptureSession()){
            myCamera.setupPreview(onview: self.view)
            myCamera.beginCaptureSession()
            
        }

        
//        let toggle: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleCamera))
//        toggle.numberOfTapsRequired = 2
        
//        view.addGestureRecognizer(toggle)
    }
    
    
    
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        cameraController.startSession()
//    }
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(true)
//        cameraController.stopSession()
//    }
//
//    override func loadView() {
//        super.loadView()
//        self.view = mainCameraView
//    }
//
//
//    func configureCameraController() {
//        cameraController.prepare {(error) in
//            if let error = error {
//                print(error)
//            }
//
//            try? self.cameraController.displayPreview(onview: self.view)
//        }
//    }
    

    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
