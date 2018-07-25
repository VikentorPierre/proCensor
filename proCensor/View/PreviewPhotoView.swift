//
//  PreviewPhotoView.swift
//  proCensor
//
//  Created by Vikentor Pierre on 7/24/18.
//  Copyright © 2018 mosDev. All rights reserved.
//

import UIKit
import SnapKit

class PreviewPhotoView: UIView {
    
    var takenPhoto: UIImage? // gloable
    
    let previewView: UIImageView = {
        let obj = UIImageView()
        obj.backgroundColor = .blue
        return obj
    }()
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPreview()
        
        if let aviliableImage =  takenPhoto {
            previewView.image = aviliableImage
        }
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func setupPreview(){
        self.addSubview(previewView)
        previewView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    
    }
    
    
    


}
