//
//  ViewController.swift
//  Auto Layout 101
//
//  Created by Andrei Puni on 02/09/15.
//  Copyright © 2015 Andrei Puni. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet var top: NSLayoutConstraint!
    @IBOutlet var leading: NSLayoutConstraint!
    @IBOutlet var trailing: NSLayoutConstraint!
    @IBOutlet var bottom: NSLayoutConstraint!

    @IBOutlet var redView: UIView!
    
    @IBOutlet var stackView: UIView!
    @IBOutlet var centerY: NSLayoutConstraint!

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

