# Default settings for most of our projects.
# Using _cset instead of set allows to set the var only if not already set.
#
# The following vars must be set before loading this file :
# * user (name of the user on the distant serve)
# * application (name of the application)

## Configuration
# Other options
ssh_options[:forward_agent] ||= true

# Using git
_cset :scm, :git
_cset :scm_username, 'novelys'
_cset :repository, "git@github.com:#{scm_username}/#{application}"
_cset :repository_cache, "git_cache"
_cset :copy_exclude, %w(.svn .DS_Store .git)

# Keep 5 releases top
_cset :keep_releases, 5

# Deploy path
_cset :deploy_to, "/home/#{user}/www/#{application}"

## Tasks
# Cleanup after deploy
after 'deploy:update', 'deploy:cleanup'
