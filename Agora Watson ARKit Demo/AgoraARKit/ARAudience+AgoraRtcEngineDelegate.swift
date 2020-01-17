//
//  ARAudience+AgoraRtcEngineDelegate.swift
//  Agora Watson ARKit Demo
//
//  Created by Hermes Frangoudis on 1/14/20.
//  Copyright © 2020 Agora.io. All rights reserved.
//

import AgoraRtcEngineKit

extension ARAudience: AgoraRtcEngineDelegate {
    // MARK: Agora Delegate
    open func rtcEngine(_ engine: AgoraRtcEngineKit, remoteVideoStateChangedOfUid uid: UInt, state: AgoraVideoRemoteState, reason: AgoraVideoRemoteStateReason, elapsed: Int) {
        if state == .starting {
            if self.showLogs {
               print("firstRemoteVideoStarting for Uid: \(uid)")
            }
            print("remote-user: \(String(describing: self.remoteUser))")
            if self.remoteUser == uid {
                guard let remoteView = self.remoteVideoView else { return }
                let videoCanvas = AgoraRtcVideoCanvas()
                videoCanvas.uid = uid
                videoCanvas.view = remoteView
                videoCanvas.renderMode = .hidden
                agoraKit.setupRemoteVideo(videoCanvas)
            }
        } else if state == .decoding {
            if self.showLogs {
               print("firstRemoteVideoDecoded for Uid: \(uid)")
            }
        }
    }
       
    open func rtcEngine(_ engine: AgoraRtcEngineKit, didOccurError errorCode: AgoraErrorCode) {
           if self.showLogs {
               print("error: \(errorCode.rawValue)")
           }
    }
       
    open func rtcEngine(_ engine: AgoraRtcEngineKit, didOccurWarning warningCode: AgoraWarningCode) {
           if self.showLogs {
               print("warning: \(warningCode.rawValue)")
           }
    }
       
    open func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinChannel channel: String, withUid uid: UInt, elapsed: Int) {
        if self.showLogs {
           print("local user did join channel with uid:\(uid)")
        }
    }
       
    open func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinedOfUid uid: UInt, elapsed: Int) {
        if self.showLogs {
           print("remote user joined of uid: \(uid)")
        }
        // TODO: Extend to support more than a single broadcaster
        if self.remoteUser == nil {
            agoraKit.enableVideo()
            self.remoteUser = uid // keep track of the remote user
            if self.debug {
                print("remote host added")
            }
        }
    }
       
    open func rtcEngine(_ engine: AgoraRtcEngineKit, didOfflineOfUid uid: UInt, reason: AgoraUserOfflineReason) {
        if self.showLogs {
           print("remote user did offline of uid: \(uid)")
        }
        if uid == self.remoteUser {
            self.remoteUser = nil
        }
    }
       
    open func rtcEngine(_ engine: AgoraRtcEngineKit, didAudioMuted muted: Bool, byUid uid: UInt) {
           // add logic to show icon that remote stream is muted
        if self.showLogs {
            let state: String = muted ? "muted" : "enabled"
            print("remote user with uid: \(uid) \(state) their mic")
        }
    }
       
    open func rtcEngine(_ engine: AgoraRtcEngineKit, receiveStreamMessageFromUid uid: UInt, streamId: Int, data: Data) {
           // successfully received message from user
           if self.showLogs {
               print("STREAMID: \(streamId)\n - DATA: \(data)")
           }
   }
       
           
    open func rtcEngine(_ engine: AgoraRtcEngineKit, didOccurStreamMessageErrorFromUid uid: UInt, streamId: Int, error: Int, missed: Int, cached: Int) {
           // message failed to send(
           if self.showLogs {
               print("STREAMID: \(streamId)\n - ERROR: \(error)")
           }
   }
}
