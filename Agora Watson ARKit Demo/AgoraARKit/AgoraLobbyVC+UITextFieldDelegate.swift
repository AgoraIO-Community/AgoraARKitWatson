//
//  ViewController+UITextFieldDelegate.swift
//  Agora-ARKit Framework
//
//  Created by Hermes Frangoudis on 1/14/20.
//  Copyright © 2020 Agora.io. All rights reserved.
//

import UIKit

extension AgoraLobbyVC: UITextFieldDelegate {
    // MARK: Textfield Delegates
    open func textFieldDidBeginEditing(_ textField: UITextField) {
        if debug {
            print("TextField did begin editing method called")
        }
    }

    open func textFieldDidEndEditing(_ textField: UITextField) {
        if debug {
            print("TextField did end editing method called")
        }
    }

    open func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if debug {
            print("TextField should begin editing method called")
        }
        return true;
    }

    open func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if debug {
            print("TextField should clear method called")
        }
        return true;
    }

    open func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if debug {
            print("TextField should snd editing method called")
        }
        return true;
    }

    open func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if debug {
            print("While entering the characters this method gets called")
        }
        return true;
    }

    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if debug {
            print("TextField should return method called")
        }
        textField.resignFirstResponder();
        return true;
    }
}
