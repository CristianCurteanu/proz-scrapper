# === README ===

This project is an Rails app that parses data from http://proz.com website, by adding a profile URL to search field, and stores it into a SQLite database.

In order to install it locally you should execute following commands:

```
  $ git clone git@github.com:CristianCurteanu/proz-scrapper.git && cd ./proz-scrapper
  $ rails db:create db:migrate
  $ rails s -p 3000
```

### Things to be improved

- Refactor `ExtractionsController#create` method in order to make it thinner, probably into a separate concern method or a service object
- Add page in which database records will be shown
- Profile source URLs should be unique, and prevent user that such record already exists
- Edit existing profile records