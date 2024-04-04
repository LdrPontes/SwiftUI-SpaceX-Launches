//
//  Router.swift
//  spacexapp
//
//  Created by Leandro Pontes Berleze on 03/04/24.
//

import Foundation
import SwiftUI

struct Route {
    fileprivate let content: AnyView
    
    init(@ViewBuilder content: @escaping () -> some View) {
        self.content = AnyView(content())
    }
}

class Router: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
    
    private let routes: [String: Route] = appRoutes
    
    fileprivate func view(for routeName: String) -> some View {
        routes[routeName]?.content
    }
    
    func pushNamed(_ appRoute: String) {
        path.append(appRoute)
    }
    
    func pop(count: Int = 1) {
        path.removeLast(count)
    }

    func popToRoot() {
        path.removeLast(path.count)
    }
}

struct RouterView<Content: View>: View {
    @StateObject var router: Router = Router()
    
    private let content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            content
                .navigationDestination(for: String.self) { routeName in
                    router.view(for: routeName)
                }
        }
        .environmentObject(router)
    }
}

extension Dictionary {
    static func +(lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
        var mergedDict = lhs
        for (key, value) in rhs {
            mergedDict[key] = value
        }
        return mergedDict
    }
}

