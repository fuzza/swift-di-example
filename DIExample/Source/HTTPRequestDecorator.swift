import Foundation
import RxSwift

class HTTPRequestAPIKeyDecorator: HTTPRequestAdapter {
  internal let decorated: HTTPRequestAdapter
  
  init(_ decorated: HTTPRequestAdapter) {
    self.decorated = decorated
  }
  
  func execute<T: APIModel>(_ request: HTTPRequest<T>) -> Observable<T> {
    var mutableRequest = request
    mutableRequest.parameters["api_key"] = "e81f61890b7ff8633ca024d0faa449e7"
    return self.decorated.execute(mutableRequest)
  }
}

class HTTPRequestResponseFormatDecorator: HTTPRequestAdapter {
  internal let decorated: HTTPRequestAdapter
  
  init(_ decorated: HTTPRequestAdapter) {
    self.decorated = decorated
  }
  
  func execute<T: APIModel>(_ request: HTTPRequest<T>) -> Observable<T> {
    var mutableRequest = request
    mutableRequest.parameters["format"] = "json"
    return self.decorated.execute(mutableRequest)
  }
}
