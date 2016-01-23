//
//  MainVC.swift
//  PhotoTaker
//
//  Created by vmalikov on 1/23/16.
//  Copyright © 2016 vmalikov. All rights reserved.
//

import UIKit
import Photos

class MainVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageHolder: UIImageView!
    
    let pickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerController.delegate = self
        pickerController.allowsEditing = true
    }

    @IBAction func takePhotoTapped(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            pickerController.sourceType = .Camera
            presentViewController(pickerController, animated: true, completion: nil)
        } else {
            //no camera available
            let alert = UIAlertController(title: "Error", message: "There is no camera available. Use library by default.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: {(alertAction)in
                alert.dismissViewControllerAnimated(true, completion: nil)
                self.loadLatestPhoto()
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        dismissViewControllerAnimated(true, completion: nil)
        setPhoto(image)
    }
    
    @IBAction func loadLatestPhotoTapped(sender: AnyObject) {
        loadLatestPhoto()
    }
    
    func loadLatestPhoto() {
        
        let imgManager = PHImageManager.defaultManager()
        
        // Note that if the request is not set to synchronous
        // the requestImageForAsset will return both the image
        // and thumbnail; by setting synchronous to true it
        // will return just the thumbnail
        let requestOptions = PHImageRequestOptions()
        requestOptions.synchronous = true
        
        // Sort the images by creation date
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: true)]
        
        if let fetchResult: PHFetchResult = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: fetchOptions) {
            
            // If the fetch result isn't empty,
            // proceed with the image request
            if fetchResult.count > 0 {
                // Perform the image request
                imgManager.requestImageForAsset(fetchResult.objectAtIndex(fetchResult.count - 1) as! PHAsset, targetSize: view.frame.size, contentMode: PHImageContentMode.AspectFill, options: requestOptions, resultHandler: { (image, _) in
                    if image != nil {
                        self.setPhoto(image!)
                    } else {
                        // show photo library if there is no available photos
                        self.pickerController.sourceType = .PhotoLibrary
                        self.presentViewController(self.pickerController, animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
    func setPhoto(image: UIImage) {
        imageHolder.image = image
    }
}
