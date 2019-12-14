//
//  ViewController.swift
//  MovieTickets
//
//  Created by Nazirul Hasan on 25/11/19.
//  Copyright © 2019 Nazirul Hasan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Firebase

class MovieDescription: UIViewController {
    
    var movieNamePassed = ""

    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieGenre: UILabel!
    @IBOutlet var moviePlot: UILabel!
    @IBOutlet var movieCast: UILabel!
    @IBOutlet var movieDirector: UILabel!
    @IBOutlet var movieRating: UILabel!
    @IBOutlet var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        movieTitle.text = movieNamePassed
        if movieNamePassed == "Gladiator" {
            image.image = UIImage(named: "Gladiator")
        }
        if movieNamePassed == "Titanic" {
            image.image = UIImage(named: "Titanic")
        }
        if movieNamePassed == "Inception" {
            image.image = UIImage(named: "Inception")
        }
        if movieNamePassed == "Interstellar" {
            image.image = UIImage(named: "Interstellar")
        }
        if movieNamePassed == "Whiplash" {
            image.image = UIImage(named: "Whiplash")
        }
        if movieNamePassed == "Drishyam" {
            image.image = UIImage(named: "Drishyam")
        }
        if movieNamePassed == "Joker" {
            image.image = UIImage(named: "Joker")
        }
        if movieNamePassed == "Airlift" {
            image.image = UIImage(named: "Airlift")
        }
        if movieNamePassed == "Godfather" {
            image.image = UIImage(named: "Godfather")
        }
        if movieNamePassed == "Goodfellas" {
            image.image = UIImage(named: "Goodfellas")
        }
        loadMovieInfo()
        
    }
    
    @IBAction func movieDescriptionBack(_ sender: Any) {
        performSegue(withIdentifier: "goToShowContentFromMovieDescription", sender: self)
    }
    @IBAction func movieDescriptionLogout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        }
        catch {
            let alertController = UIAlertController(title: "Oooops", message:
                "There was a problem signing out", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }
        performSegue(withIdentifier: "goToWelcomeFromMovieDescription", sender: self)
    }
    @IBAction func bookTicketButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "goToBookTicket", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToBookTicket" {
            let bookTicketVC = segue.destination as! BookTicket
            bookTicketVC.movieName = movieTitle.text!
            bookTicketVC.genre = movieGenre.text!
        }
    }
    
    func loadMovieInfo () {
        let url = URL(string:"http://www.omdbapi.com/?apikey=3a89fb4c&t=\(movieNamePassed)")
        Alamofire.request(url!, method: .get).responseJSON { (response) in
            if response.result.isSuccess {
                let movieJSON : JSON = JSON(response.result.value!)
                
                //Parsing data
                self.movieDirector.text = movieJSON["Director"].string!
                self.moviePlot.text = movieJSON["Plot"].string!
                self.movieGenre.text = movieJSON["Genre"].string!
                self.movieRating.text = movieJSON["imdbRating"].string!
                self.movieCast.text = movieJSON["Actors"].string!
            }
            else {
                print("Data parsing unsuccessful")
            }
        }
    }
    
}

