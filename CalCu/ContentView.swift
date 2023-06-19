//
//  ContentView.swift
//  CalCu
//
//  Created by Deepanshu Gautam on 18/07/22.
//

import SwiftUI
struct ContentView: View {
    @State var value : String = ""
    @State var operandIncluded : Bool = false
    @State var op1 : String = ""
    @State var op2 : String = ""
    @State var task : String = ""
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .cornerRadius(12)
                Text(value)
                    .foregroundColor(.white)
                    .bold()
                    .font(.largeTitle)
            }
            HStack {
                MyButton(text: "%", textColor: .white, backColor: .gray, toExecut: myFunction)
                MyButton(text: "DL", textColor: .white, backColor: .gray, toExecut: myFunction)
                MyButton(text: "AC", textColor: .white, backColor: .gray, toExecut: myFunction)
                MyButton(text: "/", textColor: .white, backColor: .yellow, toExecut: myFunction)
            }
            HStack {
                MyButton(text: "7", textColor: .white, backColor: .pink, toExecut: myFunction)
                MyButton(text: "8", textColor: .white, backColor: .pink, toExecut: myFunction)
                MyButton(text: "9", textColor: .white, backColor: .pink, toExecut: myFunction)
                MyButton(text: "X", textColor: .white, backColor: .yellow, toExecut: myFunction)
            }
            HStack {
                MyButton(text: "4", textColor: .white, backColor: .pink, toExecut: myFunction)
                MyButton(text: "5", textColor: .white, backColor: .pink, toExecut: myFunction)
                MyButton(text: "6", textColor: .white, backColor: .pink, toExecut: myFunction)
                MyButton(text: "-", textColor: .white, backColor: .yellow, toExecut: myFunction)
            }
            HStack {
                MyButton(text: "1", textColor: .white, backColor: .pink, toExecut: myFunction)
                MyButton(text: "2", textColor: .white, backColor: .pink, toExecut: myFunction)
                MyButton(text: "3", textColor: .white, backColor: .pink, toExecut: myFunction)
                MyButton(text: "+", textColor: .white, backColor: .yellow, toExecut: myFunction)
            }
            HStack {
                MyButton(text: "0", textColor: .white, backColor: .cyan, toExecut: myFunction)
                HStack {
                    MyButton(text: ".", textColor: .white, backColor: .indigo, toExecut: myFunction)
                    MyButton(text: "=", textColor: .white, backColor: .yellow, toExecut: myFunction)
                }
            }
        }
    }
    
    func myFunction(action : String) {
        if (value.count <= 15) {
            if(action == "AC") {
                value = ""
            }  else if (action == "DL") {
                if(value.count != 0) {
                    if operandIncluded && op2.count > 0 {
                        op2.removeLast()
                    }
                    if value.last == "+" || value.last == "-" || value.last == "/" || value.last == "X" || value.last == "%" {
                        operandIncluded = false
                    }
                    value.removeLast()
                }
            } else if (action == "=") {
                if operandIncluded {
                    operandIncluded = false
                    value = ""
                    let x = Double(op1)
                    let y = Double(op2)
                    if(task == "+") {
                        value = String(format: "%.2f", x! + y!)
                    }
                    if(task == "-") {
                        value = String(format: "%.2f", x! - y!)
                    }
                    if(task == "X") {
                        value = String(format: "%.2f", x! * y!)
                    }
                    if(task == "/") {
                        value = String(format: "%.2f", x! / y!)
                    }
                    if(task == "%") {
                        value = String(format: "%.2f", (x! * y!) / 100.0)
                    }
                    op1 = value
                    op2 = ""
                }
            } else if (action == "+" || action == "-" || action == "/" || action == "X" || action == "%") {
                if(value.count != 0 && !operandIncluded) {
                    operandIncluded = true
                    op1 = value
                    value = value + " " + action + " "
                    task = action
                }
            } else {
                if operandIncluded {
                    op2 += action
                }
                value += action
            }
        }
    }
}

struct MyButton: View {
    let text : String
    let textColor : Color
    let backColor : Color
    let toExecut : (String)->Void
    var body: some View {
        Button {
            toExecut(text)
        } label: {
            ZStack {
                Rectangle()
                    .cornerRadius(12)
                Text(text)
                    .foregroundColor(textColor)
                    .bold()
                    .font(.largeTitle)
            }
        }
        .tint(backColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
