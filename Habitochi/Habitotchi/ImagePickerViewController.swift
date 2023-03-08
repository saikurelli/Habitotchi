//
//  ImagePickerViewController.swift
//  Habitotchi
//
//  Created by Cole Harper on 3/6/23.
//

import UIKit
import PhotosUI
import Photos

class ImagePickerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PHPickerViewControllerDelegate {
    
    
    var signInDelegate : SignInViewController!
    var profileEditDelegate : ProfileViewController!
    var signin : Bool!
    var cameraMode : Bool!
    var finished = false
    var cancel = false
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = .clear
        view.isOpaque = false
        if !finished && !cancel{
            if cameraMode{
                openCamera()
            }else{
                openPhotoLibrary()
            }
        }
    }
    
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.isEditing = false
            imagePicker.modalPresentationStyle = .fullScreen
            self.present(imagePicker, animated: true)
        }
        
    }
    
    func openPhotoLibrary(){
         var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = PHPickerFilter.images
        
        let pickerView = PHPickerViewController(configuration: config)
        pickerView.delegate = self
        self.present(pickerView, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true)
        guard let image = info[.originalImage] as? UIImage else {
            print("Image not found")
            return
        }
        if signin{
            signInDelegate.changeImage(image: image)
        }else {
            profileEditDelegate.changeImage(image: image)
        }
        self.finished = true
        dismiss(animated: false)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        cancel = true
        picker.dismiss(animated: true)
        dismiss(animated: false)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        if results.isEmpty {
            cancel = true
            picker.dismiss(animated: true)
            self.dismiss(animated: false)
        }
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { (object, error) in
                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        if self.signin{
                            self.signInDelegate.changeImage(image: image)
                        }else{
                            self.profileEditDelegate.changeImage(image: image)
                        }
                        picker.dismiss(animated: true)
                        self.dismiss(animated: false)
                    }
                }
                
            })
        }
    }
    
    
    

}
