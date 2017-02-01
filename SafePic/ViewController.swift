//
//  ViewController.swift
//  SafePic
//
//  Created by Justin Doan on 1/31/17.
//  Copyright © 2017 Justin Doan. All rights reserved.
//

import UIKit
import MobileCoreServices
import SCLAlertView
import PMAlertController

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    
    let prefs = UserDefaults.standard
    
    
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        //imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        imagePicker.mediaTypes = [kUTTypeImage as String]
        imagePicker.allowsEditing = false
 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if prefs.object(forKey: "pw") == nil {
           
            let alertVC = PMAlertController(title: "PASSWORD", description: "Create a password", image: nil, style: .alert)
            alertVC.addTextField { (textField) in
                textField?.placeholder = "password"
                textField?.keyboardType = .numberPad
            }
            
            alertVC.addAction(PMAlertAction(title: "Create", style: .default, action: { () in
                if let pw = alertVC.textFields[0].text {
                    self.prefs.set(pw, forKey: "pw")
                }
            }))
            
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func add(_ sender: Any) {
        
        let alertVC = PMAlertController(title: "PASSWORD", description: "Enter password", image: nil, style: .alert)
        
        alertVC.addTextField { (textField) in
            textField?.placeholder = "password"
            textField?.keyboardType = .numberPad
        }
        
        alertVC.addAction(PMAlertAction(title: "Enter", style: .default, action: { () in
            if let pw = alertVC.textFields[0].text {
                if pw == self.prefs.value(forKey: "pw") as! String {
                    self.dismiss(animated: true, completion: nil)
                    self.present(self.imagePicker, animated: true, completion: nil)
                }
            }
        }))
        
        
         alertVC.addAction(PMAlertAction(title: "Cancel", style: .cancel, action: { () -> Void in
            print("Capture action Cancel")
         }))
        
        self.present(alertVC, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        
        if mediaType.isEqual(to: kUTTypeImage as String) {
            
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            imageView.image = image
            
        } else if mediaType.isEqual(to: kUTTypeMovie as String) {
            
            let url = info[UIImagePickerControllerMediaURL]
            
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }


}

