//
//  BookTicket.swift
//  MovieTickets
//
//  Created by Nazirul Hasan on 25/11/19.
//  Copyright © 2019 Nazirul Hasan. All rights reserved.
//

import UIKit
import Firebase

class BookTicket: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var movieArray = [MovieDataModel]()
    
    var movieName = ""
    var genre = ""
    
    @IBOutlet var bookTicketImage: UIImageView!
    @IBOutlet var bmovieTitle: UILabel!
    @IBOutlet var bmovieGenre: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var ticketCategory: UISegmentedControl!
    @IBOutlet var ticketIncrementDecrement: UIStepper!
    @IBOutlet var showNumOfTicket: UILabel!
    @IBOutlet var totalPrice: UILabel!
    
    /*@IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    @IBOutlet var button5: UIButton!
    @IBOutlet var button6: UIButton!
    @IBOutlet var button7: UIButton!
    @IBOutlet var button8: UIButton!
    @IBOutlet var button9: UIButton!
    @IBOutlet var button10: UIButton!
    @IBOutlet var button11: UIButton!
    @IBOutlet var button12: UIButton!
    @IBOutlet var button13: UIButton!
    @IBOutlet var button14: UIButton!
    @IBOutlet var button15: UIButton!
    @IBOutlet var button16: UIButton!
    @IBOutlet var button17: UIButton!
    @IBOutlet var button18: UIButton!*/
    var hallName = ""
    var date = ""
    var time = ""
    var premium = ""
    var regular = ""
    var ticketAvailable = ""
    var payment = ""
    
    var check = 0
    var ticketCategorySelectionCheck = 0
    var ticketSelectionCheck = 0
    var ticketCategorySelected = ""
    var numOfTickets = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bmovieTitle.text = movieName
        if movieName == "Gladiator" {
            bookTicketImage.image = UIImage(named: "Gladiator")
        }
        if movieName == "Titanic" {
            bookTicketImage.image = UIImage(named: "Titanic")
        }
        if movieName == "Inception" {
            bookTicketImage.image = UIImage(named: "Inception")
        }
        if movieName == "Interstellar" {
            bookTicketImage.image = UIImage(named: "Interstellar")
        }
        if movieName == "Whiplash" {
            bookTicketImage.image = UIImage(named: "Whiplash")
        }
        if movieName == "Drishyam" {
            bookTicketImage.image = UIImage(named: "Drishyam")
        }
        if movieName == "Joker" {
            bookTicketImage.image = UIImage(named: "Joker")
        }
        if movieName == "Airlift" {
            bookTicketImage.image = UIImage(named: "Airlift")
        }
        if movieName == "Godfather" {
            bookTicketImage.image = UIImage(named: "Godfather")
        }
        if movieName == "Goodfellas" {
            bookTicketImage.image = UIImage(named: "Goodfellas")
        }
        bmovieGenre.text = genre
        tableView.delegate = self
        tableView.dataSource = self
        configureTableView()
        loadSelectedMovieInfo()
        ticketIncrementDecrement.wraps = true
        ticketIncrementDecrement.autorepeat = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func back(_ sender: Any) {
        performSegue(withIdentifier: "goToMovieDescriptionFromBookTicket", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMovieDescriptionFromBookTicket" {
            let movieDescriptionVC = segue.destination as! MovieDescription
            movieDescriptionVC.movieNamePassed = bmovieTitle.text!
        }
    }
    
    @IBAction func bookTicketLogout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        }
        catch {
            let alertController = UIAlertController(title: "Oooops", message:
                "There was a problem signing out", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }
        performSegue(withIdentifier: "goToWelcomeFromBookTicket", sender: self)
    }
    
    func loadSelectedMovieInfo() {
        let ref = Database.database().reference().child("Admin").child("Movies").child(movieName)
        ref.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            let movieObject = MovieDataModel()
            movieObject.date = snapshotValue["Date"]!
            movieObject.premiumPrice = snapshotValue["Premium Price"]!
            movieObject.regularPrice = snapshotValue["Regular Price"]!
            movieObject.theatre = snapshotValue["Cinema Hall"]!
            movieObject.time = snapshotValue["Time"]!
            movieObject.ticketsAvailable = snapshotValue["Tickets Available"]!
            if (Int(movieObject.ticketsAvailable)! > 0) {
                self.movieArray.append(movieObject)
            }
            self.configureTableView()
            self.tableView.reloadData()
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookInfo", for: indexPath) as! BookTableViewCell
        cell.dateLabel.text = movieArray[indexPath.row].date
        cell.hallName.text = movieArray[indexPath.row].theatre
        cell.premiumLablel.text = movieArray[indexPath.row].premiumPrice
        cell.regularLabel.text = movieArray[indexPath.row].regularPrice
        cell.timeLabel.text = movieArray[indexPath.row].time
        cell.ticketLabel.text = movieArray[indexPath.row].ticketsAvailable
        return cell
    }
    
    func configureTableView() {
        
        tableView.estimatedRowHeight = 200.0
        tableView.rowHeight = UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        date = movieArray[indexPath.row].date
        hallName = movieArray[indexPath.row].theatre
        premium = movieArray[indexPath.row].premiumPrice
        regular = movieArray[indexPath.row].regularPrice
        time = movieArray[indexPath.row].time
        ticketAvailable = movieArray[indexPath.row].ticketsAvailable
        ticketIncrementDecrement.maximumValue = (Double(ticketAvailable))!
        
        check = 1
        
        //seatDataLoad()
        
    }
    
    @IBAction func ticketCategoryAction(_ sender: Any) {
        if check == 0 {
            let alertController = UIAlertController(title: "Oooops", message:
                "Please Select Any of the Movie Information", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true, completion: nil)
            
        }
        else {
            switch ticketCategory.selectedSegmentIndex
            {
            case 0:
                ticketCategorySelected = "Premium"
                ticketCategorySelectionCheck = 1
            case 1:
                ticketCategorySelected = "Regular"
                ticketCategorySelectionCheck = 1
            default:
                break
            }
        }
        
    }
    @IBAction func steppar(_ sender: UIStepper) {
        if check != 1 && ticketCategorySelectionCheck != 1 {
            let alertController = UIAlertController(title: "Oooops", message:
                "Please Select Any of the Movie Information", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true, completion: nil)
            
        }
        else {
            showNumOfTicket.text = Int(sender.value).description
            numOfTickets = Int(showNumOfTicket.text!)!
            ticketSelectionCheck = 1
            if ticketCategorySelected == "Premium" {
                let x = numOfTickets * Int(premium)!
                totalPrice.text = String(x) + " Tk"
                payment = totalPrice.text!
            }
            else {
                let x = numOfTickets * Int(regular)!
                totalPrice.text = String(x) + " Tk"
                payment = totalPrice.text!
            }
            
            
        }
    }
    
    
    
    
    @IBAction func payButtonDidPress(_ sender: Any) {
        
        if (check != 1 && ticketSelectionCheck != 1 && ticketCategorySelectionCheck != 1) {
            let alertController = UIAlertController(title: "Oooops", message:
                "Please Select Any of the Movie Information", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true, completion: nil)
            
        }
        else {
            /*print(Auth.auth().currentUser?.email!)
            print(ticketCategorySelected)
            print(numOfTickets)
            print(payment)*/
            let ref = Database.database().reference()
            let uploader = ["Movie Name":movieName, "Cinema Hall":hallName, "Date":date, "Time":time, "Ticket Category":ticketCategorySelected, "Tickets":"\(numOfTickets)", "Payment":payment, "Email":Auth.auth().currentUser?.email]
            ref.child("Users").childByAutoId().setValue(uploader) {
                (error,reference) in
                if error != nil {
                    print(error!)
                }
                else {
                    let alertController = UIAlertController(title: "Successfull!!", message:
                        "Your Movie Ticket is Booked Successfully!", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                    
                }
            }
            
        }
    }
    
    
    
    /*func seatDataLoad() {
        print("Inside seatDataLoad")
        
        let ref = Database.database().reference().child("Seats").child(movieName).child(hallName).child(date).child(time)
        ref.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            for  i in 1...18 {
                self.seatPlan[i] = Int(snapshotValue["\(i)"]!)!
                switch i {
                case 1:
                    if self.seatPlan[i] == 0{
                        print("Meow Meow Meow Moew")
                        print(self.seatPlan[i])
                        self.button1.backgroundColor = UIColor.green
                    }
                    else {
                        self.button1.backgroundColor = UIColor.red
                    }
                case 2:
                    if self.seatPlan[i] == 0{
                        self.button2.backgroundColor = UIColor.green
                    }
                    else {
                        self.button2.backgroundColor = UIColor.red
                    }
                case 3:
                    if self.seatPlan[i] == 0{
                        self.button3.backgroundColor = UIColor.green
                    }
                    else {
                        self.button3.backgroundColor = UIColor.red
                    }
                case 4:
                    if self.seatPlan[i] == 0{
                        self.button4.backgroundColor = UIColor.green
                    }
                    else {
                        self.button4.backgroundColor = UIColor.red
                    }
                case 5:
                    if self.seatPlan[i] == 0{
                        self.button5.backgroundColor = UIColor.green
                    }
                    else {
                        self.button5.backgroundColor = UIColor.red
                    }
                case 6:
                    if self.seatPlan[i] == 0{
                        self.button6.backgroundColor = UIColor.green
                    }
                    else {
                        self.button6.backgroundColor = UIColor.red
                    }
                case 7:
                    if self.seatPlan[i] == 0{
                        self.button7.backgroundColor = UIColor.green
                    }
                    else {
                        self.button7.backgroundColor = UIColor.red
                    }
                case 8:
                    if self.seatPlan[i] == 0{
                        self.button8.backgroundColor = UIColor.green
                    }
                    else {
                        self.button8.backgroundColor = UIColor.red
                    }
                case 9:
                    if self.seatPlan[i] == 0{
                        self.button9.backgroundColor = UIColor.green
                    }
                    else {
                        self.button9.backgroundColor = UIColor.red
                    }
                case 10:
                    if self.seatPlan[i] == 0{
                        self.button10.backgroundColor = UIColor.green
                    }
                    else {
                        self.button10.backgroundColor = UIColor.red
                    }
                    
                case 11:
                    if self.seatPlan[i] == 0{
                        self.button11.backgroundColor = UIColor.green
                    }
                    else {
                        self.button11.backgroundColor = UIColor.red
                    }
                case 12:
                    if self.seatPlan[i] == 0{
                        self.button12.backgroundColor = UIColor.green
                    }
                    else {
                        self.button12.backgroundColor = UIColor.red
                    }
                case 13:
                    if self.seatPlan[i] == 0{
                        self.button13.backgroundColor = UIColor.green
                    }
                    else {
                        self.button13.backgroundColor = UIColor.red
                    }
                case 14:
                    if self.seatPlan[i] == 0{
                        self.button14.backgroundColor = UIColor.green
                    }
                    else {
                        self.button14.backgroundColor = UIColor.red
                    }
                case 15:
                    if self.seatPlan[i] == 0{
                        self.button15.backgroundColor = UIColor.green
                    }
                    else {
                        self.button15.backgroundColor = UIColor.red
                    }
                case 16:
                    if self.seatPlan[i] == 0{
                        self.button16.backgroundColor = UIColor.green
                    }
                    else {
                        self.button16.backgroundColor = UIColor.red
                    }
                case 17:
                    if self.seatPlan[i] == 0{
                        self.button17.backgroundColor = UIColor.green
                    }
                    else {
                        self.button17.backgroundColor = UIColor.red
                    }
                case 18:
                    if self.seatPlan[i] == 0{
                        self.button18.backgroundColor = UIColor.green
                    }
                    else {
                        self.button18.backgroundColor = UIColor.red
                    }
                default:
                    print("Successful")
                }
            }
            print(self.seatPlan.count)
            
        }
        print("Outside BackGround")
        
    }*/
    
    
    

}
