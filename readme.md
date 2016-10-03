# <img src="https://cloud.githubusercontent.com/assets/7833470/10899314/63829980-8188-11e5-8cdd-4ded5bcb6e36.png" height="60"> Pet App!

Starter code and challenges for Validations & Error-Handling in Rails.

## Getting Started

1. Fork this repo, and clone it into your WDI class folder on your local machine.
2. Run `bundle` in the Terminal to install gems from the Gemfile. (Feel free to take a look at what's included, first.)
3. Run `rails db:create db:migrate` in the Terminal to create your local database and run the migrations.
4. Run `rails s` in the Terminal to start your server.
5. Navigate to `localhost:3000` in the browser - you should see a generic `site#index` page.   
6. Run `rails routes` to see what routes are available in the app.


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
    Create a place to render the flash message in the main application layout (`app/views/layouts/application.html.erb`).
  </details>



## Part 2:

1. You already have routes for `owners#edit` and `owners#update`, since  `routes.rb` calls `resources :owners`. Now, set up controller methods for `owners#edit` and `owners#update`, as well as a view for editing owners (edit form).

2. Make sure your `owners#update` method also handles errors by redirecting if the user submits invalid data and displaying a flash message in the view.

1. Common keys for flash messages are `:notice`, which just displays some information, and `:error`, which means something has gone wrong. Add styling to visually distinguish between these kinds of flash messages.

1. If you look at `seeds.rb`, you'll see FFaker is set up to generate seed data. In your Rails console, try `FFaker::PhoneNumber.phone_number` a few times. Just like real user data, the phone numbers don't have a standard format.  Fill in the `normalize_phone_number` method so that it will:
  * remove `1` from the beginning of the owner's phone number, and   
  * remove the characters `(`, `)`, `-`, and `.` from the owner's phone number.

  > The `before_save` method makes it so the `normalize_phone_number` method gets called whenever an owner is about to be saved in the database.
