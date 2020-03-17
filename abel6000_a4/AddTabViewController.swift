//
//  AddTabViewController.swift
//  abel6000_a3
//
//  Created by Adriana Abella on 2020-02-15.
//  Copyright © 2020 wlu. All rights reserved.
//

import UIKit
import os.log

class AddTabViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate
{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var TextField: UITextField!
    @IBOutlet weak var nameFruit: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    let imagePickerController = UIImagePickerController()
    
    var showingImage = UIImage(named: "question.png")
    
    var uploadedImage : UIImage!
    
    var fruit : Fruit?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        saveButton.isEnabled = false

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = showingImage
        TextField.delegate = self
        saveButton.isEnabled = false
        
        // Do any additional setup after loading the view.
    }
    
    func getFruit() -> Fruit {
        return self.fruit!
    }
    
    func textFieldData(_ TextField: UITextField) -> Bool {
        self.view.endEditing(true)
        if (TextField.text != "")
        {
            saveButton.isEnabled = true
        }
        return false
    }
    
    @IBAction func imageTapped(_ sender: Any) {
        print("Image was touched")
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        //choose image
        guard let uploadedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage else{ return }
        
        //The chosen image will now be displayed
        imageView.image = uploadedImage
        
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
            return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
    }
        
       
    func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
            return input.rawValue
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        dismiss(animated: true, completion: nil)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
       textField.resignFirstResponder()
       return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
         // Disable the Save button while editing.
        saveButton.isEnabled = false
        TextField.becomeFirstResponder()
     }

     func textFieldDidEndEditing(_ textField: UITextField) {
        let text = TextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
//    @IBAction func addFruit(_ sender: Any) {
//        // check if a picture was chosed and text entered
//        if (TextField.text == "" || showingImage == nil){
//            print("Picture or text not found.")
//        }
//        else{
//            let newFruit = Fruit(fruitName: TextField.text!, fruitImage: showingImage!, likes: 0, dislikes: 0)
//            
//            sharedFruitCollection!.addFruit(fruit: newFruit!)
//            
//            let alert = UIAlertController(title: "Success!!!", message: "Fruit: '\(newFruit!.fruitName)' Added.", preferredStyle: .alert)
//            
//            alert.addAction(UIAlertAction(title: "Great!", style: .default, handler: nil))
//            
//            self.present(alert, animated: true)
//            
//            TextField.text = ""
//            imageView.image = UIImage(named: "question.png")
//        }
//    }
    @IBAction func cancelFruit(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
        os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
        return }
        
        guard let name = nameFruit.text else {
             print("Error: No text")
             return
         }
        
         guard let picture = imageView.image else {
             print("Error: No image")
             return
         }

        fruit = Fruit(fruitName: name, fruitImage: picture, likes: 0, dislikes: 0)
    }

}
