//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var sexSegmentControl: UISegmentedControl!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var activityField: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    let pickerView = UIPickerView()
    
    let activites = ["None", "Low", "Medium", "High"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configuresexSegmentControl()
        configureTextFields()
        configureActivityField()
        
        weightField.becomeFirstResponder()
    }
    @IBAction func calculateDidTap(_ sender: Any) {
    }
    
    @IBAction func clearDidTap(_ sender: Any) {
    }
    
    func configuresexSegmentControl() {
        sexSegmentControl.removeAllSegments()
        sexSegmentControl.insertSegment(withTitle: "Male", at: 0, animated: false)
        sexSegmentControl.insertSegment(withTitle: "Female", at: 1, animated: false)
        sexSegmentControl.selectedSegmentIndex = 0
    }

    func configureTextFields() {
        weightField.delegate = self
        weightField.keyboardType = .numberPad
        
        heightField.delegate = self
        heightField.keyboardType = .numberPad
        
        ageField.delegate = self
        ageField.keyboardType = .numberPad
    }
    
    func configureActivityField() {
        pickerView.dataSource = self
        pickerView.delegate = self
        activityField.inputView = pickerView
        selectActivityBy(row: 0)
    }
    
    func selectActivityBy(row: Int) {
        activityField.text = activites[row]
    }
    
}

extension HomeViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    
    }
}

extension HomeViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return activites.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return activites[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectActivityBy(row: row)
    }
}
