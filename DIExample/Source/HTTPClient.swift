import Foundation
import Alamofire
import RxSwift
import AlamofireObjectMapper

typealias HTTPClient = SessionManager

protocol HTTPRequestAdapter {
  func execute<T: APIModel>(_ request: HTTPRequest<T>) -> Observable<T>
}

class HTTPClientAdapter {
  fileprivate let httpClient: HTTPClient

  init(httpClient: HTTPClient) {
    self.httpClient = httpClient
  }
}

extension HTTPClientAdapter: HTTPRequestAdapter {
  func execute<T: APIModel>(_ request: HTTPRequest<T>) -> Observable<T> {
    return Observable.create(subscribe(request))
  }
  
  func subscribe<T: APIModel>(_ request: HTTPRequest<T>) ->
    (AnyObserver<T>) -> Disposable {
      return { [unowned self] subscriber in
        let cancellable = self.httpClient.request(request)
          .validate()
          .responseObject { (response: DataResponse<T>) in
            switch response.result {
            case .success(let value):
              subscriber.onNext(value)
            case .failure(let error):
              subscriber.onError(error)
            }
        }
        return Disposables.create {
          cancellable.cancel()
        }
      }
  }
}
