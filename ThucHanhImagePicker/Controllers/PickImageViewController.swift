//
//  PickImageViewController.swift
//  ThucHanhImagePicker
//
//  Created by Hoàng Đức on 18/11/2022.
//

import UIKit
import Photos


class PickImageViewController: UIViewController {
    @IBOutlet weak var avatarImage: UIImageView!
    
    @IBOutlet weak var setAvatarButton: UIButton!
    
    @IBOutlet weak var fullNameTextField: UITextField!
    
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var doneButton: UIButton!
    var index: Int?
    
    var infomation: Infomation = Infomation(imageName: UIImageView.init(image: UIImage(named: "")), name: "", age: "")
    var handelSave: ((Infomation) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Set Info"
        makeCircle()
        ageTextField.inputAccessoryView = doneButton
    }
    func makeCircle() {
        avatarImage.layer.cornerRadius = avatarImage.bounds.width/2
        avatarImage.layer.borderWidth = 0.3
        setAvatarButton.layer.cornerRadius = 15
    }

    @IBAction func didTapSetAvaTarButton(_ sender: Any) {
        let alert = UIAlertController(title: "Avatar", message: "Choose one", preferredStyle: .actionSheet)
    
        let actionLibrary = UIAlertAction(title: "Thư viện", style: .default) { [weak self] _ in
            guard let `self` = self else {
                return
            }
            
            self.selectPhotoGallery()
        }
        let actionCamera = UIAlertAction(title: "Máy ảnh", style: .default) { [weak self] _ in
            guard let `self` = self else {
                return
            }
            
            self.takeByCamera()
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(actionLibrary)
        alert.addAction(actionCamera)
        alert.addAction(actionCancel)
        
        present(alert, animated: true)
        
    }
    
    func selectPhotoGallery() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func takeByCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    
    @IBAction func didTapDoneButton(_ sender: Any) {
        view.endEditing(true)
        if fullNameTextField.text != nil && ageTextField.text != nil {
            infomation.name = fullNameTextField.text ?? ""
            infomation.age = ageTextField.text ?? ""
            infomation.imageName?.image = avatarImage.image
            handelSave?(infomation)
            navigationController?.popViewController(animated: true)
        }
    }
    
}
extension PickImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            avatarImage.image = image
        }
        picker.dismiss(animated: true, completion:  nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion:  nil)
    }
}
