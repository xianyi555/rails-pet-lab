# <img src="https://cloud.githubusercontent.com/assets/7833470/10899314/63829980-8188-11e5-8cdd-4ded5bcb6e36.png" height="60"> Pet App!

### Overview

Track owners and pets!

### Objectives

Practice:    
- associations (one-to-many)  
- validations and error handling

### Getting Started

1. Fork this repo, and clone it into your WDI class folder on your local machine. Change directories into the project directory.
2. Run `bundle` in the Terminal to install gems from the Gemfile. (Feel free to take a look at what's included, first.)
3. Run `rails db:create db:migrate` in the Terminal to create your local database and run the migrations.
4. Run `rails s` in the Terminal to start your server.
5. Navigate to `localhost:3000` in the browser - you should see a generic `site#index` page.   
6. Run `rails routes` to see what routes are available in the app.
7. Run `rails notes` to see some of the things you'll do with this app


## Part 1: Owners Have Many Pets

![owner-pet-erd](https://cloud.githubusercontent.com/assets/3254910/22278438/6dd48c66-e278-11e6-8ed6-d24af148672b.png)

1. This app has models for owners and pets. In this app, each owner will have many pets, and each pet will belong to one owner. Change the `Owner` and `Pet` models to reflect this relationship.

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
  irb(main):001:0> ash.pets << pikachu  # or
  irb(main):001:1> pikachu.owner = ash
  ```

  Compare `ash`'s `id` with `pikachu`'s new `owner_id`.


1. At this point, you can "comment in" the parts of the `db/seeds.rb` file that relate to pets, but leave the `date_of_birth` field commented out.  Run `rails db:seed`. This will destroy all old pets and owners and create new ones.


#### Pet Routes

Nest routes for pets inside the routes for owners. Start with just an few routes:

  ```ruby
  # config/routes.rb
  resources :owners do
    resources :pets, only: [:index, :new, :create]
  end
  resources :pets, only: :show
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

1. Update the new pet view by modifying the form partial it renders. The form should have text fields for the pet's `name` and `breed`. You can use the new owner form for inspiration, but research the syntax for `form_for` with nested resources.

  <details>
    <summary>Hint: research help?</summary>
    The top google result for "form_for nested resource" is a StackOverflow question, and the top answer has the necessary syntax.  Take a look at [the answer](http://stackoverflow.com/a/4611932).
  </details>

1. Add a `new` action to the pets controller, and have the controller retrieve the data necessary to create a new pet for a particular owner.

  <details>
    <summary>Hint: what data is necessary?</summary>
    Like with most `new` actions, you'll want a dummy new pet (`Pet.new`) to send through to the `form_for` helper. Since this pet is being added to a particular owner, you'll also need to use that owner's information.
  </details>

  > At this point, you may notice that `app/views/pets` and `app/views/owners` contain `create.html.erb` files. Create isn't a GET action! Remove these unnecessary, unused files.

1. Add a `create` action definition to the pets controller.  This action will need to make and save a new pet. If the save is successful, it will also need to find the correct owner and add the pet to the owner's list of pets.  It can redirect to the new pet's show page after the creation is successful.


## Part 2: Pets Have Many Appointments

![owner-pet-appointment-erd](https://cloud.githubusercontent.com/assets/3254910/22278437/6bc4468c-e278-11e6-9813-1855a623a323.png)

1. Generate a model for `Appointment`s.  It should have:
  - a datetime field for the `time` of the appointment,  
  - a string field for the `reason` for the appointment,
  - a string field for the name of the `veterinarian`,
  - and a foreign key `pet_id` for the pet whom the appointment belongs to.

1. Check the migration that was generated, and `rails db:migrate` when you feel comfortable with it.

1. Check that the `Appointment` model in `app/models/appointment.rb` has code indicating each appointment belongs to a pet.

1. Update the `Pet` model in `app/models/pet.rb` so it can have many appointments.

1.  In the Terminal, open up the Rails console. Choose an existing pet, and create at least one appointment for it.

  ```zsh
  irb(main):001:0> pikachu = Pet.find_by name: "Pikachu" #might have to recreate
  ```
  ```
  irb(main):001:1> checkup = Appointment.create({  
  irb(main):001:2>   time: DateTime.now + 1, # one day from now
  irb(main):001:3>   reason: "annual checkup",
  irb(main):001:4>   veterinarian: "Nurse Joy",
  irb(main):001:5>   pet: pikachu
  irb(main):001:6> })
  ```

  Check that your appointment and pet have the values you expect (especially the appointment's `pet_id`).

1. Add seed data for 6 appointments to your `seeds.rb`.  Use the `Pet` seed section as an example of how to do this.
  * You can use the `random_date_after_now` method if you'd like, for the appointment date.  
  * Also, add a line at the beginning of the file that destroys all existing appointments.


#### Pet Appointment Routes

We could nest routes further, but usually we want to keep nesting to no more than 1 level deep. To accommodate this, create a few appointment routes nested inside pets.  

  ```ruby
  # config/routes.rb
  resources :owners do
    resources :pets, only: [:index, :new, :create]
  end
  resources :pets, only: [:show, :edit, :update, :destroy] do
    resources :appointments, only: [:new, :create]
  end
  ```

  Run `rails routes` in the Terminal to see the new routes.  Read or review the Rails Guide on Routing's [Nested Resources section](http://guides.rubyonrails.org/routing.html#nested-resources), especially "2.7.2 Shallow Nesting," for the source of this plan and a shorter alternative syntax.

#### Appointment New and Create

1. On the pet show view, add a list of all the pet's appointments, showing time,  veterinarian name, and reason.  We'll do this instead of having the appointments on a separate appointment index view.

  <details>
    <summary>Hint: The view has access to `@pet` right now. How would you find that pet's appointments?</summary>
    If you have your model relationship set up correctly, you should be able to get the appointments with `@pet.appointments`.
  </details>

1. Add a `link_to` the new appointments form on the pet show view.  

1. Generate an appointments controller, and add a `new` action. Have the controller retrieve the data necessary to create a new appointment for a particular pet. Remember, you'll want to use a dummy `Appointment.new` here.

1. Create a new appointment view that renders a new appointment form. The form should have fields for at least the `veterinarian` name and the appointment `reason`. You'll need to make use of `form_for` with nested resources again.  **Hint**: use your new pet form for inspiration.

  <details><summary>Hint: what kind of field to use for a date and time?</summary>
  `datetime_local_field`!
  </details>

1. Add a `create` action to the appointments controller that creates an appointment for the correct pet based on whitelisted params.


  <details><summary>Hint: strong parameters are a best practice - what were they again?</summary>
  [Strong parameters](http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters) refers to the pattern we've seen of creating a `private` method in the controller to specifically "whitelist" (allow) some fields.
  </details>


## Part 3: Owners Have Many Appointments, through Pets

![has-many-through](https://cloud.githubusercontent.com/assets/3254910/22279369/4fbfcff4-e27f-11e6-94a9-472309b0cdb3.png)

Wouldn't it be nice to get a list of all an owner's appointments?  Rails makes it convenient to do this if we set up a `has_many :through` relationship. Once it's set up, `owner.appointments` will list all the appointments an owner has based on their pets.

1. Update the `Owner` model in `app/models/owner.rb` so it has many appointments, through its pets.  If you need a syntax reminder, review the Active Record Associations Rails guide [`has_many through:` section](http://guides.rubyonrails.org/association_basics.html#the-has-many-through-association).  

  > The pet app is using pets to set up a "shortcut" from owners to appointments (as described after the red warning banner in that section).

1. Test this new association in your rails console, for instance, by checking `Owner.first.appointments`.

  > The reverse of this relationship isn't created through models yet (and we won't do it now), so `Appointments.first.owner` will NOT work. On the other hand, `Appointments.first.pet.owner` still will work.

#### Showing Owner's Appointments

Create a page at `/owners/:owner_id/appointments` that lists all of an owner's appointments by following the guidelines below.

1. Add a convenience route for users to `GET /owners/:owner_id/appointments`. Give it a prefix of `owner_appointments`. Route it to an `appointments` action in the owners controller.

  > Note that this isn't technically one of the RESTful routes listed in the [Routing](http://guides.rubyonrails.org/routing.html#nested-resources) Rails guide.

1. Make an `appointments` action in the owners controller, and make sure it sets up a list of appointments for a new page that just shows the appointment list.

  <details><summary>Hint: how to get the list of appointments to the view? </summary>
  The view needs the list of the owner's appointments. Once you look up the owner in the controller, you could send it through to the view as `@owner`. Since the `has_many through:` association is set up, you can  access appointments with `@owner.appointments`.
  </details>


1. Create a view file for the owner's appointments list at `app/views/owners/appointments.html.erb`. For each appointment, display the pet's name (as a link), veterinarian, reason, and time.


1. On the owner show page, add a link to view all of the owner's appointments. (Make sure you also create this view file!)


<!--
## Part 2: Owner Validations and Error Handling

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

1. The `owners#create` method currently looks something like this:

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

  Refactor your `owners#create` controller method to better handle this error. **Hint:** Use `.new` and `.save`  so it's easier to see if there's an error.


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


1. In the pet controller, modify the `create` action. If there is an error in the creation of the new pet, add a flash message.  Then, redirect back to the new pet form for that owner.
-->


## Part 3: Optional Extras / Choose Your Own Adventure

Three types of stretch challenges lay before you. Pick and implement any set(s) you find interesting. 

#### Circumnavigate the Site for User Experience

Practice using path helper methods by adding `link_to`s to help users move among the pages of your site. Consider adding:  
  * a link to the owner index from the owner show page
  * a link to the owner's show page from the list of their pets
  * a link to the owner's list of pets from the pet show page
  * a link to the site index on every page (keep it DRY!)

#### Follow the Routes to Full CRUD

Create or fill in routes, controllers, and views for the missing crud actions for owners and pets.  Choose one route at a time. It might be easiest to start with `destroy`; just remember the difference between `destroy` and `delete`!

#### Play with Pets!

Practice your Ruby skills - and get more time with the `Date` and `DateTime` built-in classes.

1. Generate and run a migration to add a `date_of_birth` field to the `Pet` model. The type of this field should be `date`.  Display the pet's `date_of_birth` in the view for `pets#show`.

1. Fill in the `Pet` model's `date_of_birth_cannot_be_in_the_future` method. This method should add an error to the validation errors if the pet's `date_of_birth` is in the future.  See the [Validations](http://guides.rubyonrails.org/active_record_validations.html#custom-methods) Rails guide.

1. Fill in the `Pet` model's `age` instance method. If the pet instance has a `date_of_birth`, this method should calculate and return the pet's age in years (as a decimal).  If the pet doesn't have a `date_of_birth`, the `age` method should return `nil`.  Display the pet's `age` in the view for `pets#show`.
