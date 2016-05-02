# <img src="https://cloud.githubusercontent.com/assets/7833470/10899314/63829980-8188-11e5-8cdd-4ded5bcb6e36.png" height="60"> Associations, Migrations, and Validations, Oh My!

## Getting Started

1. If you haven't already, fork this repo, and clone it into your WDI class folder on your local machine.
2. Run `bundle` in the Terminal to install gems from the Gemfile.
3. Run `rake db:create db:migrate` in the Terminal to create your local database and run the migrations.
4. Run `rails s` in the Terminal to start your server.
5. Navigate to `localhost:3000` in the browser - you should see the Rails welcome page.  

## Challenges

#### Create an Association

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

1. Add validations to the `Pet` model. Pets are required to have both `name` and `breed`, and `name` cannot be longer than 255 characters. Test your validations with `rspec spec/models/pet_spec.rb`.

1. At this point, you can "comment in" the parts of the `db/seeds.rb` file that relate to pets and run `rake db:seed`. This will destroy all old pets and create new ones.


#### Pet Routes

Nest routes for pets inside the routes for owners. Start with just an index route:

  ```ruby
  # config/routes.rb
  resources :owners do
    resources :pets, only: :index, :show, :new, :create
  end
  ```

  Run `rake routes` in the Terminal to see the new routes. You can see a table of nested routes and each route's purpose in the [Routing](http://guides.rubyonrails.org/routing.html#nested-resources) Rails guide.

#### Pet Index and Show Views

1. On the owner show view, add a "view this owner's pets" link. The link should go to the path that will show all of that owner's pets. Reference the route table in the [Routing](http://guides.rubyonrails.org/routing.html#nested-resources) Rails guide.

1. The pets index view will show all the pets for a particular owner. Finish filling in the pets index view template. The pets index view should list the names of all pets belonging to the owner.  

1. Fill in the `pets#index` controller action so that the view has the necessary information to display.

1. Add a link to each pet's name that leads to the pet's show page.  

1. Fill in the pet show template to display the pet's name and breed, and fill in the `pets#show` controller action to enable this view.

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


## Stretch Challenges

Three types of stretch challenges lay before you. Pick and choose any you find interesting. Solutions are provided.

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
