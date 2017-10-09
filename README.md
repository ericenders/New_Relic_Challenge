# New_Relic_Challenge

###    Assumption
  NSMutableArray is similar to a C type linked list.  NSMutableArray is mutable where you can insert and remove at specific indexes.  I like to think of it as a necklace where you can alter the chain at any link.  NSMutableArray is also not thread safe, which makes sense why a requirement is to make it thread safe.  There are a few ways to make code thread safe.  I chose @synchronize as it is easiest to use if implemented properly.  Each @sychronize is on self, so no thread can do anything on self which makes this thread safe since all functionality is done within one view controller.  Alternate ways would be using dispatch_async or NSLock.


###    Usage
  You can Alter List 1 with the buttons.  You can merge List 1 with List 2 with the merge button.  The merge button will also sort the final list.  In order to complete some functions, you must select a row to add a string before or after, replace, or remove.

###    Device
  The application was built and tested with iPhone 8 Plus.
