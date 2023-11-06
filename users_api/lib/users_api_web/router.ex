defmodule UsersApiWeb.Router do
  use UsersApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug, [origin: "http://localhost:3000"]
  end

  scope "/api", UsersApiWeb do
    pipe_through :api
    # Users
    post "/users", UserController, :create
    # get "/users/", UserController, :index
    get "/users/", UserController, :filter
    post "/login", UserController, :login
    get "/users/:id", UserController, :show
    put "/users/:id", UserController, :update
    delete "/users/:id", UserController, :delete
    # Clock
    delete "/clocks/:id", ClockController, :delete
    get "/clocks/:user_id", ClockController, :index
    post "/clocks/:user_id", ClockController, :create
    ### OK
    post "/workingtimes/:user_id", WorkingtimeController, :create
    delete "/workingtimes/:id", WorkingtimeController, :delete
    get "/workingtimes/:user_id/:id", WorkingtimeController, :show # by worktimes_id
    get "/workingtimes/:user_id", WorkingtimeController, :filter_between # all between start and end
    put "/workingtimes/:id", WorkingtimeController, :update
    put "/workingtimes/", WorkingtimeController, :update_end

  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: UsersApiWeb.Telemetry
    end
  end
end
