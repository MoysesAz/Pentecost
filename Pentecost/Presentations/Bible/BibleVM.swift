//
//  ViewModel.swift
//  Pentecost
//
//  Created by Moyses Miranda do Vale Azevedo on 05/02/24.
//

import Foundation
import Domain
import Application
import Infra

final class BibleVM {
    var bibleXML: BibleXML

    init() {
        let xmlGenerator = XmlGenerator()
        let usecase = GetBibleUseCase(repository: xmlGenerator)
        self.bibleXML = usecase.getKingJames()
    }
}
