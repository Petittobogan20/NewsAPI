//
//  ViewController.swift
//  NewsAPI
//
//Hello

import UIKit

class ViewController: UIViewController {

    var newsList = [NewsData]()
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    func fetchData() {
        
        let url = URL(string: "http://haritibhakti.com/newsdata.json")
        let dataTask = URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            guard let data = data, error == nil else
            {
                print("Error occured while accessing data with url")
                return
            }
            var newsFullData = [NewsData]()
            do
            {
                newsFullData = try JSONDecoder().decode([NewsData].self, from: data)
            }
            catch
            {
                print("Error occured while decoding JSON into Swift Structure \(error)")
            }
            self.newsList = newsFullData
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
            
        })
        dataTask.resume()
    }
}

extension UIImageView
{
    func downloadImage(from url:URL)
    {
        contentMode = .scaleToFill
        let dataTask = URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response, error ) in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                  let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data)
            else
            {
                return
            }
            DispatchQueue.main.async {
                self.image = image
            }
        })
        dataTask.resume()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        
        if newsList[indexPath.row].newsimage != nil
        {
            let url = URL(string: "http://haritibhakti.com/\(newsList[indexPath.row].newsimage!)")
            cell.myImageView.downloadImage(from: url!)
            cell.myImageView.contentMode = .scaleAspectFit
            cell.myImageView.layer.cornerRadius = 25
            
        }
        
        else
        {
            cell.myImageView.image = UIImage(named: "emptyimage")
        }
        cell.myLabelView.text = newsList[indexPath.row].newstitle
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ReadNewsContent") as? ReadNewsContent
        vc?.newsContent = newsList[indexPath.row]
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    
}
