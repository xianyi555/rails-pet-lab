# <img src="https://cloud.githubusercontent.com/assets/7833470/10899314/63829980-8188-11e5-8cdd-4ded5bcb6e36.png" height="60"> Pet App!

### Overview

Track owners and pets!

### Objectives

Practice:    
- one-to-many associations  
- validations and error handling

### Getting Started

1. Fork this repo, and clone it into your WDI class folder on your local machine. Change directories into the project directory.
1. Add the class copy of this repo as a new remote: `git remote add upstream https://github.com/sf-wdi-34/rails-pet-lab`.  
2. Run `bundle` in the Terminal to install gems from the Gemfile. (Feel free to take a look at what's included, first.)
3. Run `rails db:create db:migrate` in the Terminal to create your local database and run the migrations.
4. Run `rails s` in the Terminal to start your server.
5. Navigate to `localhost:3000` in the browser - you should see a generic `site#index` page.   
6. Run `rails routes` to see what routes are available in the app.
7. Run `rails notes` to see some of the things you'll do with this app

## [Part 1: Owners Have Many Pets](docs/part-1.md)

![owner-pet-erd](https://cloud.githubusercontent.com/assets/3254910/22278438/6dd48c66-e278-11e6-8ed6-d24af148672b.png)

In this part, you'll:

* Change the `Owner` and `Pet` models so that each owner has many pets, and each pet belongs to one owner.

* Add a foreign key to the `pets` table so that each pet stores a reference to its owner.  

And more!


## [Part 2: Pets Have Many Appointments](docs/part-2.md)

![owner-pet-appointment-erd](https://cloud.githubusercontent.com/assets/3254910/22278437/6bc4468c-e278-11e6-9813-1855a623a323.png)

In this part, you'll:

 * Generate a model for `Appointment`s.

 * Set up the `Pet` and `Appointment` models so each appointment belongs to one pet and each pet can have many appointments.

 * Give the `appointments` table a foreign key to reference a pet.

And more!

## [Part 3: Owners Have Many Appointments, through Pets](docs/part-3.md)

![has-many-through](https://cloud.githubusercontent.com/assets/3254910/22279369/4fbfcff4-e27f-11e6-94a9-472309b0cdb3.png)

In this part, you'll:

* See an alternate way to use `has_many through:` for creating a "shortcut" instead of a many-to-many association.

* Add a new association between the `Owner` and `Appointment` models so that an owner has many appointments through their pets.

And more!


## [Part 4: Optional Extras / Choose Your Own Adventure](docs/part-4.md)

In this optional section, you could try one of the following tasks:

* Navigation: practice using path helper methods by adding `link_to`s to help users move among the pages of your site.

* Full CRUD: Create or fill in routes, controllers, and views for the missing crud actions for owners, pets, and/or appointments.  

* Model Methods: Practice your Ruby skills, and get more time with the `Date` and `DateTime` built-in classes by creating custom model methods.

## [Part V: Owner & Pet Validations](docs/part-v.md)

In this part, you'll:

* Add validations to owners to pass tests.

* Use flash messages to tell users what's wrong if owner creation fails.

* Use TDD for pet validations - write tests to make sure the model requires a name and breed. Then write code to pass your tests.

And more!
