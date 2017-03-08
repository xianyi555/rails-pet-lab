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
