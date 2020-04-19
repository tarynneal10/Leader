//
//  SignUpVC.swift
//  Leader
//
//  Created by Taryn Neal on 9/5/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage

class SignUpVC : UITableViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var positionTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var chapterTF: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var gradeTextField: UITextField!
    
    @IBOutlet weak var termsButton: UIButton!
    @IBOutlet weak var checkmarkButton: UIButton!
    
    var takeImage: UIImageView!
    var imagePicker: UIImagePickerController!
    var signUpSuccess : Bool?
    var agreed : Bool?
    
    var db: Firestore!
    var storage : Storage!
    
    var filePath = ""
    var download : String?
    var docID : String?
    
    override func viewDidAppear( _ animated: Bool) {
        super.viewDidAppear(animated)
        signUpSuccess = false
        agreed = false
        
        db = Firestore.firestore()
        storage = Storage.storage()
        
        setFontColor()
    }
    func setFontColor() {
        let attrs1 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.white]

        let attrs2 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.init(red: 0, green: 122, blue: 255)]

        let attributedString1 = NSMutableAttributedString(string:"Agree to Leader's", attributes:attrs1)

        let attributedString2 = NSMutableAttributedString(string:" Terms of Use", attributes:attrs2)

        attributedString1.append(attributedString2)
        termsButton.setAttributedTitle(attributedString1, for: .normal)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if identifier == "goToTabs" {
            //Might be able to have it just return false here and oerform segu e in else for auth- not yet tho
            if signUpSuccess != true {
                return false
            }
        }
        return true
    }
    
//Putting up higher bc camera area is a mess
    
    @IBAction func checkmarkPressed(_ sender: Any) {
        if agreed == false {
            checkmarkButton.setImage(UIImage(named: "Checkmark"), for: .normal)
            agreed = true
        } else {
            checkmarkButton.setImage(UIImage(named: "Nothing"), for: .normal)
            agreed = false
        }
    }
    
//MARK: Sign up pressed
    @IBAction func signUpPressed(_ sender: Any) {
        signUpSuccess = false
        if emailTextField.text != "", passwordTextField.text != "", chapterTF.text != "", nameTF.text != "", positionTF.text != "", gradeTextField.text != "", agreed != false
        {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) {
                (user, error) in
                if error != nil {
                    print(error!)
                    self.errorAlert()
                }
                else {
                    //success
                    print("Registration successful")

                    guard let userID = Auth.auth().currentUser?.uid else { return }
                    var ref: DocumentReference? = nil
                    ref = self.db.collection("members").addDocument(data: [
                        "name": self.nameTF.text!,
                        "position": self.positionTF.text!,
                        "chapter": self.chapterTF.text!,
                        "grade": self.gradeTextField.text!,
                        "paid": true,
                        "user UID": userID,
                        "competitive events": [""],
                        "current events": [""]
                    ]) { err in
                        if let err = err {
                            print("Error adding document: \(err)")
                        } else {
                            print("Document added with ID: \(ref!.documentID)")
                            self.docID = ref!.documentID
                        }
                    }
                    self.showCamera()
                    
                }
            }

            
        } else {
            errorAlert()
        }
        
    }
    func errorAlert() {
        let alert = UIAlertController(title: "Error", message: "Please reenter your information.", preferredStyle: .alert)
        
        let tryAgainAction = UIAlertAction(title: "Try Again", style: .default, handler: { (UIAlertAction) in
            
        })
        
        alert.addAction(tryAgainAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: Camera methods
    func showCamera() {
            if self.positionTF.text != "Member" {
                let profileImagePicker = UIImagePickerController()
                profileImagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                profileImagePicker.delegate = self
                present(profileImagePicker, animated: true, completion: nil)

            }
        self.signUpSuccess = true
        self.performSegue(withIdentifier: "goToTabs", sender: UIButton.self)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let profileImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage, let optimizedImageData = profileImage.jpegData(compressionQuality: 0.6)
        {
            // upload image from here
            uploadProfileImage(imageData: optimizedImageData)
        }
        picker.dismiss(animated: true, completion:nil)

       // takeImage.image = info[.originalImage] as? UIImage
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion:nil)
    }
    func uploadProfileImage(imageData: Data) {
        let activityIndicator = UIActivityIndicatorView.init(style: .gray)
        activityIndicator.startAnimating()
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        
        
        let storageReference = Storage.storage().reference()
        let currentUser = Auth.auth().currentUser
        let profileImageRef = storageReference.child("officers").child("\(currentUser!.uid)-profileImage.jpg")
        
        download = "gs://leader-8bab1.appspot.com/officers/\(currentUser!.uid)-profileImage.jpg"
        addDownloadURl()
        
        //Metadata stuff
        let uploadMetaData = StorageMetadata()
        uploadMetaData.contentType = "image/jpeg"
        
        profileImageRef.putData(imageData, metadata: uploadMetaData) { (uploadedImageMeta, error) in
           
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            
            if error != nil
            {
                print("Error took place \(String(describing: error?.localizedDescription))")
                return
            } else {
    
                print("Meta data of uploaded image \(String(describing: uploadedImageMeta))")
            }
        }
    }
    
    func addDownloadURl() {
        if docID != nil {
            let reference = db.collection("members").document(docID!)
            reference.updateData([
                "imageURL": download!
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
        }
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            print("Image saved")
        }
        
    }

}
