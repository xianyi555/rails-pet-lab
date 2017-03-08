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
