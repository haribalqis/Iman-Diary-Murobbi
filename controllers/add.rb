get "/add" do
    @player = Player.new
    erb :add
end

post "/add" do
    @player = Player.new #instantiates the player
    @player.load(params)

    if @player.valid?
    @player.save_changes #update the player
    redirect "/"
    end

    erb :add
end
  