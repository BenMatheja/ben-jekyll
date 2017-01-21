# benmatheja.de jekyll bootstrap 

## Usage
Requires Ruby 2.2.1
`cd assets && bower install`
## Version

### GOALS
* add Gemfile.
* add Capistrano Config

### Bugs

### Features

### TODOS

### Tasks

    rake post["Title"]
	rake draft["Title"]
	rake publish
    rake page["Title"]
        rake page["Title","Path/to/folder"]
    rake build
    rake watch
        rake watch[number]
        rake watch["drafts"]
    rake preview
    rake deploy["Commit message"]
    rake transfer

`rake post["Title"]` creates a new post in the `_posts` directory by reading the default template file, adding the title you've specified and generating a filename by using the current date and the title.

`rake draft["Title"]` creates a new post in the `_drafts` directory by reading the default template file, adding the title you've specified and generating a filename.

`rake publish` moves a post from the `_drafts` directory to the `_posts` directory and appends the current date to it. It'll list all drafts and then you'll get to choose which draft to move by providing a number.

`rake page["Title","path/to/folder"]` creates a new page. If the file path is not specified the page will get placed in the site's source directory.

`rake build` just generates the site.

`rake watch` generates the site and watches it for changes. If you want to generate it with a post limit, use `rake watch[1]` or whatever number of posts you want to see. If you want to generate your site with your drafts, use `rake watch["drafts"]`.

`rake preview` launches your default browser and then builds, serves and watches the site.

`rake deploy["Commit message"]` adds, commits and pushes your site to the site's remote git repository with the commit message you've specified. It also uses the `rake build` task to generate the site before it goes through the whole git process.

`rake transfer` uses either `robocopy` or `rsync` to transfer your site to a remote host/server or a local git repository. It also uses the `rake build` task to generate the site before it goes through the whole transfering process.

### _config.yml

    post:
      template:
      extension:
    page:
      template:
      extension:
    editor:
	git:
	  branch:
    transfer:
      command:
      settings:
      source:
      destination:

## Examples

### Post template

    ---
    title:
    layout: post
    ---

### Page template

    ---
    title:
    layout: page
    ---

### Editor

    editor: vim

### Git branch

    git:
      branch: master

### Remote transfer settings (for *nix)

    transfer:
      command: rsync
      settings: -av --delete
      source: _site/
      destination: username@servername:/var/www/websitename/

### Local transfer settings (for *nix)

    transfer:
      command: rsync
      settings: -av
      source: _site/
      destination: ~/Git/username.github.com/

## Known issues

Rake tasks doesn't play nice when it comes to including commas in arguments. For example, if you try to create a post by running `post["One, two, three"]` the name and title of the post will become `One`. The easiest work-around for this is to skip the commas when your creating a post and adding them later on.
