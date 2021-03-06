//
//  CKMessage.swift
//  ChatSDKSwift
//
//  Created by ben3 on 19/07/2020.
//  Copyright © 2020 deluge. All rights reserved.
//

import Foundation
import ChatSDK

@objc public class CKMessage: NSObject, Message {

    let message: PMessage
    
    lazy var sender = CKUser(user: message.user())
    lazy var text = message.text()
    lazy var entityId = message.entityID()
    lazy var date = message.date()
    lazy var type = message.type()?.stringValue
    lazy var meta = message.meta()
    lazy var imageUrl = message.imageURL()
    lazy var direction: MessageDirection = message.senderIsMe() ? .outgoing : .incoming

    @objc public init(message: PMessage) {
        self.message = message
    }
    
    @objc public func messageId() -> String {
        return entityId!
    }

    public func messageDate() -> Date {
        return date!
    }

    @objc public func messageText() -> String? {
        return text
    }

    @objc public func messageSender() -> User {
        return sender
    }

    public func messageImageUrl() -> URL? {
        return imageUrl
    }
    
    public func messageType() -> String {
        return type!
    }
    
    public func messageMeta() -> [AnyHashable: Any]? {
        return meta!
    }
    
    @objc public func messageDirection() -> MessageDirection {
        return direction
    }

    @objc public func messageReadStatus() -> MessageReadStatus {
        if BChatSDK.readReceipt() != nil && messageDirection() == .outgoing {
            if let status = message.messageReadStatus?() {
                if status == bMessageReadStatusRead {
                    return .read
                }
                else if status == bMessageReadStatusDelivered {
                    return .delivered
                }
                else {
                    return .sent
                }
            }
        }
        return .none
    }

}
