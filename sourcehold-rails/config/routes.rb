Sourcehold::Application.routes.draw do

  # Help Documentation
  match 'help/getting_started' => 'help#start', :via => :get
  match 'help/why_git' => 'help#why', :via => :get
  match 'help/ssh' => 'help#ssh', :via => :get
  match 'help/ssh/windows' => 'help#sshwindows', :via => :get
  match 'help/ssh/mac' => 'help#sshmac', :via => :get
  match 'help/git/basics' => 'help#gitbasics', :via => :get

  # Legal
  match 'terms' => "home#terms", :via => :get 
  match 'privacy' => "home#privacy", :via => :get

  # Static Pages
  match 'about' => 'home#about', :via => :get
  match 'pricing' => 'home#pricing', :via => :get

  # Mailer
  match 'beta-feedback' => 'support#feedback', :via => :post

  # Account Management
  devise_scope :user do
    get "account/admin" => "devise/registrations#edit", :as => 'edit_user_registration'
  end
  match 'account' => 'account#index', :via => :get, :as => 'account_home'
  match 'account/repos' => 'account#repos', :via => :get
  match 'account/ssh' => 'account#ssh', :via => :get, :as => 'account_ssh'
  match 'account/profile' => 'account#profile', :via => :get
  match 'account/email' => 'account#email', :via => :get
  match 'email' => 'account#add_email', :via => :post, :as => 'add_email' 
  match 'email/:id' => 'account#delete_email', :via => :delete
  match 'account/profile' => 'account#edit_profile', :via => :post, :as => 'edit_profile'

  # Message/inbox
  match 'reply' => 'inbox#reply', :via => :post, :as => 'message_reply'
  match 'inbox' => 'inbox#create', :via => :post
  match 'inbox' => 'inbox#index', :via => :get
  match 'inbox/compose' => 'inbox#new', :via => :get
  match 'inbox/sent' => 'inbox#sent', :via => :get
  match 'inbox/message/:id' => 'inbox#show', :via => :get

  # Blog
  match 'blog' => 'blog#index', :via => :get
  match 'blog/rss' => 'blog#rss', :via => :get
  match 'blog/:id/:title' => 'blog#post', :via => :get
  match 'blog/new' => 'blog#new', :via => :get
  match 'blog' => 'blog#create', :via => :post
  match 'blog/comment' => 'blog#comment', :via => :post

  # Dashboard
  match 'dashboard' => 'dashboard#index', :via => :get, :as => 'dashboard'

  # Repository
  match 'repo' => 'repo#create', :via => :post, :as => 'addrepo'
  match 'repo' => 'repo#update', :via => :put, :as => 'updaterepo'
  match 'repo/new' => 'repo#new', :via => :get, :as => 'new_repo'
  match 'repo/destroy/:id' => 'repo#destroy', :via => :delete

  # User Specific
  devise_for :users
  match ':user/*repo/commit/:sha_id' => 'repo#commit', :via => :get
  match ':user/*repo/commits/:branch' => 'repo#commits', :via => :get
  match ':user/*repo/tree/:branch/*path' => 'repo#tree', :via => :get
  match ':user/*repo/blob/:branch/*path' => 'repo#blob', :via => :get
  match ':user/*repo/tree/:branch' => 'repo#tree', :via => :get
  match ':user/*repo/archives' => 'repo#archives', :via => :get
  match ':user/*repo/admin' => 'repo#admin', :via => :get
  match ':user/*repo/fork' => 'repo#fork', :via => :get, :as => 'fork_repo'
  match ':user/*repo' => 'repo#default', :via => :get
  match ':user' => 'profile#index', :via => :get

  # Authorization keys
  match 'authkey' => 'authkey#create', :via => :post, :as => 'authkey'
  match 'authkey/destroy/:id' => 'authkey#destroy', :via => :delete

  # Permissions for repositories
  match 'permission' => 'permission#create', :via => :post, :as => 'perm'
  match 'permission/destroy/:id' => 'permission#destroy', :via => :delete

  # Ajax
  match 'ajax/username' => 'ajax#username_exist', :via => :post
  match 'ajax/emailaddress' => 'ajax#email_exist', :via => :post
  match 'ajax/repoexist' => 'ajax#repo_exist', :via => :post

  root :to => "home#index"
end
