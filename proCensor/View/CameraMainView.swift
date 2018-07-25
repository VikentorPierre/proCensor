//
//  CameraMainView.swift
//  proCensor
//
//  Created by Vikentor Pierre on 7/24/18.
//  Copyright © 2018 mosDev. All rights reserved.
//

import UIKit
import SnapKit

class CameraMainView: UIView {
    
    let MysegmentedControl: UISegmentedControl = {
        
        let obj = UISegmentedControl(items: ["Photo","Video"])
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
        self.addSubview(MysegmentedControl)
        self.addSubview(cameraSwitchfunc)
        takeButton.snp.makeConstraints { (make) in
            make.centerXWithinMargins.equalToSuperview()
            make.size.equalTo(60)
            make.bottom.equalTo(-5)
        }
        MysegmentedControl.snp.makeConstraints { (make) in
            make.leadingMargin.equalTo(0)
            make.bottomMargin.equalTo(-27)
        }
        cameraSwitchfunc.snp.makeConstraints { (make) in
            make.trailingMargin.equalTo(-20)
            make.bottomMargin.equalTo(-27)
        }
        
    }
    
    
    @objc func showPreview(){
        print("showPreview")
    }
    
}
