import Foundation
import Alamofire
import Swinject

class NetworkAssembly: Assembly {
  func assemble(container: Container) {
    
    container.register(HTTPClient.self) { r in
      return HTTPClient()
    }
    
    container.register(HTTPRequestAdapter.self) { r in
      let client = r.resolve(HTTPClient.self)!
      let adapter = HTTPClientAdapter(httpClient: client)
      
      var decorated = HTTPRequestAPIKeyDecorator(adapter) as HTTPRequestAdapter
      decorated = HTTPRequestResponseFormatDecorator(decorated)
      
      return decorated
    }
  }
}
