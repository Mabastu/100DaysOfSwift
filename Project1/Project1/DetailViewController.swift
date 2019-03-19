//
//  DetailViewController.swift
//  Project1
//
//  Created by Mabast on 2/18/19.
//  Copyright © 2019 Mabast. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var countedImage: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = countedImage
        navigationItem.largeTitleDisplayMode = .never
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

}





