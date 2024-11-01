//
//  ViewController.swift
//  TicTacToe
//
//  Created by Sergey Telnov on 25/10/2024.
//

import UIKit

protocol CellDelegate: AnyObject {
    var activePlayer: String { get set }
    func playerDidClick()
}

class MainViewController: UIViewController, CellDelegate {
    
    let gameData = [[" ", " ", " "],
                    [" ", " ", " "],
                    [" ", " ", " "]]
    
    var activePlayer = "x"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBoard()
    }
    
    func checkResults() {
        if CheckResultService.shared.checkResult(table: gameData) {
            print("Game OVER")
        } else {
            print("Game goes ON")
        }
    }
    
    func playerDidClick() {
        switchActivePlayer()
        checkResults()
    }
    
    func switchActivePlayer() {
        if activePlayer == "x" {
            activePlayer = "o"
        } else {
            activePlayer = "x"
        }
    }
    
    func setupBoard() {
        let cell1 = CellView(frame: CGRect(x: 40, y: 40, width: 100, height: 100))
        cell1.backgroundColor = .lightGray
        cell1.delegate = self
        view.addSubview(cell1)
        let cell2 = CellView(frame: CGRect(x: 150, y: 40, width: 100, height: 100))
        cell2.backgroundColor = .lightGray
        cell2.delegate = self
        view.addSubview(cell2)
        let cell3 = CellView(frame: CGRect(x: 260, y: 40, width: 100, height: 100))
        cell3.backgroundColor = .lightGray
        cell3.delegate = self
        view.addSubview(cell3)
        
        let cell4 = CellView(frame: CGRect(x: 40, y: 150, width: 100, height: 100))
        cell4.backgroundColor = .lightGray
        cell4.delegate = self
        view.addSubview(cell4)
        let cell5 = CellView(frame: CGRect(x: 150, y: 150, width: 100, height: 100))
        cell5.backgroundColor = .lightGray
        cell5.delegate = self
        view.addSubview(cell5)
        let cell6 = CellView(frame: CGRect(x: 260, y: 150, width: 100, height: 100))
        cell6.backgroundColor = .lightGray
        cell6.delegate = self
        view.addSubview(cell6)
        
        let cell7 = CellView(frame: CGRect(x: 40, y: 260, width: 100, height: 100))
        cell7.backgroundColor = .lightGray
        cell7.delegate = self
        view.addSubview(cell7)
        let cell8 = CellView(frame: CGRect(x: 150, y: 260, width: 100, height: 100))
        cell8.backgroundColor = .lightGray
        cell8.delegate = self
        view.addSubview(cell8)
        let cell9 = CellView(frame: CGRect(x: 260, y: 260, width: 100, height: 100))
        cell9.backgroundColor = .lightGray
        cell9.delegate = self
        view.addSubview(cell9)
    }
}

