//
//  VC.swift
//  proCensor
//
//  Created by Vikentor Pierre on 7/26/18.
//  Copyright © 2018 mosDev. All rights reserved.
//

import UIKit
import AVFoundation
import SnapKit

class VC: UIViewController {
    
    
    
    var captureSession = AVCaptureSession()
    var previewLayer = AVCaptureVideoPreviewLayer()
    var movieOutput = AVCaptureMovieFileOutput()
    var videoCaptureDevice : AVCaptureDevice?
    
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    
    
    
    let takeButton:UIButton = {
        let obj = UIButton()
        obj.backgroundColor = .white
        obj.layer.cornerRadius = 30
        obj.clipsToBounds = true
        obj.addTarget(self, action: #selector(takeVideo), for: .touchUpInside)
        return obj
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        prepare()
    }
    @objc func takeVideo(){
        if movieOutput.isRecording {
            movieOutput.stopRecording()
        } else {
            print("playing")
//            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//            let fileUrl = paths[0].absoluteURL
//            try? FileManager.default.removeItem(at: fileUrl)
//            movieOutput.startRecording(toOutputFileURL: fileUrl, recordingDelegate: self as AVCaptureFileOutputRecordingDelegate)
        }
        
    }
    
    override func loadView() {
        super.loadView()
        view.addSubview(takeButton)
        takeButton.snp.makeConstraints { (make) in
            make.top.leading.equalTo(200)
        }
        
        
    }
    
    func prepare() {
        createCaptureSession()
        configureCaptureDevices()
        configureDeviceInputs()
        startRunningCaptureSession()
        


}
}

extension VC{
    
    
    func createCaptureSession() {
        self.captureSession = AVCaptureSession()
    }
    
    func configureCaptureDevices() {
        let session = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .unspecified)
        
        let cameras = session.devices
        
        //2
        for camera in cameras {
            
            
            
            if camera.position == AVCaptureDevice.Position.back{
                self.backCamera = camera
            }else if camera.position == AVCaptureDevice.Position.front{
                self.frontCamera = camera
                // camera.focusMode = .continuousAutoFocus
            }
        }
        self.currentCamera = self.backCamera
        
    }
    
    func configureDeviceInputs() {
        if self.currentCamera != nil {
            
            do {
                // Add Video Input
                try self.captureSession.addInput(AVCaptureDeviceInput(device: currentCamera!))
                
                // Get Audio Device
                let audioInput = AVCaptureDevice.default(for: .audio)
                
                //Add Audio Input
                try self.captureSession.addInput(AVCaptureDeviceInput(device: audioInput!))
                
                self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
                
                previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
                
                previewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                previewLayer.frame = self.view.frame
                self.view.layer.insertSublayer(previewLayer, at: 0)
                
                
                //Add File Output
                self.captureSession.addOutput(self.movieOutput)
                
                //captureSession.startRunning()
                
            }catch { print("somthing in the configDevice input")}
        }
    }
    fileprivate func  startRunningCaptureSession(){
        self.captureSession.startRunning()
    }
    
    
    override var prefersStatusBarHidden: Bool{ return true}

    
    
    
}
extension VC: AVCaptureFileOutputRecordingDelegate{
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        if error == nil {
            UISaveVideoAtPathToSavedPhotosAlbum(outputFileURL.path, nil, nil, nil)
        }
    }
}
