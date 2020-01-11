# Instalation
Create a .env file in the repository folder with the db user/password
```
DATABASE_USERNAME= ""
DATABASE_PASSWORD= ""
```
Run the following commands in the repository folder
```
bundle install
rake db:create
rake db:migrate
```

If you want some awesome contact examples
```
rake db:seed
```

## Usage
Run `rails s -p 3001` to launch the server