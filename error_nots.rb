1) Pets Controller new action has a field for creating a new owner
     Failure/Error: expect(page).to have_field(:owner_name)
       expected #has_field?(:owner_name) to return true, got false
     # ./spec/controllers/pets_controller_spec.rb:27:in `block (3 levels) in <top (required)>'

  2) Pets Controller new action creates a new pet and associates an existing owner
     Failure/Error: expect(@pet.owner.name).to eq("Cricky")

     NoMethodError:
       undefined method `name' for nil:NilClass                                                                                                                                                           
     # ./spec/controllers/pets_controller_spec.rb:40:in `block (3 levels) in <top (required)>'

3) Pets Controller new action  creates a new pet and a new owner
Failure/Error: fill_in "owner_name", :with => "Mary Nelson"

Capybara::ElementNotFound:
Unable to find field "owner_name"
# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-2.12.1/lib/capybara/node/finders.rb:44:in `block in find'
# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-2.12.1/lib/capybara/node/base.rb:85:in `synchronize'
# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-2.12.1/lib/capybara/node/finders.rb:33:in `find'
# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-2.12.1/lib/capybara/node/actions.rb:92:in `fill_in'
# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-2.12.1/lib/capybara/session.rb:780:in `block (2 levels) in <class:Session>'
# /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-2.12.1/lib/capybara/dsl.rb:52:in `block (2 levels) in <module:DSL>'
# ./spec/controllers/pets_controller_spec.rb:46:in `block (3 levels) in <top (required)>'


4) Pets Controller new action redirects to '/pets/:id' after form submissions
  Failure/Error: expect(page.current_path).to eq("/pets/#{@pet.id}")

    expected: "/pets/1"
         got: "/pets"

    (compared using ==)
  # ./spec/controllers/pets_controller_spec.rb:62:in `block (3 levels) in <top (required)>'

5) Pets Controller edit action  loads form to edit a pet and his owner
  Failure/Error: expect(page).to have_field('pet[name]')
    expected #has_field?("pet[name]") to return true, got false
  # ./spec/controllers/pets_controller_spec.rb:79:in `block (3 levels) in <top (required)>'


  6) Pets Controller edit action edit's the pet's name
       Failure/Error: fill_in "pet_name", :with => "Chewie Darling"

       Capybara::ElementNotFound:
         Unable to find field "pet_name"
       # /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-2.12.1/lib/capybara/node/finders.rb:44:in `block in find'
       # /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-2.12.1/lib/capybara/node/base.rb:85:in `synchronize'
       # /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-2.12.1/lib/capybara/node/finders.rb:33:in `find'
       # /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-2.12.1/lib/capybara/node/actions.rb:92:in `fill_in'
       # /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-2.12.1/lib/capybara/session.rb:780:in `block (2 levels) in <class:Session>'
       # /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-2.12.1/lib/capybara/dsl.rb:52:in `block (2 levels) in <module:DSL>'
       # ./spec/controllers/pets_controller_spec.rb:86:in `block (3 levels) in <top (required)>'

       7) Pets Controller edit action edit's the pet's owner with an existing owner
            Failure/Error: check(@adam.id)

            Capybara::ElementNotFound:
              Unable to find checkbox 2


8) Pets Controller edit action edit's the pet's owner with a new owner
     Failure/Error: fill_in "owner_name", :with => "Samantha"

     Capybara::ElementNotFound:
       Unable to find field "owner_name"
     # /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-2.12.1/lib/capybara/node/finders.rb:44:in `block in find'
     # /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-2.12.1/lib/capybara/node/base.rb:85:in `synchronize'
     # /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-2.12.1/lib/capybara/node/finders.rb:33:in `find'
     # /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-2.12.1/lib/capybara/node/actions.rb:92:in `fill_in'
     # /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-2.12.1/lib/capybara/session.rb:780:in `block (2 levels) in <class:Session>'
     # /usr/local/rvm/gems/ruby-2.3.1/gems/capybara-2.12.1/lib/capybara/dsl.rb:52:in `block (2 levels) in <module:DSL>'
     # ./spec/controllers/pets_controller_spec.rb:101:in `block (3 levels) in <top (required)>'
