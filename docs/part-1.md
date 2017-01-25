## Part 1: Owners Have Many Pets

![owner-pet-erd](https://cloud.githubusercontent.com/assets/3254910/22278438/6dd48c66-e278-11e6-8ed6-d24af148672b.png)

1. This app has models for owners and pets. In this app, each owner will have many pets, and each pet will belong to one owner. Change the `Owner` and `Pet` models to reflect this relationship.

1. Add a foreign key to the `pets` table so that each pet stores a reference to its owner.

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
