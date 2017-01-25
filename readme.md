# <img src="https://cloud.githubusercontent.com/assets/7833470/10899314/63829980-8188-11e5-8cdd-4ded5bcb6e36.png" height="60"> Pet App!

## Overview

Track owners and pets!

## Objectives

Practice:  
- validations and error handling  
- associations (one-to-many)  

## Getting Started

1. Fork this repo, and clone it into your WDI class folder on your local machine. Change directories into the project directory.
2. Run `bundle` in the Terminal to install gems from the Gemfile. (Feel free to take a look at what's included, first.)
3. Run `rails db:create db:migrate` in the Terminal to create your local database and run the migrations.
4. Run `rails s` in the Terminal to start your server.
5. Navigate to `localhost:3000` in the browser - you should see a generic `site#index` page.   
6. Run `rails routes` to see what routes are available in the app.
7. Run `rails notes` to see some of the things you'll do with this app

## Sharing

When you're finished working on the pet app:  
- add a 3-5 sentence reflection on this app to the top of your readme  
- push your work to the master branch of your GitHub fork  
- add a link to your repo on the "My Work" section of your website  

## Part 1: Owner Validations and Error Handling

#### Add Model Validations

1. Run `rspec spec/models/owner_spec.rb` from the Terminal to see the tests that are set up for the `Owner` model.

1. Add validations to the `Owner` model. Owners have the following restrictions:  
  * owners are required to have a `first_name`, a `last_name`, and an `email`  
  * an owner's `first_name`, `last_name`, and `email` must each be at most 255 characters long  
  * emails must be unique; that is, no two owners can have the same `email`  
  * emails must contain an `@` symbol (hint: this checks the `format`)

   > See the [Active Record Validation guide](http://guides.rubyonrails.org/active_record_validations.html) for guidance.

2. In the Terminal, open up the Rails console, and try adding an invalid owner to the database using the `.create` method:

  ```zsh
  irb(main):001:0> guy = Owner.create({
  irb(main):001:1>   first_name: "Guybrush",
  irb(main):001:2>   last_name: "Threepwood"
  irb(main):001:3> })
  ```

   What happens?


3. Now try storing the invalid owner in memory with the `.new` method, and check if it's valid:

   ```zsh
   irb(main):001:0> guy = Owner.new({
   irb(main):001:1>   first_name: "Guybrush",
   irb(main):001:2>   last_name: "Threepwood"
   irb(main):001:3> })
   irb(main):001:4> guy.valid?
   ```

4. Still in the Rails console, use `.errors.full_messages` to display the user-friendly error messages for the invalid owner you just created.

#### Refactor Controller to Handle Errors

1. The `owners#create` method currently looks like this:

  ```ruby
  #
  # app/controllers/owners_controller.rb
  #
  def create
    owner = Owner.create(owner_params)
    redirect_to owner_path(owner)
  end
  ```

  > The `owner_params` method is set up to use Rails strong parameters.

  What happens when you navigate to `localhost:3000/owners/new` in the browser and try to submit a blank form?

  Refactor your `owners#create` controller method to better handle this error. **Hint:** Use `.new` and `.save`.

  <details>
    <summary>Hint: which methods to use?</summary>
    Try `.new` and `.save` so it's easier to see if there's an error.
  </details>

  <details>
    <summary>Hint: what to do if there's an error?</summary>
    For now, redirect back to the page with the form.  If you don't remember the path helper method to use, `rails routes` in your Terminal and check the prefixes!
  </details>

2. Once you've refactored `owners#create` to redirect in the case of an error, add flash messages to show the user the specific validation error they triggered, so they won't make the same mistake twice.

  <details>
    <summary>Hint: where to set the flash message?</summary>
    Set the flash message in the controller by adding the message into the `flash` hash.  The `flash` hash is special short-term memory in Rails that lasts just until the end of the *next* request - which makes it perfect to use with redirects! (See the [Rails Flash message guide](http://api.rubyonrails.org/classes/ActionDispatch/Flash.html) for syntax.)
  </details>

  <details>
    <summary>Hint: where to display the flash message?</summary>
    Create a place to render the flash message in the main application layout (`app/views/layouts/application.html.erb`). You should template in the contents of your flash hash.
  </details>


#### Editing Owners

1. You already have routes for `owners#edit` and `owners#update`, since  `routes.rb` calls `resources :owners`. Now, set up controller methods for `owners#edit` and `owners#update`, as well as a view for editing owners (edit form).

2. Make sure your `owners#update` method also handles errors by redirecting if the user submits invalid data and displaying a flash message in the view.

1. Common keys for flash messages are `:notice`, which just displays some information, and `:error`, which means something has gone wrong. Add styling to visually distinguish between these kinds of flash messages.

1. If you look at `seeds.rb`, you'll see FFaker is set up to generate seed data. In your Rails console, try `FFaker::PhoneNumber.phone_number` a few times. Just like real user data, the phone numbers don't have a standard format.  Fill in the `normalize_phone_number` method so that it will:
  * remove `1` from the beginning of the owner's phone number, and   
  * remove the characters `(`, `)`, `-`, and `.` from the owner's phone number.

  > The `before_save` method makes it so the `normalize_phone_number` method gets called whenever an owner is about to be saved in the database.



## Part 2: Owners Have Many Pets

1. In addition to owners, this app has a model for pets. In this app, each owner will have many pets, and each pet will belong to one owner. Change the `Owner` and `Pet` models to reflect this relationship.

1. Add a foreign key to the `Pet` table so that each pet stores a reference to its owner.

  > See the [ActiveRecord Migrations](http://guides.rubyonrails.org/active_record_migrations.html) Rails guide for how add a foreign key to a table that's already been created.

  <details>
    <summary>Hint: how to generate migration to add foreign key?</summary>
    The example from the docs adds a user foreign key to a products table, by running `bin/rails generate migration AddUserRefToProducts user:references`, but you can also use something like `rails g migration AddUserRefToProducts user:belongs_to`.  Just replace the example models with the names this app needs!
  </details>

1. In the Terminal, open up the Rails console, and create a few associated instances of pets and owners.

  ```zsh
  irb(main):001:0> ash = Owner.create({
  irb(main):001:1>   first_name: "Ash",
  irb(main):001:2>   last_name: "Ketchum",
  irb(main):001:3>   email: "a_ketchum@example.com",
  irb(main):001:4>   phone: "(03) 1234-5678"
  irb(main):001:5> })
  ```

  ```zsh
  irb(main):001:0> pikachu = Pet.create({
  irb(main):001:1>   name: "Pikachu",
  irb(main):001:2>   breed: "pokemon"
  irb(main):001:3> })
  ```

  ```zsh
  irb(main):001:0> ash.pets << pikachu
  ```

  Compare `ash`'s `id` with `pikachu`'s new `owner_id`.


#### Model Validation for Pets

1. Practice TDD.  Pets are required to have both `name` and `breed`, and `name` cannot be longer than 255 characters. Using the `Owner` model tests as an example, write tests for these validations.

  > Note that two gems are included to add extra Rails-appropriate RSpec features to this project:  [`rspec-rails`](https://www.relishapp.com/rspec/rspec-rails/docs) and [`shoulda-matchers`](http://matchers.shoulda.io/). You can see where they're set up in `Gemfile` and `spec/rails_helper.rb`.

  <details>
    <summary>Hint: Where to code `Pet` model tests?</summary>
    The tests for the `Pet` model belong in `spec/models/pet_spec`.  This file already exists and was generated when the command `rails g model pet ...` was run.
  </details>

  <details>
    <summary>Hint: Where to look for `Owner` test examples?</summary>
    The tests for the `Owner` model are in `spec/models/owner_spec`.
  </details>

1. Add validations to the `Pet` model. Then, test your validations with `rspec spec/models/pet_spec.rb`.  If you're not sure of the quality of your tests, try a few valid and invalid inputs in the console to make sure invalid inputs don't get saved.

1. At this point, you can "comment in" the parts of the `db/seeds.rb` file that relate to pets and run `rails db:seed`. This will destroy all old pets and create new ones.


#### Pet Routes

Nest routes for pets inside the routes for owners. Start with just an few routes:

  ```ruby
  # config/routes.rb
  resources :owners do
    resources :pets, only: :index, :show, :new, :create
  end
  ```

  Run `rails routes` in the Terminal to see the new routes. You can see a table of nested routes and each route's purpose in the [Routing](http://guides.rubyonrails.org/routing.html#nested-resources) Rails guide.

#### Pet Index and Show

1. On the owner show view, add a "view this owner's pets" link. Remember to use `link_to`. The link should go to the path that will show all of that owner's pets. Reference the route table in the [Routing](http://guides.rubyonrails.org/routing.html#nested-resources) Rails guide.

1. The pets index view will show all the pets for a particular owner. Finish filling in the pets index view template. The pets index view should list the names of all pets belonging to the owner.  

  <details>
    <summary>Hint: What data will this view need from the controller?</summary>
    Since we're looking for the pets from a single owner, the view will need to know which owner to use (`@owner`). If you have your model relationship set up correctly, an owner's pets are simply `@owner.pets`.
  </details>

1. Add a link to each pet's name that leads to the pet's show page.  Remember to use `link_to`.

1. Fill in the `pets#index` controller action so that the view has the necessary information to display.

1. Fill in the pet show template to display the pet's name and breed.

1. Fill in the `pets#show` controller action to give this view the necessary information.

#### Pet New and Create

1. On the pet index view, add a link to the path for the new pet form. Remember to reference the route table in the [Routing](http://guides.rubyonrails.org/routing.html#nested-resources) Rails guide.

1. Create a new pet view that renders a form. The form should have text fields for the pet's `name` and `breed`. Research the syntax for `form_for` with nested resources.

  <details>
    <summary>Hint: research help?</summary>
    The top google result for "form_for nested resource" is a StackOverflow question, and the top answer has the necessary syntax.  Take a look at [the answer](http://stackoverflow.com/a/4611932).
  </details>

1. Add a `new` action to the pets controller, and have the controller retrieve the data necessary to create a new pet for a particular owner.

  <details>
    <summary>Hint: what data is necessary?</summary>
    Like with most `new` actions, you'll want a dummy new pet to use with the `form_for` helper. Since this pet is being added to a particular owner, you'll also need to use that owner's information.
  </details>

1. Add a `create` action to the pets controller.  This action will need to find the proper owner, make and save a new pet, and add the pet to the owner's list of pets.  It can redirect to the new pet's show page when the creation is successful.

1. If there is an error in the creation of the new pet, add a flash message.  Redirect back to the new pet form for that owner.


## Part 3: Choose Your Own Adventure

Three types of stretch challenges lay before you. Pick and implement the set(s) you find interesting. Solutions are provided.

#### Circumnavigate the Site for User Experience

Practice using path helper methods by adding `link_to`s to help users move among the pages of your site. Consider adding:  
  * a link to the owner index from the owner show page
  * a link to the owner's show page from the list of their pets
  * a link to the owner's list of pets from the pet show page
  * a link to the site index on every page (keep it DRY!)

#### Follow the Routes to Full CRUD

Create or fill in routes, controllers, and views for the missing crud actions for owners and pets.  Choose one route at a time. It might be easiest to start with `destroy`; just remember the difference between `destroy` and `delete`!

#### Play with Pets!

Practice your Ruby skills - get more time with the `Date` and `DateTime` built-in classes.

1. Generate and run a migration to add a `date_of_birth` field to the `Pet` model. The type of this field should be `date`.  Display the pet's `date_of_birth` in the view for `pets#show`.

1. Fill in the `Pet` model's `date_of_birth_cannot_be_in_the_future` method. This method should add an error to the validation errors if the pet's `date_of_birth` is in the future.  See the [Validations](http://guides.rubyonrails.org/active_record_validations.html#custom-methods) Rails guide.

1. Fill in the `Pet` model's `age` instance method. If the pet instance has a `date_of_birth`, this method should calculate and return the pet's age in years (as a decimal).  If the pet doesn't have a `date_of_birth`, the `age` method should return `nil`.  Display the pet's `age` in the view for `pets#show`.
