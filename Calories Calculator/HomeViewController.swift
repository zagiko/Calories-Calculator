//

import UIKit
 
enum Activity: CaseIterable {
    case none
    case low
    case medium
    case high
    
    var title: String {
        switch self {
        case .none:
            return "None"
        case .low:
            return "Low"
        case .medium:
            return "Medium"
        case .high:
            return "High"
        }
    }
    
    var value: Int {
        switch self {
        case .none:
            return 0
        case .low:
            return 50
        case .medium:
            return 150
        case .high:
            return 250
        }
    }
}

class HomeViewController: UIViewController {
    @IBOutlet weak var sexSegmentControl: UISegmentedControl!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var activityField: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    let pickerView = UIPickerView()
    let activites = Activity.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configuresexSegmentControl()
        configureTextFields()
        configureActivityField()
        
        weightField.becomeFirstResponder()
    }
    
    @IBAction func calculateDidTap(_ sender: Any) {
        guard let weight = Int(weightField.text ?? ""),
              let height = Int(heightField.text ?? ""),
              let age = Int(ageField.text ?? ""), weight > 0 && height > 0 && age > 0 else {
            return
        }
        
        let activityIndex = pickerView.selectedRow(inComponent: 0)
        let activity = activites[activityIndex]
        var activityValue = activity.value
        
        let selectedSex = sexSegmentControl.selectedSegmentIndex
        var result = ""
        switch selectedSex {
        case 0:
            let result = Double(10 * weight) + (6.25 * Double(height)) - Double(5 * age) + 5.0 + Double(activityValue)
            showAlertWith(title:String(result))
        case 1:
            let result = Double(8 * weight) + (5.25 * Double(height)) - Double(5 * age) + 5 - 161 + Double(activityValue)
            showAlertWith(title:String(result))
        default: break
            
        }
        
    }
    
    func showAlertWith(title: String) {
        let alert = UIAlertController(title: "Your result", message: title, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .cancel))
        self.present(alert, animated: true)
    }
    
    @IBAction func sexControlDidChange(_ sender: UISegmentedControl) {
        //        switch sender.selectedSegmentIndex {
        //        case 0:
        //            break
        //
        //        case 1:
        //            break
        //
        //        default: break
        //
        //        }
        
        clear()
    }
    
    
    @IBAction func clearDidTap(_ sender: Any) {
        clear()
    }
    
    func clear() {
        weightField.text = nil
        heightField.text = nil
        ageField.text = nil
        pickerView.selectRow(0, inComponent: 0, animated: true)
        selectActivityBy(row: 0)
        weightField.becomeFirstResponder()
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
        activityField.text = activites[row].title
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
        return activites[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectActivityBy(row: row)
    }
}
