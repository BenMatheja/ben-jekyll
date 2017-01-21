# Jekyll-Bootstrap

The quickest way to start and publish your Jekyll powered blog. 100% compatible with GitHub pages

## Usage
Requires Ruby 2.2.1
`cd assets && bower install`
## Version

0.3.0 - stable and versioned using [semantic versioning](http://semver.org/).

**NOTE:** 0.3.0 introduces a new theme which is not backwards compatible in the sense it won't _look_ like the old version.
However, the actual API has not changed at all.
You might want to run 0.3.0 in a branch to make sure you are ok with the theme design changes.

## Milestones

[0.4.0](https://github.com/plusjade/jekyll-bootstrap/milestones/v%200.4.0) - next release [ETA 03/29/2015]

### GOALS

* No open PRs against master branch.
* Squash some bugs.
* Add some new features (low-hanging fruit).
* Establish social media presence.


### Bugs

|Bug |Description
|------|---------------
|[#86](https://github.com/plusjade/jekyll-bootstrap/issues/86)  |&#x2611; Facebook Comments
|[#113](https://github.com/plusjade/jekyll-bootstrap/issues/113)|&#x2611; ASSET_PATH w/ page & post
|[#144](https://github.com/plusjade/jekyll-bootstrap/issues/144)|&#x2610; BASE_PATH w/ FQDN
|[#227](https://github.com/plusjade/jekyll-bootstrap/issues/227)|&#x2611; Redundant JB/setup

### Features

|Bug |Description
|------|---------------
|[#98](https://github.com/plusjade/jekyll-bootstrap/issues/98)  |&#x2611; GIST Integration
|[#244](https://github.com/plusjade/jekyll-bootstrap/issues/244)|&#x2611; JB/file_exists Helper
|[#42](https://github.com/plusjade/jekyll-bootstrap/issues/42)  |&#x2611; Sort collections of Pages / Posts
|[#84](https://github.com/plusjade/jekyll-bootstrap/issues/84)  |&#x2610; Detecting production mode

### TODOS

Review existing pull requests against plusjake/jekyll-bootstrap:master. Merge or close each.

* Create twitter account. Add link / icon on jekyllbootstrap.com.
* Create blog posts under plusjade/gh-pages, expose on jekyllbootstrap.com, feed to twitter account.
* Announce state of project, announce roadmap(s), announce new versions as they’re released.

## Contributing


To contribute to the framework please make sure to checkout your branch based on `jb-development`!!
This is very important as it allows me to accept your pull request without having to publish a public version release.

Small, atomic Features, bugs, etc.
Use the `jb-development` branch but note it will likely change fast as pull requests are accepted.
Please rebase as often as possible when working.
Work on small, atomic features/bugs to avoid upstream commits affecting/breaking your development work.

For Big Features or major API extensions/edits:
This is the one case where I'll accept pull-requests based off the master branch.
This allows you to work in isolation but it means I'll have to manually merge your work into the next public release.
Translation : it might take a bit longer so please be patient! (but sincerely thank you).

**Jekyll-Bootstrap Documentation Website.**

The documentation website at <http://jekyllbootstrap.com> is maintained at https://github.com/plusjade/jekyllbootstrap.com


## License

[MIT](http://opensource.org/licenses/MIT)
=======
# Jekyll Rake Boilerplate

*Jekyll Rake Boilerplate* is a small rake "boilerplate" for doing common tasks with the static site generator [Jekyll](http://jekyllrb.com/ "Jekyll"), such as generating your site, preview it in your default browser, creating a new post or page from a default template and transfering it to a remote git repository, a remote host/server or a local git repository.

Please note that the code is intentionally "messy" and quite un-DRY so that'll be easier to take the parts that you want and toss away the others.

## Usage

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

### Remote transfer settings (for Windows)

    transfer:
      command: robocopy
      settings: /mir
      source: _site\
      destination: username@servername:\var\www\websitename\

### Remote transfer settings (for *nix)

    transfer:
      command: rsync
      settings: -av --delete
      source: _site/
      destination: username@servername:/var/www/websitename/

### Local transfer settings (for Windows)

    transfer:
      command: robocopy
      settings: /e
      source: _site\
      destination: C:\Git\username.github.com\

### Local transfer settings (for *nix)

    transfer:
      command: rsync
      settings: -av
      source: _site/
      destination: ~/Git/username.github.com/

## Known issues

Rake tasks doesn't play nice when it comes to including commas in arguments. For example, if you try to create a post by running `post["One, two, three"]` the name and title of the post will become `One`. The easiest work-around for this is to skip the commas when your creating a post and adding them later on.

## License

**The MIT License (MIT)**

*Copyright (c) 2012 Ellen Gummesson*

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
>>>>>>> c9942624178957d5b4dcbfde2162724f36b52fe4
