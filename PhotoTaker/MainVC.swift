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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loadLatestPhoto(sender: AnyObject) {
        let picker = getPickerController(UIImagePickerControllerSourceType.PhotoLibrary)
        presentViewController(picker, animated: true, completion: nil)

    }

    @IBAction func takePhotoPressed(sender: AnyObject) {
        let picker = getPickerController(UIImagePickerControllerSourceType.Camera)
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func getPickerController(sourceType: UIImagePickerControllerSourceType) -> UIImagePickerController {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = sourceType
        pickerController.allowsEditing = true
        return pickerController
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.delegate = nil
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.dismissViewControllerAnimated(true, completion: nil)
        imageHolder.image = image
    }
}
