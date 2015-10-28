# How to import users form the *.xls file to database?
It's simple.

### 1. First of all: prepare users.xls file

How you can do this?

    1. One user for one row (it's very important!)
    2. First column shoud be a first name
    3. Second column should be a last name
    4. Third column should be an email
    5. Fourth column should be an expiration date

OK. Now you have got a valid .xls file. Name it users.xml

### 2. Put users.xls file to the lib/tasks folder.

### 3. Type in console: rake import:xls

That's all.
You can see in the console how much rows (users) were added and you cas see also all of the errors.