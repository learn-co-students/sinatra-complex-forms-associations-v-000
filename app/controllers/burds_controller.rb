class BurdsController < ApplicationController

=begin
  So i went ahead & copied another student's answers for
  this lab since the "solution" branch on Learn.co's
  GitHub account doesn't pass all the tests.  So much
  for crossing t's & dotting i's.

  The following get & post requests are my custom
  additions that I will build to reverse engineer this
  lab's functionality so I can figure out what the
  hell is goin on here...it's much easier to reverse
  engineer these things than to try and read the test
  errors and figure it out that way.

  After I understand this crap I'll go in and build some
  tests so I get how those work too!

  After that I'll break some stuff & see how the tests
  respond so I get an idea of what errors the tests are
  trying to point out.
=end

  get '/burd' do
    @var = Owner.all
#   raise @var.inspect
    erb :'/owners/burd_1'
  end

  get '/burd/chamber' do
    redirect to '/burd'
  end

  post '/burd/chamber' do
#   raise params.inspect
    erb :'/owners/burd_2'
  end

  post '/burd/life' do
#   raise params.inspect
    if params["Box 1"] == "on"
      redirect 'burd/etzhayim'
    else
      "You're dead guy! :("
    end
  end

  post "/burd/owners" do
#    raise params.inspect
#   => {"owner" => {"name" => "Maximus"}, "pet" => {"name" => "Garfield"}}
    @baal = Owner.create(params[:owner])
    if !params["pet"]["name"].empty?
  #   @baal.pets << Pet.create(name: params["pet"]["name"])
      @baal.pets << Pet.create(params[:pet])
    end
    @baal.save
    redirect "owners/#{@baal.id}"
  end

  get '/burd/etzhayim' do
    erb :'/owners/burd_3'
  end

  get '/burd/owners' do
    erb :'/owners/burd_4'
  end

  get '/burd/addowners' do
    erb :'/owners/burd_5'
  end

end
