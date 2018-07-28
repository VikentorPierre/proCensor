//
//  CameraVideoViewController.swift
//  proCensor
//
//  Created by Vikentor Pierre on 7/25/18.
//  Copyright © 2018 mosDev. All rights reserved.
//

import UIKit
import AVFoundation

class CameraVideoViewController: UIViewController {
    
    var myCaptureSession: AVCaptureSession = AVCaptureSession()
    var previewLayer:AVCaptureVideoPreviewLayer?
    var movieOutput = AVCaptureMovieFileOutput()
    
    var currentCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var backCamera: AVCaptureDevice?


    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func setupPreview(onview: UIView) {
        // Configure previewLayer
        self.previewLayer = AVCaptureVideoPreviewLayer(session: myCaptureSession)
        self.previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.previewLayer?.connection?.videoOrientation = .portrait
        self.previewLayer?.frame = self.view.frame
        if let preview = self.previewLayer{
            onview.layer.insertSublayer(preview, at: 0)
        }
    }
    
    func setupCaptureSession() -> Bool{
        // setup the qulity
        myCaptureSession.sessionPreset = AVCaptureSession.Preset.high
        // setup CaptureDevice
        if (deviceSetup() == false){ print("something with wrong with our deviceSetup");return false}
        //input and output
        else if (inputOutputSetup() == false){print("something with wrong with our inputOutputSetup"); return false}
        
        return true
    }
    
    func deviceSetup()-> Bool{
        
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: .video, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoverySession.devices
        
        for device in devices{
            if device.position == AVCaptureDevice.Position.back{
                self.backCamera = device
            }else if device.position == AVCaptureDevice.Position.front{
                self.frontCamera = device
            }
        }
        self.currentCamera = self.backCamera
        return true
    }
    func inputOutputSetup()-> Bool{
        do{
            if(self.currentCamera != nil){
                // get current camera device
                let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
                // add the current camera device
                if (myCaptureSession.canAddInput(captureDeviceInput)){ myCaptureSession.addInput(captureDeviceInput)}
                // Get Audio Device
                let audio = AVCaptureDevice.default(for: .audio)
                let audioInput = try AVCaptureDeviceInput(device: audio!)
                // add audio
                if (myCaptureSession.canAddInput(audioInput)){myCaptureSession.addInput(audioInput)}
                
                if (myCaptureSession.canAddOutput(self.movieOutput)){myCaptureSession.addOutput(self.movieOutput)}
                myCaptureSession.commitConfiguration()
            }
            
        }catch{print("Error setting device audio input: \(error.localizedDescription)");return false}
        return true
    }
    
    func beginCaptureSession() {
        if !myCaptureSession.isRunning {
            cameraQueueManager().async {
                self.myCaptureSession.startRunning()
            }
        }
    }
    func cameraQueueManager() -> DispatchQueue {
        return DispatchQueue.main
    }
    
    
    
    
}// end class

extension CameraVideoViewController{
    func startRecording() {
        if self.movieOutput.isRecording == false {
            
            let connection = self.movieOutput.connection(with: AVMediaType.video)
            if (connection?.isVideoOrientationSupported)! {
                connection?.videoOrientation = currentVideoOrientation()
            }
            
            if (connection?.isVideoStabilizationSupported)! {
                connection?.preferredVideoStabilizationMode = AVCaptureVideoStabilizationMode.auto
            }
            
            let device = self.currentCamera // AVCaptureDEviceinput
            if (device?.isSmoothAutoFocusSupported)! {
                do {
                    try device?.lockForConfiguration()
                    device?.isSmoothAutoFocusEnabled = false
                    device?.unlockForConfiguration()
                } catch {
                    print("Error setting configuration: \(error)")
                }
                
            }
            
            //EDIT2: And I forgot this
            outputURL = tempURL()
            movieOutput.startRecording(toOutputFileURL: outputURL, recordingDelegate: self)
            
        }
        else {
            stopRecording()
        }
        
    }
    func tempURL() -> URL? {
        let directory = NSTemporaryDirectory() as NSString
        
        if directory != "" {
            let path = directory.appendingPathComponent(NSUUID().uuidString + ".mp4")
            return URL(fileURLWithPath: path)
        }
        
        return nil
    }
    func stopRecording() {
        
        if self.movieOutput.isRecording == true {
            self.movieOutput.stopRecording()
        }
    }

    func currentVideoOrientation() -> AVCaptureVideoOrientation {
        var orientation: AVCaptureVideoOrientation
        
        switch UIDevice.current.orientation {
        case .portrait:
            orientation = AVCaptureVideoOrientation.portrait
        case .landscapeRight:
            orientation = AVCaptureVideoOrientation.landscapeLeft
        case .portraitUpsideDown:
            orientation = AVCaptureVideoOrientation.portraitUpsideDown
        default:
            orientation = AVCaptureVideoOrientation.landscapeRight
        }
        
        return orientation
    }
}// end extensiom
