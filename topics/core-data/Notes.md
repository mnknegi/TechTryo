
# CoreData Interview Questions

**Q:** What is CoreData?
**A:** Core Data is a framework in Objective-C and Swift to manage the model layer object in the application. Core Data provides an abstraction layer over SQLite, making it easier to work with databases and manage the object graph of your application.

### Key features:

- `Object-Relational Mapping (ORM)`: Core Data allows you to define data models using a graphical editor (Xcode Data Model Editor) and then automatically generates corresponding classes in Swift. These classes represent the entities and their relationships in your data model.

- `Persistence`: Core Data manages the persistence of your data, whether it's storing data in a SQLite database, binary files, or other supported formats. This makes it easy to save and retrieve data between application launches.

- `Undo and Redo`: Core Data includes built-in support for undo and redo functionality, making it easier to manage changes to your data.

- `Relationships`: Core Data allows you to define relationships between entities, making it easy to model complex data structures.

- `Faulting`: Core Data uses a faulting mechanism to efficiently manage memory by loading only the data that is necessary for the current operation.


**Q:** What is CoreData Stack?
**A:** The Core Data stack refers to the set of services that work together to manage the lifecycle of Core Data objects (managed objects) in your application. The Core Data stack in Swift typically consists of three main components:

- `Managed Object Model`: This is a representation of your `data model`, defining the entities, their attributes, and the relationships between them. It is usually created using the Xcode Data Model Editor. The managed object model, an instance of the NSManagedObjectModel class, loads the data model and exposes it to the Core Data stack. Even though Core Data is not a database, you can compare the data model with the schema of a database. It describes the data of the application.

- `Managed Object Context`: The managed object context, an instance of the NSManagedObjectContext class, is the workhorse of the Core Data stack. It is the object of the Core Data stack, the developer, interact with most. The managed object context keeps a reference to the persistent store coordinator. Even though most applications have one managed object model and one persistent store coordinator, it is not uncommon for applications to have multiple managed object contexts.

- `Persistent Store Coordinator`: It keeps a reference to the managed object model and the managed object context. And, as the name implies, the persistent store coordinator is in charge of the persistent store of the application. It understands the data model of the application through the managed object model and it manages the persistent store of the application.

`Step 1`
 - The first object we need to instantiate is the managed object model. To instantiate an instance of the NSManagedObjectModel class, we need to load the data model from the application bundle. The data model is used to initialize the managed object model of the Core Data stack.
 
 `Step 2`
The managed object model is required to instantiate the persistent store coordinator. The persistent store coordinator needs to know and understand the data model of the application before it can add the persistent store of the application.

`Step 3`
The Core Data stack is only usable once the persistent store is added to the persistent store coordinator. The persistent store coordinator inspects the data model and makes sure the persistent store is compatible with the data model. That is one of the reasons it needs a reference to the managed object model. It uses the managed object model to know about that data model of the application.

`Step 4`
The application interacts with the Core Data stack through the managed object context. A managed object context keeps a reference to the persistent store coordinator. That is why we first need to create the managed object model and the persistent store coordinator before we can create the managed object context.


**Q:** What is persistentContainer?
**A:** It is available as of iOS 10. It encapsulates the core components of the Core Data stack, including the managed object model, the persistent store coordinator, and the default managed object context. After Creation, NSPersistentContainer holdes the reference to the NSManagedObjectModel, NSPersistentStoreCoordinator, and NSManagedObjectContext.
The `NSPersistentContainer` instance is initialized by invoking a convenience initializer, `init(name:)`, passing in the name of the data model. It doesn't requred any explicit instantiation of `NSManagedObjectModel`, `NSPersistentStoreCoordinator`, or `NSManagedObjectContext`. This is abstracted away by the NSPersistentContainer class.

A Core Data stack without a persistent store isn't terribly useful. After initializing the persistent container, the persistent store is loaded by invoking the `loadPersistentStores(completionHandler:)` method. It accepts one parameter, a closure, which is invoked when loading of the persistent store is completed, successfully or unsuccessfully. The closure accepts two parameters, an instance of the NSPersistentStoreDescription class and an optional Error object.

The NSPersistentStoreDescription class is another new addition to the Core Data framework. It encapsulates the information and configuration to add a persistent store to the persistent store coordinator. As the name of the class implies, it describes a persistent store.

After creating an instance of the NSPersistentContainer class, you can easily access the managed object model and the persistent store coordinator through the managedObjectModel and persistentStoreCoordinator properties.

```
persistentContainer.managedObjectModel
persistentContainer.persistentStoreCoordinator
persistentContainer.viewContext
```

The class also provides easy access to a `viewContext` property, an instance of the `NSManagedObjectContext` class that operates on the main queue. As the name of the property implies, this managed object context is designed to be used in combination with the application's user interface.
