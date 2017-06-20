import Foundation
import Alamofire

struct HTTPRequest<Response>: URLRequestConvertible {
  let endpoint: String
  let responseType: Response.Type
  let method: HTTPMethod
  var parameters: Parameters
  var headers: HTTPHeaders
  
  init(endpoint: String,
       responseType: Response.Type,
       method: HTTPMethod = .get,
       parameters: Parameters = [:],
       headers: HTTPHeaders = [:]) {
    self.endpoint = endpoint
    self.responseType = responseType
    self.method = method
    self.parameters = parameters
    self.headers = headers
  }
  
  func asURLRequest() throws -> URLRequest {
    let url = try endpoint.asURL()
    var urlRequest = URLRequest(url: url)
    
    urlRequest.httpMethod = method.rawValue
    for (key, value) in headers {
      urlRequest.setValue(value, forHTTPHeaderField: key)
    }
    
    urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
    return urlRequest
  }
}
