import UIKit
import CoreData

class ViewController: UIViewController {
                            
    @IBOutlet var txtUsername: UITextField
    @IBOutlet var txtLastname: UITextField
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnLoad(sender: UIButton) {
        
    }
    @IBAction func btnSave(sender: UIButton) {
        
        // Fetch the AppDelegate
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        // Fetch the NSManagedObjectContext
        var context:NSManagedObjectContext = appDel.managedObjectContext as NSManagedObjectContext
        
        // Fetch the user entities
        let ent = NSEntityDescription.entityForName("Users", inManagedObjectContext: context)
        
        // Create a new user object
        var newUser = Users(entity: ent, insertIntoManagedObjectContext: context)
        newUser.username = txtUsername.text
        newUser.password = txtPassword.text
        
        //Save the object
        context.save(nil)
        
        //Print the object
        println(newUser)
        
    }

}

