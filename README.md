Easy-Data
=========

Helper methods for taking away the grunt work of Core Data.

## Configuration

Download the EasyData CocoaPod by placing the following line in your Podfile:

```pod 'EasyData', '~> 0.1'```

and then running from the directory where your Podfile is located:

```pod install```

In your project, import the EasyData header file into the class you wish to use it in:

```#import "EasyData.h"```

Create an create an EasyData instance to manipulate data. In the below examples, this is called 'easyDataInstance'.

```@property (strong, nonatomic) EasyData *easyDataInstance;```

## Insertion

Insertion uses the ```[insertObjectOfType: withValues:]``` method. This inserts an object with key-value pairings into Core Data for a given class name and data object.

Example:

```    
NSDictionary *objectToInsert = [[NSDictionary alloc] initWithObjectsAndKeys:@"The Great Gatsby", @"title", 180, @"numberOfPages", nil];
[self.easyDataInstance insertObjectOfType:Book withValues:objectToInsert];
```

## Retrieval

Retrieval uses the ```[retrieveObjectOfType:(id) withAttribute:(id) equalTo:(id)]``` method. This retrieves an object that has a field equal to a specified value.

Example:

```Book *book = [self.easyDataInstance retrieveObjectOfType:Book withAttribute:@"title" equalTo:"The Great Gatsby"];```

## Updating

Updating uses the ```[updateObjectOfType:(id) withAttribute:(id) equalTo:(id) withNewValues:(NSDictionary*)]``` method. This retrieves an object that has a field equal to the specified value and then replaces all fields in the ```values``` dictionary with supplied values. Returns the updated object.

Example:

```
NSDictionary *newValues = [[NSDictionary alloc] initWithObjectsAndKeys: @"1984", @"title", 266, @"numberOfPages", nil];
Book *book = [self.easyDataInstance updateObjectOfType:Book withAttribute:@"title" equalTo:"The Great Gatsby" withNewValues:newValues];
```

## Deletion (singular)

Deleting a single object uses the ```[deleteObjectOfType:(id) withAttribute:(id) equalTo:(id)]``` method. This deletes an object that has a field equal to the specified value. Returns the deleted object.

Example:

```Book *book = [self.easyDataInstance deleteObjectOfType:Book withAttribute:@"title" equalTo:@"1984"];```

## Deletion (plural)

Deleting multiple objects uses the ```[deleteAllObjectsOfType:(id)]``` method. This deletes all objects of a given class. Does not return anything.

Example:

```[self.easyDataInstance deleteAllObjectsOfType:Book]; ```

## License

Usage is provided under the [MIT License](http://opensource.org/licenses/MIT).
