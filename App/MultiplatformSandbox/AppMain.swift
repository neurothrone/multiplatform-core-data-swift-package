//
//  AppMain.swift
//  MultiplatformSandbox
//
//  Created by Zaid Neurothrone on 2022-12-15.
//

import SwiftUI

@main
struct AppMain: App {
  let persistenceController = PersistenceController.shared
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
  }
}
