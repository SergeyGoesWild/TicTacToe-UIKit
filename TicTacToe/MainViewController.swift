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
        var cellArray: [CellView] = []
        var stackViewArray: [UIStackView] = []
        
        for i in 0...8 {
            let cell = CellView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), id: i)
            cell.delegate = self
            cell.backgroundColor = UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1.00)
            cell.layer.cornerRadius = 10
            cell.clipsToBounds = true
            cell.widthAnchor.constraint(equalToConstant: 100).isActive = true
            cellArray.append(cell)
        }
        for j in stride(from: 0, through: 6, by: 3) {
            let stackView = UIStackView(arrangedSubviews: [cellArray[j], cellArray[j+1], cellArray[j+2]])
            stackView.axis = .horizontal
            stackView.spacing = 10
            stackView.translatesAutoresizingMaskIntoConstraints = false
//            stackView.backgroundColor = .blue
            stackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            stackViewArray.append(stackView)
        }
        
        let globalStackView = UIStackView(arrangedSubviews: [stackViewArray[0], stackViewArray[1], stackViewArray[2]])
        globalStackView.axis = .vertical
        globalStackView.spacing = 10
        globalStackView.translatesAutoresizingMaskIntoConstraints = false
//        globalStackView.backgroundColor = .red
        view.addSubview(globalStackView)
        NSLayoutConstraint.activate([
            globalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            globalStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            globalStackView.heightAnchor.constraint(equalToConstant: (100 * 3) + (10 * 2)),
            globalStackView.widthAnchor.constraint(equalToConstant: (100 * 3) + (10 * 2))
        ])
    }
}

