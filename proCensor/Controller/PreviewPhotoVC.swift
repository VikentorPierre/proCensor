//
//  PreviewPhotoVC.swift
//  proCensor
//
//  Created by Vikentor Pierre on 7/24/18.
//  Copyright © 2018 mosDev. All rights reserved.
//

import UIKit

class PreviewPhotoVC: UIViewController {
    
    let previewView: PreviewPhotoView = PreviewPhotoView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
    override func loadView() {
        super.loadView()
        self.view = previewView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
