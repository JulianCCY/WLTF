import SwiftUI

struct AddFoodScreen: View {
//    @State var name: String = ""
//    @State var category: String = ""
//    @State var enterDate: String = ""
//    @State var expireDate: String = ""
//    @State var amount: String = ""
//    @State var unit: String = ""
//
//    func addFood() {
//
//    }
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    @State private var foodName = ""
    @State private var category = ""
    @State private var amount: Double = 0
    @State private var unit = ""
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("Food name:", text: $foodName)
                    TextField("Category:", text: $category)
                    
                    VStack {
                        Text("Amount: \(Int(amount))")
                        Slider(value: $amount, in: 0...99, step: 1)
                    }
                    .padding()
                    TextField("Unit:", text: $unit)
                    
                    HStack {
                        Spacer()
                        Button("Add") {
                            DataController().addFood(name: foodName, category: category, amount: amount, unit: unit ,
                                                     exiryDate: Date.now.addingTimeInterval(TimeInterval(86400 * Int.random(in: 1..<11))),
                                                     context: managedObjectContext)
                            dismiss()
                        }
                        Spacer()
                    }
                    
                }
            }
        //            TextField("Food name", text: $name)
        //            TextField("Category", text: $category)
        //            TextField("Date of entry", text: $enterDate)
        //            TextField("Date of expiration", text: $expireDate)
        //            TextField("Amount", text: $amount)
        //            TextField("Unit", text: $unit)
        //            Button("Add food", action: addFood)
        }
//        .padding()
    }
}

struct AddFoodScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodScreen()
    }
}
