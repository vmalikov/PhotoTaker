//
//  MainVC.swift
//  PhotoTaker
//
//  Created by vmalikov on 1/23/16.
//  Copyright © 2016 vmalikov. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageHolder: UIImageView!
    
    let pickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerController.delegate = self
        pickerController.allowsEditing = true
    }
    
    @IBAction func loadLatestPhotoTapped(sender: AnyObject) {
        loadLatestPhoto()
    }

    @IBAction func takePhotoTapped(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            pickerController.sourceType = .Camera
            presentViewController(pickerController, animated: true, completion: nil)
        } else {
            NSLog("Unfortunately you can't use the camera.")
            loadLatestPhoto()
        }
    }
    
    func loadLatestPhoto() {
        pickerController.sourceType = .PhotoLibrary
        presentViewController(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        dismissViewControllerAnimated(true, completion: nil)
        imageHolder.image = image
    }
}
