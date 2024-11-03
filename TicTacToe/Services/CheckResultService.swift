//
//  CheckResultService.swift
//  TicTacToe
//
//  Created by Sergey Telnov on 30/10/2024.
//

import Foundation

struct CellData {
    let id: Int
    var value: String
}

final class CheckResultService {
    
    static let shared = CheckResultService()
    private init() {}
    
    private var globalDidWin = false
    private var localDidWin = false
    
    func resetCheckResultService() {
        globalDidWin = false
        localDidWin = false
    }
    
    func checkResult(table: [CellData]) -> Bool {
        //horizontal
        for i in stride(from: 0, through: 6, by: 3) {
            if table[i].value == " " {
                localDidWin = false
                continue
            }
            for j in 1 ... 2 {
                if table[i].value != table[i+j].value {
                    localDidWin = false
                    break
                } else {
                    localDidWin = true
                }
            }
            if localDidWin {
                globalDidWin = true
                break
            }
        }
        if globalDidWin {
            return true
        }
        
        //vertical
        for i in 0 ... 2 {
            if table[i].value == " " {
                localDidWin = false
                continue
            }
            for j in stride(from: 3, through: 6, by: 3) {
                if table[i].value != table[i+j].value {
                    localDidWin = false
                    break
                } else {
                    localDidWin = true
                }
            }
            if localDidWin {
                globalDidWin = true
                break
            }
        }
        if globalDidWin {
            return true
        }
        
        //diagonal 01
        for i in stride(from: 0, through: 4, by: 4) {
            if table[i].value == " " {
                localDidWin = false
                break
            }
            if table[i].value != table[i+4].value {
                localDidWin = false
                break
            } else {
                localDidWin = true
            }
        }
        if localDidWin {
            globalDidWin = true
        }
        if globalDidWin {
            return true
        }
        
        //diagonal 02
        for i in stride(from: 2, through: 4, by: 2) {
            if table[i].value == " " {
                localDidWin = false
                break
            }
            if table[i].value != table[i+2].value {
                localDidWin = false
                break
            } else {
                localDidWin = true
            }
        }
        if localDidWin {
            globalDidWin = true
        }
        if globalDidWin {
            return true
        } else {
            return false
        }
    }
}
