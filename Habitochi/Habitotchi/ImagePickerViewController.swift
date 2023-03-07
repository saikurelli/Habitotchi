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
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !finished{
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
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { (object, error) in
                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        if self.signin{
                            self.signInDelegate.changeImage(image: image)
                        }else{
                            self.profileEditDelegate.changeImage(image: image)
                        }
                        picker.dismiss(animated: false)
                        self.dismiss(animated: true)
                    }
                }
                
            })
        }
    }
    
    func configureProfilePicture(width: Int, height: Int, newImage : UIImage) -> UIImage{
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        //let radius = CGRectGetWidth(view.frame) / 2
        view.layer.borderWidth = 1
            view.layer.masksToBounds = false
            view.layer.borderColor = UIColor.white.cgColor
            view.layer.cornerRadius = view.frame.height/2
            view.clipsToBounds = true
        
        view.image = newImage
        
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        let newImage = renderer.image { ctx in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        
        return newImage
        }
}
