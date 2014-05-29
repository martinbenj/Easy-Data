Easy-Data
=========

Helper methods for taking away the grunt work of Core Data.

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
