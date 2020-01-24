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

class SignUpVC : UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var positionTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var chapterTF: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var gradeTextField: UITextField!
    
    var takeImage: UIImageView!
    var imagePicker: UIImagePickerController!
    var signUpSuccess : Bool?
    var db: Firestore!
    var storage : Storage!
    var filePath = ""
    var download : URL?
    var docID : String?
    
    override func viewDidAppear( _ animated: Bool) {
        super.viewDidAppear(animated)
        signUpSuccess = false
        db = Firestore.firestore()
        storage = Storage.storage()

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
//MARK: Sign up pressed
    @IBAction func signUpPressed(_ sender: Any) {
        signUpSuccess = false
        if emailTextField.text != "", passwordTextField.text != "", chapterTF.text != "", nameTF.text != "", positionTF.text != "", gradeTextField.text != ""
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
                        "user UID": userID
                    ]) { err in
                        if let err = err {
                            print("Error adding document: \(err)")
                        } else {
                            print("Document added with ID: \(ref!.documentID)")
                            self.docID = ref!.documentID
                        }
                    }
                    self.showCamera()
                    self.signUpSuccess = true
                    self.performSegue(withIdentifier: "goToTabs", sender: UIButton.self)
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
                self.imagePicker =  UIImagePickerController()
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = .camera

                self.present(self.imagePicker, animated: true, completion: nil)
            }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        
        //Saving Image
        guard let yourImage = info[.originalImage] as? UIImage else { return }
        UIImageWriteToSavedPhotosAlbum(yourImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        
        //Selecting file path
        var photoURL : URL?
        if (picker.sourceType == UIImagePickerController.SourceType.camera) {

            let imgName = UUID().uuidString
            let documentDirectory = NSTemporaryDirectory()
            let localPath = documentDirectory.appending(imgName)
            photoURL = URL.init(fileURLWithPath: localPath)
            print("PhotoURL: \(String(describing: photoURL))")

        }
        
        //Uploading image
        guard let localFile = photoURL else { return }
        let ref = storage.reference().child("images/officer.png")
        let uploadTask = ref.putFile(from: localFile, metadata: nil) { metadata, error in
            print("Image Uploaded")
              ref.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        print(error!)
                      return
            }
                    print("downloadURL: \(downloadURL)")
                    self.download = downloadURL
                    self.addDownloadURl()
                }
            }
        

       // takeImage.image = info[.originalImage] as? UIImage
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
