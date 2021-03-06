// DeviceAPIClient.swift
//
// Copyright (c) 2016 Auth0 (http://auth0.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

struct DeviceAPIClient: DeviceAPI {
    
    let session: URLSession
    let url: URL
    let token: String
    
    init(baseUrl: URL, session: URLSession, id: String, token: String) {
        self.url = baseUrl.appendingPathComponent("api/device-accounts/\(id)")
        self.session = session
        self.token = token
    }
    
    func delete() -> Request<Void> {
        return Request(session: session, method: "DELETE", url: url, headers: ["Authorization": "Bearer \(token)"])
    }
    
    func update(deviceIdentifier identifier: String? = nil, name: String? = nil, notificationToken: String? = nil) -> Request<[String: Any]> {
        var payload: [String: Any] = [:]
        payload["identifier"] = identifier
        payload["name"] = name
        if let notificationToken = notificationToken {
            payload["push_credentials"] = [
                "service": "APNS",
                "token": notificationToken
            ]
        }
        return Request(session: session, method: "PATCH", url: url, payload: payload, headers: ["Authorization": "Bearer \(token)"])
    }
}
