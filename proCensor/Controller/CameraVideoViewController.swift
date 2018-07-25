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
    
    var captureSession: AVCaptureSession?
    
    var frontCamera: AVCaptureDevice?
    var rearCamera: AVCaptureDevice?
    

    var currentCameraPosition: CameraPosition?
    var frontCameraInput: AVCaptureDeviceInput?
    var rearCameraInput: AVCaptureDeviceInput?
    
    
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    
    var  photoOutput: AVCapturePhotoOutput?// to hold the data output of our capture session

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    /*This function will handle the creation and configuration of a new capture session. Remember, setting up the capture session consists of 4 steps
     * 1. Creating a capture session.
     * 2. Obtaining and configuring the necessary capture devices
     * 3. Creating inputs using the capture devices
     */
    func prepare(completionHandler: @escaping (Error?) -> Void) {
        func createCaptureSession() {
            self.captureSession = AVCaptureSession()
            
        }
        func configureCaptureDevices() throws {

            //1
            let session = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .unspecified)
//            guard let cameras = (session.devices.compactMap { $0 }), !cameras.isEmpty else { throw CameraControllerError.noCamerasAvailable }
            
            let cameras = session.devices
            
            //2
            for camera in cameras {
                if camera.position == .front {
                    self.frontCamera = camera
                }
                
                if camera.position == .back {
                    self.rearCamera = camera
                    
                    try camera.lockForConfiguration()
                    camera.focusMode = .continuousAutoFocus
                    camera.unlockForConfiguration()
                }
            }
            
            
        }
        func configureDeviceInputs() throws {
            
            //3. This line simply ensures that captureSession exists. If not, we throw an error
            guard let captureSession = self.captureSession else { throw CameraControllerError.captureSessionIsMissing }
            
            //4only allows one camera-based input per capture session at a time. Since the rear camera is traditionally the default, we attempt to create an input from it and add it to the capture session
            if let rearCamera = self.rearCamera {
                self.rearCameraInput = try AVCaptureDeviceInput(device: rearCamera)
                
                if captureSession.canAddInput(self.rearCameraInput!) { captureSession.addInput(self.rearCameraInput!) }
                
                self.currentCameraPosition = .rear
            }
                
            //
            //
            //If that fails, we fall back on the front camera. If that fails as well, we throw an error
            else if let frontCamera = self.frontCamera {
                self.frontCameraInput = try AVCaptureDeviceInput(device: frontCamera)
                
                if captureSession.canAddInput(self.frontCameraInput!) { captureSession.addInput(self.frontCameraInput!) }
                else { throw CameraControllerError.inputsAreInvalid }
                
                self.currentCameraPosition = .front
            }
                
            else { throw CameraControllerError.noCamerasAvailable }
        }
        func configurePhotoOutput() throws {
            guard let captureSession = self.captureSession else { throw CameraControllerError.captureSessionIsMissing }
            
            self.photoOutput = AVCapturePhotoOutput()
            self.photoOutput!.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])], completionHandler: nil)
            
            if let picOutput = self.photoOutput {
                if captureSession.canAddOutput(picOutput){ captureSession.addOutput(picOutput)}
            }
            //if captureSession.canAddOutput(self.photoOutput) { captureSession.addOutput(self.photoOutput) }
            
            captureSession.startRunning()
//            This is a simple implementation. It just configures photoOutput, telling
//            it to use the JPEG file format for its video codec. Then, it adds photoOutput to captureSession.
//            Finally, it starts captureSession
        }
        
        DispatchQueue(label: "prepare").async {
            do {
                createCaptureSession()
                try configureCaptureDevices()
                try configureDeviceInputs()
                try configurePhotoOutput()
            }
                
            catch {
                DispatchQueue.main.async {
                    completionHandler(error)
                }
                
                return
            }
            
            DispatchQueue.main.async {
                completionHandler(nil)
            }
        }
//  In the above code listing, we’ve created boilerplate functions for performing the 4 key steps in preparing an AVCaptureSession for photo capture. We’ve also set up an asynchronously executing block that calls the four functions, catches any errors if necessary, and then calls the completion handler. All we have left to do is implement the four functions! Let’s start with createCaptureSession
        
    }

    enum CameraControllerError: Swift.Error {
        case captureSessionAlreadyRunning
        case captureSessionIsMissing
        case inputsAreInvalid
        case invalidOperation
        case noCamerasAvailable
        case unknown
    }

    public enum CameraPosition {
        case front
        case rear
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension CameraVideoViewController{
//    Now that we have the camera device ready, it is time to show what it captures on screen. Add another
//    function to CameraController (outside of prepare), called it displayPreview.
//    It should have the following signature
    
    
    
   // this function will be responsible for creating a capture preview and displaying it on the provided view
    func displayPreview(onview: UIView) throws {
        
        
        guard let captureSession = self.captureSession, captureSession.isRunning else { throw CameraControllerError.captureSessionIsMissing }
        
        self.previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.previewLayer?.connection?.videoOrientation = .portrait
        
        if let preview = self.previewLayer{
            onview.layer.insertSublayer(preview, at: 0)
        }
//        view.layer.insertSublayer(self.previewLayer, at: 0)
        self.previewLayer?.frame = self.view.frame // this line
        
        //This function creates an AVCaptureVideoPreview using captureSession,
        //sets it to have the portrait orientation, and adds it to the provided view
        
    }
    
    
    
    
    
    
    
}
