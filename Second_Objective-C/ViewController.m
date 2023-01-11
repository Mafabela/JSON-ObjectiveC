//
//  ViewController.m
//  Second_Objective-C
//
//  Created by Consultant on 1/10/23.
//

#import "ViewController.h"
#import "dataModel.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray<DataModel *> *users;

@end

@implementation ViewController
NSString *cellId = @"cellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self setupCourses];
    [self fetchCoursesUsingJSON];
    
    
    
    
}

-(void)fetchCoursesUsingJSON {
    NSLog(@"Fetching Data");
    //https://api.letsbuildthatapp.com/jsondecodable/courses
    
    NSString *urlString = @"https://jsonplaceholder.typicode.com/users";
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"Finish fetching courses...");
        
        NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Data JSON: %@", json);
        
        NSError *err;
        NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        if (err){
            NSLog(@"Failed to serialize into JSON: %@", err);
            return;
        }
        
        NSMutableArray<DataModel *> *users = NSMutableArray.new;
        
        for (NSDictionary *jsonData in dataArray){
            NSString *name = jsonData[@"name"];
            NSString *email = jsonData[@"email"];
            DataModel *user = DataModel.new;
            user.name = name;
            user.email = email;
            //NSLog(name);
            [users addObject:user];
        }
        
        NSLog(@"%@", users);
        self.users = users;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }] resume];
}

/*
-(void)setupCourses{
    self.users = NSMutableArray.new;
    
    DataModel *user = DataModel.new;
    user.name = @"Name of users";
    user.email = @"@example.com";
    [self.users addObject:user];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.users.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    
    DataModel *user = self.users[indexPath.row];
    
    cell.textLabel.text = user.name;
    cell.detailTextLabel.text = user.email;
    return cell;
}
*/
@end
