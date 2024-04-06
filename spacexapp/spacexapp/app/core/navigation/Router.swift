//
//  Router.swift
//  spacexapp
//
//  Created by Leandro Pontes Berleze on 03/04/24.
//

import Foundation
import SwiftUI

typealias RouteArguments = [Any?]?

struct Route {
    fileprivate let content: (RouteArguments) -> AnyView
    
    init(@ViewBuilder content: @escaping (RouteArguments) -> some View) {
        self.content = { args in AnyView(content(args)) }
    }
}

class Router: ObservableObject {
    @Binding private var path: NavigationPath
    
    private let routes: [String: Route] = appRoutes
    private var arguments: [RouteArguments] = []
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
    
    fileprivate func view(for routeName: String) -> some View {
        let args: RouteArguments = arguments.last ?? []
        return routes[routeName]?.content(args)
    }
    
    func pushNamed(_ appRoute: String, args: RouteArguments = []) {
        arguments.append(args)
        path.append(appRoute)
    }
    
    func pop(count: Int = 1) {
        arguments.removeLast(count)
        path.removeLast(count)
    }
    
    func popToRoot() {
        arguments.removeLast(path.count)
        path.removeLast(path.count)
    }
}

struct RouterView<Content: View>: View {
    @Binding private var path: NavigationPath
    @ObservedObject var router: Router
    
    private let content: Content
    
    init(path: Binding<NavigationPath>, @ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        self._path = path
        self.router = Router(path: path)
    }
    
    var body: some View {
        NavigationStack(path: $path) {
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

