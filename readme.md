# <img src="https://cloud.githubusercontent.com/assets/7833470/10899314/63829980-8188-11e5-8cdd-4ded5bcb6e36.png" height="60"> Validations &amp; Error-Handling - Challenges

## Getting Started

1. Fork this repo, and clone it into your `develop` folder on your local machine.
2. Run `rake db:create db:migrate` in the Terminal to create your local database and run the migrations.
3. Run `rails s` in the Terminal to start your server.
4. Navigate to `localhost:3000` in the browser - you should see the Rails welcome page.

## Challenges

#### Model Validations

1. Add validations to the `Pet` model. Pets are required to have both `name` and `breed`, and `name` must be at least 3 characters. See the <a href="http://guides.rubyonrails.org/active_record_validations.html" target="_blank">Active Record Validation docs</a> for guidance.

2. In the Terminal, open up the Rails console, and try adding an invalid pet to the database using the `.create` method:

  ```zsh
  irb(main):001:0> pet = Pet.create(name: "Ty")
  ```

  What happens?

3. Now try storing the invalid pet in memory with the `.new` method, and check if it's valid:

  ```zsh
  irb(main):001:0> pet = Pet.new(name: "Ty")
  irb(main):002:0> pet.valid?
  ```

4. Use `.errors.full_messages` to display the user-friendly error messages for the invalid pet you just created.



### Pets Controller and Routes

1. Generate a Pets controllers using `rails g controller Pets`. This will create a file like this:

  ```ruby
  class PetsController < ApplicationController
    # routing actions go here
  end
  ```

2. Define a method in `pets_controller.rb` called `new` and a method called `create`. In **both** methods, assign an instance variable `@pet` to `Pet.new`. Assign an instance variable `@owner` to `Owner.find(params[:owner_id])`.

3. Use an `if / else` block (after your assignment of `@owner` and  `@pet`) in `PetsController#create` to handle valid and invalid form submissions.
  ```ruby
    if @pet.save
      @owner.pets << @pet
      redirect_to @owner
    else
      render 'new'
    end
  ```

4. In `config/routes.rb`, add `resources :pets` to the `resources :owners do ... end` block. This will give you access to all seven RESTful routes for Pets.

### Making your Pet Form

1. Create a file in your `views/pets` directory called `new.html.erb`.
2. Use `form_for` to create a form for `@pet`.
3. Add an errors `<div>` so that an invalid form submission will cause the page to render with the errors displayed.

**NOTE:** If you need a refresher on syntax for `form_for` and the errors, refer to the README for examples or look at `views/owners/new.html.erb`.

If all is right, you should be able to create new pets and associate them with their owners. Additionally, your awesome error handling should display informative messages on how to properly submit your forms. Great job!

## Stretch: Make update forms, add more validations

- In either `owners_controller.rb`, create `edit` and `update` methods, the former renders a form to edit the owner, and later handles the `PUT` request.
- Add new attributes to your models with new migrations using `rails g migration Add<SOMEATTRIBUTE>To<MODELNAME>`. Add validations for these new attributes in the models files (`owner.rb` and `pet.rb`). For example:
  - Add a breed attribute to the `Pet` model by creating a new migration. Add a validation for `breed` in your `models/pet.rb` file. Edit your Pet creation form to include the new `breed` attribute.
  - Add a email attribute to the `Owner` model by creating a new migration. Add a validation for `email` in your `models/Owner.rb` file. Validate the email using a [Regular Expression](http://edgeguides.rubyonrails.org/active_record_validations.html#format) Edit your Owner creation form to include the new `email` attribute.