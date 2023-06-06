//
//  AddProductViewController.swift
//  Month5HWs
//
//  Created by Jarae on 3/6/23.
//

import UIKit

class AddProductViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var brandTextField: UITextField!
    
    let vc = SearchProductViewController()
    
    @IBAction func addProductButton(_ sender: Any) {
        vc.createProduct(
            name: titleTextField.text ?? "",
            price: priceTextField.text ?? "0",
            desc: descriptionTextField.text ?? ""
        )
        clearTextFields()
    }
    
    private func clearTextFields() {
        self.titleTextField.text = ""
        self.priceTextField.text = ""
        self.descriptionTextField.text = ""
        self.categoryTextField.text = ""
        self.brandTextField.text = ""
    }
}
