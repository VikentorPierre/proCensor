//
//  CameraMainView.swift
//  proCensor
//
//  Created by Vikentor Pierre on 7/24/18.
//  Copyright © 2018 mosDev. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation

class CameraMainView: UIView {
    
    let camera: CameraVideoViewController = CameraVideoViewController()
    
   // let MysegmentedControl: UISegmentedControl = {
        
       // let obj = UISegmentedControl(items: ["Photo","Video"])
        //return obj
    //}()
    
    let theFlash:UIButton = {
        let obj = UIButton()
        obj.setImage(UIImage(named: "flashOff"), for: .normal)
        obj.addTarget(self, action: #selector(toggleFlash), for: .touchUpInside)
        return obj
    }()
    
    let takeButton:UIButton = {
        let obj = UIButton()
        obj.backgroundColor = .white
        obj.layer.cornerRadius = 30
        obj.clipsToBounds = true
        obj.addTarget(self, action: #selector(showPreview), for: .touchUpInside)
        return obj
    }()
    
    let cameraSwitchfunc:UIButton = {
        let obj = UIButton()
        obj.setImage(UIImage(named: "CameraSwitch"), for: .normal)
        obj.addTarget(self, action: #selector(toggleCameraPosition), for: .touchUpInside)
        return obj
        
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCamera()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        //setupCamera()
    }
    
    
    
    
    
    fileprivate func setupCamera(){
        self.backgroundColor = .black
        self.addSubview(takeButton)
        self.addSubview(theFlash)
        //self.addSubview(MysegmentedControl)
        self.addSubview(cameraSwitchfunc)
        takeButton.snp.makeConstraints { (make) in
            make.centerXWithinMargins.equalToSuperview()
            make.size.equalTo(60)
            make.bottom.equalTo(-5)
        }
//        MysegmentedControl.snp.makeConstraints { (make) in
//            make.leadingMargin.equalTo(0)
//            make.bottomMargin.equalTo(-27)
//        }
        cameraSwitchfunc.snp.makeConstraints { (make) in
            make.trailingMargin.equalTo(-20)
            make.bottomMargin.equalTo(-27)
        }
        
        theFlash.snp.makeConstraints { (make) in
            make.topMargin.equalTo(15)
            make.trailingMargin.equalTo(-15)
        }
        
    }
    @objc func toggleCameraPosition(){
//        do {
//            try camera.switchCameras()
//        }
//
//        catch {
//            print(error)
//        }
//
//        switch camera.currentCameraPosition {
//        case .some(.front):
//            print("front camera")
//            //cameraSwitchfunc.setImage(#imageLiteral(resourceName: "Front Camera Icon"), for: .normal)
//
//        case .some(.rear):
//            print("back camera")
//            //cameraSwitchfunc.setImage(#imageLiteral(resourceName: "Rear Camera Icon"), for: .normal)
//
//        case .none:
//            return
//        }
    }
    
    @objc func toggleFlash(){
//        if camera.flashMode == .on {
//            camera.flashMode = .off
//            theFlash.setImage(#imageLiteral(resourceName: "flashOff"), for: .normal)
//            print("flash is off")
//        }
//            
//        else {
//            camera.flashMode = .on
//            theFlash.setImage(#imageLiteral(resourceName: "flashOn "), for: .normal)
//            print("flash is on")
//        }
        
    }
    
    
    @objc func showPreview(){
        print("showPreview")
    }
    
}
