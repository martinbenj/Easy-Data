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

Insertion uses the [insertObjectOfType: withValues:] method. This inserts an object with key-value pairings into Core Data for a given class name and data object.

```- (void)insertObjectOfType:(id)className withValues:(NSDictionary*)values;```

Example:

```    
NSDictionary *objectToInsert = [[NSDictionary alloc] initWithObjectsAndKeys:@"The Great Gatsby", @"title", 180, @"numberOfPages", nil];
[self.easyDataInstance insertObjectOfType:NSStringFromClass([Book class]) withValues:objectToInsert];
```

## Retrieval

Retrieval uses the [retrieveObjectOfType: withAttribute:(id)attribute equalTo:] method. This retrieves an object that has a field equal to a specified value.

```- (id)retrieveObjectOfType:(id)className withAttribute:(id)attribute equalTo:(id)value;```

Example:

```Book *book = [self retrieveObjectOfType:NSStringFromClass([Book class]) withAttribute:@"title" equalTo:"The Great Gatsby"];```

## License

Usage is provided under the [MIT License](http://opensource.org/licenses/MIT). See LICENSE for the full details.
