if(Rails.env.production?)
  GIT_REPOS = "/main/repos"
else
  GIT_REPOS = ""
end
