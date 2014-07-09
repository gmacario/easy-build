# Contributing

We love pull requests. Here's a quick guide.

## Getting Started

* Make sure you have a [GitHub account](https://github.com/signup/free)
* [Submit a ticket for your issue](https://github.com/gmacario/easy-build/issues), assuming one does not already exist.
  * Clearly describe the issue including steps to reproduce when it is a bug.
  * Make sure you fill in the earliest version that you know has the issue.
* Fork the repository on GitHub, then clone the repo:

````
    git clone git@github.com:your-username/easy-build.git
````


## Making Changes

* Create a topic branch from where you want to base your work.
  * This is usually the master branch.
  * Only target release branches if you are certain your fix must be on that
    branch.
  * To quickly create a topic branch based on master; `git checkout -b
    fix/master/my_contribution master`. Please avoid working directly on the
    `master` branch.
* Make commits of logical units.
* Check for unnecessary whitespace with `git diff --check` before committing.
* Make sure your commit messages are in the proper format.

````
    (#37) Make the example in CONTRIBUTING.md imperative and concrete

    Without this patch applied the example commit message in the CONTRIBUTING.md
    document is not a concrete example.  This is a problem because the
    contributor is left to imagine what the commit message should look like
    based on a description rather than an example.  This patch fixes the
    problem by making the example concrete and imperative.

    The first line is a real life imperative statement with a ticket number
    from our issue tracker.  The body describes the behavior without the patch,
    why this is a problem, and how the patch fixes the problem when applied.
````

* Make sure you have added the necessary tests for your changes.
* Run _all_ the tests to assure nothing else was accidentally broken.

## Making Trivial Changes

### Documentation

For changes of a trivial nature to comments and documentation, it is not
always necessary to create a new issue. In this case, it is
appropriate to start the first line of a commit with '(doc)' instead of
a ticket number. 

````
    (doc) Add documentation commit example to CONTRIBUTING.md

    There is no example for contributing a documentation commit
    to the easy-build repository. This is a problem because the contributor
    is left to assume how a commit of this nature may appear.

    The first line is a real life imperative statement with '(doc)' in
    place of what would have been the ticket number in a 
    non-documentation related commit. The body describes the nature of
    the new documentation or comments added.
````

## Submitting Changes

* Push your changes to a topic branch in your fork of the repository.
* [Submit a pull request][pr] to the repository in the gmacario organization.
[pr]: https://github.com/gmacario/easy-build/compare/
* After feedback has been given we expect responses within two weeks.
  We may suggest some changes or improvements or alternatives. After two
  weeks we may close the pull request if it isn't showing any activity.

### Some things that will increase the chance that your pull request is accepted

* Write tests.
* Follow our [style guide][style].
* Write a [good commit message][commit].

[style]: https://github.com/thoughtbot/guides/tree/master/style
[commit]: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html

# Additional Resources

* [General GitHub documentation](http://help.github.com/)
* [GitHub pull request documentation](http://help.github.com/send-pull-requests/)
