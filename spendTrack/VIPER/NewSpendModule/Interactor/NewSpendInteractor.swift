//
//  NewSpendInteractor.swift
//  spendTrack
//
//  Created by Юрий on 25.02.2023.
//

import Foundation

protocol NewSpendInteractorInput {
    var output: NewSpendInteractorOutput? { get set }
}

protocol NewSpendInteractorOutput: AnyObject {
    
}

final class NewSpendInteractor: NewSpendInteractorInput {
    
    weak var output: NewSpendInteractorOutput?
}
