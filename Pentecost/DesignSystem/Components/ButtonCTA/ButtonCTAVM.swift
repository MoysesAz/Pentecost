//
//  ButtonCTAVM.swift
//  Pentecost
//
//  Created by Moyses Miranda do Vale Azevedo on 12/03/24.
//

import Foundation


final class ButtonCTAVM: ObservableObject {
    @Published public var isLoading: Bool = false
    @Published public var disable: Bool = false

    init(isLoading: Bool, disable: Bool) {
        self.isLoading = isLoading
        self.disable = disable
    }
}

