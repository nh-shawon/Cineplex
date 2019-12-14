//
//  ShowContentViewController.swift
//  MovieTickets
//
//  Created by Nazirul Hasan on 3/12/19.
//  Copyright © 2019 Nazirul Hasan. All rights reserved.
//

import UIKit
import Firebase

class ShowContentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var movieStream = [MovieDataModel]()
    var movieNameToBePassed = ""
    
    @IBOutlet weak var contentTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTableView.delegate = self
        contentTableView.dataSource = self
        
        configureTableView()
        retrieveMovieData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        }
        catch {
            let alertController = UIAlertController(title: "Oooops", message:
                "There was a problem signing out", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }
        performSegue(withIdentifier: "goToWelcomeFromShowContent", sender: self)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieStream.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        cell.mTitle.text = movieStream[indexPath.row].movieName
        if movieStream[indexPath.row].movieName == "Gladiator" {
            cell.mImage.image = UIImage(named: "Gladiator")
        }
        if movieStream[indexPath.row].movieName == "Titanic" {
            cell.mImage.image = UIImage(named: "Titanic")
        }
        if movieStream[indexPath.row].movieName == "Inception" {
            cell.mImage.image = UIImage(named: "Inception")
        }
        if movieStream[indexPath.row].movieName == "Interstellar" {
            cell.mImage.image = UIImage(named: "Interstellar")
        }
        if movieStream[indexPath.row].movieName == "Whiplash" {
            cell.mImage.image = UIImage(named: "Whiplash")
        }
        if movieStream[indexPath.row].movieName == "Drishyam" {
            cell.mImage.image = UIImage(named: "Drishyam")
        }
        if movieStream[indexPath.row].movieName == "Joker" {
            cell.mImage.image = UIImage(named: "Joker")
        }
        if movieStream[indexPath.row].movieName == "Airlift" {
            cell.mImage.image = UIImage(named: "Airlift")
        }
        if movieStream[indexPath.row].movieName == "Godfather" {
            cell.mImage.image = UIImage(named: "Godfather")
        }
        if movieStream[indexPath.row].movieName == "Goodfellas" {
            cell.mImage.image = UIImage(named: "Goodfellas")
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        movieNameToBePassed = movieStream[indexPath.row].movieName
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "goToMovieDescription", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMovieDescription" {
            let destinationVC = segue.destination as! MovieDescription
            destinationVC.movieNamePassed = movieNameToBePassed
            
        }
    }
    
    func configureTableView() {
        
        contentTableView.estimatedRowHeight = 100.0
        contentTableView.rowHeight = UITableView.automaticDimension
        
    }
    
    func retrieveMovieData () {
        let ref = Database.database().reference().child("Admin")
        ref.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as? [String : AnyObject] ?? [:]
            
            for each in snapshotValue {
                let movie = MovieDataModel()
                movie.movieName = each.key
                self.movieStream.append(movie)
            }
            
            self.configureTableView()
            self.contentTableView.reloadData()
           
        }
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
