//
//  ProjectDataVM.swift
//  Feivan
//
//  Created by javigo on 9/2/22.
//

import CoreData
import Foundation

class ProjectDataVM: ObservableObject {
    private let context = PersistenceController.shared

    @Published var project: ProjectViewModel = ProjectViewModel()
    @Published var client: ClientViewModel = ClientViewModel()
    @Published var products: [ProductViewModel] = []
    
    init() {
        print("Nuevo proyecto creado")
    }

    
}
