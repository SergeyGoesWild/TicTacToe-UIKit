//
//  ViewController.swift
//  TicTacToe
//
//  Created by Sergey Telnov on 25/10/2024.
//

import UIKit

protocol CellDelegate: AnyObject {
    var activePlayer: String { get set }
    func playerDidClick(id: Int)
}

class MainViewController: UIViewController, CellDelegate {
    
    var gameData: [CellData] = []
    var activePlayer = "❎"
    static let didWinNotification = Notification.Name(rawValue: "didWinNotification")
    static let didRestartNotification = Notification.Name(rawValue: "didRestartNotification")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBoard()
        setupData()
    }
    
    func checkResults() {
        if CheckResultService.shared.checkResult(table: gameData) {
            print("Game OVER")
            sendBlockingNotification()
            AlertService.shared.showAlert(withTitle: "Game Over", withText: "The winner is: \(activePlayer)", on: self, withOkTitle: "Ok", okAction: { [weak self] in
                guard let self = self else { return }
                self.sendCleaningNotification()
                self.gameData = []
                self.setupData()
                CheckResultService.shared.resetCheckResultService()
                self.activePlayer = "❎"
            }
            )
        } else {
            print("Game goes ON")
            switchActivePlayer()
        }
    }
    
    func playerDidClick(id: Int) {
        changeGameData(id: id)
        checkResults()
    }
    
    func switchActivePlayer() {
        if activePlayer == "❎" {
            activePlayer = "🅾️"
        } else {
            activePlayer = "❎"
        }
    }
    
    func changeGameData(id: Int) {
        if let cellToChangeIndex = gameData.firstIndex(where: { $0.id == id }) {
            gameData[cellToChangeIndex].value = activePlayer
        }
        print(gameData)
    }
    
    func setupData() {
        for i in 0 ... 8 {
            gameData.append(CellData(id: i, value: " "))
        }
    }
    
    func sendBlockingNotification() {
        NotificationCenter.default
            .post(
                name: MainViewController.didWinNotification,
                object: nil)
    }
    
    func sendCleaningNotification() {
        NotificationCenter.default
            .post(
                name: MainViewController.didRestartNotification,
                object: nil)
    }
    
    func setupBoard() {
        let cell1 = CellView(frame: CGRect(x: 40, y: 40, width: 100, height: 100), id: 0)
        cell1.backgroundColor = .lightGray
        cell1.delegate = self
        view.addSubview(cell1)
        let cell2 = CellView(frame: CGRect(x: 150, y: 40, width: 100, height: 100), id: 1)
        cell2.backgroundColor = .lightGray
        cell2.delegate = self
        view.addSubview(cell2)
        let cell3 = CellView(frame: CGRect(x: 260, y: 40, width: 100, height: 100), id: 2)
        cell3.backgroundColor = .lightGray
        cell3.delegate = self
        view.addSubview(cell3)
        
        let cell4 = CellView(frame: CGRect(x: 40, y: 150, width: 100, height: 100), id: 3)
        cell4.backgroundColor = .lightGray
        cell4.delegate = self
        view.addSubview(cell4)
        let cell5 = CellView(frame: CGRect(x: 150, y: 150, width: 100, height: 100), id: 4)
        cell5.backgroundColor = .lightGray
        cell5.delegate = self
        view.addSubview(cell5)
        let cell6 = CellView(frame: CGRect(x: 260, y: 150, width: 100, height: 100), id: 5)
        cell6.backgroundColor = .lightGray
        cell6.delegate = self
        view.addSubview(cell6)
        
        let cell7 = CellView(frame: CGRect(x: 40, y: 260, width: 100, height: 100), id: 6)
        cell7.backgroundColor = .lightGray
        cell7.delegate = self
        view.addSubview(cell7)
        let cell8 = CellView(frame: CGRect(x: 150, y: 260, width: 100, height: 100), id: 7)
        cell8.backgroundColor = .lightGray
        cell8.delegate = self
        view.addSubview(cell8)
        let cell9 = CellView(frame: CGRect(x: 260, y: 260, width: 100, height: 100), id: 8)
        cell9.backgroundColor = .lightGray
        cell9.delegate = self
        view.addSubview(cell9)
    }
}

