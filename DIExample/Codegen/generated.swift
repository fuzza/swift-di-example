// Generated using Sourcery 0.7.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


import Foundation
import Swinject





class ApplicationAssembly: Assembly {
  func assemble(container: Container) {
    container.register(HTTPClient.self) { r in
      return HTTPClient()
    }.inObjectScope(.container)

    container.register(Timeline.self) { r, name in
      return Timeline(
        twitterApi: r.resolve(TwitterAPI.self)!, 
        name: name
      )
    }.inObjectScope(.transient)

    container.register(Tweeter.self) { r, name in
      return Tweeter(
        twitterApi: r.resolve(TwitterAPI.self)!, 
        name: name
      )
    }.inObjectScope(.transient)

    container.register(TwitterAPI.self) { r in
      return TwitterAPI(
        httpClient: r.resolve(HTTPClient.self)!
      )
    }.inObjectScope(.container)

  }
}
