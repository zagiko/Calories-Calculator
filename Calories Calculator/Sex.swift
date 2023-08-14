//
//  Sex.swift
//  Calories Calculator
//
//  Created by Mykhailo Zagiko on 14.08.2023.
//

import Foundation


enum Sex: Int, CaseIterable {
    case male = 0
    case female = 1
    
    var title: String {
        switch self {
        case.male:
            return "Male"
        case.female:
            return "Female"
        }
    }
}
