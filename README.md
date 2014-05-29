Easy-Data
=========

Helper methods for taking away the grunt work of Core Data.

## Insertion

Insertion uses the insertObjectOfType: withValues: method.

```- (void)insertObjectOfType:(id)className withValues:(NSDictionary*)values;```

Example:

```    
NSDictionary *objectToInsert = [[NSDictionary alloc] initWithObjectsAndKeys:@"The Great Gatsby", @"title", 180, @"numberOfPages", nil];

[self.easyDataInstance insertObjectOfType:NSStringFromClass([Book class]) withValues:objectToInsert];

