//
//  ViewController.swift
//  TicTacToe
//
//  Created by Sergey Telnov on 25/10/2024.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cell = CellView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        cell.backgroundColor = .blue
        cell.center = view.center // Center it in the main view
        view.addSubview(cell)
    }
    
}

