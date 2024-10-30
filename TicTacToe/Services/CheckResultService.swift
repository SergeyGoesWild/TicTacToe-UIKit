//
//  CheckResultService.swift
//  TicTacToe
//
//  Created by Sergey Telnov on 30/10/2024.
//

import Foundation

final class CheckResultService {
    
    static let shared = CheckResultService()
    private init() {}
    
    private var globalDidWin = false
    private var localDidWin = false
    
    func checkResult(table: [[String]]) -> Bool {
        //horizontal
        for i in 0 ... 2 {
            for j in 0 ... 1 {
                if table[i][j] != table[i][j+1] || table[i][j] == " " {
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
            for j in 0 ... 1 {
                if table[j][i] != table[j+1][i] || table[j][i] == " " {
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
        for i in 0 ... 1 {
            if table[i][i] != table[i+1][i+1] || table[i][i] == " " {
                localDidWin = false
                break
            } else {
                localDidWin = true
            }
            
            
            if localDidWin {
                globalDidWin = true
            }
        }
        
        if globalDidWin {
            return true
        }
        
        //diagonal 02
        var x = 2
        for i in 0 ... 1 {
            if table[x][i] != table[x-1][i+1] || table[x][i] == " " {
                localDidWin = false
                break
            } else {
                localDidWin = true
            }
            x = x - 1
            
            if localDidWin {
                globalDidWin = true
            }
        }
        if globalDidWin {
            return true
        }
        return false
    }
}
