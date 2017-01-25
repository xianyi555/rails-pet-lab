## Part V: Owner Validations and Error Handling

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
