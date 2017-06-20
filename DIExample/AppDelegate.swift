import UIKit
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    let assembler = Assembler([ApplicationAssembly()])
    
    let tweeter = assembler.resolver.resolve(Tweeter.self, argument: "alex_fuzza")!
    tweeter.tweet("Hello, #alex_fuzza!")
    
    let timeline = assembler.resolver.resolve(Timeline.self, argument: "alex_fuzza")!
    timeline.loadMore(20)
    _ = timeline.get()
    
    return true
  }
}

