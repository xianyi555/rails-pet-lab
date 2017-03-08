## Part 4: Optional Extras / Choose Your Own Adventure

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
