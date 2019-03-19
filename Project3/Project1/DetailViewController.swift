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
        
        //sharebutton arrow!
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        
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
    
    
    //share action method in objective C
    @objc func shareTapped(){
      guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        let vc = UIActivityViewController(activityItems: ["image as Any",image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

}





